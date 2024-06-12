Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2018287D
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219513; cv=none; b=qRP8kEIh+fy7um2MDPBtlq/XS1WU+NbJ/KbOWSZtjc2/V/0QYG7ZGLqgZfcJydu2fX1hSQY3aOZw78kxlDwjtaTWwuWEwwxg2b+fVR4wbhxmggiFdrD90k5WRenJOoPath5zURoBAjC/ZG7/rnHBMdbYQoBrdbVGGTviYOAULj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219513; c=relaxed/simple;
	bh=IyrqJkgNdB5buAkiNGn7nV+igsr2fauD0q/gNMws1Ow=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWHdQRCFsPKxdqJA/Gp6NmUOx89ExXCP+J9cv3c6DtfhVX2EKsLUz3qBY2tPotTUDkcjPlNyO61LrJGtGPdvT7ANiNqsw+OtiJiTEt37FnlK+0nIHiZdsK+Qh0xgpmDAzImNcqSRtVM6md4nir3fxUQfFRBGbhbNBkPUatKVVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZa/4Wz+; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZa/4Wz+"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48baea0acfdso75189137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718219510; x=1718824310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxsukHlldEVRnfzj3IpxUazAS5yxt4jHkAGJMps0wDs=;
        b=GZa/4Wz+XCsFkr3KxervnAMDgsqk5jsXQ5cKXoa9iLDaZmbOHaTd6NvjRzn9E7CePB
         2Ui8krk79/E/ZFDWuW0RAD7lcFlZDcQ9qL3e4a8Opq5p1HJ1ogig2jbUrEwfaYtludnK
         LfLzrwqlZvolU5TNdMzZ2rcloGdi/Z5owyAmY2HD9HY8z+qqOsPexE5RHIV2XR+MVMBu
         vJSrBSUII3Ab6XW2fwyNZ/VbR5vqYDMJOhWl1jjFUpPNaYoZhadapWTziMLbIGA95s68
         D7440epxeQSppizj6FydkucCBGwWygzO9UfWGgnwEsnfyg79XRo7JSlEsRvyz+Eao/cK
         xhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718219510; x=1718824310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxsukHlldEVRnfzj3IpxUazAS5yxt4jHkAGJMps0wDs=;
        b=hVAPCybdMxitbcYzrd2FKHX7ylP7o58srqNvW/ZyhI2nn2WBqXUqPXCeheL30Yszzn
         ZxnA4h0ntvRFjn0gK3CyppuoPuQ1Nhfn1bVJMXpbwNquyk0KMbE2+MzJMr54zkUtVQsB
         PXpHlB/QroEplKjkMV1VZKViTlmFb4FSaZvqMGXU0I0uitM9r1Qr3IEBRrAll7t9ONbx
         +euO5VXa4dGQ7EtC/4MNf4Qt0PgRh5Ygt6wuiqXuB6NuxIMuHXw/MagMLvfigbJXTvfk
         r2PEVomVdvxPP7cx2syQnsSb0Cd7kcVqzq/VQpa/FqzJIgrIvh0BTfFx+GRklP1KJk3C
         doUg==
X-Gm-Message-State: AOJu0YyWOmF9IgtCjsFL6SkBKFnpxEawPNKvRRyZC0NjSMZI0I1MOvEM
	GJo2pPYFmUFQaqkXOeAE6J7rcPdaEbqBrqiSp1pdkUxtTFk6xesFQk8fJg==
X-Google-Smtp-Source: AGHT+IE3NGJT0ReQkZo1rMmcT6uzrDIgWQU8oPuty7Wy0V3p7lP9adjcjPGAs5/mUBef9pYGyqOfzQ==
X-Received: by 2002:a05:6102:72b:b0:48c:3953:9c02 with SMTP id ada2fe7eead31-48d91df0394mr2881462137.8.1718219510245;
        Wed, 12 Jun 2024 12:11:50 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48d92a165d3sm478706137.31.2024.06.12.12.11.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:11:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] gas: Fix default PPCP connection intervals
Date: Wed, 12 Jun 2024 15:11:45 -0400
Message-ID: <20240612191145.1379415-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612191145.1379415-1-luiz.dentz@gmail.com>
References: <20240612191145.1379415-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the remove sets 0xffff switch to using 30-50ms as that is the
recommended values for GAP as 7.5ms-4s seems to be causing problems on
some controllers.
---
 profiles/gap/gas.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index b50a9c03acd1..dbe5f003bfba 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -182,19 +182,19 @@ static void read_ppcp_cb(bool success, uint8_t att_ecode,
 	latency = get_le16(&value[4]);
 	timeout = get_le16(&value[6]);
 
+	/* 0xffff indicates no specific min/max */
+	if (min_interval == 0xffff)
+		min_interval = 0x0018; /* 30.0ms */
+
+	if (max_interval == 0xffff)
+		max_interval = 0x0028; /* 50.0ms */
+
 	DBG("GAP Peripheral Preferred Connection Parameters:");
 	DBG("\tMinimum connection interval: %u", min_interval);
 	DBG("\tMaximum connection interval: %u", max_interval);
 	DBG("\tSlave latency: %u", latency);
 	DBG("\tConnection Supervision timeout multiplier: %u", timeout);
 
-	/* 0xffff indicates no specific min/max */
-	if (min_interval == 0xffff)
-		min_interval = 6;
-
-	if (max_interval == 0xffff)
-		max_interval = 3200;
-
 	/* avoid persisting connection parameters that are not valid */
 	if (min_interval > max_interval ||
 	    min_interval < 6 || max_interval > 3200) {
-- 
2.45.2

