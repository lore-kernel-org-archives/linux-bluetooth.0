Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2DF15B54A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620526; cv=none; b=XY5ex+439pw666CcAh1+wDiuf1pOvZVFZYQpj/+QDUSdIhehG5DjfBdAEil7vw744QjDaKcTEWq6YoZgAVtnKuiIauDWZ8E+tfJgn1cbPaB4tl7/XLZnzkqp0rq2tbPxTzy4qIE+Eg6stfoinYlgCQsTKZLWYW9zvCKGibBzNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620526; c=relaxed/simple;
	bh=sqeQn8Js8FAAOv7odLrrymob6T5hujHhFgrMkY+RgHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L4rJIlRTsZ4YtDQWlobZMWXKmWikK22VQ7xPxt27U5RNOSlR41Ew6N25aCO7qdvIUdbXFnsIRCoAcnop3aRzNoHJxNbei7Q2uqyo9dhRD3U6rpkzzrk6vJ5vBbBGaNQWfvyNsqLlLzINliR7p25P52KxU0dwHyTlo7HWiJIZGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikOzFkdn; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikOzFkdn"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e401b11bfaso213732241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760620523; x=1761225323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRjAawYO+jyQ0TyhX06vdTHkGqegZWwxpylKvbJad1c=;
        b=ikOzFkdnBphX+cOXToHNH5SPmzGrYaV9wpoEeU3v+xCNxU9dyyk/ISVSXyc9DmhcAt
         UrP4Z3PSeSkSSY1PWxgBVxt3P31g3BHDImZAdrU1Hrj9zobMcu7XBEgCf7H/gn0XH1RA
         jC1ihRkleyCdV++h0t+M5YpJ4PUD6mrMV9tr/VNFhtxPGD3U3nfutAH2n+Q/1w5wzqku
         1AdcLBoCpW3W7uuQUnSspEIwBgkf4jbWuW9hf4VvJhNmlhaEjR0zAeRQl+bPPGcMM6IH
         qdVYc0nJmvp6yyI2PJ2tZE6H5asfsgIFciwfNaoUYzqZYpEzdilfcIMhJ+rZbB2Us/hc
         GMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760620523; x=1761225323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRjAawYO+jyQ0TyhX06vdTHkGqegZWwxpylKvbJad1c=;
        b=CLVRk2thU6PqebcOBq6wgCTWPzPxahNLoSUdGD4/K9MvmiMqTZlhPM8cdIH8Aw6Fm8
         tEmIIl52fHxVLI7da7CiEPDW4eAw+Y3/TNDjVtEMr0TiS4FI8YSFBd/IAR4ktw6Z3rPn
         QVSwwso5BUMQOnUDj7zHNF7RoK2OANhsol2FL4/I2a9C8Ox8aFw//FumYZQ4fpt8mnqf
         Rpru/aD5YU10BSfi8auVnathGz6cFz8IY2kFkIMXI8WMcOXNz0Ml95sEKgJcc678effJ
         thQtg4b/Rte79cktkZ8o062L2OofGnfKghzmJXkAQdmutOen5v8ZLtITMwkEAMNLtzrT
         hxAg==
X-Gm-Message-State: AOJu0YyYH2Y8mdijs423GzRDh3+iFA1jiKZUBHKyz/NwKBXE9ZnJLc6h
	oQcxi1oReNCepc1sBpz8fckhiJ1+m6q82daN3P1URygkt0GS964P7/DM0UK2drTH
X-Gm-Gg: ASbGncsYW2VljClBTH1zN+7E73qrB6VkzBebstmsSEpV8kYO8Gs0r/aI9EPRvmg4pKa
	QDRH7RKmLSP8WZI8ZyllLArLMPqaLiyI50chSyH1TOiFl1NX7oKt3oGVDPhdFqWUicgpji/MqkU
	bgE6D3ZiHXucOYsAeSv1hL2sr+37gsDP+az/Fy7iFN0s2/euX8ulFGWbFibczE4iXxdgz+xeIt5
	V95iACwP013sSQJyF+T82KuCtY28ZaUFeOQOIKHo6YpPSRVLM4I8N0BSbJmZHkeG5DjNczCUMHY
	ugxe0s6TsfwB51SWI5GMFCalZg2hwbcawCWAeH18sS0vDgZc4O24Vu4BpSl5arr92NOhZ5+Ldy2
	owILJ6FMiYkiCWLLcSur7JhROQ9cTd55TcaX1B8ICFQWlc1Oibyxm19e2t6Tq2SyqDudYjWJzK6
	LCUOyJzRoDCjWvhQ==
X-Google-Smtp-Source: AGHT+IFhH+LbXje6WZ3uFaUDbgXjsfRqGebVU4Sw46wuVtuDwyD9diKbd8xFxN4PG7hNnYxwWVdrGw==
X-Received: by 2002:a05:6102:3a0c:b0:59d:6be4:5b87 with SMTP id ada2fe7eead31-5d7dd5a3a36mr98528137.12.1760620522731;
        Thu, 16 Oct 2025 06:15:22 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8f0a87sm6257931137.13.2025.10.16.06.15.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 06:15:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mgmt-tester: Fix handle value
Date: Thu, 16 Oct 2025 09:15:14 -0400
Message-ID: <20251016131514.92485-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Recent changes to emulator has changed the ACL handles to start at
handle 0x0001 in order to use dedicated ranges for different link
types.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index ac27b85dd4c8..242909117987 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3106,7 +3106,7 @@ static const void *pair_device_expect_param_func(uint16_t *len)
 
 static uint16_t settings_powered_bondable[] = { MGMT_OP_SET_BONDABLE,
 						MGMT_OP_SET_POWERED, 0 };
-static uint8_t auth_req_param[] = { 0x2a, 0x00 };
+static uint8_t auth_req_param[] = { 0x01, 0x00 };
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
 
 static const struct generic_data pair_device_success_test_1 = {
-- 
2.51.0

