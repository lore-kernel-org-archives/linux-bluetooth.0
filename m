Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785925;
	b=Epbxp2m3Vk+mg35Hw9eX/nDNQnDY1mBDSDAfP3mUv5eWklGOQN8kRN8W+tdBaObogKnC
	 OvImojfdnrt4IgkXvAEZor//85JfORzipPJNIafekRCvrNgGFG3+EMFb0mwyXZKfndjyM
	 iI1XTsrevGMS+Oq9bsnF9nx3tHbZX1Mr8IU6toUJw19Xm02IQmVdBOQJjff8tyhQgI+Se
	 J/X/8SiOBscEUROXhKR/5piWfSlAYM2W6oZBoELelw4+Fs3rLERlzGu75XMUefBkESSnm
	 liedjuOuwP4fKVeEZ3m4wff6EFbEJkcYgt1hyFguE1fDjm5xbiJM09RuWiTqDOu5+7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785925;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fsWGnEZ5RKV6lIzRH7Tlw+9LSGwafYEQKJ+xp4OkgK8=;
	b=Wbgv2Mbm/unPjZMO04kERq0BkFiU76mkxjcctcg8XndyiA0oXAKvXB44Jh3yUQhn/tnn
	 GhlsuHs7MjCLcAetaDaaPskYzZgePTw1x6fe8tkMIJmO4eV0JBrQOXqJHlpGsL1dW1Qs8
	 2/O+NJzg2N+vI0YniLvebHEJadJqc4y3SI1pO32R0e8Fa77e1XOGNJSdlfICNTHpThadI
	 0f3Mow9aXk6U+pyr5UE7KHiI1Yre7ukyf7jqGx5be35tvIPmt0/C4VrgNhjZGGKqGlQcT
	 EHqjMGuGQvUoqwgQzNb7qRTMuunvWLVgF+hkziPgFKUeJCdp+TFThLeRat9Qfg6IzXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=k07RwCpt;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF06606A689;
	Fri, 27 Nov 2026 13:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF06606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=k07RwCpt
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795785923;
	bh=I+5+4Cp5p5qxFPp6obALvbtUZY0z9Ceb02BWKTkXBvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k07RwCptZdv3JTqfF+mHnPZiENqluG+INjymvqRGYkYhNet6clZItckwiqQwqi/Mp
	 enXdS1HnVWlVtToaCzHCi8iDhXnu/OvYjNTCSBuPDuHdaZTF34vjszcBZcmQcN++kP
	 yzEQA1gAOkfrN282rPIA/su0LmvunYljaXBdmsrK9+bgcUslobhldghOcpuZ5GUa8B
	 /wBz/wEKHmuBggxiLvmuoBaAxzFDw1Kw1ICB03RAneHo/y7qCcUDTBdGkNWAGLqH8l
	 BoB5PMX86keSe/YUxp8fYyZV2p5Ft4G7qcJQ7Yc1oJiYf2gSGtUAapaCkI0SqHlUmP
	 IQn+U2xmtz1sg==
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
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>,
	Aditya Garg <aditya.garg@linux.dev>
Subject: [PATCH v3 2/2] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom
Date: Fri, 27 Nov 2026 14:25:13 +0100
Message-ID: <20261127132513.262754-3-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127132513.262754-1-dev@deq.rocks>
References: <20261127132513.262754-1-dev@deq.rocks>
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
index d2fbaf7cfbc..d85554188b5 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -604,8 +604,11 @@ static int bcm_setup(struct hci_uart *hu)
 	    bacmp(&bdaddr, BDADDR_ANY))
 		hci_set_quirk(hu->hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
 
-	if (!fw_load_done)
+	if (!fw_load_done) {
+		/* btbcm_finalize() sets this after loading a patch file */
+		hci_set_quirk(hu->hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
 		return 0;
+	}
 
 	/* Init speed if any */
 	if (bcm->dev && bcm->dev->init_speed)
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 7900e8ca2fb..3362e017bd1 100644
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
