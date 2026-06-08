Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A532E757
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916407; cv=none; b=NaZgY4btCDyO7MyFECLg5BvIFbfLIN2jjCEMoF3vrcwuluOhJqyMymYUOF7iwJ98TpIc2wtofnD4PhLIs8CU4KOVvWROzjDsxss/GQiuHG+RfEi5z8wmzxBo6fYfL7Mr1QxtrK8HeBca1je8by9c99CAJMF1N6PohVsuKkv9lZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916407; c=relaxed/simple;
	bh=bIEcrbWKTjr4pdE/d5hVwDxlPG4KK/Mcqo+brxKcI78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOTzHNUHzh+ea9FJUKUm7y3DXOnKet/aJT7PaDRS0LudG8DICRFl/GzDpXGVhqkgZRzcRvYv4qA2uY2wrhzyMleNara3/T0HW+OytoXkytkLXmtaUNivJ/J1SIrf1cK/D7GewV0ZFaXX32Mln8SPD9hD8tSrsI2FwfmO/JUpAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=JD6KfEsP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="JD6KfEsP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so2729514f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780916405; x=1781521205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG6L6EOWOBOmDDux5xjI8XWy+wHtnPSV2XzZIQyATRI=;
        b=JD6KfEsP60j/S0soF/fHgQwxCJxp+DA1aCr8oA3py/b39co2RCzjW3yd/UTQW9glTV
         4ivjKFi5xJ2rbbEiudMHO4l4OjrfHad+qQDt72q5f+S61AH4K+4fIazpmufNNtbpq6SF
         8i1qAJq51GbfIRcP1InBp8pgEmqbcWi1DZuQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916405; x=1781521205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZG6L6EOWOBOmDDux5xjI8XWy+wHtnPSV2XzZIQyATRI=;
        b=PrHmUBmY/N3oriU1yHSwVqAzedpUlEC79lxoBi2+G2USVxi1XeJ+MJRGJrgt5BK/Ys
         KAFIbB8KlCFeGwg/0SgC7VSvGsihlRsdkliOfhgKjYLOhNFGWv/IOKwTcti05rF+R5B+
         z05lypEJ6mZw05IWePmAZmdyNxCfkFWSunm1PvHoG71LJuk6spPZXjRRw09mPSuMn/uH
         KA4mwkofGzTjWQ5kGiVFwQNP+0F+4MYSw6UtsCBYyc2DonTuNzCp9g3sUKqGHVnEjdc7
         8sVo7k77Lb3exckTgwx8wl3/g7aTqd5zCR1gzuPsmUsgKiUaqrnNYBg2MIF5MCbQOu1P
         /u+A==
X-Gm-Message-State: AOJu0YxJq9WVxdqGKSH1uNHvPK1HLZBO+IliH89+9vC8cQqDixPGW+AR
	PbhsDTud8pXoOGTzNe+T1WnEn8KUpy1u9F8undpGvU39bDnwJwd7QkGc3OgGggoT8yg2wyiADka
	dBG33
X-Gm-Gg: Acq92OHPApGFKJ7QeT2S6rqw+KdyFFQDAL6gp9bNrsQ0PqLVXtAVE1cy/IngdzTTMtu
	Gt//VED/9G/G0DAWt5hG9nWEXGhrvuvehjjC/C6yCEqTnhNZ5I7TkaU3/YOVpvyDtIxyB2GbVWh
	k3zoHZ7vajUREmfqhyKrqfjXhLX2LYqCmmqykEKYe5A3TVMUw/1312Wqp+6FUgTpUNAbc73WrmQ
	BYhRsfIIfzHefuBdM9uVXrKAbJiAyqL3GIF74yACB39KerGnJr2YMAVfZOPZOIkxd36VjgZUZPI
	vMQoxcp+UK8i47hoI7XQFrB4qIgM11Rz1BMcm2AsTAJGoOFz4QIgsOUFsX+ZHlY2767dRiDuWz3
	7tuddqndGVrh5AgvwW+6gVYK05g3shq8ZG7lLPd/KhT69EzqApBMRiJV1Ks8jvtZcxp4HCDjfQR
	7+ALong8ZtA4WKFPXJP/d5jRip4dH2XwHIUCcwkUs73tzyRMUsbLMDIg==
X-Received: by 2002:a5d:6b10:0:b0:44a:fa76:5193 with SMTP id ffacd0b85a97d-460302ed6f7mr17088083f8f.12.1780916404700;
        Mon, 08 Jun 2026 04:00:04 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm93113112f8f.29.2026.06.08.04.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:00:04 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/3] device: Rename start_discovery function
Date: Mon,  8 Jun 2026 12:59:51 +0200
Message-ID: <20260608105952.3683040-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608105952.3683040-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
 <20260608105952.3683040-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename it to start_discovery_cb to indicate that it is callback function
from timer.
---
 src/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0c2ee7d8d..da70f9cc0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7185,7 +7185,7 @@ bool device_is_connectable(struct btd_device *device)
 	return state->connectable;
 }
 
-static bool start_discovery(gpointer user_data)
+static bool start_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -7364,7 +7364,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			DBG("setting timer for reverse service discovery");
 			device->discov_timer = timeout_add_seconds(
 							DISCOVERY_TIMER,
-							start_discovery,
+							start_discovery_cb,
 							device, NULL);
 		}
 	}
@@ -7409,7 +7409,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 		dev->discov_timer = timeout_add_seconds(
 						0,
-						start_discovery,
+						start_discovery_cb,
 						dev, NULL);
 	}
 
-- 
2.43.0

