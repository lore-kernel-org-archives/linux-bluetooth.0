Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990034;
	b=Y1VBK+0ODJGuQT4r9+awgK7xvAULybmRE+zjLAomOfYgxj1nimFDSDwc77mBomRHERmj
	 PG0rFmD8Ck1/TEmjTrv4Lpzl3fo8Y6zpJCgvpsV+9yK7CRilxc8Z4a5b+cf+pz4OOIh3F
	 haudswzAeqlLJlHc/IUaJ3nZPGuLEtiTy9c0H27vWMsc9kuGdNYkJdNxOf37eWMkLV5ow
	 YfQTQpdTV7pmI6fUO+WwKqhx8a/BsUMeOMxBWbO4v916ckdpY7XzVagzFAL5TZNtDQYhl
	 w77QsLHXYIevYDm38cc/MU6lz8aA2CVg9BP8pGPp9FGPan7vOxXRVRLssTlwcjN7Usg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fLGqe0xIjuBs7QvGvPAxQNPs3KVLT+z5sUHLw5OLIMg=;
	b=XRoOTCe8sTaOSlDikufjTuBdPEPsVfCefiP0rfjDLM6WLSipK15QNdE58ATe3zlKvZFL
	 +IKVOEogemwpf9gaAOwQsamQPYvbkzo3N1Ju5Qq94ZukRaFRx4pnJ/4lBl4DtV8OGZFrz
	 +8lkEPnNZcRetSlQRz0Vl0L5XPwoR+1m2atmie+b/+WQSvZUAFN/QQPImzXTSqvFcEWDc
	 OkqRe5mfSAXZQTHy+pDBSNu1iAWYv1LTFshbKyhYLxchzYd30vjH+h9Gaj/facEB7cnEx
	 C/yS2JObt8czRIntQuLDeLbHOhODlwGlSHlnI3qHZEFsXaDExdb6XYQCRldgUZhMpaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D1k/RYee";
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACD606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12ACD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D1k/RYee
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eabf243d05so379957e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990033; x=1794594833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fLGqe0xIjuBs7QvGvPAxQNPs3KVLT+z5sUHLw5OLIMg=;
        b=D1k/RYeebrFtwmMmGHGn+W1VJvyJORgPnbTCYTuMu80zXd6JtwyPrX+wqWlXuIu05s
         zkzZwPurc/YzBxxCIPwQ5iVEycwT224j/Di5FO/HP6ODVSqvEwiOGdS3ouiVQWrfr0uQ
         6/kBm9p0+5fpa8WOvMWTUKb165Upjz2sHrF9gORgDTjgV19/WHo7gWYYuzvjnyrstFMn
         L6NfGaK7aZwFTRfgABWb0IkCaxGzTsWnaAtMnSL1lAWNTiugkgeFW0UuNnAllSG4tPbS
         BX0h1pV5vk8BLTKSGNCXlzbvvn2QOFOm8NkttHWJuU297E66h2ddVFe5piNbJ/gLpxWh
         Ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990033; x=1794594833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fLGqe0xIjuBs7QvGvPAxQNPs3KVLT+z5sUHLw5OLIMg=;
        b=Ti6gP+rzZFzZ39TgMNqSj8X+5OQJmR4tj4qt5Z7fCXIRuJZM0rSsLlBrISfO7DIBIp
         DmIZLJFQbUZ+DglUG22UqdtpzLvIpd3iIGhUtD3Ga0VCiikC5FdNVWb+fMkdfuX5kREp
         hWR3HUilYfZfwuNxVvxIVQfpNRvE3yt2RkYhtz1bBN11fXH1myL0C0fq+ybGVQbSw8u9
         o3EYgXnq4LH+J95aoHYXbTjBg5d2Qlxs6NB46cA9o3Pw6JjcDdafIrLPw0aJCs/hYkdi
         bnxDxRCclQRNeC7rmCFS8MVFX0Ku/rIjwiqZ3cuGkHzQiVs0e8187XMa7x88ybnQCUSl
         407Q==
X-Gm-Message-State: APuU4Z9PHiGbbhAvc3P4pq/9mqCJO5nrZpv8WNIP+8fcvqQ8EuFqhJQJ
	5BSn8Qd18W5SSHRrgwZBc7MCSRUhQkCT93BETstc2KCV/lTQQD10M5O39BvpdA==
X-Gm-Gg: AYBFou0wBbxSi+Iqf8Bi3zw7u4KoQ28o+mWL1ezIzQT7HGk7YaO4YWO7aOephjgJ6sY
	ypyn2vQ1Pc6WBDc6J8Ach0Z9NlvN2m5B9fxIcnazKat75BLWkouvX+Hah4I0P+JOaGUnv0CkW6I
	+ay91m5NTmdezl60bE/gNsvp3m24nYZKX6YIvewiPynDvge+aaEL0zmP7BbGz4Ee5FzUKqlQbK3
	d78iqoNrYehzRw/RdueND/HwE/WvP6PIMfOO3657HUKBbcuk2iisTVHQg5Q/6V/M8z1kEW00lFl
	M9Rrb9vWEyHp7tn5UCKRkxnupC6065U/nH+tNVqBOQeC6CBw15G8xNzKWAqz9tbKAShS/wHNiXa
	5SUtiNWZn/imKd1MAkmXaQK0Ddg1a0sM/4gw5VeRYgsjCqq6ZC1PZjr0Uuqawvdno/s2uLLc6jY
	nCNERsOkoBBYLtWJ6TF7D9A7029h/jC20f/2KErNWkKu0sQoML/i8O9kkt3s5kSsDvA6xoxhIQA
	9bguh9RCVR50YQJqFyRRWGfqtD7fHOGsFSKbllYbAN+pjyErTQ7Xf5JceV6U5fStCeHOIUxyBOD
	8seZOs+1yC2eOu7A6/XYly6jLeDzmaQT093dqCuuncUIsFAQ7JEn9MioeGw0unfH7lchdGHXElD
	BEPtVyJ/oRI46PraM4vm8U2FpNhj72OFKbjTSg2ebMfK4JRGoJdJsDJFQPAU9gEbG/xMw4VmBaO
	ASDa4=
X-Received: by 2002:a05:6122:1791:b0:5d6:7f46:b8dc with SMTP id 71dfb90a1353d-5ecc44825e5mr1738211e0c.21.1793990032975;
        Fri, 06 Nov 2026 10:33:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/8] shared/gatt: Validate Read By Type responses
Date: Fri,  6 Nov 2026 13:33:43 -0500
Message-ID: <20261106183350.3155282-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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

read_by_type_cb used the peer-provided Attribute Data Length without
validation, causing a division by zero when it was 0 and out-of-bounds
reads when it was shorter than a handle or the PDU itself. Reject such
responses as the other discovery handlers do.

Also check the iterator result and value length before reading the
Server Features value.

Closes: https://github.com/bluez/bluez/issues/2746
Fixes: d21412b96048 ("shared/gatt: Implement "Characteristic Discovery" procedures.")
Fixes: 76d63c91b27a ("shared/gatt-client: Add support for EATT features")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c  | 6 ++++--
 src/shared/gatt-helpers.c | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 836a59a8c990..09bd9c971ee5 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1565,8 +1565,10 @@ static void db_server_feat_read(bool success, uint8_t att_ecode,
 	if (!result)
 		return;
 
-	bt_gatt_iter_init(&iter, result);
-	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
+	if (!bt_gatt_iter_init(&iter, result) ||
+			!bt_gatt_iter_next_read_by_type(&iter, &handle,
+						&len, &value) || !len)
+		return;
 
 	DBG(client, "Server Features found: handle 0x%04x "
 				"length 0x%04x value 0x%02x", handle, len,
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index b3d5d8f1a483..e3281ec17758 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1299,14 +1299,15 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu) {
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 3) {
 		success = false;
 		att_ecode = 0;
 		goto done;
 	}
 
-	data_length = ((uint8_t *) pdu)[0];
-	if (((length - 1) % data_length)) {
+	data_length = ((const uint8_t *) pdu)[0];
+	if (data_length < 2 || data_length > length - 1U ||
+					(length - 1) % data_length) {
 		success = false;
 		att_ecode = 0;
 		goto done;
-- 
2.56.0

