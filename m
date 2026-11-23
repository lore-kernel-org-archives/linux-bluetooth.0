Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456290;
	b=vDwlT+heygDe6xTK+VjkoiMoIOVHIMI+x/Usv9NsjxvabU1kliSi+xxaf5OS9lKfy0S4
	 /72SjmCLXZDs6Ny6kQgCM6d+j1HomSqGCJjgznxCZwVnvTMoQdqk/qZDGBCLi4MeTsCT3
	 9jBxZrckqW5J1n9Axx5P7BcV7UVlLbvL/5sBd4t4li+10sJYWtmKki3tnUh0hAgXVehU3
	 Wnut7mFwhfyw5RxUUdmiHTEto5bWWxSkl3Stp/CK9cqg2GiZDunRwO0it+bPN2+p+yu92
	 kNT8OvUXmOwNnDj+JsrfvtpwkZeAKB5vGu5W11klLERhDp6zOeTwEZZrjvvLd2ORxag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
	b=dcA2VLzWWKBqusfJYsYJcliBE/rBDkt7G35TzDV/G9ZGfU3FYQXLciYSjGTYseGL+3PQ
	 D03di5YGxZ+KD8SF/U/pYr8hUhsc987RoBMP9Fm7Sj6UamzxcnxEhpZVDIaLgYB8A0iIB
	 sB2FI0U3j2J/VBlnv1O6lkY5PwKD74Cl1VcpGBJzZQMS+yHvxmOAY+CkORpiHQpSC2GAt
	 EFwSsAiL1BasDIfRa2NHlDbMigpfmE8wiExvYuAN++4IztdFEBIC9gSHMK0HFqPFtO2vz
	 jI6wHAvBybaKhjsBuUHbmAX2jbzwCV4cHCx1DJemMEQmGULb4tjgeyPRDTOTuwHLvvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3EiP2W6;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B499606A32D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B499606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3EiP2W6
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-99e740a7131so1502460241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456288; x=1796061088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=s3EiP2W6C9rWTRANJD02kC0rMu5D6EOf2U7qCFyuxXfco7bRwcSF0OeZ9O91E7q0mv
         INPX1gao+8tk40d0eDovRIUjazxEs3JcfJSCg1zneOhmk27GGb2rMlKhlAee30KzJ66B
         Booura9kxnA0CtbF5ErSGSVYOdyghif3q88oSm6wNB+bGtv43Q3etjmAi6wUs21uoSpG
         a41cl7PanCqexrEj+drMbiBZudLBdKZM4v7Z3pH/LL0xsR6X8QQ26QrdRdIncL6FrN5t
         8e0ukNmVPOxKhGYpXf86EGAFcAWLLt2lDTXtuRWCZKuy/Fbp3ZT62Kp0D8T5K9KWfXDL
         mLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456288; x=1796061088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jN8ZW1W9pvSO3eLma459NbPkZY6h/rYF8OFGbNiDuQw=;
        b=jyAGUISX5eYjgt2zzFWv1BHk32dy4hAFXJ4kvRwmWVEvIIKZw4p7qDLjpKa2e2Hxqx
         NjgOT2mthdLEc2R/F32l4UfhQ6srWjA1JT4sPPl4FL24c/y9Ey9gNFcLffletYDwINGH
         u4bwFifeM+84FZx3PdaDtk9tToO6PA4vI9uHsneoXm6JhwXs1NTBU4gogtYSxaoe5Q5w
         oq+eeMOeFa6p76lTv3fHFVmLAnvkMtf/+yx47kRiL5K8VvZnrFdiomHSL1HxN9qrFQZB
         M54eSWFQEXFzNu9C9YnmbcjJWk9/xCaAeiEE68U7qY++sk2imRaok50UhXLw5r3Xm6Nr
         vZ5A==
X-Gm-Message-State: APuU4Z+gGec0lfYsKtAgJKZpRhsNb0kfvAg2xiVEgeQA1CJyq+4GN5TY
	M0SInjJ+jqpYv9YGhK9TAqGZw4387fRvpcD3rx8mtmsi0gYRuZCrC3EWTBaCaQ==
X-Gm-Gg: AZFdTZctmttsByS4o7UxvNlK92iYlI+bNQYFHBRiqWZZ5CuJXqWiq/RfDDxCwxCatzG
	4sJoptGVK9s3OyMxQalWE16CKnTf3YoDjpTUPlrmJ5iNKtPW54N3/xy603fAAYeoIRyaSPxAD6h
	EsIgmTxDUoPeInaEN0TzyAF/mUgtR5FAgsnDUCbHJMfwUCplKHieeQnyNgps9cw0BJ8L3bUH7XN
	VJbQIGv8vukx2X9p43R1GdhN8UmhIBcmWtxuvcwncTJWkMDAXTF4eeUVyVUGKdZhzBvvH/fp3NN
	W/ldyK17d+C1PvYMB00sIPFaY7mS3TSpl5XoHTOODmNfpyG3F8AgCYRL7zaodk9Yq/g3q75PYh+
	7wirF70wZOVuWCP3gfi/LY2plnvYUjFTKM6PKEFq3UWwtquhZ2+pehyy8EgwEduvR4pVlnKa3B4
	4Sxg/QxwZ5X/Us2baFO8ZD0hglMgfBzu3De10JOSa4Bzur9GYvA4wMRxN9Lf+pQoKfqeSP5ZE5M
	MtYAVLB55RCF/XP0F8v0OQETQlC2cgDRRZ5bVxuvLCwuE5usHttnAMh6pg0Z8o6OFSXCf9uaCjZ
	+ZgqYWkcMoS6H5u3ajDe6rgLmnwb4WnWT/rkImxlMgcXJpyYylIEQU8h01UdizQboQLWOAkAHcd
	KIdscLlGjz+9Y9ag/rBeDsJOVLuW3ooE/jpgtGk9cJxy+iNAle8EDpsoj3+uNYdriaugk4sRED4
	xrSfY=
X-Received: by 2002:a05:6102:508f:b0:7cc:174b:f7c3 with SMTP id ada2fe7eead31-7d739674d2fmr5590964137.30.1795456288459;
        Mon, 23 Nov 2026 09:51:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 02/18] shared/rap: Reset the readable Ranging Counters per connection
Date: Mon, 23 Nov 2026 12:51:05 -0500
Message-ID: <20261123175125.3642617-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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

