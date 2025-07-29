Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50E15CD74
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816939; cv=none; b=Ohd2YDKpczFCrTVbhaV+kXQgepXtLOirLmstIkJkW9sLyqvJ0cv+8VOBUTMS14WTq4NuFRltfbRpoY0K8gCdtnUau7yVoM/ueaXxkJVD7FATzVJejui4sBZZFalcBQbYc2SkqFlvXuJSvoCG0hpm/woie5mVC/coha2/v+mAgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816939; c=relaxed/simple;
	bh=itKfKk9XNVdyk43UjhHvKmSvK3bo/MqROLr5Ymp2ULM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UZLUtnu1+CxcTQSktgGpCUrCBqqYOnHBHAeaj5IWYtZmy965kGIB85Pi10oMvcmKtPG1UWENq5EkX/4cPhTbvGDkzhkDkvIt3m1gwnCUZiYPboKC6eRARk7LxbjbRJwkMovOtJanNWUrx7jkFz/XWxK/MP0bWPf6qKNe8TKcHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiUlcd4m; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiUlcd4m"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-886b2fdba07so1958684241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753816936; x=1754421736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q94ev9qrhrzmPMFQR/LkQgZRscT0w2YSlzwdHm3W664=;
        b=CiUlcd4mAHipPNmXl2E/r8dyXQoN6gqFxC61L1EbsmkOspJizKzBH6Hyb8013LEJY+
         L8wgYtoubEOQsXg0rKu6aI3O36NGzs2f2n1auJLoAO5TQ3lx+nB765EeFRk7bQPFVGP3
         K2MXrLFN9AXhCN650FmeAdco1EvzqNBXtZuB0LJ8LN1sqDpBv1lmy4biINIQtiF12kxD
         bvJdmY+Qn8YI2gRKACDE/tqt9vl1EM496R9JVjpb7VvRBdOjCMkQMDeYTS4hBr2KQ1VG
         4fXrIwLaSTB1OoL8rUofzjqzZqHnTGzpYk0xOywYN290w120E+FRhHWcSTv4eEMX40Hq
         g5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816936; x=1754421736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q94ev9qrhrzmPMFQR/LkQgZRscT0w2YSlzwdHm3W664=;
        b=gLqSHlQWHRKhbF3d8P7X8rpkESNpm87LLYJ66evgHr4RWuIFgE/yV3ca3LKQIJsLbc
         lx98/SBbzGZhK/gXOhOxwHSw/sX7F6d+VKBKyWCYyuAOa86eVp0XsBchhwfIkKTo8y+Y
         BBppcZ1+9f/OkzK/Wyv3SYrUvpo7G8a7w4kSWvZqC2NQeqhbc/Q7bCWLPG+kHZmnDsXx
         N5i4vmzkvBg0FTWSVSKq6Lv2dZNK2X3xnY21W5FOIbdAieyuDH9zDprZreVdlVPlndcF
         8xwTNexWxNZ6STi4u0nXog9YfmakkK/rONGhKWSpA4+Ipr96gShVoKrVIocagiCsiMMz
         Glpw==
X-Gm-Message-State: AOJu0YzFNq5uLVgVuOkJVSzdyl1Pg40t0Xfa4Qpo2DeAGcPkecf5k/1m
	hH/XIi2HS3+4wK1eTY8pgjlPoLSPknn0YDMhFXBfXJ5GuIX9fEQh2T9nraQ/maXx
X-Gm-Gg: ASbGncvtkR01AF6jY0iQGVOAnTy8kA9BzCvYYeteq/CIR8AMFDX+/iF4A8G9wqqM6pP
	4tXI4rw+p/qjTmD+duFrvEje7qEtGeKBSrmxZyBsY7/0KDxtqdSZGzoiRi3jkvixL4lpvPWFEY7
	lDFYA2bTMDJNH5b7JMzZl5sMJAGjd7FgpjxQjcRb8RXBslF9EEftYQC6TrHZt0oJ+6qbNaIl+h/
	HHaYhe4+sECYwRDpYghGJV+tEEC3MRGgJIho0riugMnUjgL61KuOLq9wj4bw0NF28uFlYw7voh8
	Cm3K8FexQ13yPVA39JdOru69Wgl6y1JMBDEfDHJEHiZALa5tIkWNQTQOp0Z09HB6CTzpel5KSxN
	WX5NtTjbi0dIn8lG0jB9KbbS8MxTxT85aDQscQa9CPGP0K5l1LHoofluEGdwKbXRC0ZUVMwLmBF
	Y=
X-Google-Smtp-Source: AGHT+IEZ3O4Smxmoiv/ctyUfTApo6U6fw64THvKjozcZC+fkjWO+toljsoG/9K5v87e/WDCh6yBlGA==
X-Received: by 2002:a05:6102:5114:b0:4e6:d94f:c197 with SMTP id ada2fe7eead31-4fbe87956d6mr752641137.23.1753816935966;
        Tue, 29 Jul 2025 12:22:15 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d0745fsm1684577137.5.2025.07.29.12.22.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 12:22:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] btdev: Fix checking for PA on BT_HCI_CMD_LE_TERM_BIG
Date: Tue, 29 Jul 2025 15:22:02 -0400
Message-ID: <20250729192206.272462-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_HCI_CMD_LE_TERM_BIG does not require PA to be enabled.
---
 emulator/btdev.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3747eaaef842..5dd7d099432c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6542,14 +6542,6 @@ static int cmd_term_big(struct btdev *dev, const void *data, uint8_t len)
 	struct le_big *big;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
-	/* Check that PA advertising is enabled othewise it is not possible to
-	 * have a BIG.
-	 */
-	if (!dev->le_pa_enable) {
-		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
-		goto done;
-	}
-
 	/* If the BIG_Handle does not identify a BIG, the Controller shall
 	 * return the error code Unknown Advertising Identifier (0x42).
 	 */
-- 
2.50.1

