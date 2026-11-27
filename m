Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785919;
	b=V0+kjQmaU9ssG6Magx3h2HFw5SdF3w32VFup/M7dR47hNVieme7UmQAhVcXOSEghIOf+
	 jPbF4q62tYMPgC9hBoLGZ4jSIq6OIVsxf/lPBaOvfKa0RaEauAS/YWqG/31RucF6TG5/0
	 s2b558mNu/pQ1DjL4QPhHpdOUJtaUohdsjKfFQveFeXOeiVCsYH5yEN57vyS0cRHZts15
	 rMaP1yZaEiWCXC7a7TjOoNQvwCxH118/c2mnYotCE+/3Sks+CugmS1zZ+gmVKDZEmAlfg
	 nNjWULRXwzo6R/b5HhWyMJ8n+MNG9KbiQw7PgJFmym5L/ZTmhbboZ/nLXUY3Ag3jrcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785919;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=87loX2K1MRUkuuriEOw5VwScje1H4+shrb09r2CZSlo=;
	b=TroG2S90Fma+3lkKmbJDCISCrYIKbmVWjQLINSMB/yyqdalpM9wHY23ATZtMCozFPbHX
	 qV0b7rPsAxeTetYI1SE7VMCAFyGeMYpdb5FQraAYz/3B/3GWROusjpgL7Igk1ELLWqzqc
	 5zNmGd/6M5nMs9/vaz3984wQCucWz3jZT3Tw2CFR+ifUuXA+iUHYNR1lf8TSoUSokjs7N
	 7y61s1yLd5ze21r7HphFkZXUMNLXLiKRazyvn4egqH5qm4of0Z1iHn5veNayy8qMqQYpI
	 ZfOGznAInPx4u5U18n5pEu4bF7t/D0QDgpUE3GDfGbusyGTSgmXXeC3yWN6uSnL4Bow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b="BF9/M/FJ";
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E82606A327;
	Fri, 27 Nov 2026 13:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E82606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=BF9/M/FJ
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 8a5ecd65-d520-476d-b113-531c87366ce0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795785917;
	bh=TFZW56ctheIsJ0mDPfySDHNMgAhFyvnxeAxQ3mNsdZM=;
	h=From:To:Cc:Subject:Date:From;
	b=BF9/M/FJpQud79g1eDuHaDZh/VfV/gCMOpSOs/kMUYPS0n551LaZqCkuLuDkivO+5
	 aJE+yNF3auuRXMoe88w9bVsP8GNl/EOY6xO62gsBDjxPA3ce6X/nV5PrLptkJGJbtz
	 nIXf4HoZeTTRzanm0kQtDf3kC6Q9GkHyKCvJg9MVnnD1jprLsU2V5NKghVe7wvNK2h
	 f8Cvf7vdVPfkCm9WR1fxw6imPRc15Xhb47k92IQ57JIlGvqtyilkt0LBpxmJYJCyBn
	 aAK2E4Y/C0XV/zSYUFJRvIzjZlZY1cZMrIzmOVrqpE2gZ6XvhJsPAsdwl15UHBSCPC
	 EQRCoeeYdP3aQ==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sasha Finkelstein <k@chaosmail.tech>,
	Myria Sarvay <myrialsarvay@gmail.com>,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v3 0/2] Bluetooth: Broadcom controllers of the Apple T2 Macs
Date: Fri, 27 Nov 2026 14:25:11 +0100
Message-ID: <20261127132513.262754-1-dev@deq.rocks>
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

This series is for the Broadcom Bluetooth controllers of the Apple T2
Macs, the BCM4364 over UART (hci_bcm) and the BCM4377 over PCIe
(hci_bcm4377).

Patch 1 builds on a vendor command the Android Broadcom vendor library
uses, 0xfc57, to keep A2DP from dropping out while WLAN runs on 2.4 GHz.
Patch 2 sets the strict duplicate filter quirk in both drivers, so a
discovery reports changed advertisement data before its next cycle.

The T2 Linux community runs these patches. Users reported them working
on the MacBookPro15,1, 15,2, 15,3, 15,4, 16,1, 16,4, MacBookAir9,1 and
iMac20,1.

Changes in v3:
- Rebase on bluetooth-next. Patch 2 sets the quirk after the new
  platform address check in bcm_setup()
- Patch 2: shorter subject
- Patch 1 is unchanged. The comparison with Sasha Finkelstein's channel
  priority patch is in the v2 thread

Changes in v2:
- Dropped "Bluetooth: btbcm: clear vendor bits in LE advertising report
  types" and the revert of 88397423671f. The mask in hci_event.c stays
  as it is.

v2: https://lore.kernel.org/all/20261105085750.120392-1-dev@deq.rocks/
v1: https://lore.kernel.org/all/20261104151601.70493-1-dev@deq.rocks/

Andre Eikmeyer (2):
  Bluetooth: btbcm: raise ACL priority on Apple Broadcom controllers
  Bluetooth: set the strict duplicate filter quirk on Apple Broadcom

 drivers/bluetooth/Kconfig       |  1 +
 drivers/bluetooth/btbcm.c       | 71 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h       |  7 ++++
 drivers/bluetooth/hci_bcm.c     | 23 +++++++++--
 drivers/bluetooth/hci_bcm4377.c |  8 ++++
 5 files changed, 107 insertions(+), 3 deletions(-)


base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
