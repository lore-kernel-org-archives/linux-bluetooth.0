Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805373;
	b=s//0l8dlUpKJa1+BwGPZy/UpUSkJO1xoaYNFv5hwX5FYq5mXfSlaoV3ibeEqL6Eve/hT
	 Tan0ms8kFDgNKn2M8C4874ZYjM2FrCzu0arbaj6Kn8J+MAzfw0E5Bzp6yb2fjykWFe+mH
	 iLz5XBIWg5ta142GSO/YNHcI8CztLbslhkbiVjqHfMw8fHJcHNN2yKIe6g885Kos659ZH
	 P0jgmswTVo6yn05tQPIWOzdvtCJpq+QJQgykJs0MP627WhhUdEa28KWzfg1MZwy4NeqLZ
	 awWYhm6ONSBQ86Gb5dZL9N8bKpZko9EutU/TC3tekhWDi9m15Kyds5zUe3EfN0hXjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805373;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VWIce8GyF+Wph1oxrXCd7PKAGon4ik0yeO2H0tvXzbo=;
	b=Kq6m+96lmFGa8dfQg9KJoKtkm2zuUGAfNX4IL3wxsRPz9Q0/5eZtdVlrtAiqAPFL/XiX
	 8VTwSwhMnPB9XCtEfY/RdK3C4/D/pcZRVsc+ObfxpkzL/8dpftSqEtfxkRSNwpj/aDH5H
	 GzfJmGpEMrq9ETddJu50fNev+e5J1KLYoJLBGNc0/ARQqLVLQ+/0FUvP+lZwOG+nl8b9w
	 VYHFZh1Gh2QQd9ffKy39H2+Ptp7QHGO9zQCoRHrHlRf6BKbjRz9EvarM6NB6Ihml29Xl+
	 JMNQ6ZlEb8RPe8aS669DQbryo5msYJc13yxzwT/kb7PJoLNQ3QYaC9P3nlBV6GcFZuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=OcMT5IUe;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDF608360D;
	Wed,  4 Nov 2026 15:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCDF608360D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=OcMT5IUe
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 8e654eb6-ed48-42b1-95f7-cc1366fea7b7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793805365;
	bh=7dnOqwZnTP8NaQ3TDpLPp6CK/DOOubcnxEKdxMEfruo=;
	h=From:To:Cc:Subject:Date:From;
	b=OcMT5IUexJYPM7J7pdfIzQvX4gWo90lGlQoCoK3jHc3bHk5yNm24EybqLOOzG9sgy
	 DA9HfAxf/IhLh9vs0QIGACS/sIEyrMDq13WlCoMgrZy3OVFh03uY5EsFDgpr8dAcVR
	 srqHgECGSQvl8nbseay06nK5HDoQVgK84x1RKfQ6tBqDr14rLteDsgTFOtSpTw8RIQ
	 HZI1CPRaf8vWL1j+EiJDNWmG1XGp/qZjVo2UnsQytDzBxlltKNQfYVRsPrSxoJqCUL
	 DywjGLa5AKHcSs3nJwzjA9h+V3LTUZ3qW87NfftkSBW6p9afZjg4be8YcqjoQrkuLM
	 PGE79Kjub9zmA==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	66ton99@gmail.com,
	josemiguelo.ochoa@gmail.com,
	aditya.garg@linux.dev,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH 0/4] Bluetooth: Broadcom controllers of the Apple T2 Macs
Date: Wed,  4 Nov 2026 16:15:57 +0100
Message-ID: <20261104151601.70493-1-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This series is for the Broadcom Bluetooth controllers of the Apple T2
Macs, the BCM4364 over UART (hci_bcm) and the BCM4377 over PCIe
(hci_bcm4377).

  1    raise ACL priority on Apple Broadcom controllers
  2    clear vendor bits in LE advertising report types
  3    Revert "Bluetooth: hci_event: strip Broadcom vendor bits from
       legacy adv report type"
  4    set the strict duplicate filter quirk on Apple Broadcom controllers

Patch 2 and 3 belong together. Commit 88397423671f ("Bluetooth:
hci_event: strip Broadcom vendor bits from legacy adv report type") in
bluetooth-next masks the event type of legacy LE Advertising Reports for
every controller with manufacturer 15. The controllers known to set these
bits are the ones of the T2 Macs. Aditya Garg asked about this on the
list:

  https://lore.kernel.org/linux-bluetooth/F4853998-F2A8-4AFE-99EA-544657EAB0E8@linux.dev/

Masking the type to its low nibble goes back to a t2linux patch by Jose
Miguel Ochoa. Patch 2 clears the bits in the two drivers of these
controllers before the event reaches the core, and patch 3 reverts the
check in hci_event.c. Patch 2 comes first, so every commit in between
keeps the reports.

Patch 1 builds on a vendor command the Android Broadcom vendor library
uses, 0xfc57, to keep A2DP from dropping out while WLAN runs on 2.4 GHz.
Patch 4 sets the strict duplicate filter quirk in both drivers, so a
discovery reports changed advertisement data before its next cycle.

The KaiT2en community, about 280 members, runs these patches with its
kernels. Users reported them working on the MacBookPro15,1, 15,2, 15,3,
15,4, 16,1, 16,4, MacBookAir9,1 and iMac20,1, and nobody reported a
regression.

Andre Eikmeyer (4):
  Bluetooth: btbcm: raise ACL priority on Apple Broadcom controllers
  Bluetooth: btbcm: clear vendor bits in LE advertising report types
  Revert "Bluetooth: hci_event: strip Broadcom vendor bits from legacy
    adv report type"
  Bluetooth: set the strict duplicate filter quirk on Apple Broadcom
    controllers

 drivers/bluetooth/Kconfig       |   1 +
 drivers/bluetooth/btbcm.c       | 102 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h       |  12 ++++
 drivers/bluetooth/hci_bcm.c     |  28 ++++++++-
 drivers/bluetooth/hci_bcm4377.c |   9 +++
 net/bluetooth/hci_event.c       |  11 ----
 6 files changed, 149 insertions(+), 14 deletions(-)


base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
