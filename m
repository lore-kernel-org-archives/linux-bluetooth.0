Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F306775
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828596; cv=none; b=TufBjjeslRFwyuSxJak9WvA5ncrsRP8qH0b2qPqVpn7lE/mE78j6YSs97VlbTC1SIMPCSilnr1TdbUVU6W7ljhwuPN7S5zW0IRg/pqcV2RDWyjFQmXYp6oHWasQybAS7NbNuoPndHCNbdrKrJLgPYIbFtI8ejVocLV4szQbtVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828596; c=relaxed/simple;
	bh=xUcU4/ath3MB9X4umm3moMbocA/jtcRYF1kJ89FEfuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KxixeASceDZbf4RGoqP8DUSHD1GRoU398ojfWfsMj8ucP0fCiTS/rN7ERiJOpRL4e4w0F6WTQOKWOLjarnl8ugPdy+g+0d2f08e2YpYJGiGH8ckMMuiPgKVh0ooz2zqxBKFi9nNs1skpg5xub9Q2HKIQx9Vh4BatUtDbuVilKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=iWjFxj8d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="iWjFxj8d"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceab75934dso24913025ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787828593; x=1788433393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z30Tt3xIoabTbn0/fF4p38d5mX0hzLF11O+CjT3QkYI=;
        b=iWjFxj8dZ1jcL8ZJMZv1pSAz1/BNMjpgdPDiZsG4OVK7zaD8ArMT8Tb1w+HnTm1ZDr
         alfI7uvtOVffIJadERkR1ulzNIBdgCajUoprQryVNivatxfgZy7479eBLUikb18QHkKW
         pJCnZJoh8eLSz74lvJCteYhhniN4iETH7RCB1XIaaD0AqRKWeKLO4GUrooQrdwLC+GqP
         vGGlWvCv9n/LzrppMi8e7tmd5M9jXqVciPy2vMJq6SP0C1J6ypGBFcT5YUV3UUiU/XWk
         VjVliNtWlBCtONXIeDrEycZIvVNSbP68A6Ylt/bGeFNT7pBWQIc2snA53ZuYh6dMAs/G
         oZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828593; x=1788433393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z30Tt3xIoabTbn0/fF4p38d5mX0hzLF11O+CjT3QkYI=;
        b=jKoADNXNN6GaYN3QhGQ4b1D+73OKKt7um5ojPlWjiuVGrYbQSH/SHpY0u4Fs5D2KK1
         gu+5PYm49+1hofVXmGkYvKXDbH5EY4bsdSI92JgZnOplEhN+ZbDOQw+VywgQeZVc3fQo
         /VkSn61k1YqsgDrHrdM6Iqoef/FMDdCiBJgMs25ffQhTsBzT+9Y7OBbrLZhQhhUEs3kA
         UXctSrpil2KIi8H/1bh+UBTWKRLW0JhXNJRnurPXerJ+AaWM0ArvzDgerx6/uPFIXDjE
         HMtYYfS8yNFU34Ouzv9V4O7zpxeNEeZR/ss0bw2qg9rZMulfySlCVdbiNqEpq4JMme0n
         DYlQ==
X-Gm-Message-State: AFuF++lUWChiRGRiHK8pMwASN2XzPqIQiScz9fj4uMj3v1QNkOoPiqyp
	pafd7+SYRCkKZEi/n8jkBtuG+GlNAWJVeZvQgrAlBef1IaKbS1dVnkdkyk3iZEIyS1G5Hfl0Sld
	BeaKH1MlvMw==
X-Gm-Gg: AR+sD12SW3qYmlsrLJ2PkKWy/9KGT8nvMppH5RmrgPxbgFaetCn3UXuq2vM/MzYPvK9
	YQp7riQr/1AOno707q4+Dv1dTAWY+ekWLj0CozJ8fdQatiNAb6zMzyOFwgcWEX3dXScAWNvT5wY
	54YbqqOdpqR8V8N+A1Xwrl5WwebwNKDS3eIsXZo91tdrgSpFwlLiIReXICZZAftWGX7JwPgRJZr
	bdUIiyOSK4jglWf1ZG8Db51Rqb01Mj22r9BwceJtXkBic1vkyrS+/pR/dChFUvrrvDdjYkWVJAr
	IGYSQtSfCNbH8oIv1zCjd2EEGnIjTpTBqmnv/+A9gtr1HSHq7Ds0MIOzfJ1Qh9WnzS8KbpO2tn2
	+mt+m/TJRZwTrUfMrbGgFv8h+Mx8uZxD4fiGBzYJHilThXo8UKwJaIPNGMTLIHRdZ9e6wT4lX5s
	faPzHuNV12ZFdm7+ia+GY9pebapFIORdZtGTxUdHuVwUnia9RoSqpeIzR8KHSnPvMS3iV/H7ZpM
	6PfIMczDglxqSG7bIW3UNoWnd+IF+ZbLCfcv5LlG86sj8GaQQGiPTOJ+MLkMP+RydgDHP/RCbbW
	LS58Cwg=
X-Received: by 2002:a17:903:32c9:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d7079eb7e9mr258015565ad.4.1787828593135;
        Thu, 27 Aug 2026 04:03:13 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c4bea8sm15081585ad.82.2026.08.27.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 04:03:12 -0700 (PDT)
From: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Subject: [PATCH v1 0/2] Add support for the Synaptics BCM4384 Bluetooth controller
Date: Thu, 27 Aug 2026 19:02:40 +0800
Message-Id: <20260827110242.1203546-1-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch adds the BCM4384 Device Tree compatible string.

The second patch adds the controller support to the Broadcom
Bluetooth driver

Andy Chang (2):
  Bluetooth: dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.1

