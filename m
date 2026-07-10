Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E1377017
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709423; cv=none; b=eXarcmZEWmmN/0KtypPG7Ni5+sm9aKq/c7cP2XJIwZvTX8mppgqTPLkUOI1Bd2pB+U1sAYuoEMLlonP6iYyVuFxd9GEdK2iO0yHz9DhaTkSDdfpPl/1UF0qzgsZ//acNUpEfUC2cj4RwKLg+Z7a6Jd1SfvilYnAzLtFs1NTc1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709423; c=relaxed/simple;
	bh=IcRE7ElWUYGftBbmvMc74EqGbiG04UMMAdVv4z4eNTA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XA+u7ALdDXnhJypUgZe34zq2u+eCJX9HG1VbIHIzaAigUJExu/x9Ix8jAT+3ml1ZdVYJmXbiJMwqqnF5PKeEJ3lGxgzkXWu0IuHhogz+0OsNzXDdL0N3J9qa52jmEefIOh1zwnU2V8A6t7aLkEREJwUi0jSmFLw5YKpcyHogU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6kE5uNA; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6kE5uNA"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf62388d17so376630e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783709421; x=1784314221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F4pilxLsgWBb2BV8yXEW5GLI3zcnSbOc+gzNv1rtd4U=;
        b=N6kE5uNADg2nyeimYWNZY1loEMp5l74ngeI61od6qhFGYXp0NvggarEU9B/k7Mygix
         RdlHh/42ynXytF4DLPBA2h/UQKBzfVA13hQ1ZWGtjnKt4+tTFidR/cGrw6r2CEiJrrf2
         itT2mRiINyKnwQyoy4u7lTmNCqI4cT6l9sg0vS73ZRUT6od/yosb9x+2B69z/y9sCzPx
         t62vv0z0DZfxLLli8pkRntra4LZ2nXE6cjx3Ml82+q4jl2WZTfM8LCJCS61roBvGIEzL
         JUNKdsb/3nkD1CKsZ+cJUgW429jyiCUKnUNqQG5QXBs19FpJK3gqyRFMghaMe8TQ/MJy
         8xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709421; x=1784314221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F4pilxLsgWBb2BV8yXEW5GLI3zcnSbOc+gzNv1rtd4U=;
        b=msAm8F4CcyC6T/wburyk8viGHKBKJ/SxinAXy6z/S9GAJlQRr1dmgDLulHC8a198si
         7GhhONwz+wRcjnS3Ulnm/aYB3uVEOQcSazWGQ8lClWLijzQvzT1e5q513p82Kh2f59Tc
         GqhqOP9cOJl0EwQQfxt/T62X8ifKEFtdEFcDqnwRjJZWmd8v9h4Tkd0cmZJNutM7OzC8
         avO3ug1nFIWovq/G5O7zS408tCED6Tvyzri3ecCGX09N/Ov0TuuA02Y02rZYdlLp9HjK
         4OiEC+a+rCMiym10P8EuydCFdMkUwj0VepmKUPGbtuFaDbJiVqhlyXl0nIjNHo7rGQVB
         /sbQ==
X-Gm-Message-State: AOJu0YwLng09fFRVR+X7Ghitkd4LqKl17amdz0qHKfAf9v+xP++62lnZ
	/Mgrk8WU1ccLxu2w7OdJcRM5HH9N5un2HE2MXbf5UsFor5cuqeHvvVFE6c/x/yb5bcI=
X-Gm-Gg: AfdE7clW7IrthHr8KQm9QMWEksh1hV55tNMti8aGznHWOruOxnpXb0bz3Tj1ZL7PEsR
	8Pps3sRGiTme6uMEIf3eAUjbovrwhvLhpVxuG3H0HYXNtoVoMnTfCePxnL86WDsrGAVzAhdawoY
	xN9oRfuMExxv0EAdKrAuTehdceUAhHauVX9LEI+OOctbIbtDG9ORahyds7fK9sj65QrtB3etTRc
	jeLjoAx1zeBvxRWZr2iluVNWv/v4nt9XizMl6hcqk6CB/cMXiRv+x12HvJAR758r/YgPAxh4iKY
	wN39L25hrUHuYUyENfO2ul2tpu2fpPtncfMo8D7iGxvn1RbfkkjJ4VxEhx5DPr7y9FE7gw6Rd9R
	1UOX4htFvYN+BJYJMKK6CUtqkUuHahwWVRWI64p5xwmlDm2OR5kYbRNYiciZRQynFcwM949x9gg
	PgDZxNddavCfBdduZmw4pc5TLimOnnMVPJ4A7PO2A+aYw/12QJox2hZPCfkpgGH5Zs5X4FLmC4b
	01a750=
X-Received: by 2002:a05:6122:4b88:b0:5bd:cb34:1b70 with SMTP id 71dfb90a1353d-5bfbf0a427bmr346023e0c.1.1783709420639;
        Fri, 10 Jul 2026 11:50:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bface91766sm1238624e0c.10.2026.07.10.11.50.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:50:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Fix printing subpages bits after all subpages
Date: Fri, 10 Jul 2026 14:50:12 -0400
Message-ID: <20260710185012.699301-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes printing the decoded subpage bitfields after all subpages
rather then after the subpage itself:

before:

        Features[1/0][8]:
        00 03 00 00 00 00 00 00                          ........
        Features[1/1][8]:
        00 00 00 00 00 00 00 00                          ........
        Features[1/2][8]:
        00 00 00 00 00 00 00 00                          ........
          Shorter Connection Intervals
          Shorter Connection Intervals (Host Support)

after:

        Features[1/0][8]:
        00 03 00 00 00 00 00 00                          ........
          Shorter Connection Intervals
          Shorter Connection Intervals (Host Support)
---
 monitor/packet.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index e62ad4cfb337..ba6ff8e8e551 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2925,17 +2925,29 @@ static const struct bitfield_data features_msft[] = {
 
 static void print_features_subpage(uint8_t page, uint8_t subpages,
 					const uint8_t *features_array,
-					uint64_t *features)
+					uint64_t *features,
+					const struct bitfield_data *table)
 {
 	int i, j;
 	char str[18];
 
 	for (i = 0; i < subpages; i++) {
+		uint64_t mask;
+
 		for (j = 0; j < 8; j++)
 			features[i] |= ((uint64_t) features_array[i * 8 + j])
 					<< (j * 8);
 		sprintf(str, "Features[%u/%u]", page, i);
 		print_hex_field(str, &features_array[i * 8], 8);
+
+		if (!table)
+			continue;
+
+		mask = print_bitfield(2, features[i], table);
+		if (mask)
+			print_text(COLOR_UNKNOWN_FEATURE_BIT,
+				"  Unknown features (0x%16.16" PRIx64 ")",
+				mask);
 	}
 }
 
@@ -2943,16 +2955,13 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 								uint8_t type)
 {
 	const struct bitfield_data *features_table = NULL;
-	uint64_t mask, features[3] = {};
+	uint64_t features[3] = {};
 	uint8_t subpages = 1;
-	int i;
 
 	/* LE pages 1-10 are 192 bits (24 octets) each */
 	if (type == 0x01 && page)
 		subpages = 3;
 
-	print_features_subpage(page, subpages, features_array, features);
-
 	switch (type) {
 	case 0x00:
 		switch (page) {
@@ -2985,16 +2994,8 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 		break;
 	}
 
-	if (!features_table)
-		return;
-
-	for (i = 0; i < subpages; i++) {
-		mask = print_bitfield(2, features[i], features_table);
-		if (mask)
-			print_text(COLOR_UNKNOWN_FEATURE_BIT,
-				"  Unknown features (0x%16.16" PRIx64 ")",
-				mask);
-	}
+	print_features_subpage(page, subpages, features_array, features,
+							features_table);
 }
 
 void packet_print_features_lmp(const uint8_t *features, uint8_t page)
@@ -11065,7 +11066,7 @@ static const struct opcode_data opcode_table[] = {
 				"LE Read Minimum Supported Connection Interval",
 				null_cmd, 0, true, le_read_conn_interval_rsp,
 				sizeof(struct bt_hci_rsp_le_read_conn_interval),
-				true },
+				false },
 	{ }
 };
 
-- 
2.54.0

