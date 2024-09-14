Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF643210E9
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322995; cv=none; b=ITr6VQhr/YSD1jYVZmXayXyd39dJZR1FF/PtOhnCDjbLf6+8JvkVKkVk/fSucECC/MQ5qf4gSqbTxe7umnijnvo+PhuHBJ88o3Am5XsnqD1kBEFh7rX0JSKuY704dlHMTbNbVRTy2N3tOSqrKlnUKmlAqPyjWYxIYiQ6hN4dNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322995; c=relaxed/simple;
	bh=OYNMkWyAo+IkmyUssxMl5AbUm7P2zhSB91b2b0PQIQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sLaJRX1Uh4zpFcAAPGqpnJV/5GPBNLMZTtmnwHHZw1hY9erNn22uY0DxXi2dO1lmttirtTqsCwR0r/9HC9Meu75jFXHd4IymICITaM+ToxQpTAKteUajXRg9FD2psW79IElS/M0bZlOVh6Lt0JPj3sgK7PKMsrlvOAROJpfAr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3VV/4FD; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3VV/4FD"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so2203098a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726322992; x=1726927792; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M23J2aqvTtvSN7S2IZIER8Y39GvULB4jVm/UXtIx/c0=;
        b=I3VV/4FDFLz6u2/uTtwd30n9+1U9mgOp01iWuk9I3/4wpb2zyCqLmCpaht+ROf+cg8
         6AM3loG0vTzZ/cfKvO2qPtftwMBNv5aJG7bBdNsXGzcgCxUyIur6JewKSlHG2vh2ZzFO
         mjiIq8oGYzps2hxkvMarn9Hqb0nCeASsKMlb96O/xjeGAA2qSHseXI9KPc5585I1TukF
         2hBWWSOjdLrHJ+AgHeSqTmopD5cRJaCCnlZlHbcjHazm5mVNyH/fPoJa8ayqMR0/5mAO
         jDo6/SKD67JFjq8AFmeS2T2lBMoDq/OYaLL9Iw+4avL/HRzFLvbBUsyrO59bzRsixiCg
         mKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726322992; x=1726927792;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M23J2aqvTtvSN7S2IZIER8Y39GvULB4jVm/UXtIx/c0=;
        b=bC4gxBA2+yBboJJxJHowPReiy+JzNQe/TBnt/PKWuX16ysB14HPK6poIWmWLfZ2KOy
         qpjT8V/UCrCXFLcMry6Lok1nx/SgzQwe1MbV0smHyR161YHF8Qbc9ZbSLPu9BO9xG8LF
         GqQHGnYzMNABI58E9zRazRaI0gRAFxD2KGD/8HN/8qK8q3oOPFPPw5MHtz6NgBiUdQYt
         rzeWn822/7tDUwV9od/8XU8fbx9DyK2+q8pVnj4syaP2TKYk2EmEUw0fW2uYJSlWl+Om
         OPmJ8sEs2/X8988oY1U9mURr+H9fWwUzHqNI0OabGxWOQggFP+GIyGIdwIhD055bf1G6
         dOFw==
X-Gm-Message-State: AOJu0YzSiSV+Anvu+KRuX2y/7YFtBSgSfGUzjyO2K9BZxoP0kZ1BhuYG
	pHcDme1WEjCmGKZfm2Bn7ZN+n7ye+Oa+qZeNONvcJFY/+WrFzzQ5yAwfTWv2wuw=
X-Google-Smtp-Source: AGHT+IEMyaW6fhPL4P9Ga9iSAZ4nZ+y4VtZwTiH1IBArlkh4usy6mMOLMrzeQOJu1U+gt4XtDDgBgA==
X-Received: by 2002:a17:90a:644d:b0:2da:89ac:75b9 with SMTP id 98e67ed59e1d1-2db9ff9237emr10428928a91.11.1726322991940;
        Sat, 14 Sep 2024 07:09:51 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d953a6sm3690771a91.56.2024.09.14.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 07:09:51 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date: Sat, 14 Sep 2024 22:09:43 +0800
Subject: [PATCH] monitor: fix buffer overflow when terminal width > 255
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com>
X-B4-Tracking: v=1; b=H4sIACaZ5WYC/x2M3QpAQBQGX0Xn2ikrhFeRi8W3nJLV2fyUvLvN5
 dTMPBSggkBt8pDilCB+i2DShMbFbjNYpsiUZ3mRNaZgJzevfubhcA7K/oS61V/cWFuiMkA51BT
 rXRHV/9z17/sBbOcMJmkAAAA=
To: Bluez <linux-bluetooth@vger.kernel.org>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498;
 i=CoelacanthusHex@gmail.com; h=from:subject:message-id;
 bh=OYNMkWyAo+IkmyUssxMl5AbUm7P2zhSB91b2b0PQIQk=;
 b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaU9napv9816voGB+cP/qiD9mTLKvG6d3efK4aazgV
 Fa/d0GTdWlHKQuDGBeDrJgii9jOp6+XlT76sIzXZAbMHFYmkCEMXJwCMJETiQz/LOusp4TymrlP
 vqg9afXhs/Mz/jmvXnwuf/qJhRtkc+Y/0mf4H9FttTVzOquD5eerCnozH/7brsN7bzfb9KyCEM5
 NWdbveQFMr0tB
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

In current code, we create line buffer with size 256, which can contains
255 ASCII characters. But in modern system, terminal can have larger
width. It may cause buffer overflow in snprintf() text.

We need allocate line buffer with size which can contains one line in
terminal. The size should be difficult to calculate because of multibyte
characters, but our code using line buffer assumed all characters has
1 byte size (e.g. when we put packet text into line buffer via
snprintf(), we calculate max size by 1B * col.), so it's safe to
allocate line buffer with col + 1.

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
 monitor/packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..3a21909116b341f782bcaf47c0cb3b880cb3a288 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 					const char *text, const char *extra)
 {
 	int col = num_columns();
-	char line[256], ts_str[96], pid_str[140];
+	char ts_str[96], pid_str[140];
+	char *line = (char *) malloc(sizeof(char) * col + 1);
 	int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
 	static size_t last_frame;
 

---
base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8

Best regards,
-- 
Celeste Liu <CoelacanthusHex@gmail.com>

