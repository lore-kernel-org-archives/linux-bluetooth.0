Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1164746A3
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253043; cv=none; b=qtr8Smkrqi6mgBX0ZqbduIJF9luPwMRldlUr7XbDjuJvNACYtzTgYgkoYYtEy+OXSnq2IDhosOPxEaykYmXBYlMjLNKyCVzCraDaSIvxDgu3hjZ7K3P0Cs5QxsDRaoi0pIIXQ0YTGt/qQDURa2L6KPOChxAGfgg/neYrkQxI/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253043; c=relaxed/simple;
	bh=ENu0ff/T9GLBxirGVWZDIEaSILfp2s3hEpQHwIiy3fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmtivHp396yT+zSd0V8Sh1BIwTt1YJ70YzzQbZKQ1l/16J4s8sF4a2/GXQvKRjS9fw88Qyl3ip/N1iOn8rTRlz2/cFZ05lQsKd8u715tEmhjQZa8FqGYdIkaWECIxbudifBr2KLq0gzvSGlWem2T97xk19I37aP4IZD5IpiEhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=f68geqt7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="f68geqt7"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so4946316a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1788253041; x=1788857841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3N14T7S98EVd1zcTAmDaJnZi9OULXIvtKuCSfJc2RNs=;
        b=f68geqt71ydmLpoUQEoVuDgFfHpnTSEaKO9o5RW9YK81ULPw0DEMN9EeIrfX4UUQ+H
         iXMNaB2hXNUUkYKTWcW1Klb+8cjjrhHLUt37JtuFqfv42WnYgAwfZG0QFpF8WDdVibdh
         dXK+Q19ZRNlcz5yU1T3Mmh/gZrsx6PW3NgRGfTVjoLtKZ8Th0TUuPXBRdbM5UcILB9Xc
         A0h+FRVh5YBN4t01q4rkMiCpEoeFTOXZvPZizZtzR1m7LMVCGa2aMQ8nHXn3OC8jhdCz
         RaepSsgBG5LL2jyVSgsJPi39aU2zuEM1M83WytDkpMGxFZpBI0HRGaeEVGm647H9Bsdq
         iDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253041; x=1788857841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3N14T7S98EVd1zcTAmDaJnZi9OULXIvtKuCSfJc2RNs=;
        b=mwtnDxsoEGE5zExSDB0vWnqJwRDR7JLwoVngatOoOjhVU9si5k+mcZg+SdHgi8ffb2
         PxjBZkyDYwhSANFcg13IPuzaazSlcLDgmE7S8R8GimXqiYqdniNotIhdEj/0Zi5JDkf0
         cWDpoRpgkQUHIA0exkXLTBltO56j+60/Iyam9rTL7ppPO/L8koyaBTdNwUbsUXYn0gt5
         RN27qE9nROXuV7mCbyiafgkul7LRXLxREi1zLUo9V+3nFjehp/8y9HBhZzcCRilbruL/
         8YI1/bapKqP1NUEMrZOCHhpLXEEauCxrr/TwUeysu6s/twZwbvBWKwXlZ1E5hhy38sOZ
         d6qg==
X-Gm-Message-State: AFuF++kSsnDElZIHv9Bge7mgRCmgw2YvrnO55wX3zncqMyMflw5nB4C1
	/582qycDGqJ3aGYdhKxs01GAMr3KunEJxkfIPSFw3PAajgreMK+xtMgmRq1xUXhH514KBv5o3Nv
	3sRNXUz4=
X-Gm-Gg: AYBFou0NwriUGPPGEhTd6YkJ2OXevUAoXPUDpzS6EP/WfkHxl2y+F9H8pHB7BIyspw6
	9YOAAE+3Mym0viC60DRFuTpNWcFxwjHAEWTm2+hwx2ztmBcVC+1U0Z5zWL4kym4A9++GfQnUIUz
	5E9wagIsOc3RUErKaYwcvNshtvoYOLDWQt++ljjxnRjowj0ezz8GHUlnB6VuSUm+95TH7qplxgD
	O+KhTIE0G17aVJpql2RlWbFnz9MWaEe5vvtRvmNkIDq1ndky3ig0+HnYaBwtHUYz8O2FgfGGRbg
	WAJNWqsW3Aah8vTzSROSfqXGbVyBMvZuRvc0AAnicypmLi0oh0+5EKQzydbjhhDzU6ZB5DPMECB
	MfmIiqqFcP0JwHVE323F3K95KdiLOXE/DdPM3S9WcwRmYJTYzYp8N2pgsz2kKFZLxiMoVbYwCEb
	dSW5YelchC+B6/Ak9J2oa459K0IbhFJ1890bUNLdTRIT6J4ImSnwCrZ0zunO02AWYOVxm8qQN7o
	noIhKNOlmY0Ufr/sU6xxC9mVRH/oyqjliEx4SdRqI/yIl1V5HfNiEWsUVO5QAEpbCbrcCKaQQPx
	6CvHew==
X-Received: by 2002:a17:90b:388d:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-396d0ed8eb2mr47596038a91.9.1788253040839;
        Tue, 01 Sep 2026 01:57:20 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf6800sm5934432a91.3.2026.09.01.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:57:19 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add support for the Synaptics BCM4384 Bluetooth controller
Date: Tue,  1 Sep 2026 16:57:00 +0800
Message-Id: <20260901085702.1515378-1-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
References: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

he first patch adds the BCM4384 Device Tree compatible string.

The second patch adds the controller support to the Broadcom
Bluetooth driver

Changes in v3:
 - Patch 1: Fixed typo and GitLint failure.

Andy Chang (2):
  Bluetooth: dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.1

