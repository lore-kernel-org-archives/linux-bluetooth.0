Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534742;
	b=KvEQZMn6lyACA65js9Vkn0eOtvdxsRR61Rtb4v8x3ZDNE2z2vxrkuxQa7uK6HVz64tO5
	 Ova5VaGZ3GFYorZe/ECCNroGQNy/5PBEDEFsjVCSHKnlqpGJPg2eLHniV7zb6hW8oDawm
	 /oIREXVPYMKOnmjMXePbv+F160RfMMGxl8QFfXB445aiZ94bG2gAUI2pz2tFvDCnQMxlI
	 4hAT/dwy2PN+owYS7N19/fOpgMEXDIKc2MitQ5IurEc9Bsnk0kG/0dY7RN8TpxUux6lSt
	 8lXNrDLOTqecfAxNd3Wyoa4bfN6KxaRVH0PKGRKHzi3zM7CffLtUZbHGVSroX1nQJYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
	b=REAv5v4vFKEncTs1wTXMrkU9wTb4bsLukazQUXl/gfIQm2/+KPloJyZ1ezO+PY0dzS07
	 QAlVroKyaVfbAPE+aQOJtgIlOvUSTkFFWE7SiiI6+jvONA1oBDdQJGX35MYDNdTkaQOVc
	 VGOdK5pou//49v+8V+2uc8FalN7njmM0DXm5XSuDKxxi4ZBL29vtKYnT/CbTtjN1kOkVl
	 ireY1WxZM2trUp7Ah6MLPpUA1FSu1YdaTYbwXcudpbbv2vJo8/lODxUeMh1OBAb3uPqJi
	 V/+0vwTSGHkXimxU1rKVtzmDherSVUpgxWw5CDAlS2y0hIkpf/LjP/o81ppaYxVF5zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0EsU3Kb;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B0606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0B0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N0EsU3Kb
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eae12762c9so1897401e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534741; x=1796139541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=N0EsU3KbkBO2q6AEXhmq1tNUEMdFsBKjkdvf1VqJREuEMUOSKBGuQONLkjYmb3O3pg
         R4WB8F6qaK8dvE8JWAiaTtmMGJAlC4R17GX5SGg8k2DScA8XWeBg5RQUGn8UbOe8hTgR
         YmCvQbggdRcCfiL8AAMyuJKxdSsV4Mc9Jx1yAq0Ci+pfIpFVDt9fOiMart8ESFX8JYE7
         DZ2jsr+d80t1pIQUiyGu3NLaMRp8FDjol4W+SDWSd6Q8CpabtgMhkhX+KnEfkAZYa/8k
         O0m9V89b3ydSqW0MgZKx74zvJQBj+QcuJKURG9M+NqLuMeosa2vLFWjhI57FIxxyZVuI
         KABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534741; x=1796139541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=Koyo3KeY+cnlPsgpKUD0EP500BCimG9s4mDhZawVHYpLgAapf1h5LeGtE0EJXlMtXJ
         S5HMilrOa4HxohwJE4vneGtNaPOA2K1H7nF8ZfWoIA9/nLZ3jEMvaXOkCjuuSW5D24j4
         AW1JjBbGPBwotnVdIUa1sF+PbkKVpForXjHC9ezBdDBmnzVjGgxuTXmpbYZ3PgFOcgTl
         OwTQBKjV2XGxDvF2z5BdzdqNxMT+Dt9W7DBvy0naqJLGOYjMf0fGTHGSEGigpTeP3WxD
         UH2/x9Z8FFOJCACKKEwm5EKocdVBEF9dMXaBZnj1ETGTGTVS/DmrF6rICqG7H/BmKBhV
         PpAg==
X-Gm-Message-State: APuU4Z8f6FPjXkE2EBgNeGMHt7aWXFKHsYkYdo3lbSgyPTJ0+H/CIAn7
	CLupDYpecV53LHTxSwjtuc0hQ6K8u6BSV6qnoP3ScKBUkSwY6H6AAlGvyVyGKQ==
X-Gm-Gg: AZFdTZeXF5Gur0RJUxvQE9AYD49kuhaikWF9vJu2s4plF6QcnGSJyaqfpb/OCEQJCF1
	qe1newxXkm5sI0lQ3uravJ/3cMrOihyA6kVXYI3Z43BWFkxgSooG79ORiUEvMnByMGPp9/cfgD9
	GYN63rsX0CEbBBb6QC6ATV5pXberDBn54/C0z56WER8LqJ7OhcKgsxxcUyEGizGQVABwNxVWhco
	LdaDGCwyskML1ty4GLomjLefZyqRIqozl2repP6SeNzkEMQNPQjmJDHcFJYzdtt7aSJYItlcV07
	9/FH6upwEkfn6XV69yjD9yg8SGMOqNndUt6s5lwrV8mrqRCZ17KUuFFVkBQEJcjvaI3tUjVlGYD
	8Ro4Nr81qx1szPU6pPYDKRH7EdENTyhRrjBznJGAkg8vee1Vj4h4igQbcuPi2P5V8GEgQTsQwTA
	IowS5eM0PKxRT9cznwFXiZ2sARwX6WRVh4l1mC4CaNL2Z6ki0onlYk/hnZaMf/UXWoNUxlhH3bU
	VaSfOEiG0m81th875F7RtNYVad6gNak/XHrVAWXRc0HAsGn6aZPFRb8WTemNzndp2zayf2lyGzr
	k/UVHaF1vRmSeD3qhkPYEZxbo/OUIJ40Yil9rFldCeHQSAvY5aEBKPiILFJJ55Gyj66dqv7AE/o
	6DAjyuE6RMHGSvUKxqEpd/GwLy7KfDRzMD6zhhvEr9PGyeTWXvO8CUwYPPd49BvweoGPzm4yJEI
	3rxak=
X-Received: by 2002:a05:6122:2226:b0:5ea:8e0c:1f8b with SMTP id 71dfb90a1353d-5ee8aeaa9b5mr7611140e0c.5.1795534740691;
        Tue, 24 Nov 2026 07:39:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 02/18] shared/rap: Reset the readable Ranging Counters per connection
Date: Tue, 24 Nov 2026 10:38:39 -0500
Message-ID: <20261124153856.216054-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

A read of Ranging Data Ready reports the Ranging Counter of the most
recent CS procedure completed during the connection, and 0 if none
completed; Ranging Data Overwritten reports the counter of the most
recent procedure whose data was overwritten during the connection, and 0
if none was (RAS v1.0, 3.4 and 3.5). Both are scoped to the connection.

Neither counter was cleared when the link went away, and the local RAS
service outlives it, so the value counted on one connection was still
reported on the next. After any run that produced ranging data, a read
on a fresh connection returned a stale non-zero counter, which is what
RAS/SR/RCO/BV-07-C checks in its first step.

Clear both on the local RAS service in bt_rap_detach(), next to the
other per-connection state it already drops.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/rap.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index ebf12a6bba31..6de8111d1067 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -392,8 +392,6 @@ struct ras {
 	struct gatt_db_attribute *ready_ccc;
 	struct gatt_db_attribute *overwritten_chrc;
 	struct gatt_db_attribute *overwritten_ccc;
-	uint16_t ready_counter;
-	uint16_t overwritten_counter;
 
 	/* Initiator role: pending RAS Control Point request state */
 	struct ras_ondemand_client client;
@@ -482,6 +480,13 @@ struct bt_rap {
 	unsigned int overwritten_notify_id;
 	uint32_t ras_features;
 
+	/* Responder role: Ranging Counters read back through Ranging Data
+	 * Ready and Overwritten, scoped to this connection (RAS v1.0, 3.4
+	 * and 3.5).
+	 */
+	uint16_t ready_counter;
+	uint16_t overwritten_counter;
+
 	/* Responder role: this connection's on-demand ranging data cache.
 	 * Per-connection (not on the shared struct ras) so that concurrent
 	 * centrals cannot evict or receive each other's cached data.
@@ -1018,6 +1023,10 @@ void bt_rap_detach(struct bt_rap *rap)
 	 */
 	ras_ondemand_cache_clear(rap);
 
+	/* Neither counter may survive the link it was counted on. */
+	rap->ready_counter = 0;
+	rap->overwritten_counter = 0;
+
 	if (rap->rrapdb && rap->rrapdb->ras) {
 		struct ras *ras = rap->rrapdb->ras;
 
@@ -1387,12 +1396,13 @@ static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
 				   void *user_data)
 {
 	struct ras *ras = user_data;
+	struct bt_rap *rap = NULL;
 	uint8_t value[2];
 
 	if (ras)
-		bt_rap_get_session(att, ras->rapdb->db);
+		rap = bt_rap_get_session(att, ras->rapdb->db);
 
-	put_le16(ras ? ras->ready_counter : 0, value);
+	put_le16(rap ? rap->ready_counter : 0, value);
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -1403,12 +1413,13 @@ static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
 					 void *user_data)
 {
 	struct ras *ras = user_data;
+	struct bt_rap *rap = NULL;
 	uint8_t value[2];
 
 	if (ras)
-		bt_rap_get_session(att, ras->rapdb->db);
+		rap = bt_rap_get_session(att, ras->rapdb->db);
 
-	put_le16(ras ? ras->overwritten_counter : 0, value);
+	put_le16(rap ? rap->overwritten_counter : 0, value);
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -1937,7 +1948,7 @@ static void ras_send_ranging_data_ready(struct bt_rap *rap, struct ras *ras,
 	if (!rap || !ras || !ras->ready_chrc)
 		return;
 
-	ras->ready_counter = counter;
+	rap->ready_counter = counter;
 	put_le16(counter, value);
 	if (ras_ccc_use_indication(rap->ras_ccc.ready))
 		gatt_db_attribute_indicate(ras->ready_chrc, value,
@@ -1955,7 +1966,7 @@ static void ras_send_ranging_data_overwritten(struct bt_rap *rap,
 	if (!rap || !ras || !ras->overwritten_chrc)
 		return;
 
-	ras->overwritten_counter = counter;
+	rap->overwritten_counter = counter;
 	put_le16(counter, value);
 	if (ras_ccc_use_indication(rap->ras_ccc.overwritten))
 		gatt_db_attribute_indicate(ras->overwritten_chrc, value,
-- 
2.56.0

