Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EB221F3D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582366; cv=none; b=cvrZrqpt/9O3up6ZfWM1m2+wqD3Lkeirc8C8eWxAUNpQhqC9TCwVvkZWNEft8cAZB3FffIuMR5kQ1Klk9j+zAmKr8VKqyekiQsoSUWuqb1z1iI6LvLSuh1M8aTSjFBwRFewqobPZa9d1SEU/JMUs5Vk3ZJwBtsbpyh5nP+SYFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582366; c=relaxed/simple;
	bh=eI25Tt3mzACaZCYbE2WlMOCEeAOnCyHGufi3Sm+c/D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6TZKeLI2feNMtcSq7cb89o2j9p1Ycpmr+A4XjDuVjIdgGmWUy1w309G5cXmIygQQXh+e7XN24oav/c2ZWcCMJ7QdKx0Xu+KX7PhPAlrPTrKYSGkADh7v0JMJDYaa/aEe4ehZaH1nq/mC5RtY2o6pv+wCXYfvCBMJ05nmEwbg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDvdxTeC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDvdxTeC"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f6287649eso5445002f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740582361; x=1741187161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2inlcyGrp4gsySkMajr9slvItZBIGY35voxeoHKWVw=;
        b=CDvdxTeCAC6tuYOVvBuxsOIoxwFs5wmcv1YB0Wb6futcKUCJYPVhFbJO4ovZ3dweuy
         6o/WogH704w/bi1OWxOfphppdKy6ZjaolI7yjS7qU1Bdpf7HvrX6p0I3cjq69COR9h2g
         ArLwHJdgAsc957c8MuP0xxH/a3IDFFYJxm+Fm7eCM5Ardr4FAe3G7Z+Lrke0Fs3o1M5r
         DprhHR8vfh9B+bMM11GOaNK/TTgeXNOMgYR4e3gimy9Mj/+O13COSmdN1T4vIU7ZBGM4
         zMWzsCwMfIeWvVLokObX4ijuvPVBeZMeAspneVbGnAD3R7DlzxYc/1dt8GuyF8NrQae4
         Qwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582361; x=1741187161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2inlcyGrp4gsySkMajr9slvItZBIGY35voxeoHKWVw=;
        b=obo04EQoZq8uza96uVAFMHGYBFdGsvxsFLcjZxkcmOkdiQZCZZXGaq3Uf7ll/w0GcV
         lxo75M/GuwejJ7PlMorKxgzACH6cdxUd1eV2nX5Ue5Tt2FmfErZ5JsdvK5cebtPJVz3k
         H3hIpdpZaoLsJMoUv6qWccfxnAeC8z0/Z8xG8Xmg3RHDMNq9ah/4ytJyCDH9n9GE2daI
         KX0al0i5cZKFyEB4+KlqAT68Tej4joawvLJAu2q30srTyWhJCSNsfBb5bobXvkm2K0ku
         wYIlURd+KsrUwVEkXnILH7uh4aHjvi0qvYy3TTdoAHBGajzrO8ZVxmiFX3ZWgx502nKR
         qufA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+3PQZqWH4i8axmNMP39nktNAvGL2mjVVpJ1csll6afkoxknN9vOgPHDxWCMUfX/ZaP9cbGh8LvBdHlo+ZjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddZxWDmstz5mE6SnRO8jY2eqaLRYDYL7j1wvcJ6oR9uDr+2NY
	6RS2/nLxNRJVi1gJB4DCjLZxFdSmuMvK9VeRsV73xbnphKph9O+/+rl+LPJr7Q1PKy0qqXp5opz
	dBIw=
X-Gm-Gg: ASbGnctmWjF9nZxjD5KbI1klY5M5mxnH0RA59VIzZFZtddUdYZKMoKRmN5M3UbgkWC7
	F+IGDXsU4XoYSN2z0E3Q1L3pxGH+zxlKcU/6PUulvuXmMm7jhZCiiW8ZZ/6/F7xdjYYCGepiU8Z
	8v1kfs6XBV3dAVraOhJeteFIPdeHFJle4qtjWjLux+9W7l7pu/lj90+U2wdvFVRtGH0AmevV/fB
	tmyf6REaJbPiwfV++vfsLY01Db4BoO8py1CEwdKQoY3F79gphKLzxiBabavwjLr1mfLBMFMUyjb
	KukmjZt98KSUV48/oK6hi+roPWFZMO/N+aXWCeiR5mcE
X-Google-Smtp-Source: AGHT+IHrAFGVYII4lZLYB2wkwkybgtbEsUBZpKLBTuPfS8zJ9+MgwZUvmEIcYf0/J2nGs7RrAxHRmg==
X-Received: by 2002:a5d:47a4:0:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-38f70799a46mr15169416f8f.12.1740582361041;
        Wed, 26 Feb 2025 07:06:01 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbc31sm5768155f8f.85.2025.02.26.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:06:00 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: amitkumar.karwar@nxp.com,
	conor+dt@kernel.org,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 1/2] Bluetooth: btnxpuart: Add VIN regulator support
Date: Wed, 26 Feb 2025 16:05:52 +0100
Message-Id: <20250226150553.1015106-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As bluetooth controller is usually part of a WiFi/BT combo chip,
it is important that each driver references the common supply.
This prevents bluetooth to be powered down if WiFi driver is not
loaded or removed.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/btnxpuart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4f2f429c9800..fc313559c2aa 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -17,6 +17,7 @@
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1522,6 +1523,11 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	int ret;
+
+	ret = devm_regulator_get_enable(&serdev->dev, "vin");
+	if (ret)
+		return dev_err_probe(&serdev->dev, ret, "Failed to enable VIN\n");
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
-- 
2.34.1

