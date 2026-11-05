Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869082;
	b=dd0p45m9QuL4q+/S3HpGa7XLJDvZkNOPkzzk2nrDbZ0i6imeWrBg7v40s07fOgQblykJ
	 uLK2l222as1hNiIJlkWQdpjCe/AgrOnDQhJfua7Q7xGWL024Ac6sRyUmmMfE9y0GdsBkS
	 Nv9Us0kyUL6NvDWQ6DKCQoqA3kOqjYw5DB6eU131tm6xU5NslL/aKhZWI9R59oOTp9zJg
	 HLEnLpQ7zwKi+QNeRXJ+weBFF/ex8jVoa01lO6OPYB2yBBJ9UVEW9ZiN4LEY80sRQMQim
	 kS1JDYRUxr4dozA7eqmMMfbT5Tc6fOem/iTklGa1xx6j6Rd1437NbZWdfknDr/1LgHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869082;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6UOkymQhnfOrj2yAZv17rmW+xuQ+0zZXE06/CQLTSww=;
	b=0GfboqYPWwkas3/bdH3K0iuW+eb1CdZHytQ+81QSy7OzyC7boJ3qOdssqnrx6ElA5O3R
	 NRRBFwAO5XQPQtbr26DZRO3CM+JqmS1lEotut8Ow3j4YjDF41eeknm/G689FQ3PxcTAqw
	 mvVd7W/X7OVs4kzFgEHIW6hmyJHf4HX8AlEXPgIkAqEfs7AmQKSvsg8641nbDXY7DRS42
	 vuMPlmrU61vP+c27BIsa0iSdS+F6Cdpf8dc2rCaPSfgxDiOEtXAItXqKtd2eYS8/ZLyE+
	 HIHRGXop3KdrHou4UiXyp3bf/+DGXcAv/pq4wuhKHLLn2ygFA4dSncpDPm5FHBotIUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=cbGVGSKj;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527A606A334;
	Thu,  5 Nov 2026 08:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7527A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=cbGVGSKj
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793869079;
	bh=AlntEjGZGdpJydOR7xazAe3mieEGTxbT1NLXNTsDkjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbGVGSKjSlLWifvxO0qrhgHm2nn1svRBdsFavoAUjaVD7q5UqCRG4z/V75mVI/6a4
	 jlyqAKYQAY+rZqxFunTLXcylQ3O0rSxOPXT6UrU4GdqoMtzEQNLD+maF5j1tawaB/U
	 fS6LtVJ8jrUDq6UfE6hqnIKuRPY9kmDk1Pm4xZw+wb3yNuNAgJNurn0YDarmiihN8U
	 4Lsz9/dzZp7SLvZs0xDfqueoCDOvVx8H2ZiJ1niRiqSG3ahJ2aTLMDCreGu3OJVC0F
	 1pv1SpPCWUIOiI6gmb4okeTXIRiuY33yZetuU2NZ4C1sPufQBGlC83lsrtKglvf0AK
	 15Fn9UO9skexQ==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>,
	Aditya Garg <aditya.garg@linux.dev>
Subject: [PATCH v2 2/2] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom controllers
Date: Thu,  5 Nov 2026 09:57:50 +0100
Message-ID: <20261105085750.120392-3-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105085750.120392-1-dev@deq.rocks>
References: <20261105085750.120392-1-dev@deq.rocks>
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

btbcm_finalize() sets HCI_QUIRK_STRICT_DUPLICATE_FILTER, but bcm_setup()
returns before it when no patch file was loaded. The MacBookPro15,1 has
none for its BCM4364B0 ("BCM: firmware Patch file not found").
hci_bcm4377 does not use btbcm_finalize() and never sets the quirk. A
service discovery then scans with "Filter duplicates: Enabled", and the
controller reports an address once per discovery cycle of about 10.7 s.
A Mac that changed its advertisement data on the same address was
reported 6 s after the change, at the next cycle.

Set the quirk in hci_bcm on that path and in hci_bcm4377.

Tested-by: Yossef Osman <Yossef.Osman@proton.me>
Tested-by: Aditya Garg <aditya.garg@linux.dev>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm.c     | 5 ++++-
 drivers/bluetooth/hci_bcm4377.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index cf4f1455cf9..9eeeaf5d6b0 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -596,8 +596,11 @@ static int bcm_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
-	if (!fw_load_done)
+	if (!fw_load_done) {
+		/* btbcm_finalize() sets this after loading a patch file */
+		hci_set_quirk(hu->hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
 		return 0;
+	}
 
 	/* Init speed if any */
 	if (bcm->dev && bcm->dev->init_speed)
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 30fcadfae3f..66cdd896c95 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2391,6 +2391,11 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
 	hdev->setup = bcm4377_hci_setup;
 
+	/* The controller reports an address once per scan with duplicate
+	 * filtering, also after its advertisement data changed.
+	 */
+	hci_set_quirk(hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
+
 	if (bcm4377->hw->broken_mws_transport_config)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG);
 	if (bcm4377->hw->broken_ext_scan)
