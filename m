Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2081B0F23
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586335; cv=none; b=nlY+jhS/5ZNXZSbXQs58ePuIBxAElwALu6NIkLGvCSkqqArVX/mT/HJTLEMUplLRfhYW5xs6eeYwUbZEluek33+ws0rNS0ZQk9IU5S2WfhsZ0d8JGzor/c0vgtio7XhLO7cqXb8z9SdHpiW8has0uJjl3z+eJBqMh8f/vQgR/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586335; c=relaxed/simple;
	bh=OYwzMYnDeSWWMljadrkQn2SVgvR8kGwEMA3cfalr9+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pECp3DVZNPV26TdUx0f+Zc6hwzU5K93WzkGv2AsHVrmzJYsQ6eXFNWo8i4tDGx67whYcVsMQdnTr7FWJHZW8/7MBag7bYw7l95K64wi+1Xh9z2UMsURzQbOpY3+cEIJFBPs6Lxb9ES+zCm3TdXliz+sWNM/LuSgnOVyojGG0UbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VttliNIr; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VttliNIr"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so1862727241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752586332; x=1753191132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcGHeNba+jgk6vvUPZ2OhZT+cwX4AwKJeQMk/lhdODU=;
        b=VttliNIrDE1YLWc3fLqjknF2ovEtCM8vCnTYRJbnCeI6EZJjqDiEC5DegpkFmbvdy1
         2wGYTT4WTBTkr8AhaDwFq+e1BKEJCbHhbVjXnS49zvendHImFaEQPt3MRKGeAEQ2x1l9
         dK3Ovt2x7zPTky64QqdkXsY750/A/nfFfyaxs2zcNdJM/9hMa7a7skFiRVctH28lExyo
         LVDCKqCo1aXGbeXXChc5VE7t+m3Q23CsXX/ih8bMMg0Q3dl+vfwpa/IW2imNbMrT8zlu
         q7k/GXTNgXFmFbL7znNkXC21VB4ofa297hpZn9+JKCIBF0HcXfy190BDCI7H0ZAnhSa0
         f2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586332; x=1753191132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcGHeNba+jgk6vvUPZ2OhZT+cwX4AwKJeQMk/lhdODU=;
        b=qZYulJWjKA2yiBMAHAIdvWZZaRtEv0lbSsiuinbuTr7IHXvCrSpZJ1FVtARQTGtiqM
         0Pte4YlQ3UyNDYq4tOdMxMoleC8nlY1kFOkn6TnrGcHTspHCWx4zt/Mqo2rn3B4krrzQ
         Mewn+TdfTHwGJwv4YCSP+DNFuIjZvoTYwTpfUQhAbjaERFvgmj7wlM8s0+Gb94X+1cmz
         IpIIkdNuicScLmks0OTTnUtev/8pQFhaWZInLWdkWTMqiSG4ghfsj2ylNc9PJoJCivSW
         aPeFjdOx4U2mDM5BMWHEPCx/277A1MBlma11vAOno4pvLikk3J/+adICFFYsOcEDTr0Y
         AGAQ==
X-Gm-Message-State: AOJu0YzV3kAd4H9sHgbMmYNpC0pwJvSwhWW4/hu+7QnzfS/cllH7CLg2
	2BAzPcGRpbR/tzhc1FTvFNBieoZLYxOtGvZfHxsYuOkti1IzwqAPv9+Vh0JvjIoC
X-Gm-Gg: ASbGncv7SkWlM0wbGagLmLNzlz46iLh/6y3htZJmiHAdHhxY1ba4rxqiQet1QknKyr7
	OzkpfAqVDkaqQC5Az1MA78uXTyI8gH2O9MHPGrNzs0sEcVZ8fWTTFFJNIeaSkpqKc2+XU3IGVSs
	91ySOPGGGE1D+Z2WaCX554gdpvCyOxHy7tKo/rfjFuuMWvUdZfzwDVfbpCURK4yfd8zOV0uv2GA
	2Gi32kTfM209UXxLVtzRq+FquGBbqdNGRgu40aYFWLIB9R9R3sOd+yKZhLsrhBBcwQ3FhMBTUzs
	O41CJvt+lT6Q3TWNmxosg9lGg+ddfgfCDXdWeFYsjWcB7XJ5uMedGRx15evVz4w3UYWraZW+lW3
	sGoqnHSGs+Uzy51UmxKxHE6deoCyL9bvVMEdBgJvHBh0Lg94jCAsao2OMnNf9KbSq
X-Google-Smtp-Source: AGHT+IFhGmnoNs5ILJCEYzUPYfid3XznFj4R+6YxwwxG1r0w8cR3vH3iIhatjn1+FGln360/R0W5fA==
X-Received: by 2002:a67:e716:0:b0:4bb:eb4a:f9ec with SMTP id ada2fe7eead31-4f641ea1941mr9747665137.16.1752586332064;
        Tue, 15 Jul 2025 06:32:12 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-888ec245356sm2134623241.1.2025.07.15.06.32.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:32:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] tester.config: Add missing drivers
Date: Tue, 15 Jul 2025 09:32:01 -0400
Message-ID: <20250715133201.589025-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing config options to enable all drivers which is required
in order to catch build problem with github CI workflow.
---
 doc/tester.config | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/tester.config b/doc/tester.config
index b5fee30b817e..24a0ca1eb6c8 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -58,6 +58,8 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PLATFORM=y
 
+CONFIG_SERIAL_DEV_BUS=y
+
 #
 # Bluetooth device drivers
 #
@@ -74,13 +76,21 @@ CONFIG_BT_HCIBTUSB_RTL=y
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_SERDEV=y
 CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_BCSP=y
+CONFIG_BT_HCIUART_ATH3K=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_3WIRE=y
 CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_AG6XX=y
+CONFIG_BT_HCIUART_MRVL=y
 CONFIG_BT_HCIUART_AML=y
 CONFIG_BT_HCIBCM203X=y
 CONFIG_BT_HCIBCM4377=y
+CONFIG_BT_HCIBPA10X=y
+CONFIG_BT_HCIBFUSB=y
 CONFIG_BT_HCIVHCI=y
+CONFIG_BT_MRVL=y
+CONFIG_BT_ATH3K=y
 CONFIG_BT_MTKSDIO=y
 CONFIG_BT_MTKUART=y
 CONFIG_BT_VIRTIO=y
-- 
2.50.0

