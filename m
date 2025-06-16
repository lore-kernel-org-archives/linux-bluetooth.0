Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC711E7C23;
	Mon, 16 Jun 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071908; cv=none; b=g43DvM2FevatXShvrOSZ47zMTAxPo/czITn4EzVuS1LBCVMvYAGCFCMX5Za7HmdJVuqXGcUaUX5lOKASSZ1hVIk1snTHtVWZTX9WWnfJhg9gC6UH79iRtqqPJAuYYlrS8n+AENKvxsCoP6kkb7A278W8vUNPOxqKEic85oqFEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071908; c=relaxed/simple;
	bh=YF9drZt1Vk2tqLIRz2qYVmlEicLlB4tRXccdLxx+vwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tujNuLsgXIVIDaHradt4hm4NGueQDl08FS0oBpzdN7pQYFa+N9C60DUjf9lkvidc7UGA4ada4Sj3e1NUi0KHTUA7OphCO0NFGtAszBVAqRXgeVbZHyY+PIVhYf3Jfczy6l1pwJAE3BF4nJKpPGhOo1HIWM7lpw+ZZ2kVP8HG9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeMTakPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeMTakPt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE119C4CEEA;
	Mon, 16 Jun 2025 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750071908;
	bh=YF9drZt1Vk2tqLIRz2qYVmlEicLlB4tRXccdLxx+vwc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HeMTakPtuQv6b5KMOeuBi/+mhwM0DlMjbUG+POaxZQPQgGGTXOOi1kfGhmi6tmu5k
	 Hc0W9nZ1+QGkgrgl6jLLPsNGVMgS6+evr6MY00Dif9yn6DRw16iIHDARNl2DovFJ4G
	 akMbBuQ2Al+U+nz7P1I9eV5fIFraq60KMDVI/GkpwzFUW0pogOwL2Vdfd6ICgzUQ2B
	 +lrjGYwqK6dXyn0U8zL3IMuGhrxEC0MF//rd/F4sK7nivmWMnkT+WUWef7GDbWxpeE
	 vTx7zkTWBIDXYeSALVJQ+mUfGV7QUM2jcouoLrlco/3Njq8HIqXvF+QtO4fwVcM/0z
	 RIiUS6UJSz2Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA185C71155;
	Mon, 16 Jun 2025 11:05:07 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 16 Jun 2025 19:05:05 +0800
Subject: [PATCH] Bluetooth: Prevent unintended pause by checking if
 advertising is active
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAGD6T2gC/x2MQQqAIBAAvxJ7TtBIob4SEWZbLoSGlgTi35OOw
 zCTIWIgjDA2GQImiuRdBdE2YKx2BzLaKkPHO8mVUGw9H7y9v+2it8RUPygURlcjoTZXwJ3e/zf
 NpXwt9z1AXwAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750071906; l=2052;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=r05iRzMErPFbpn/k1ZeU0pqT4UoisdNs9mKwnHRGPV4=;
 b=hop0CniKgaW+59T/eFsqEPThdBfFKX0zijHrAcYlvjOPkk6C76S9LnMHUOxGdglNyBUB2DdDR
 NFRpFKOoGuaACPqG4oBtmBtsn7hNQX/Epkv6lKhyFG56/UJHdvTARrI
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When PA Create Sync is enabled, advertising resumes unexpectedly.
Therefore, it's necessary to check whether advertising is currently
active before attempting to pause it.

  < HCI Command: LE Add Device To... (0x08|0x0011) plen 7  #1345 [hci0] 48.306205
  		Address type: Random (0x01)
  		Address: 4F:84:84:5F:88:17 (Resolvable)
  		Identity type: Random (0x01)
  		Identity: FC:5B:8C:F7:5D:FB (Static)
  < HCI Command: LE Set Address Re.. (0x08|0x002d) plen 1  #1347 [hci0] 48.308023
  		Address resolution: Enabled (0x01)
  ...
  < HCI Command: LE Set Extended A.. (0x08|0x0039) plen 6  #1349 [hci0] 48.309650
  		Extended advertising: Enabled (0x01)
  		Number of sets: 1 (0x01)
  		Entry 0
  		Handle: 0x01
  		Duration: 0 ms (0x00)
  		Max ext adv events: 0
  ...
  < HCI Command: LE Periodic Adve.. (0x08|0x0044) plen 14  #1355 [hci0] 48.314575
  		Options: 0x0000
  		Use advertising SID, Advertiser Address Type and address
  		Reporting initially enabled
  		SID: 0x02
  		Adv address type: Random (0x01)
  		Adv address: 4F:84:84:5F:88:17 (Resolvable)
  		Identity type: Random (0x01)
  		Identity: FC:5B:8C:F7:5D:FB (Static)
  		Skip: 0x0000
  		Sync timeout: 20000 msec (0x07d0)
  		Sync CTE type: 0x0000

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 net/bluetooth/hci_sync.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6687f2a4d1eb..4ea5a87f017d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2481,6 +2481,10 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	int err;
 	int old_state;
 
+	/* If controller is not advertising we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return 0;
+
 	/* If already been paused there is nothing to do. */
 	if (hdev->advertising_paused)
 		return 0;

---
base-commit: 6c31dab4ff1e1f4e0f3412efb1cfc88033358d1f
change-id: 20250616-bluetooth_adv-6496e1ca6165

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


