Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429596;
	b=kH4b7ylscksNhz+wfhj47aygt129nefNR11KOOUbffDQQGg/PZpizdmat4vBD9PtRmmX
	 k/OZcZQqvwYvXBhDPlgR12CipwjQZGF8SyeE4NUevAZXPY2Saihke6pT3FKJ/1nt3jPIl
	 PLGgTsXBtrIYPfu1ZRTrbONwWykGetfmoSrwHQOO5beSiGVhdGtC4copZsTYf3jCpMOSb
	 xCX1axjn7jXdfdilBpO72J3am9lgCHUPkN5xqMXYIS97NubnEKDhoHPf99Kl2cFIAXUex
	 qeVIHW034L6Ws/UidCbE6R+DhiLnr0AK8eMy0oIG7hScKq9GfxlmyvLxysJnqXHgFvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wmylTaOV8nr0wwkQbNW1AzuYnM2IAYmUuAuAzfzgXdg=;
	b=d7zvk0fmpuqZ1Bb+NWU1ALSqBMCg4SdZ3UunKd/lviRJCATVjfB/6SFb4L26US1+7Joh
	 fRohoLgT76n2WoWaW5GIAOemZgBS8mnx3R+BCTGCdXbrhuEA1mVk8evu+6RHZbjDgm1I3
	 xlQFLYIOQ5bQfQul3wJVeExl/E6zMSPDor1jVRdLwNsYiEKgdsr9iwO7WkQONnsJ1wGrm
	 qDL5fHLifVG/TFHaJyjIS330QnKnX3aG7AIUEIa2ICTybjWN6RICwOnNSKIFEIsCWntVH
	 NQhPFwf8r4IZazcryqrEMFUzUoUjaDV42RP3TwzeY/CH5lHW1SF42jFTHcy5/O+gRaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DndCjx7Q;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906B606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B906B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DndCjx7Q
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso1250292e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429595; x=1795034395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wmylTaOV8nr0wwkQbNW1AzuYnM2IAYmUuAuAzfzgXdg=;
        b=DndCjx7QLpWZtEWGrDwh7DzL/HazyTri6LNeh8LjNdDDVNhF4FtWHmH2skjemTtsE9
         +xIPwrNG0K2fWuSisc96n+1HuUq61d3gkldmMZOn2sDKxdYcIgibtIq08BLNVc8sDtmf
         Zts/PPldJBLZeFjNwNCLbNiRRcLdDvKTqMHruhvy6w62cXYvhHnXdSCFfDF6rHHLYa6R
         SqZtBiw3BKT192DnaVzCn9vw1msNT4BywRQh9zY0PQPCdtFcdQFdTo3MMyPG+D20RvRf
         ubtccZU9068l6R8/+ebN+633UvBywWWy7x0VOJdZ8ycv26rvA2OP8nUl9zcVJ/X16eNE
         v+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429595; x=1795034395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wmylTaOV8nr0wwkQbNW1AzuYnM2IAYmUuAuAzfzgXdg=;
        b=GcnIUpROfEew7Us/a9U5NsUtgHjIbnWSOcWiogufBvBwJbFC+5GR/VK5vm9YBha7jX
         u7bzeMvOC0G2wxC4ikHc77uq4ahIn3c34pC3cFGqPjzF7fXvPOat/q2PfKksxrsyX03u
         RDj1dCdg7JGLs8Q5JrllenssbgmgIznJ/Rp9lT7LoS4+k/chREBTTX8G+hZ7IgqyyHdF
         aIhP8vQMH7P1tyGEJoMfjTk4M3cJr9+K+ROId2K7Pr+ZT29fw74VIpDoc5BshpOlAVcI
         Er0Wginxe5fW1prRAZPVT4bWNHNHWBr5nLQd7ruvty93NnAmYcmeU535xSLjVzDGn6pM
         DhPw==
X-Gm-Message-State: APuU4Z/9y2nEab5uet44P5PfBv+14z4doc2Uv3EkWStvuMNHMqjldmkj
	ZB2jGXLFsbQKimSNxCVtRIModPRE7ZcgO39CauHq70LpEdrTRkleQsbEO7uotw==
X-Gm-Gg: AYBFou3vjZFsKsqMoSw1RAFdXDPaV2qtg0Et6r2o8sdIFQBb2fUztSoEru3q/JEqDlP
	7q2RpL2jc6nn66JJuL8HCYoDri1iEYvfgP5V1vPAy9htRAX8Axy3+whvuitVtQB0xEa2iKW1ts0
	rGAxWN0fa9AVVCFElMo/Kcw/e/G1x6m7C52TJOrCODbZUFk1F8GG87IjdIHtmiUJcX8BDKx7Oz1
	SHrG1+ioL0OJ1ko5ZFzj620mCO4tPsA0NAUB7EAaxGCf6AfFf1uxabDO9nJ1j9RqJT2Oly0SQAE
	SJaRWZFMdDuOJEdeZYkWYT6/o29dSAFRofU705IUe4OpIxgCdynu5B4HlwLdI99EghZOy2kYXf8
	AP0PSaKi3Grz1etG5ngGzu6BZuTv9Xtqt2atFkRsAo81Q5V6j2YpDNgxo1aNg/zSV8XsmFLtUkt
	GJ72/tlLf+bGwgSfc/cqO/98+VryvNqFtliHeGss5wU3TtycD1+lKTQv1WVc38HMEXNetBThaB1
	v9IkctRvZk+l602CAwPXOVvEqah+ddSNhn7JEsDjiKeVlpi6CRwh7gxM0EmR39HdGMyF8bsoY4E
	IqNwCSasOAfNTsRQQqDBmLIlOf+sgYRJjIqNKe//Nid1itCIG8pOCYp7WitIN92TeyqP1B8mT1/
	xc/TZS6JIL8MJx/kYmzJG147Ugz9qNr9wCrBqtRRcQBEnrlOICvTcbi9NX5cDIZjSuS1fORWn9r
	EOxKku
X-Received: by 2002:a05:6102:50a0:b0:7cc:2c29:54ef with SMTP id ada2fe7eead31-7d5060ed817mr1428903137.19.1794429594054;
        Wed, 11 Nov 2026 12:39:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c2f3bfasm4301380e0c.0.2026.11.11.12.39.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:39:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] shared/hog: Use util_iov helpers to parse characteristic values
Date: Wed, 11 Nov 2026 15:39:46 -0500
Message-ID: <20261111203949.3874673-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111203949.3874673-1-luiz.dentz@gmail.com>
References: <20261111203949.3874673-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Parse Report Reference, External Report Reference, HID Information, SCI
Mode, SCI Information and Protocol Mode values with util_iov_pull_*
instead of indexing the value, so every field is checked against the
length of the value that was read.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/hog.c | 62 +++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/src/shared/hog.c b/src/shared/hog.c
index ca560831bb14..e62423fa4c33 100644
--- a/src/shared/hog.c
+++ b/src/shared/hog.c
@@ -267,12 +267,14 @@ static void ccc_read_cb(bool success, uint8_t att_ecode,
 {
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
+	struct iovec iov = { (void *)value, length };
+	uint16_t ccc;
 
 	if (!success)
 		DBG(hog, "Error reading CCC value: 0x%02x", att_ecode);
-	else if (length == 2)
+	else if (length == 2 && util_iov_pull_le16(&iov, &ccc))
 		DBG(hog, "Report 0x%04x: CCC 0x%04x",
-				report->value_handle, get_le16(value));
+				report->value_handle, ccc);
 
 	/* Enable notifications regardless, as the HID Device may not
 	 * persist them.
@@ -286,6 +288,7 @@ static void report_reference_cb(bool success, uint8_t att_ecode,
 {
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
+	struct iovec iov = { (void *)value, length };
 
 	if (!success) {
 		DBG(hog, "Read Report Reference descriptor failed: 0x%02x",
@@ -300,8 +303,9 @@ static void report_reference_cb(bool success, uint8_t att_ecode,
 
 	cache_value(hog, report->ref_handle, value, length);
 
-	report->id = value[0];
-	report->type = value[1];
+	if (!util_iov_pull_u8(&iov, &report->id) ||
+			!util_iov_pull_u8(&iov, &report->type))
+		return;
 
 	DBG(hog, "Report 0x%04x: id 0x%02x type %s", report->value_handle,
 				report->id, type_to_string(report->type));
@@ -438,6 +442,7 @@ static void external_report_reference_cb(bool success, uint8_t att_ecode,
 {
 	struct ext_ref *ref = user_data;
 	struct bt_hog *hog = ref->hog;
+	struct iovec iov = { (void *)value, length };
 	uint16_t uuid16;
 
 	if (!success) {
@@ -454,7 +459,9 @@ static void external_report_reference_cb(bool success, uint8_t att_ecode,
 
 	cache_value(hog, ref->handle, value, length);
 
-	uuid16 = get_le16(value);
+	if (!util_iov_pull_le16(&iov, &uuid16))
+		goto done;
+
 	DBG(hog, "External report reference read, external report "
 				"characteristic UUID: 0x%04x", uuid16);
 
@@ -901,20 +908,19 @@ static void sci_mode_read_cb(bool success, uint8_t att_ecode,
 					void *user_data)
 {
 	struct bt_hog *hog = user_data;
+	struct iovec iov = { (void *)value, length };
 
 	if (!success) {
 		DBG(hog, "HID SCI Mode read failed: 0x%02x", att_ecode);
 		return;
 	}
 
-	if (length != 1) {
+	if (length != 1 || !util_iov_pull_u8(&iov, &hog->sci_mode)) {
 		DBG(hog, "Malformed HID SCI Mode: length %u", length);
 		return;
 	}
 
-	hog->sci_mode = value[0];
-
-	DBG(hog, "SCI Mode: 0x%02X", value[0]);
+	DBG(hog, "SCI Mode: 0x%02X", hog->sci_mode);
 
 }
 
@@ -923,6 +929,7 @@ static void sci_info_read_cb(bool success, uint8_t att_ecode,
 					void *user_data)
 {
 	struct bt_hog *hog = user_data;
+	struct iovec iov = { (void *)value, length };
 	uint8_t min_conn_interval;
 	uint8_t num_grps;
 	uint8_t i;
@@ -932,25 +939,23 @@ static void sci_info_read_cb(bool success, uint8_t att_ecode,
 		return;
 	}
 
-	if (length < 2) {
+	if (!util_iov_pull_u8(&iov, &min_conn_interval) ||
+			!util_iov_pull_u8(&iov, &num_grps)) {
 		DBG(hog, "Malformed HID SCI Information: length %u", length);
 		return;
 	}
 
-	min_conn_interval = value[0];
-	num_grps = value[1];
-
 	DBG(hog, "SCI Info: Minimum Supported Connection Interval: %.3f ms "
 		"(0x%02x) Number of Supported Subgroups: %d",
 		min_conn_interval * 0.125, min_conn_interval, num_grps);
 
-	for (i = 0; i < num_grps && (2 + i * 6 + 5) < length; i++) {
+	for (i = 0; i < num_grps; i++) {
 		uint16_t min, max, stride;
-		size_t off = 2 + i * 6;
 
-		min = get_le16(&value[off]);
-		max = get_le16(&value[off + 2]);
-		stride = get_le16(&value[off + 4]);
+		if (!util_iov_pull_le16(&iov, &min) ||
+				!util_iov_pull_le16(&iov, &max) ||
+				!util_iov_pull_le16(&iov, &stride))
+			break;
 
 		DBG(hog, "  Subgroup[%u]: Min %.3f ms Max %.3f ms "
 				"Stride %.3f ms", i, min * 0.125, max * 0.125,
@@ -963,15 +968,14 @@ static void sci_mode_notify_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	struct bt_hog *hog = user_data;
+	struct iovec iov = { (void *)value, length };
 
-	if (length != 1) {
+	if (length != 1 || !util_iov_pull_u8(&iov, &hog->sci_mode)) {
 		DBG(hog, "Malformed HID SCI Mode notification: length %u",
 								length);
 		return;
 	}
 
-	hog->sci_mode = value[0];
-
 	DBG(hog, "SCI Mode changed: 0x%02X", hog->sci_mode);
 
 	if (hog->sci_mode_func)
@@ -1007,6 +1011,7 @@ static void info_read_cb(bool success, uint8_t att_ecode,
 					void *user_data)
 {
 	struct bt_hog *hog = user_data;
+	struct iovec iov = { (void *)value, length };
 
 	if (!success) {
 		DBG(hog, "HID Information read failed: 0x%02x", att_ecode);
@@ -1020,9 +1025,10 @@ static void info_read_cb(bool success, uint8_t att_ecode,
 
 	cache_value(hog, hog->info_handle, value, length);
 
-	hog->bcdhid = get_le16(&value[0]);
-	hog->bcountrycode = value[2];
-	hog->flags = value[3];
+	if (!util_iov_pull_le16(&iov, &hog->bcdhid) ||
+			!util_iov_pull_u8(&iov, &hog->bcountrycode) ||
+			!util_iov_pull_u8(&iov, &hog->flags))
+		return;
 
 	DBG(hog, "bcdHID: 0x%04X bCountryCode: 0x%02X Flags: 0x%02X",
 			hog->bcdhid, hog->bcountrycode, hog->flags);
@@ -1047,6 +1053,8 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 					void *user_data)
 {
 	struct bt_hog *hog = user_data;
+	struct iovec iov = { (void *)value, length };
+	uint8_t mode;
 
 	if (!success) {
 		DBG(hog, "Protocol Mode characteristic read failed: 0x%02x",
@@ -1054,12 +1062,12 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 		return;
 	}
 
-	if (length < 1) {
+	if (!util_iov_pull_u8(&iov, &mode)) {
 		DBG(hog, "Malformed Protocol Mode: length %u", length);
 		return;
 	}
 
-	if (value[0] == HOG_PROTO_MODE_BOOT) {
+	if (mode == HOG_PROTO_MODE_BOOT) {
 		uint8_t nval = HOG_PROTO_MODE_REPORT;
 
 		DBG(hog, "HoG is operating in Boot Protocol Mode");
@@ -1067,7 +1075,7 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 		bt_gatt_client_write_without_response(hog->client,
 						hog->proto_mode_handle, false,
 						&nval, sizeof(nval));
-	} else if (value[0] == HOG_PROTO_MODE_REPORT)
+	} else if (mode == HOG_PROTO_MODE_REPORT)
 		DBG(hog, "HoG is operating in Report Protocol Mode");
 
 }
-- 
2.56.0

