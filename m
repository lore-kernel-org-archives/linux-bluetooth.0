Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346531;
	b=NnKRF+z/bVOEUvOYXH0eNbPbhhT+6qvIhBjSwMOo0/Ruxb2Mx2kBY0jREnD9We63pnHy
	 uVgZWvEeLZm3UWzpQSvRPYQBac22tYfbzqT8Xywy/p9D7cU3nnKCGtUOIYjOpIxv2taVF
	 Hy3lCPkv7nN5jj7sJ4v9z84p7bi67gEAiX3VSLprMoO7vRYU61UhqN24w16LIDxq2GCOf
	 GOs+e31QHLScP1E+ovPoJkGIDcUWH1PhmKWhyCy/H9ZJlzGFAz55FjyZPhQUtz71ANjmP
	 MqUYJzP2znuTeMzyPhsAqaIHYW1kS9kiEeqViw3OHeFyQpKdNylz/DSP9qgazCwD/EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wmylTaOV8nr0wwkQbNW1AzuYnM2IAYmUuAuAzfzgXdg=;
	b=0L1oYu/9W9rEpoBklYLa+zsbckCAiHfGBa2QlNicF00wRASJq8V81CK8XfUcRpQYD2TZ
	 XnTsT3XV67nfUvJlFYoVC2iuqFQdTNlZgD4VO6rT/GyREKDJR70Yyg0JsVoGFtDRX5oki
	 mLNahY83cM6esFKDCH2dgjE04uqf3hEEANCR35O737L+DcA1BT0vrGCvrmbmvbocKgijU
	 K0w8jhN1VFevTR30K9JzBCrEK516dCB969w7wzA/x/U3+6d3jdMwcJrQ7+nzVITNveS32
	 4BzxnKIv4sY+hirRgtuyjU2E6yjmuEE+clb0r/XVbEzj9yBP70k1P5SwRK5u0qyQd6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RVn4Kawu;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F460A2600
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 470F460A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RVn4Kawu
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eae12762c9so916029e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346530; x=1794951330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wmylTaOV8nr0wwkQbNW1AzuYnM2IAYmUuAuAzfzgXdg=;
        b=RVn4KawuXnUWMX5cmsGMzlNLw2YoSyvwXw9WMBZVBsCfPX2urlIBzNALM8w8bEAtPm
         9Z+wfVhHaw9y3yj4KUD7RA0rbgHFYlT4g9C2vOk6vFMknuqiEIgUNoERkzz7RZgDMamg
         yUy7oXZOTCpOqzGXgmnjCBYaCilXyldU7xXiYrlvU0lpj6iA3so2eEmcTw4d4RkZQIYi
         ai5I5ARjOynQUNb77osq/7KkPWXGSJZX0kyXmIYjr3qw45IggOWGUsEfSHkHXb0SYQTm
         Y5hTIHG06cq8RzPJEgI4MgFIdRKYsrBXOmgpj+fgYs2bBYPvHf8UdZz/gDlek5Ww8c99
         obmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346530; x=1794951330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wmylTaOV8nr0wwkQbNW1AzuYnM2IAYmUuAuAzfzgXdg=;
        b=TjLDVZCo7pAKrWtdDraVnuAmHk7HRndYpJ25eo+GAk3kvrcbXs0aeasvgTW3h7xJft
         WEvlrO9KIA1X8RCwaIKdtjcf8Ay8GFruPn3lUiVsOwOpgt8zDb+egUrjS8YDS87Am5i3
         7KzwxZCJu0v3pr5dxpZS7eXZXV1ZR4P/5XhG3l9SeZdcz+2r8BtcdjurhhH1hPZYOArP
         7/i8mXv6t0uR2YnG9FU0LD5tCTFrs9Z84wVF2rQ6EVdRydll3Ob9kydMnRk820cjGAvb
         juCNHa/uwsK9QsOWvCjSCzj5YXQlM5qyGh3eAWkViDh3NmgcyiztdftQ8GVonK/spjjF
         xd5g==
X-Gm-Message-State: APuU4Z9jKFsDzCef4f3JsbDqoGMimxLP5030iWxTKtBbWHUsARk87/dC
	zjw7iTkziAP5gTx9IkpGezUe0Qij2sR2RGvjm5kxedJNR6OIr2FP0+lvuSRD2w==
X-Gm-Gg: AYBFou1kCiQCpeVDUH+OLj0yh23zg2/Oip2puX5blvGUFlVI2Tda1Y4MGOAx1166xPF
	lw++I9pmJigij3K5rlm9sV6C2AJzT4Am/PlIA5I2O/HHJs6iB2HiOfJqYYK64sBoEKkzQOpNm5n
	KM345f8b2BGrq89RegP5xOQpJZIorPWuO8cIA01m3uxys2oBzMunnylYtbIjceM9dAbhHITRFzV
	rkAF7tH+n7uYwlxUYZ8wpRW0AUMd3exwSKv9Z51pX6fYJkOZka1Bc6OzAYsXDnzHDHCqyH0OQIW
	q9Dmcd8n47Y3qcMpPYp4BtH5LQQH/LRdnD0QM7i6Trdyw1/PBOulwBszFVDCyGZxCLN/Qcaga83
	2zbBISKPLIgWcrJy2/prXU2czYivUS5lkkEQmIiH7nXG+IQalvTM08m4baKgh8YytytNxRreKrY
	nlAbjUSRUA76bCW57Y9R2xOLFMyH1eWZeD5FtCDq3XMhbzY1QLfgi64Q1gVWQ1d+VcBZNdKFvO5
	IbYxBIC8VKbs0wId4HIFKWwYVxXA8Bh2v9/3xeNllTM8f0CzkuFoD6OLoIDlobWO1yS2xEtEPmC
	GyNweyFFUO8aXdUpeyo+lg1OrCBycP4yr8A2peB59mAXzlHM8b7hNhvZOawL3YxDmKz0KxT93X3
	2ND7gQHctw083GsJJTdempWxAWj/X4XYt0T5BTZJxn5EV1QDglB66lrd1KxJSNNR0dC0HlDpLmk
	28wyo=
X-Received: by 2002:a05:6122:4b88:b0:5ee:1ade:ba3c with SMTP id 71dfb90a1353d-5ee1c44ac75mr82840e0c.18.1794346530087;
        Tue, 10 Nov 2026 13:35:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c614572sm2482189e0c.17.2026.11.10.13.35.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:35:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/5] shared/hog: Use util_iov helpers to parse characteristic values
Date: Tue, 10 Nov 2026 16:35:22 -0500
Message-ID: <20261110213525.2942339-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110213525.2942339-1-luiz.dentz@gmail.com>
References: <20261110213525.2942339-1-luiz.dentz@gmail.com>
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

