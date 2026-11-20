Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193716;
	b=34uOLiiVqeAYesboZD9SncBCG/+tv4lQyHkhZ4JWofCq2TAa+wDbzitG40GEocp1xS+z
	 /tf2rWA5q3WPMm1KPaxzchEDVAb0jo5+pKc9nsT+eaTZ47SGudzr5a/qy+5EGtIarBfI3
	 +RE8xtIQaTsmzyijcw9naM5ecnQVEhNkvdTVmJ9NxnoIcJD0CU+MoV6zP366sBGyydTBu
	 gCLYeVOZz1cnbZ91KptH7TPN+XBkKVOJ8bhtB2wUmpVePhY2Hk0BUigeQtkzOyk39/Mep
	 1cCn/V8OQTcH/Ub9ODQU1tnV3DWPdTAzodW9LCyspx8K2vk+FSZ5wDot2pIlgNnGklQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
	b=MdfSVCFbeIhnoxBGrXI5cuDf7mThhaGgfta1sr3gIlSjsjOaEdQghU1e4wBvVpLO2IkA
	 Ac9vkV2zRl6JmXUb9Su/xv8lztZnxwsXPX3eLdufomeFbksugoL0MP9xPVWx+TJnX2Bj/
	 WnE2GHqHRwtJtyZWxkEI8npHUb1/UsBAAQZimzfCG5JX/0V7zTHIdouUTQ2yi+2vHfjdC
	 iKIj40sbA9wg0ar3PqzmERyfjDvmp/tvhJCuERbhSQf569wClT89v90SxBEFKoIK8QB0r
	 CxhX3SRbJeDNDg0r7gU27EGzGz4GcvGNJ9eLENSxUiqrys6+P6Q8w61U8IT5glx6pWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ovh73yFA;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED9606A330
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00ED9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ovh73yFA
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99e0b1ee864so375756241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193715; x=1795798515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=Ovh73yFAc1JewcN7Hpckw6ntttyB9c3rZr4P7qaIHCsWnlyXlTIcZqp4Leb9YLY5L5
         77tHTsXedH3Q4Oq7LufsE3NhTu4nolhUKxTIdh96yxkf7svSn0VzhNur3u1IcsRfBLjG
         GbnfglfXhNP+sDSJ5NkrEBRnBTDWQPpJloHAoRwNSE8dK337pjkaSvAJ3CTqqHa1XCPM
         qk3Huk8bulE5US4KokPC66EcglaYFeIY4WTpimFIlr1xp7zVAZp/ixvH+JvIjv0FJovx
         87DBk92PxTHg6CG6b9I9c7z5r3TJGSvaTZUNkM1IMO+6fTbyvTy4OMHGW0Hbsda98Lwu
         dmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193715; x=1795798515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=2ANorhQSqNDFQZwt2kMkX1zkKQ/4EOR5Zeyyz0b8isZ15zrSHp7LC4Q4W+TfFRMVej
         xB+a6R3nh6TvuymOQf/qyWVA1i5/GGq7Y3VkoFDNcpCQs3Z/Vv3AE4CpMW1M6uino53V
         FeqNY71REdYEo808k+pt/PLkUSGmXE52YI+FdfI8kQCikMqtozL4FgljckxC//HNj53l
         tFoiPOxdzJF+e6/VL9Dx4hyadWpwaWwHl9nA1DKn2XIe3abcOgO1bB+cz4mf0AOvGwyP
         EgPSI7W64ZGRwOJashM3xeCD6EzY2GKtXO17RVE+Y3pvxWDPyve/8k2W/LxGMb1XyBy+
         fbog==
X-Gm-Message-State: APuU4Z9mTHr53nHV+PVTm723xJ7GsJSEQ7/7krrCqoxzbhll1UcfCEnk
	k6tx3HTIkbliiLRcnRPkeSQnkrT1PWL6+fhKXUAcs7t7TgorrZpdEpNdvBOZsAEd
X-Gm-Gg: AZFdTZcet/Sgmupr6KSRsqlADXZ5b/vLHsRCo8ix5jJ+sTeE8vXUmiATt79MEpbXbTN
	8YWU9t2jHiBknIMpF/6QxiW65RFfERuZj8QJnJEGuHUuplYwcLdQVRLrzsKTcSnYScya0vZ5IAq
	P6QeLz144PIdMD5635p5CrQ0HOBShLFYnS/ZbZ3aiIv/Ph/LmlwQxLQBE+cegV8tm8yOWnSjJRH
	o3RThrf4YUEdbb5fjs4AGTCqtvVGh40CMLQvGfQtdIl0A2zfkuKFzWMHhfjR33SErKzE9bnnHjd
	tmgXJFnife2FjiRflWR7GJJc06myci51s7AXXuV/iowDdQM9CYLCq6DwWjYFc7dfJ6h0uUFMtwN
	wLn7mqTJL3FpJ9GfQnuODPZp2xbLBBlcvgnyRCM1a1c2l8p95GC3xqeaRHqTl0AAisKotPzm+JJ
	bEQVCAVAuoihAwcnlZWuzntl5WRUFfc2cuomU2dEBoJCLAO42m4fCu3wNFu9GzXTsCtdhE2tL6/
	XtFynVwdWvWLux1hW7K5ZcFcrZmulTjR6L9QKMoys1R/KX6b458lv+tjxGEeMMrF2VtHdOSGAj6
	5/GJvafObZJ7FDllWQ5r80s+sEHYktYhGIAyOi/qO/yyXAN2K5KPBbFVCD+fdytsJO/As30f/Bz
	0x46ZNMeXpchLz2rQAxljI8UVElQsW+VWo2GD8Xbeh0KygGNdTiPg3VKy9SDP1ea/wDG//8F5uh
	mRe6U=
X-Received: by 2002:a05:6102:6486:10b0:7d8:70b0:6b12 with SMTP id ada2fe7eead31-7d870b06ecdmr973073137.36.1795193714806;
        Fri, 20 Nov 2026 08:55:14 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 02/18] shared/rap: Reset the readable Ranging Counters per connection
Date: Fri, 20 Nov 2026 11:54:52 -0500
Message-ID: <20261120165510.1858959-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

