Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251B2627E2
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234034; cv=none; b=mfxi5kPTyUd/mVWbSrtfqo9G5m1648FgqgrqIJP72LeC+IJMvDAXyB1RIlTscFOZdPOjhxZxGSiS8hwhTPfmchjMmDVMs2JsHxFy4LFA24b6MtHcxlxMuGY9xgfT2Zvp2EqMghtTjG5jyZ01aNInzQTm9LFJKJDYQrZZDwPXawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234034; c=relaxed/simple;
	bh=s/fBpRKRwdp0GU83TvjtnYPZz7NKUhBHuYwO995Vffo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G652xG2Z8v8+w4FIDPC2w7RMUKGjvahZXi39WXrKNQ/IChp1RsqM1FkwXrtC84wFsXDq2RZAhU5lEsR332gS++inpd4PJn+PhG37IWqIHWkSOwkNXsYgDhQYBTCypeb8EhUrEPz7ycbvZapQDh7U66S0sc3otnXKgEWxz7ljYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SuAHx38n; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SuAHx38n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745234030;
	bh=s/fBpRKRwdp0GU83TvjtnYPZz7NKUhBHuYwO995Vffo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuAHx38nuYzm9idj8yBB3VX9+fVjwpPEUa4bfzBwQVTTPVJlCJ2AsvPI8QckkE6WR
	 TO9Hu/IKeG+AEYJTEGABu+U/+oxlFZQG7vxeseb2B/jPItDXMo6OmOLp1/hdfZzEhM
	 Wl2kwVntSBBEuL2wNQcR8krKYKIaMpqVlT+5MZefrWqivFCZ6Z0vHl7SwNjRfgNmvi
	 TS8NsJ94atHEahKFe9vZxzIrILLz4eZAxhx2xSlqvVqSdYPDP1F9O+uNHONU5Y3BjE
	 9RGwS9ukgE6gUtNx03EE3yPszTtFP9yTGPpoVhgUgvWakNpw3Ad/3qIe8yfoFF+QR9
	 sWwNuVFy5plkw==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 61F3717E00FC;
	Mon, 21 Apr 2025 13:13:50 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 5/5] input: Validate the Sixaxis HID report descriptor
Date: Mon, 21 Apr 2025 13:12:51 +0200
Message-ID: <20250421111251.108943-6-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421111251.108943-1-ludovico.denittis@collabora.com>
References: <20250421111251.108943-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that the Sixaxis devices can't work with encryption, i.e. they
only work with BT_IO_SEC_LOW, this makes it harder to notice if the
device we are talking to is the expected Sixaxis gamepad or an impostor.

To reduce the possible attack surface, we ensure that the report
descriptor that the device provided resembles what a real Sixaxis
gamepad should have. E.g. it should only have Usages for `Joystick`,
`Pointer` etc... and nothing unexpected like `Keyboard`.
---
 profiles/input/device.c | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index eb2fb5c8e..2297eb4ff 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1062,9 +1062,72 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 	return FALSE;
 }
 
+static bool validate_sixaxis_rd_data(const uint8_t *rd_data, uint16_t rd_size)
+{
+	uint16_t i;
+	size_t data_size = 0;
+
+	for (i = 0; i < rd_size; i += 1 + data_size) {
+		uint8_t b = rd_data[i];
+
+		/* Long items are reserved for future use, HID 1.11 Section 6.2.2.3 */
+		if (b == 0xFE) {
+			DBG("The sixaxis HID report descriptor has an unexpected long item");
+			return false;
+		}
+
+		/* Extract data following the HID 1.11 Section 6.2.2.2 */
+		uint8_t bSize = b & 0x03;
+		uint8_t bType = (b >> 2) & 0x03;
+		uint8_t bTag = (b >> 4) & 0x0F;
+		data_size = bSize == 3 ? 4 : bSize;
+
+		if ((i + 1 + data_size) > rd_size)
+			break;
+
+		const uint8_t *data = &rd_data[i + 1];
+
+		if (bType == 1 && bTag == 0x0 && data_size >= 1) {
+			/* Usage Page (Generic Desktop) */
+			if (data_size == 1 && data[0] == 0x01)
+				continue;
+
+			/* Usage Page (Button) */
+			if (data_size == 1 && data[0] == 0x09)
+				continue;
+
+			/* Usage Page (Vendor Defined Page 1) */
+			if (data_size == 2 && data[0] == 0x00 && data[1] == 0xFF)
+				continue;
+
+			DBG("The sixaxis HID report descriptor has an unexpected Usage Page: 0x%02X", data[0]);
+			return false;
+		}
+
+		if (bType == 2 && bTag == 0x0 && data_size >= 1) {
+			/* Usage (Joystick) */
+			if (data_size == 1 && data[0] == 0x04)
+				continue;
+
+			/* Usage (Pointer) */
+			if (data_size == 1 && data[0] == 0x01)
+				continue;
+
+			/* Axis usages, e.g. Usage (X) */
+			if (data_size == 1 && data[0] >= 0x30 && data[0] <= 0x35)
+				continue;
+
+			DBG("The sixaxis HID report descriptor has an unexpected Usage: 0x%02X", data[0]);
+			return false;
+		}
+	}
+	return true;
+}
+
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
+	bool sixaxis_cable_pairing;
 	GError *gerr = NULL;
 	int err;
 
@@ -1090,6 +1153,14 @@ static int hidp_add_connection(struct input_device *idev)
 
 	sixaxis_cable_pairing = device_is_sixaxis_cable_pairing(idev->device);
 
+	/* The Sixaxis devices must use the security level BT_IO_SEC_LOW to work. */
+	/* We reduce the attach surface by ensuring that the report descriptor only */
+	/* contains the expected Usages that a real Sixaxis gamepad has */
+	if (sixaxis_cable_pairing && !validate_sixaxis_rd_data(req->rd_data, req->rd_size)) {
+		error("The sixaxis HID SDP record has unexpected entries, rejecting the connection to %s", idev->path);
+		goto cleanup;
+	}
+
 	/* Make sure the device is bonded if required */
 	if (classic_bonded_only && !sixaxis_cable_pairing && !input_device_bonded(idev)) {
 		error("Rejected connection from !bonded device %s", idev->path);
-- 
2.49.0

