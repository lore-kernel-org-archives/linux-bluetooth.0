Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C7272803
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017807; cv=none; b=QFyP2JsP3oHfty+NdKrySxNcz7PYPjXuJGLUd0ruYSyQnpHrGOqdIZyGRg0gWAMl8UyiCOcYzb7L47sEdK1fcjkt7Kzooq/1CfszrgEeBNJzGYY+tkM3RUqPBeMs+e2dkGOVVrMcEiL5SUcDZfGfd3s/c7+G1QYiFbSQ7/iSIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017807; c=relaxed/simple;
	bh=8Shijzz+87DBkGeFbAuU1GMELsQzAXTa4COa8P8ZJ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQiuKM0onhn5mlzFX4/HxDGwNS0oYL1/lpF0Pn9SxwSC80mj1NnjggGkm9FkcaSjKG9GltDBLFL3aHmelnSe1niXAwsVCyEzE8QHO5T2it5hQqgXHtjN2m4H+St6oK2Z2iaEn8+btqOMo0Iw6BOX1VdJKmV7nuySRTPLhh8BKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=dmJ2zEKO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="dmJ2zEKO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3171576a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787017805; x=1787622605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVoEfUB/ZAD7MbDl9ApeTkwxbHHTb4QoDPUw60dqPOE=;
        b=dmJ2zEKOsOrSljBO8ap4693sqyvcmy23E0Ae7MhxQcF7zZe2CKsGzW8/j6GvsPG9N9
         V1PfRHDvN8Qq7tCE/Pg8z+BGcRZQ6/Z3k6EkbtjPjTu/BBv5l2feZjorInn6BdfIPCRP
         /6//9CF1E4xxU2r+gl/Js5HI3D7A3+5l7J1MQWyL2Bz4oP/vwpJ9Fw1O+k7CFJZ4/kNs
         c6XEZTus9roZ+VvnjrKcPxhfs3otlTTw4iNiMrpE/DSw+7Xj/jvP6x3S8qqVlssU7T8S
         oz19lkX2kNmuHlCFuAkPIvhoTaAl9q6n+dbasnurb4gpME3bDwcNKY94w93xz0ll85Qe
         R5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787017805; x=1787622605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVoEfUB/ZAD7MbDl9ApeTkwxbHHTb4QoDPUw60dqPOE=;
        b=Vc1ksrz/wbYoyMYfNUZDF+iyCKzMEvgCOmJhGBqdoU/KEmGfTCPGDgHi38ikdiUrWP
         /xejEkumdxlOcUXMiTsSYsPrNXV/TLO/8TwWiXUv9WhJJu3S/pbNMZgYaPBUzg/ToqpC
         rmDtNiKU8Gzmh3p59YNm3Amz7/bPFgf+8J/0r6zy+dX1RxMNAp+hlW4+etNq76Ls+HYb
         RYF0F69lHtKSEDf++g2LbNMJairByB3SB4fF5OymAt5NjnH7HfKbmBjlJF5uX6RZbTHR
         gRTfJWes2i+s/GZrLflY/kicUxqcvsSo7MX0GNbD4Cp49dSDLMzpO89SJIrJGL+ZX2mY
         TYoA==
X-Gm-Message-State: AOJu0YzJXB+TJ1o0V3ygKNDnZA8qtlQa+k43FXRGElenNkK8d0IHG8dZ
	gteQbirKGsoyngN914MQt3LYLzMlUY06oEtY2SIGiMO5wWwLo88gf0Z3jSA6ZunLyD10MrtJL7E
	crnk=
X-Gm-Gg: AR+sD10XS/lYfwsvZR7p0CmIL1wKPtgWe7AraE3F5UyA7FEE9U7tqNhXcxmoQSx965q
	Ld6U0sa6qVk0xZT+GeOT+oUk8eEtmdX9JM4b+RxOZ181BvnDCDdj6ZUYeOduXVeP+kitwEvHBwe
	LpjCI1DX4fVXtTD7Ol749ufhgo0T9uliAiy0Wdgbv0R8kXrJl0k2wHGoiXucEUTTxzulOhnRSFC
	nep0gIbXqEkG+QTZYVe2Mwg246/FPL/fTi9Jt3JxuIQsOYL+VsL2R8ISuKMp1SriSysFLe/cHpI
	+pXcdoXPIiBE+/dUvVJ1dfQBDHPZZAiMuoiYk6riDFPdTU34RkrfQsQw8OC+LwLLXqtBKRj2sev
	G4+OG7qizqnekrNCThK7pE1YfEKfbEpqcj/7drJ3NzKv80vwt7+nlq88TpWzuHLrEWMkQvvmd8e
	3+EGTDmuf2/HQhZGOwsW+PwhoKhlEtFpHgj4PNIUmznbaEV9V67O9VmmUYjMm4S4JvvCGIZ0iZ8
	99w9UBJryZWZXceFDkm+9rQrIBgV0q6We72Wb3683n49xlny6CymkyG5/4rcyvRfw==
X-Received: by 2002:a17:90b:2810:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-3933b8f4527mr31343707a91.15.1787017805461;
        Mon, 17 Aug 2026 18:50:05 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84118sm7364750a91.5.2026.08.17.18.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 18:50:04 -0700 (PDT)
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: Kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v2 0/2] Add support for the Synaptics BCM4384 Bluetooth controller 
Date: Tue, 18 Aug 2026 09:49:46 +0800
Message-ID: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
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

Kaihsin Chung (2):
  dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

