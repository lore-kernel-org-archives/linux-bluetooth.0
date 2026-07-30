Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835744839E
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433905; cv=none; b=ifDjtW08OOOUOkVeSyMoG/tkfnNiGKSQtKKJm7UgcoUSnQvrH0BY4weKNOLyudzI6jsKQO3oHv3m2jXzLo0/TGQZCP4nPwA3Cg/yfhv/zlRB9+CxdXdbzz50IYIVGh+c2eY+xdlRq3Wa755gmZKmBgio0EozLZpWecOnhjRRpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433905; c=relaxed/simple;
	bh=VnOvjyrEGRaXvYD4JcbJ/KVSu45fH4LyQBP9yJrnioQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EGzCiKuDJN5bM//eaWkkkF6J4QEUB9dXS4LU8S0VZKqf9R91DHz8yLAsQk9Tt7NtbwkWrswpzOLbSmj8kWju48SB4DsvjZ7dd0gnni6E/tgc+x+99WnRz6/o9wrk+U5OVgHqKHRfT5wTM0jNIqL0MQehvAjYBUSIpF9cACCa/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl1uv28L; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl1uv28L"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-963a722ed59so3200241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433902; x=1786038702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sh3oxt6pQyzJDmWc8STDx8Y+TVMkGV+VVSzWlbvjrv8=;
        b=cl1uv28LJdt81GjKbMrl0aqqKnxzKcGCpXtQ1LxakMltTRBUmrkDgq/y1UVOKxS3WO
         oSImob+g/3DJdepQY/rg8Qj+9ChTUBPbVpuR9GvAdLW/S5HKxO5g8p1MB4NSxs4Jy9+R
         hm77k0jIJlFhTJrXYIC1Jt/aCczJxnf22ejs4uyMeXtzjMqVgc95JKAxSsmpQg0Jfqld
         DUPLD7fEURqBVI59WSB4PE1PabUAV+eOZdFcPXRhKrS7R19Qow7i09OvJ9EwrDZtc2oa
         LvMMThPEyqbjnwnJP6BWwFQyTyqArqKA1AIuSwqu4eyws3/FIpwb0ol0/M8gPNsncHQ8
         A+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433902; x=1786038702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sh3oxt6pQyzJDmWc8STDx8Y+TVMkGV+VVSzWlbvjrv8=;
        b=PewSmaQ0MN3WzTYwdWC37FVllhNGo/zjhkn6mUcguA2G7ubOH5coof3yFqbWpfdoX2
         xq5KtMujSDoCrMW3VSJgmsW8AkVk5iuRyKDVIwSHQG4A3SSJHy9/7Us9X+FQ3/RipdnR
         nfcadWvji/r12rsfFzMDoww6nPGCcUEDzFM4G/puS0UMX7/UW7jH51RM+OA6Gd6w8fBi
         DIP4g4jsGWc6FyyPotYrbjpAGX4cNcKsc3Ns+Xp9LvwqjrWFipsf2Ae0cOGu80GP7qr+
         88vCAbf7owbsa0wJvyG1bGQEXwD+z1MASX9KvfcpGPwwvXZr5ePafmgeMeMJH0bRsQaB
         X+MA==
X-Gm-Message-State: AOJu0YxepSTYEMZBiznF27nsYhbmuVedtIY/UFOsBLJf7KxuzTNKTY/a
	7AZXhrlW9AI8VjedwEz6wnPhgtCWSwFHSc72S5u8F6cwj1LAOqWeGuV3AsCJuw==
X-Gm-Gg: AR+sD11zwKUPKSZ0mA/g14saafRNon0cu01iu0yObSRAHDkJQ1SvbxHnj9XTfArd3Wq
	i5pQmOp4U+2ZnsxsuxLWmbsjM8oaus0W91LBdPP2+VTsU72VI04uWcC3Bz4GatjY0/+CKoSzioU
	f5IguOOr5dilr5r3jmh6eW9XJqzvBxnB/CXmJxUNDgJvMh43fFDKUNyeybZE+1JRXW2tOWJlCQB
	NIEOfv4hoVhqwA0sQwfH62QaawL/XmvutNVWPd5f/xEIxjGFZCMIGtPU1Vd6AA3MBamCU56A6q8
	UPu3UL0z6SaVICgHJ4SvnHbhfqWQUDGbAXOh2SMZ7bMhZs51Sw2GV8d4O9gqG2dPqBEstttk/lE
	O0SlmBrDDDeDApaAgkr+tjumHE3W9esiWZo409Q6ECFbdJI3J10mzVf/T9PKsb2fzLoBAtFuy+p
	ZtiSmYeQCdtORnZ3QJ2trKusRae0N9eAnm1BuXteqVeT21gyFGcz5GJuCqfOAcIRKRcDpmkqvC8
	Do86BsdocGeo/wOCGpz2FNm3QdqEO6vBLjMZtZnaEtWGsw7OdHzB9X1yyg=
X-Received: by 2002:a05:6102:3f52:b0:739:71ef:d772 with SMTP id ada2fe7eead31-7574dba5060mr1322426137.4.1785433902263;
        Thu, 30 Jul 2026 10:51:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75759a9376bsm1616416137.5.2026.07.30.10.51.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:51:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Decode Intel DDC LE extended features
Date: Thu, 30 Jul 2026 13:51:35 -0400
Message-ID: <20260730175135.2865308-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Intel DDC Config Write command (0x3f|0x008b) can carry identifier
0x031f which holds the 248 octet LE extended features array, using the
same layout as LE Read All Local Features: page 0 is 8 octets followed
by 10 pages of 24 octets each.

Decode it with the existing LE feature tables instead of dumping raw
hex, and make the parameter loop stop on truncated/padded entries.

Example, setting only the SCI bits on page 1 (bits 8 and 9):

  hcitool cmd 0x3F 0x008B 0xFA 0x1F 0x03 \
      0xFF 0xF9 0x01 0x3F 0xBE 0x00 0x00 0x80 \
      0x00 0x03 0x00 0x00 ... (padding up to 248 octets)

  < HCI Command: Intel DDC Config Write (0x3f|0x008b) plen 251
          Identifier: 0x031f
          Features[0/0][8]:
          ff f9 01 3f be 00 00 80                          ...?....
            LE Encryption
            Connection Parameter Request Procedure
            ...
            LL Extended Feature Set
          Features[1/0][8]:
          00 03 00 00 00 00 00 00                          ........
            Shorter Connection Intervals
            Shorter Connection Intervals (Host Support)
          Features[1/1][8]:
          00 00 00 00 00 00 00 00                          ........
          ...
---
 monitor/intel.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index cd997d24b59c..782fda675422 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -681,14 +681,43 @@ static void set_event_mask_cmd(uint16_t index, const void *data, uint8_t size)
 						"(0x%16.16" PRIx64 ")", mask);
 }
 
+#define DDC_ID_LE_EXT_FEATURES	0x031f
+
+/* LE extended features: page 0 is 8 octets, pages 1-10 are 24 octets each */
+static void print_ddc_le_ext_features(const uint8_t *features, uint8_t len)
+{
+	uint8_t i;
+
+	if (len < 8) {
+		packet_hexdump(features, len);
+		return;
+	}
+
+	packet_print_features_ext_ll(0, features);
+
+	for (i = 0; i < 10 && len >= 8 + (i + 1) * 24; i++)
+		packet_print_features_ext_ll(i + 1, features + 8 + i * 24);
+}
+
 static void ddc_config_write_cmd(uint16_t index, const void *data, uint8_t size)
 {
-	while (size > 0) {
+	while (size > 2) {
 		uint8_t param_len = get_u8(data);
 		uint16_t param_id = get_le16(data + 1);
 
+		if (param_len < 2 || param_len + 1 > size)
+			break;
+
 		print_field("Identifier: 0x%4.4x", param_id);
-		packet_hexdump(data + 3, param_len - 2);
+
+		switch (param_id) {
+		case DDC_ID_LE_EXT_FEATURES:
+			print_ddc_le_ext_features(data + 3, param_len - 2);
+			break;
+		default:
+			packet_hexdump(data + 3, param_len - 2);
+			break;
+		}
 
 		data += param_len + 1;
 		size -= param_len + 1;
-- 
2.54.0

