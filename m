Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE45D72B
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114569; cv=none; b=cSTLjYQCsJUOWIWVJikpjRrJKShatzEo7nu1qNIT6eaRdOUKbahoQWg0qW7p1ulNhaoxetVKZcf7SUOVu15NHNW+Yfl+bxkIaMVybnVOtdY8S/LL24O3vFn+S2RPjmsZCsWKjB67HIgF1hgt/47wnRahc6WUj9gHGcn9Z6KyV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114569; c=relaxed/simple;
	bh=vIT8LwGVG91TxeYOCcfqhfXzJmU+7cIIcnWzlZNPc3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gCOYmU0qKE0gjMb4t5ci95gXFtPRJClr1JhyXhChMCMUisMLS+JdtmE6+w7GCu2no4dvRWIsXKl0CiIsTfz8Yqa2yJ7hkrDX66WVgMxnQMq/U7hZDXys7Rhl24YIHuirI9S8Of0CgOXtRvJ+YNvwuNx6ANee9pA3VgLAo2Tu1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKNqPKyi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKNqPKyi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-414776775d3so9999455e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711114565; x=1711719365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=87r4rh9xnhwTfyQ8xucHULUHP9DRNgLZBZsgxdFQ3AM=;
        b=jKNqPKyiz/UnR2Ptx6b93USOVJLTDblk/wA2kaDkN3c81BVcv672jSX0+qoHmTEp2r
         SDXDu8j5o7Db9GTru9e5vKBt8+XTiLk0XLAN8ZKs9zCHMSqAc2scfy3oDc606VUrow8x
         sVBUG6nxWdhxXkUf0WlJUJe2gA+QAH3+Y5DJYqH2jc2CKWc1DWO28olB433d7lO3/SaW
         498NtvRnk1aCBDwXa8jA+6BHQp18qYUGEIQzaeGAW2eRrZVJHmerT62fpZsk+sfRSH63
         Eima9hp5K9/4YJL0ZL7KIkBxZXxLu7pk+OFm85V+0lokZBuYWXuka5KsEUmz3BybqUcy
         tzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114565; x=1711719365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87r4rh9xnhwTfyQ8xucHULUHP9DRNgLZBZsgxdFQ3AM=;
        b=R8rs8piDcYu3v4Xj44wPj4kQXLLZ33mdXfoTKK07+BffBDMah9BDhX/fw0V0he9GB3
         /eCHWQao7ND5gjfYnxGfTXDPgqFpUqW3YGZ5UF1KX8rzGUy/a/kVt8R25KyTKv5rC34+
         TAK1pnHNRJ30mhkyYAsgh/7TycmtFbriB7PO0iF8hsSdaekqG2fKFTsYkjxscpdhTsRy
         WYAGdWpp9eW0QeJ64yDCR7RTbFs2NKBVBzVaWJ1x3zlX1f/xEkgbjvw6JkvnLStgjEYe
         dT1K88M9MSXqsaMMhyQ45qPjloFG/jJy8N3y1GBwyyddN12B4kPOPLqVAsiHnWoYRn/M
         RkFw==
X-Gm-Message-State: AOJu0Yw0yeLYTUFFNxiPa601Aqm+M+gUv48W18pdKDsiLnrmDny04Zof
	X/Nsf8WybNNH2gmVDV2S3HfHcLCi+A9bQIYvGcX5jqGfhFsTroalIIN/Gb2rhT/YFjKR
X-Google-Smtp-Source: AGHT+IGw7qXptLujr9DdrpYHgSdV6cIIPazw21qZ2WWf5S83mTAazvlRGbXn2hRVZ83gNRocKfvXvg==
X-Received: by 2002:a5d:4645:0:b0:33e:7029:96bf with SMTP id j5-20020a5d4645000000b0033e702996bfmr1377685wrs.58.1711114564925;
        Fri, 22 Mar 2024 06:36:04 -0700 (PDT)
Received: from lvondent-mobl3.. (ftip004290803.acc4.faraday.21cn-nte.bt.net. [109.144.76.63])
        by smtp.gmail.com with ESMTPSA id b7-20020a056000054700b0033e7b05edf3sm2107915wrf.44.2024.03.22.06.36.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 06:36:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bap: Fix not setting adapter address type
Date: Fri, 22 Mar 2024 13:36:03 +0000
Message-ID: <20240322133603.43620-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not setting adapter address type when listening for
broadcasters (aka Broadcast Sink).
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 38900771a..ec55614ca 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2737,6 +2737,8 @@ static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_SOURCE_TYPE,
+			btd_adapter_get_address_type(data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			device_get_address(data->device),
 			BT_IO_OPT_DEST_TYPE,
-- 
2.44.0

