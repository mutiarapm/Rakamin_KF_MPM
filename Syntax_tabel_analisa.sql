SELECT 
  f.transaction_id,
  f.date,
  f.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  f.customer_name,
  f.product_id,
  p.product_name,
  f.price AS actual_price,
  f.discount_percentage AS discount_percentage,
  CASE 
    WHEN f.price <= 50000 THEN 0.10
    WHEN f.price > 50000 AND f.price <= 100000 THEN 0.15
    WHEN f.price > 100000 AND f.price <= 300000 THEN 0.20
    WHEN f.price > 300000 AND f.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,
  -- Perhitungan Nett Sales
  f.price * (1 - f.discount_percentage) AS nett_sales,
  -- Perhitungan Nett Profit
  (f.price * (1 - f.discount_percentage)) * 
  (CASE 
    WHEN f.price <= 50000 THEN 0.10
    WHEN f.price > 50000 AND f.price <= 100000 THEN 0.15
    WHEN f.price > 100000 AND f.price <= 300000 THEN 0.20
    WHEN f.price > 300000 AND f.price <= 500000 THEN 0.25
    ELSE 0.30
  END) AS nett_profit,
  f.rating AS rating_transaksi
FROM 
  Kimia_Farma.final_trans f
JOIN 
  Kimia_Farma.kc kc ON f.branch_id = kc.branch_id
JOIN 
  Kimia_Farma.product p ON f.product_id = p.product_id;
  