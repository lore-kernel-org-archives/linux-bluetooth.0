Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108591;
	b=12lQflWqX8QuU2ewLffTuoadH739Eq5t4zFpyjbPHiTDySgmnoyJYPKAKvnKF8zQ6pbo
	 SRRX5cROgXGJiqOo91ryi4h1Vow0osN9uNVhxVhjzflKm8RUVPPFTmfXr9pq+eWyBeoIQ
	 7S91Db1qpOVJQeTlRnlFdhKanVJj3lVJRcm2kMG6XesAtu9FbXNxv46qgOIy7esMLxqV2
	 kzDbYzgZDiJCPC9s5bnG1+xQ8OBCeDhLodlz9EVYe52s8RpPVnc1dchhUivxiM/1hUdDo
	 2TOlrYMJGbO0pzn7EA9lvvqeViWNOMqao/pJYUgfAnB9PMRgBTsZU2oQdAKWzdWt3CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
	b=mNYdLyl//AOWN19sjLSjnVVquOY/k3ry+vMB6MvMG1/ZfRayufFLQRGUxP0u2JDNanWq
	 AItiWwASJhaGKZ4LmVV4YmGs7/ncbvhtT0L/Xvy3BXfm8HAGurdKSH0CNXRkVjL6VjfTt
	 zsfweJ80hERovzxhx9/BdSAHIMNOG1bobYAYKQ1dXpFuFEqfydp/cqhOrdsQP23ifDeBH
	 m7QUicqW+3yJsi/FyNcqTw/z7UYealGnWZGaPzzTDYsu0kW0vhghWCNVP63D28MrjB8IK
	 Mc1EqLHsCrf8yz+Tlm3xvhgcKGcQMbOb+Qn5jr3LCHOgh7uB1AKECZrncV6bVB2QP7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2Q6zXQv;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A5606A333
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117A5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2Q6zXQv
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so730108241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108590; x=1795713390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=H2Q6zXQvMFDa8SdIaP2gIklsc430YtmYaknpybstxgtXbbcjoych89QBmgTRDarHDC
         n6v6ls0lk2VlUioOb25ZKHiZkDda0acV7okEJJXguQqm3s7qrAAtRMFpb6AK8HDqV2/1
         WZkR2DmrNZ4qE6spJmQueYGF8BFkT7SheT5E4UwkSJm9V3sXZSVyjeJwvIlbX12xp1O+
         6fI1mrknf8ODkdHLLEwnBZbaO6+JiyTQxTh+2bjHhqXpIrztbZkR3ZZHaKvbnY+plzeZ
         WgLDjx56VyhiFtfoB/Vq2qwicPj9hGovnzhJOnXXKQpsFk0IlTYB+uNk18cb5dIbENno
         xc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108590; x=1795713390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=xM8aXANZGyTRAE67G09dW4hiclO2bLDgXCtBx4ZZqEKy+HZ7CXyg0uZ4z6+lIPt8aS
         hyOl9pK/J4UodDmCY1qbmqIyGAdcpQDLfdbkSFpo/AVdZvEW6IZ9JLDnizjMImvOBo5h
         f2PCZ9RFqVd00sOPfxYbxHRN8WsFI+Mg0S2ddsWVn3NazXwYDQaqkJSWdL0bCUWskWIb
         5ZkEvZAqVAgiX0Ag7S2hjixHcxeF1L+9WVZYozl3Ha0YUB3wpjXh4i3Jrfzd9nCp5j/g
         p2JFDmToHKi8toUKpEI6J3Ov4dVqzhE0wU0iE3U4gfHOL0fWl116E5KhH4Mcf+xS6Alv
         il6g==
X-Gm-Message-State: APuU4Z8ETNJfkd3GrEvMxzQkbXA+FiHlNUhxJLEU52iOq5geE9JHYJ3q
	/bZ3JMQYrJiZ0U18dxekyEXcA8Hn1FOpWrzjHPTaxKSQe4UH4mM+NWK5NS1NLLxaElM=
X-Gm-Gg: AYBFou0H4aWK6P2IZq++94YMmM38BvFcvXESXtLYQ3T6tvvr+NW+6SFJDefj14ouwUz
	t5meEioL5/Cka1rV65WHVACjLdjQfza1kUn/+Z9kGLnNvSEd7XEj8UKTZsoVIEiNE8oW/8h4+Sq
	CvGc88CYsMlejCYbscjGNRVkTR5hCEjkHrjzpDwck5RQhxYBaRaApm83WmC7WL6OAoYf+a+qqrg
	u24i1n1EsdDElMwbXjbOKuTodf6F6idN8BZqNBgk3jBpCRu1675HUHu88qz1Obup7CzTCkSEE9K
	XCQ/nkQcOses1voJAQ+B8pFgeD/AQNgyB4zdSra+omf0c1g5AyB1hXbhCqS0N0NDacmQNbiqIEX
	F9Owewi6YnGRfSGhMwrcVggqz+407mTWVaGAps+pko7hqzPKMY3m4d9IQmjxNko637mLGGTcjUZ
	srwHCBSFCID/2+3jDONsPejdl7tLplQWfCxEa3EiWpv6BvicOK6ERnMaWnnGI/NF99JlF6WQ55q
	EsiYeN0CEu0qJesK2k14PCmiHDVZOlLxDyUnDxFTf/W5jWq9vmCoUBfTotp6ZijBSZnEsATwt8J
	asVIDu9LUUddoAYRd8pRFdjn2fS2kEn5FYq+gDJTDnCUL140creTFunF+H7V8RfkqwJn1OJ28EG
	2JRVNWKS6wkmP8wl5mz4pv+a94YGSfpUxsj3yUEVdGwb/s1/tD+hx6+FHK+TDqxwlVCznhG1LV7
	ScCs8=
X-Received: by 2002:a05:6122:6e0e:b0:5d7:2918:c648 with SMTP id 71dfb90a1353d-5ee8aeb7facmr223424e0c.8.1795108589829;
        Thu, 19 Nov 2026 09:16:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 02/16] shared/rap: Reset the readable Ranging Counters per connection
Date: Thu, 19 Nov 2026 12:16:10 -0500
Message-ID: <20261119171625.1014004-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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

