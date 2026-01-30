Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEB32E6BF
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788610; cv=none; b=KCz8roiK4Nb6PUNOIAKXZPcSOFTf9xsHNzYk8mKQRY8m///nH4xtG8BpfdP5yYodwdHUEyvLv/kAxP3knfWl6iyBu7U/2p1/ZVfxl2YmjOxz3vbrTrDSwWAyeRxY3Cdh/loWapQz+jfwCJtBydfz4NDCuxPzATEPJTkWNDQ0vj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788610; c=relaxed/simple;
	bh=JV1HDMN/3vpccOCfKUw5arFWWbSDX93MFb74Vann+9A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LCARJbqaEVWOIRlT75ollggOY9+B6Y9WphEPceDPpkozkd3Wysx56bfaW1S+3l1vPRUPI89wOBl5uyBii9ShrM3nZVKl/JF4tA9j/QMTbHng87r/98Rrgwwxe0sMwuZMt35nbxq5/Kaq4UWTZFp1EHXruXpS0vepGHW2uHVe6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7Tum9Oc; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Tum9Oc"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9489fb38cbeso12433241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 07:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769788608; x=1770393408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dE8kDWA450sZhx8iPbGSIkLCD70bTPy4Q9EkVeZo9SI=;
        b=k7Tum9OcF21tF/6KsZgQrnCs9HdHtssn60JACXk/A89k0XMJMpic5y3yyBpYftSSo7
         ZJYOpHsgdk3nGnrdKjak0ltwCjbAxZPA5R7wDnRd55tM3yYAynuxVkC2+w3hbjXr0fst
         atXz36+ACsxggNYIR6pGE3dGUx/9Jk32mC/esw6QcQjHSQsu1Bjmfhf+TXUsmXzxdePY
         L/0FSD6Q98ycr/Jo/IAr731hdkUj1aD9gGqelBuQRWYt9UdryIHEDW/TRibhBzUX2HGY
         Rx9kavTn98bDoM54h7cU5JBX++zKYIt00ZONIC5lPx4eJtBU+njwHQ+UNMWGpsvxpP8y
         AEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788608; x=1770393408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE8kDWA450sZhx8iPbGSIkLCD70bTPy4Q9EkVeZo9SI=;
        b=qLnHCyEVjR8kQTO8mNhz9lKiGThMGqhUTC0nrzEicJ4O7mJgvqh2MHqf07FEbKOV+N
         E4rXxqSO5A50LV47liU/K7rem3tt3FLliCiIkTyWlaTgyhP/0nSMZiG/OKD2zUlazL5v
         MdtZvsS8SPaiXiRUOeszk7YZnelu/CtG/91bJnSyeIO9RrPDrPOEd3njQMTa6e5NiYrg
         JWaROUN4zTOIhx6tXhu+2psqTiGFOOmHCIiPQ9a3YnzedVqgUf7JEsXg5faNKHEnIQPw
         lNl2JplWhaLOMTyTUIsyXDDNH6xTw9VUAhXgZffSLY5P78vYsmEp+o1pGZ2RbRjOolS7
         QqMQ==
X-Gm-Message-State: AOJu0Yzu0Lo9CCaNbqY2hSi3fUmOgGC3wLWON2pD9bNISHx+iGtR1lcl
	FDdb++dkVDOOb4dCfflH3YL+BZoQB2p15yhkhj3yPJzXiQmgHHS4nRevwj17mg==
X-Gm-Gg: AZuq6aJdHr0f8JP+3YYVlTR+yP8cLlWoriMCra4oukyyiaao0tB7aZGJFLAWJ2TC6KW
	AdMDtg56Elf6wPVw4r/jj7j+Wl/KNLjmhDhoT8bqsXj8yzF0hhyHVSwef2MbT32YX3fZSzadgNF
	FRd4OwGU3DeVh6U1hF+p+QA9DeOGsSlvCjIj4P7P5ykNXZf2EYpaNOFn3ELGZK8ToINcX2TA0Ak
	WjZwsvzZEC6De/+u7uxFE3HIP7fEarG56OWWdMYB8BJzPMNsNWFA6VWTqacP5RZScJFy7WqVq5+
	0ZrKf86eRya9Y33143c5V8g0bIQ0ERstf0PnOY/Mz+o2W8rBI0PTwfoHmHmEtNGW10ossQEuuCf
	UwyTB3eFdXt/7PIxHPygLafqhngkhyj/glr9S1t6YO+9YPhoGhUMKK7mc4f/bmJ8EXTdYSzvpMx
	HQcc5MbXVhSO39KSHwbjkb5B6NLajZewjCzCFc0TDk77jrnn6RYbk5TTgQHQx6+/IV2F4cQsWgv
	jHQCw==
X-Received: by 2002:a05:6102:d89:b0:5ef:a312:e70c with SMTP id ada2fe7eead31-5f8e362fbacmr944243137.20.1769788606803;
        Fri, 30 Jan 2026 07:56:46 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f734b71547sm2176035137.3.2026.01.30.07.56.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:56:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] monitor/att: Add initial decoding for HIDS attributes
Date: Fri, 30 Jan 2026 10:56:36 -0500
Message-ID: <20260130155637.1150573-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoders to HID Information and HID Control Point
characteristics.
---
 monitor/att.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index 24aaa264c2bd..b77ffb66e89d 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4506,6 +4506,87 @@ static void ras_data_overwritten_notify(const struct l2cap_frame *frame)
 	GATT_HANDLER(0x2c19, ras_data_overwritten_read, NULL, \
 					ras_data_overwritten_notify)
 
+static const struct bitfield_data hog_info_flags[] = {
+	{  0, "RemoteWake (0x01)"		},
+	{  1, "NormallyConnectable (0x02)"	},
+	{ }
+};
+
+static void hog_info_read(const struct l2cap_frame *frame)
+{
+	uint16_t bcdhid;
+	uint8_t bcc, flags, mask;
+
+	if (!l2cap_frame_get_le16((void *)frame, &bcdhid)) {
+		print_text(COLOR_ERROR, "    bcdHID: invalid size");
+		goto done;
+	}
+
+	print_field("    bcdHID: 0x%4.4x", bcdhid);
+
+	if (!l2cap_frame_get_u8((void *)frame, &bcc)) {
+		print_text(COLOR_ERROR, "    bCountryCode: invalid size");
+		goto done;
+	}
+
+	print_field("    bCountryCode: 0x%2.2x", bcc);
+
+	if (!l2cap_frame_get_u8((void *)frame, &flags)) {
+		print_text(COLOR_ERROR, "    Flags: invalid size");
+		goto done;
+	}
+
+	print_field("    Flags: 0x%2.2x", flags);
+
+	mask = print_bitfield(4, flags, hog_info_flags);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static const char *hog_cmd_str(uint8_t opcode)
+{
+	switch (opcode) {
+	case 0x00:
+		return "Suspend";
+	case 0x01:
+		return "Exit Suspend";
+	default:
+		return NULL;
+	}
+}
+
+static void hog_cp_write(const struct l2cap_frame *frame)
+{
+	uint8_t opcode;
+	const char *str;
+
+	if (!l2cap_frame_get_u8((void *)frame, &opcode)) {
+		print_text(COLOR_ERROR, "    Opcode: invalid size");
+		goto done;
+	}
+
+	str = hog_cmd_str(opcode);
+	if (!str) {
+		print_field("    Opcode: Reserved (0x%2.2x)", opcode);
+		goto done;
+	}
+
+	print_field("    Opcode: %s (0x%2.2x)", str, opcode);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+#define HIDS \
+	GATT_HANDLER(0x2a4a, hog_info_read, NULL, NULL), \
+	GATT_HANDLER(0x2a4c, NULL, hog_cp_write, NULL)
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -4588,6 +4669,7 @@ static const struct gatt_handler {
 	GATT_HANDLER(0x2bc1, incoming_call_read, NULL, incoming_call_notify),
 	GATT_HANDLER(0x2bc2, call_friendly_name_read, NULL,
 					call_friendly_name_notify),
+	HIDS,
 	GMAS,
 	RAS
 };
-- 
2.52.0

