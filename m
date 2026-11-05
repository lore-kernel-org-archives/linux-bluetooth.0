Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869078;
	b=232OUyAp7D5z9BVtijrlceV8iKxSQmLf9SVAxaLsYWVd9yvK2cnuIA4Zhe/FvwW1W03i
	 f/MBAWqTIRI3jHmTb013mHzMzTuyZTE/jcSvZvKXxPD4qBhZNJWBvrB4ZQ7xKmlILwpID
	 IpkmhC2ER7ZQFa36N37ldlzBJn6iiNnRCugcVwlWLzAdMEZAcypStoxnXOrsUtORlfgS1
	 OtpgJ/dyiSPQJqHf+Exg6LR9KZyGjiIX/dl02WCw21Gfz0ojrncABfn2etED6+FDEeNx4
	 Q0chp1MoHF6WNgziV5U+AxI3KNE8dFXaJK2N2shq0uP4HpoVuA2uFksRBfJ/ye38mGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869078;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+OEukqBjZ4Nc8BCDu/WoG17PIAdLhibLS5ySFrI+Syw=;
	b=O5jq92G8X8xEhAeczva+d+yhZGeFYARqqBwKCc8oMVYbXxaM+YaAFt3J+wJf//n18+/0
	 VgmDWdOAmeK0fr57RcHXf8I+fHOVmBTPz2iKIOFQ4Q8EUS4cSSqc5iKEf/0Nsea66tpSq
	 qc38zdXXhHglmVbObDacMJkIqIZyXROQsa4NAlLKeo4vnKSfvWYbHeItI4AUeafIkc7+X
	 hQGhuSeU2QlnXRgP4YYUt6um2a5pc5vT4D6Ixk/kzOwljg152GbwxVQYr7We71wew/bPz
	 3Nv3IFDv+WpiLhfDvJ/DPltqrm46DirBPIcBhx0Wai1TOo6JiAWZBJbtnbDIkASSz1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=XUim8JGm;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6899606A326;
	Thu,  5 Nov 2026 08:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6899606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=XUim8JGm
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 03bf1ce5-610b-4b95-b93f-bc73e1d656ec
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793869073;
	bh=jbMk5zFI/hHGFxPw9ffoT+Q2QeN+W0YqVUTB4WZlEfg=;
	h=From:To:Cc:Subject:Date:From;
	b=XUim8JGmqk3A1Wm2m0CInsOy8epbIAo3Kixqlf4l6cNHDe8A5Llw4ZJ9v4rcNTvUR
	 hTcJv0z2jC49j38CMSBqCCrNPT1EN5d3+qLdMj/mekAXaBneySor9pT1nlCO4zW4MS
	 fb/SDWr2o0nA+haydi8L8F7dMACn01sv/EMb7ybm7E+DVaxtL/cryEmL+9aF/YaP/j
	 LUtnqVm8/N6LQYo9L5rNKxobLBkmmFPY58rjn5gSo314vQw/N/CunsHC3jrq5IGGuh
	 SaQ8I5bsCFpFsyMJ2JtN+uUvg3KBkpcxiZe7VCY9p+RRSLWWS9GwQjqI/gYpl88zvn
	 OYb5xPl7Vu/VA==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v2 0/2] Bluetooth: Broadcom controllers of the Apple T2 Macs
Date: Thu,  5 Nov 2026 09:57:48 +0100
Message-ID: <20261105085750.120392-1-dev@deq.rocks>
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

Patch 1 builds on a vendor command the Android Broadcom vendor library
uses, 0xfc57, to keep A2DP from dropping out while WLAN runs on 2.4 GHz.
Patch 2 sets the strict duplicate filter quirk in both drivers, so a
discovery reports changed advertisement data before its next cycle.

The KaiT2en community, about 280 members, runs these patches with its
kernels. Users reported them working on the MacBookPro15,1, 15,2, 15,3,
15,4, 16,1, 16,4, MacBookAir9,1 and iMac20,1, and nobody reported a
regression.

Changes in v2:
- Dropped "Bluetooth: btbcm: clear vendor bits in LE advertising report
  types" and the revert of 88397423671f. The mask in hci_event.c stays
  as it is.
- Link to v1:
  https://lore.kernel.org/all/20261104151601.70493-1-dev@deq.rocks/



Andre Eikmeyer (2):
  Bluetooth: btbcm: raise ACL priority on Apple Broadcom controllers
  Bluetooth: set the strict duplicate filter quirk on Apple Broadcom
    controllers

 drivers/bluetooth/Kconfig       |  1 +
 drivers/bluetooth/btbcm.c       | 71 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h       |  7 ++++
 drivers/bluetooth/hci_bcm.c     | 23 +++++++++--
 drivers/bluetooth/hci_bcm4377.c |  8 ++++
 5 files changed, 107 insertions(+), 3 deletions(-)


base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
