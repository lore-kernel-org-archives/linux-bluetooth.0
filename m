Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA11474CC
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267861; cv=none; b=C2EGOl5kYsNtXC5F+73xZx/9UteIQvMmWGpCO8O8QF7xV3+TjYWELsCOqdbIFbeGDAty49i2qaOraid4d+pMIHJtpbCzdIEKJ4NXl+zOyKbQniBbAH29ndgaU/ehejZ/Ltskq+GyTLm2KsMJP4G/ao8uqBve8c0RvHy8F4N77PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267861; c=relaxed/simple;
	bh=QTshT36JN9XAxbK66d0eliBcA5b9nXYiQOCdwTNKuak=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VR0/+O4+xIn+55OVgBgbUGH2CpbV5grmrhtfeGDamJbJPQbXkCEP31L29lr2wO+zAq3gApJyjcDEAstpLl3vs0O3pN20x7Pw0k2hDThP42hnUZGQXUB0chXMmCB2UKufwXzXsVJNAzigraBhGbhkYpoyVZd0XN219WSVflx/YLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU8tYlXN; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU8tYlXN"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-95cc8ac98bfso570568241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778267859; x=1778872659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MmoJ5sF87wsPujoDyBGCS5lBa4UsqPxW1MXsAXuu+o=;
        b=KU8tYlXN0ixPg76CC8265bbDj7r4UkKkiUsmVDwT8flCoE8M4onrg7ZHQrr1bAv1Qu
         T6XA3djEzGW6RqdkpZLYjYMtN4Ou+fpRD3Xzs1THytfhmo7/A8mf1ntj0uuK2FfwJFLb
         taNtgHDegygGtPaopLHXyV997qiLyiAXHXq7rBNogpEheMArl6+ceIZ0Sd2UvnCa9oOW
         2Ozu7hfBrWJVzmpMv79P7Xd/7KLZkNRjtEfXrx9fM2C91VFWdCK3K5JXSIb1wbsPD0Wq
         3ST2gNUmnCThv6VmP5OqQazoaHXNlvj3r8DE2NWFrk5taKlEZeHDlAD+puCCS1Y+/WXd
         /INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267859; x=1778872659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MmoJ5sF87wsPujoDyBGCS5lBa4UsqPxW1MXsAXuu+o=;
        b=k9Iw8W/8wXFmfElnFtu511fqSZzWTKtedKfskucAsSmQjJu1715Vv06iCJ9f8id7KC
         erxwR7polMZhcZMVVpGPe3JE1A0/ebOvVsLVyeyJwMVE6ys0kF/8CJWprGIEIySiuygN
         x2JSUtyWyGw2GK1tsU05S/nXiOGFPDZymNM8zxjXNfVN4mxixrhG1M/7Z/uiNu9N5xJJ
         l86/3hkfqroHmjWfD+par2Si5nR38iuyuxa2Z9LTagvwQ3hOX2wtsDzASTNzp9L2XxrW
         IcCVaYV3FWJjRaWhAZTFz6a4/wB9Dqq/3SYWq6oULNz1OboB873DmdRvxC/eqrAGsusp
         a+Rw==
X-Gm-Message-State: AOJu0Yw8VH6rq/IBbIR0L+XY9o98H1Edz+1jZSTMC2Eymvler6bUPnZt
	QeYJbBQM2oQQbv9Q5XanwhXeUg7T6JjqXnzNE9Kf7fnuOyZTav5Z3tnsosPIIBZ7
X-Gm-Gg: Acq92OEQnRW0vgqBUuPadOs6CG3ygI0I0zmnsgLCcmoqoRfCrUWXDRwbhpZteN2vhn+
	6P1QaJbxO8IoueoABslQj2LhrhSeoAB3f1SCUjHBJZNdqaG5lcr2baomXdami9kevOQk46YsChX
	QitP50qhPZpDtvOf+UfPylTZhOGp1AWVPln8evJxh+3ONZN0qc3jwVw9VQ0LMekRXO8oEnwWKEb
	v10EZIHo+TBbkdvJrPv6m7nJjgldfaBwUg2xRmU96TWNPFFHJ803GJ3n28UsXnXaKsd6FrN1PLl
	QqdNVCmsUm0Z2Qc2Ps9vQFKaCeaaLC2fkYhQGU8ShR3w6bZvZ15mhl3RNXbI4rPY7vH5X62ozKG
	OYqqeBVnGfjhqdUdJzw7jMOKGljvyoDBy90TXjlurOWP/7o3AcNSDMA6jTN2BqmM8sBqSkHJtak
	U30jjuU0odTYKx3ojb3AGiNLWd8/prZ/8tf3BF70wlz8LLRA4L7ygQuShmmXS+RrRfELUgvf3B+
	Hez2i2mfpUI3Yjo/LN7yg6qPclC
X-Received: by 2002:a05:6102:4a86:b0:631:7781:fe93 with SMTP id ada2fe7eead31-631778225b3mr923232137.19.1778267858834;
        Fri, 08 May 2026 12:17:38 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95f21bd2853sm1385124241.13.2026.05.08.12.17.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:17:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH BlueZ] monitor: Fix RAS CS step mode parsing issues
Date: Fri,  8 May 2026 15:17:28 -0400
Message-ID: <20260508191728.428868-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix double space typo in print_ranging_steps signature.

Fix ToA_ToD sign extension using proper cast via (uint32_t)(int16_t)
instead of unconditionally OR-ing with 0xFFFF0000 which corrupts
positive values.

Refactor print_step_mode_3 to reuse print_step_mode_1 and
print_step_mode_2 eliminating ~90 lines of duplicated code.

Initialize first_segment to false so the error path via goto done
does not incorrectly print remaining data when the segmentation
header was never parsed.

Improve Mode 0 step data length heuristic with better alignment
check and clearer documentation of the limitation.

Assisted-by: OpenCode:claude-opus-4.6
---
 monitor/att.c | 122 ++++++++------------------------------------------
 1 file changed, 18 insertions(+), 104 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 278ac5675fd4..7506dc528e85 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4425,7 +4425,7 @@ static void print_step_mode_1(const struct l2cap_frame *frame, uint8_t len)
 		return;
 	}
 
-	print_field("          ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
+	print_field("          ToA_ToD: 0x%08x", (uint32_t)(int16_t)toa_tod);
 
 	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
 		print_text(COLOR_ERROR, "          Packet Antenna: invalid");
@@ -4501,13 +4501,7 @@ static void print_step_mode_2(const struct l2cap_frame *frame, uint8_t len,
 static void print_step_mode_3(const struct l2cap_frame *frame, uint8_t len,
 				uint8_t num_antenna_paths)
 {
-	uint8_t quality, nadm, rssi, antenna;
-	uint16_t toa_tod;
-	uint8_t ant_perm_idx;
-	uint8_t i;
-	uint32_t pct;
-	uint16_t i_sample, q_sample;
-	uint8_t tone_quality;
+	uint8_t mode2_len;
 
 	/* Mode 3 = Mode 1 (6 bytes) + Mode 2 (variable) */
 	if (len < 6) {
@@ -4515,101 +4509,18 @@ static void print_step_mode_3(const struct l2cap_frame *frame, uint8_t len,
 		return;
 	}
 
-	/* Parse Mode 1 data first */
-	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
-		print_text(COLOR_ERROR, "          Packet Quality: invalid");
-		return;
-	}
+	/* Parse Mode 1 portion */
+	print_step_mode_1(frame, 6);
 
-	print_field("          Packet Quality: 0x%02x", quality);
-	print_field("            %s", packet_quality_str(quality));
-	print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
-
-	if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
-		print_text(COLOR_ERROR, "          Packet NADM: invalid size");
-		return;
-	}
-
-	if (nadm == 0xFF)
-		print_field("          Packet NADM: Unknown NADM (0xff)");
-	else
-		print_field("          Packet NADM: %u", nadm);
-
-	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
-		print_text(COLOR_ERROR, "          Packet RSSI: invalid size");
-		return;
-	}
-
-	print_field("          Packet RSSI: %d", (int8_t)rssi);
-
-	if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
-		print_text(COLOR_ERROR, "          ToA_ToD: invalid size");
-		return;
-	}
-
-	print_field("          ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
-
-	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
-		print_text(COLOR_ERROR, "          Packet Antenna: invalid");
-		return;
-	}
-
-	print_field("          Packet Antenna: %u", antenna);
-
-	/* Now parse Mode 2 data */
 	if (frame->size < 1)
 		return;
 
-	if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
-		print_text(COLOR_ERROR, "          Antenna Permutation Index: "
-							"invalid size");
-		return;
-	}
-
-	print_field("          Antenna Permutation Index: %u", ant_perm_idx);
-
-	/* Use the antenna paths count from ranging header */
-	for (i = 0; i < (num_antenna_paths + 1); i++) {
-		if (frame->size < 4) {
-			print_text(COLOR_ERROR,
-				"            Insufficient data for path %u",
-				i);
-			return;
-		}
-
-		if (!l2cap_frame_get_le24((void *)frame, &pct)) {
-			print_text(COLOR_ERROR, "            PCT: invalid");
-			return;
-		}
-
-		/* Extract 12-bit I and Q samples from 24-bit PCT */
-		i_sample = pct & 0x0FFF;
-		q_sample = (pct >> 12) & 0x0FFF;
-
-		print_field("          Path %u", i);
-		print_field("            PCT: 0x%06x", pct);
-		print_field("              I: 0x%03x", i_sample);
-		print_field("              Q: 0x%03x", q_sample);
-
-		if (!l2cap_frame_get_u8((void *)frame, &tone_quality)) {
-			print_text(COLOR_ERROR,
-				"            Tone quality indicator: "
-				"invalid size");
-			return;
-		}
-
-		print_field("            Tone quality indicator: 0x%02x",
-				tone_quality);
-		print_field("              %s (0x%02x)",
-				tone_quality_str(tone_quality),
-				tone_quality & 0x03);
-		print_field("              %s (0x%02x)",
-				tone_extension_str(tone_quality),
-				(tone_quality >> 4) & 0x03);
-	}
+	/* Parse Mode 2 portion */
+	mode2_len = len - 6;
+	print_step_mode_2(frame, mode2_len, num_antenna_paths);
 }
 
-static void  print_ranging_steps(const struct l2cap_frame *frame,
+static void print_ranging_steps(const struct l2cap_frame *frame,
 				uint8_t num_steps, uint8_t num_antenna_paths)
 {
 	uint8_t step_idx;
@@ -4649,15 +4560,18 @@ static void  print_ranging_steps(const struct l2cap_frame *frame,
 		 */
 		switch (mode_type) {
 		case 0:
-			/* Mode 0: Default to 3 bytes (reflector)
-			 * Only use 5 bytes if we're the last step AND have
-			 * exactly 5 bytes remaining
+			/* Mode 0: 3 bytes without Measured Freq Offset, or
+			 * 5 bytes with it. The presence depends on the CS
+			 * role (initiator includes it, reflector does not).
+			 * Without role info, try 5 bytes if remaining data
+			 * aligns exactly, otherwise default to 3 bytes.
 			 */
-			if (step_idx == num_steps - 1 && frame->size == 5) {
-				/* Initiator - last step with exactly 5 bytes */
+			if (frame->size >= 5 &&
+					frame->size % 5 == 0 &&
+					frame->size / 5 ==
+					(size_t)(num_steps - step_idx)) {
 				step_data_len = 5;
 			} else if (frame->size >= 3) {
-				/* Reflector - default case */
 				step_data_len = 3;
 			} else {
 				print_text(COLOR_ERROR,
@@ -4742,7 +4656,7 @@ static void  print_ranging_steps(const struct l2cap_frame *frame,
 static void ras_ranging_data_read(const struct l2cap_frame *frame)
 {
 	uint8_t seg_header;
-	bool first_segment = true;
+	bool first_segment = false;
 
 	if (!l2cap_frame_get_u8((void *)frame, &seg_header)) {
 		print_text(COLOR_ERROR, "  Segmentation Header: invalid size");
-- 
2.53.0

