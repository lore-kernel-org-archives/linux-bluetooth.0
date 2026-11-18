Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031931;
	b=cGqUpyj71/zpiPHsS9NwaBMPIWXIV2CXN0ubaorf2Sp76S+CKJwkB43v73AkE9TkXaYr
	 4A0kYgEU8+3c8faptAGNXFyYvEh5lr0vHQpDTEolCiCS8IaVTzTkLlCosKpOjP1CAOMHK
	 IBn00mItHlIgkyUq64AiJqWexm3CnQbAinayXF55WKCP3xtf7E6FpmHX9dAj95nxpczVz
	 EIQmNHJ7UKnqEnWoBZsAP8H84RUJmXFeZlyDixubo5phggVGbRYAEHAIqzoy8dPQRrQhV
	 9lTsZHka/59zjWen42P4WEt6D/ejY6HbRpv5XlfKd+SPUKGZXU1hMln1b2tqb4yh6kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
	b=4FHmeBKQHPMa3Nwny36byd3YWFQ5fto3fa+UOYHJ2GEHyLB0pRihWpSj7XQeLH2hZWY5
	 PeZA/OG6LGPJlMemRKt4GNrfmCimiWBhn0PAhwUD5tfj6R+paFGJEedb8jmsJz+6CFE4c
	 Hfn9N7CExrgOwXE/uwhdbjUA3c8FshkTbLRWOXN735ufFUvQQLBwklj8WA1Qax9N9Q3Ar
	 VO9NxP1XgD+pVVI7I1YlbXhOBva/ovd447C8se33BbE4zdrfEFU5RLMAzyhWBtZTLHki/
	 Zrcg2eUz5gTvfKikZiLcToJjty/VYryw6Bldv0bmqLHdqHarb7ZCaTR5JJ30FoRtAmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNh1y9vo;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E660A2602
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844E660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNh1y9vo
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-78fb1fb9508so147796137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031930; x=1795636730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=JNh1y9voIR4pZpSUUWH4RcnYPBxHQv/Is0iSfpOSGX/E9l6cDM3cibZuyrc0lp/bAc
         lvLREY1ZWk+TFtPWfp8Th9slbO+YY+pvFzN+ywdw8FeCW8Gfs0Y70E3uyrEQHpWPW+dX
         NVmQiG50fN7Xa6ly7YCuzgi6IhKvrGDdBAMZPoOrnfVm1Ch6Kt509pkpKeZIAnkLyWls
         9EbgdqWJvvjkwVSoffTanK6nb8bIjYTcTqW/JhVI4GF8nUO2jw/qA8gm7q/n65cyDMF+
         3+nX9tfiwg1QHWU1k1F6+P9NzNfdQ4sD39GuQMBsq2MbTVXhAwJjIiRv20xybBYLrW8C
         +P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031930; x=1795636730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=Oh2ihVs8OfLDU7KZfjir2tfcZo79h7cETf0re2XPuOJZlMjcmRUnBR7DBMaDIl+um6
         5803RJniVgw/LGiEx2+6znqyivPjSMdqvSaaeUihlSAM/rE+6UWEV2ptidycarFPfxmf
         Zp+IuQTiWPhzcA/wcMQjzzN4e119K3c+C6RVPHKk+Rf4CnzmOcZZQkPLITRleZ460Qkk
         oC068VPkCCH9dBciOOnLkE966ECbZhIBzpUnDElPInML7S3OpbdfLx1ntTWygxBL2eeF
         TU6tyPyslnuuUKEGSNHj347hvTg7ehhI7eLzN4CHJsiGbq7TWcDTp/C55DVbJ0SKq7LE
         VE5w==
X-Gm-Message-State: APuU4Z8SPVrrfU2dTPlOiwhT2R26/kzj2AMke/XPFjGDjd15OLP1RgA6
	eiRRPmeQY9B7PcfCLKIwwQyBNimeF9QhDldTUBSgPqhtzwZM3tJD0mo2jSRd2mQx
X-Gm-Gg: AYBFou3+ZjpS6469wuKjlgbcSt/uzKhRnuDDRGhPdUKwmcx16e3wfxoKbjM+dilvTSH
	CGRdZJAUcKu9FwSmNHeEnxeH8+FkDjGhZcwvrMVmzR4B2JcBK8rx7udtL/KynsEiv/VCBg3QlHm
	MYdMnvkn8KaZOhEHE2CuiXKvOtZBQDwBG1DmG3YC7RWQSY7+UsViwK/3gm8pPoGgc5NU02eMeVJ
	yMbVkbxF5efWYRRPdXSVxdcenws++3e24PCZ+798wA9IOFBnQAqlVreQWL/OEbxlFa8y/tT0G7O
	zt4jLAHm5WlPXSO9PWnAOctGiex9i8SXHLUVnUSRc6zYcGKlek7maWV3Qv7H4ZbgZ6q4YUQMuqU
	UPpcQS7v+9O36uf5cPIycj50ZkzkPOBRyAXHvHxksAoRCS8vyVi1TudetdfpFb/gEVnQuxpytHi
	0Qtz5/oAcP810vHlQ4RaM9r5LDgJC8oBK1V7vegFXfHUia7C30y6C+MRPTHpB6AgRNg3qpgVcPd
	BW+7WVsu7d3ntGCidizysHvkPfuOrNgGaXD1khGDZM5Jzfg4ldBbw9DIma3itdwIZy1rm9YIFw/
	iBGdyG07KA0H8Tvd7Egn1LpZ1PYuIbtCsSKS34yLlyTCT8cToi3mVa9CFOgVEAJRrEzujsqRCeC
	bK6nepX3eo4SU30g0nPbtqVv2GBBQK9d4CSqkD4TWpo0N5wew36L9q4TWKTWNUpaWCzRmVT4fIV
	c+0TU=
X-Received: by 2002:a05:6102:f0d:b0:7d2:ca2b:ad5b with SMTP id ada2fe7eead31-7d6cb99e257mr197574137.42.1795031930254;
        Wed, 18 Nov 2026 11:58:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/16] shared/rap: Reset the readable Ranging Counters per connection
Date: Wed, 18 Nov 2026 14:58:30 -0500
Message-ID: <20261118195846.393710-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

