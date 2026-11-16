Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846396;
	b=4gsQqqRH1A7ktrFr3pam0Pj6VCXs1VXx/KzSC7Ptzj4cqPZ9jfdTzwcgdPhdS+39jK58
	 8xgQx+WWexAmc5YfE32xE5do/IKWIJ4UuYCgAbPniIkHGZpzK47p5Er4QlzLfoUnxmsDH
	 AF6lG5ml7kPbQyge8Aq//wI0p+kypa1EaayRVMok2NEdcnftRzn9h/ls1nNb5hshQdnAp
	 saniE0AbJkvezymWpcyYoQ6LaoPP7sUOS4MtXkS1cGgzo1pesG4sextKWamL5VN77Djoq
	 ynFdRPt/X387m/OCUaySvaXPLStfoRJnLDonGh4/4b+eCT9G/KEm7+L9+9mrzzeUoYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846396;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=0LDtyOaBPaCfHTwJNyj4KDFIDjeAApU7lcCq8Fl6tdM=;
	b=kNpM6U33o1Syj5OLWrIQh5f/8WSqeBffiEnR+kNDGfsIGbVDRZ3IgonqGzG33EfOcRbr
	 a3i4OT7FQroaiiO/uncqzsN7BCDSRZAdlpqi9WX/IWIBxOfyR11inSK1WHnD2vgLLOsEm
	 QiXFUgXf1ro7tUc9aPIquepG1DOAkh4lt9Xks/QG+dgvSJIIz0gGpRG/k47Yg81DYaD9y
	 oXyR++MBfDqehw/jaWO04FVWPVNKtgZVS3e5StbiU8by8ZsfIWLHTmaErExddqeh6Xv+Y
	 38LsXZD+N2/Q3iYdgx1UPxE2u70tXYB+daVo732zyr5P/RI1fVAh05QLSJFg8gMGeLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=XEt6sPKd;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358B606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 16:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9358B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=XEt6sPKd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794846391; x=1795105591;
	bh=0LDtyOaBPaCfHTwJNyj4KDFIDjeAApU7lcCq8Fl6tdM=;
	h=From:To:Cc:Date:Subject:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XEt6sPKdfP0jfg1Lt1GIAcnwvtaqGomIJXOwWUXbM+CuoYSU6/uQMyQpVrqZiNZYB
	 Rg3e/B6KCDpIOM7O/HXzK6vPqJRoRHViazVeIWywgqpvHa6o7qOZXKAhmZ2qyAxxDN
	 FOR0i5dmDwhFkq/K97onfKXS4pH2WOJo22KFFiPEJzVcdYzKMxwIGDWEbhWKbC5/Mu
	 bR7HuyCKzF/hDgpqHFTpNDbcmx9APNjrHOBsqHur+IBaM1rPfx451f9AmMeMa0dUdf
	 C7wUdCEldGOCE1sZtwIR00zjnXbjofvrQWvbjoz5PXWPeGFzQgHZGwhtvaBeTnABXB
	 9dcL1WtFrx5fA==
X-Pm-Submission-Id: 4jStXh2BYyz1DF5G
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com, enderaoelyther@gmail.com
Date: Mon, 16 Nov 2026 16:26:21 +0000
Subject: [PATCH v3 0/5] Bluetooth: qca: Power off WCN3950
Message-ID: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Zhao, thanks for the review. I've split the serdev unregister fix into
its own patch as requested.

The final code is unchanged from v2, which I tested on my Moto G10. I've
also build-tested the standalone fix and rerun the regression tests.

Thanks,
Michael

Changes in v3:
- Split the generic unregister fix out as patch 1, with a stable Cc.
- Keep the port-state-dependent TX flush with the QCA power-off change.
- No changes to the final source tree.

Patch 1 applies independently. The remaining series keeps the separate
Marvell port-lifetime fix as a prerequisite, as in v2.

v2: https://lore.kernel.org/179468159400.2456.8302096233933976388.wcn3950-poweroff-v2-0@michaelmcallister.org/

Michael McAllister (5):
  Bluetooth: hci_serdev: Unregister HCI before freeing the TX buffer
  Bluetooth: hci_serdev: Track whether the serial port is open
  Bluetooth: qca: Power off after unregistering the HCI device
  Bluetooth: qca: Handle failed power-pulse writes
  Bluetooth: qca: Power off WCN3950

 drivers/bluetooth/hci_qca.c    | 35 ++++++-----------------
 drivers/bluetooth/hci_serdev.c | 52 +++++++++++++++++++++++++++-------
 drivers/bluetooth/hci_uart.h   |  3 ++
 3 files changed, 54 insertions(+), 36 deletions(-)


base-commit: da3cc02587c629420603df4395179ec82955c941
prerequisite-patch-id: 517b9cfef6a60777b0869a8f46d4c07be7f77c13
-- 
2.39.5

