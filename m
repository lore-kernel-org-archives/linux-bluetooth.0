Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DE1AB908
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087896; cv=none; b=UvfnYQVmaYMpqAE16MIpbMkbS/iflgMLafg/AAPXXEZR1ceJuA9cZVq3D/wYhTk/SEwRDAu2fLnUpGYfUh9q7YtmSygumj30Lzt/rZWktEVC3MAYiLB7zKGLaRLcjQN0wRoZVDlrfalrZopdqpPBz6ycpuZp4TQAP46R5zilP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087896; c=relaxed/simple;
	bh=12w0LUXJMDs9vtLNf5HKFI4QE6RwEkNKZxKzs1q5tIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpHfxO3A9e6fC18kaHzzkk7PExKUOHBJx/Uin+ANVw2jTzSaNPTiSaSJgFXjBK9QWGI67qU+uLyUppFs5ACTL1qV47p0g/I2msliQO5/5S7IopCUG0eE6/1QmsXPVhRtH3+HBLvjvzOKYhcEdkrd9MR5avTVaxXrxN0xJrcPgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtQfKWfu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtQfKWfu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42573d3f7e4so2995245e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720087892; x=1720692692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5SKqGalceZT4WJcowpYSHeUSOijyyDVbfF2Vti9XXc=;
        b=HtQfKWfuyoq1DoF8xvQr82CB6qu6ywVWNYQ6Wfz+oZ3BoySEfLk7lE4CZqc0PqWd9j
         LOYMuCyRA5motW66X4J/MBgy5QbSklzLY/Im8CL5x5Y9s+gF1oToNGIm8abUUIqFqXdA
         6pm3BblVgyjCePV2sSmL04pqjL3X/wu2kY/HpEJNKlsKfrTmAsIr6tsyer4pHwLGIfNz
         9rEK+gRE1GYKu1vQtHHmd3i6wLJpwXlWCkeStaiimIBj8DOwV8qdmzLHattc1BQFmzRi
         lnFVrWram0YzKCWO71Q1VjEokXV8gFy6ZiFVVfk1w/Vbj7haarsIj6gGaY4wr302iNPW
         JFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720087892; x=1720692692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5SKqGalceZT4WJcowpYSHeUSOijyyDVbfF2Vti9XXc=;
        b=drL2p/xrqlb2MG3BR1k8FTCOd7EgKDJg0YBabSOcv74Im2UedA9Q8kcCeddm1TDZJW
         BZF5dFnaBErpTq9DazIXfK17pmkdWxJ52MjTxzrGmylTSy/F9ezwi2E3BfKwuKdPb1E5
         ehxDcZPx4OxpCXAi5pSbR5ur8tz8ZpnOawEmNy485luLYRRP8tGJuzevzmfpBGx0x/Ff
         ghQ52Y7Pghv3yzjEeGtye8Vt6UWFakXbdA+LibsGaHHq31+cA4sbMzGbAvPF7WSEDM7N
         qjMsq5OIeKPHr8NvGHpZu/+jFg03QL33hwJkS4oKOMYeOZM24H1y7oHuL1PZ8fpDv6eA
         fhxg==
X-Gm-Message-State: AOJu0Yym+Df2/ST/T1MeIhDeghv9TNfxLCXoxsYWD38OdQMCfx0NZwFx
	0j+V8J6wGJpazJQAeFFdGop5sdGMkc/Y+7kGISS6NHY/bOCK1wfLEuFNCA==
X-Google-Smtp-Source: AGHT+IGrbcUM/hBYjH4NyBIadriabh0V3MIEGlbYgxuP42/ByZvQzael5uvZ3/JXFOQfeVIt1qzFGw==
X-Received: by 2002:a05:600c:21c8:b0:425:5a26:a12c with SMTP id 5b1f17b1804b1-4264a3e1cb5mr8414115e9.13.1720087892453;
        Thu, 04 Jul 2024 03:11:32 -0700 (PDT)
Received: from localhost.localdomain (cm-93-156-196-56.telecable.es. [93.156.196.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21d2basm17763505e9.28.2024.07.04.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:11:32 -0700 (PDT)
From: =?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
Subject: [PATCH BlueZ 1/1] bdaddr: Add cypress manufacturer support
Date: Thu,  4 Jul 2024 12:11:23 +0200
Message-ID: <20240704101123.51164-2-antoniovazquezblanco@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704101123.51164-1-antoniovazquezblanco@gmail.com>
References: <20240704101123.51164-1-antoniovazquezblanco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tools/bdaddr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bdaddr.c b/tools/bdaddr.c
index bc0478d46..de17416e9 100644
--- a/tools/bdaddr.c
+++ b/tools/bdaddr.c
@@ -303,6 +303,7 @@ static struct {
 	{ 48,		st_write_bd_addr,	generic_reset_device	},
 	{ 57,		ericsson_write_bd_addr,	generic_reset_device	},
 	{ 72,		mrvl_write_bd_addr,	generic_reset_device	},
+	{ 305,		bcm_write_bd_addr,	generic_reset_device	},
 	{ 65535,	NULL,			NULL			},
 };
 
-- 
2.45.2

