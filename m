Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF70221FD3;
	Thu, 19 Jun 2025 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750302093; cv=none; b=pTwjQ1KESvhZGUUf4dZs/t3bLlGQnfRNgIZPZCYb0pg1Q0RzxBxipVf7xcMdv4RiYI75Y8szwL50IuJHQqMzzHA0UdlMlMhpnkNmk3iAGqe5Sw+1/j2fbnr1X7U3m+clRpBmC/MseAb+PVHWJNWHrUdH1wd0nn0rD6lQ24HV9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750302093; c=relaxed/simple;
	bh=ueXKMxRdIaks7XPO1ZEDJxosRpy/GICdci81awrun34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kJSh8soZy3T9srzdqv6j+Yo0cmKDGA9l43UMmHInRbtGy2WqiZX8+8ZZZPKj9HETFhMrqewpk/pUoWg1nL/bZVelTE99u0ndahNYjF/u70PoJSWZinpt0FR71ENjZpRT0++QwoGugh96GjZBIo3XZVXLunWJkYJ2JV5cXI3kgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIgJsMfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIgJsMfM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8B82C4CEE7;
	Thu, 19 Jun 2025 03:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750302092;
	bh=ueXKMxRdIaks7XPO1ZEDJxosRpy/GICdci81awrun34=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SIgJsMfMJrfCb5J0pjpyEIEmgX1HQc0iFXbPnyRfK+BNfJ6hZUwmYntsfLt01VhEX
	 HDFmYJlNpHhjDLegMQNW62urZIpPEFSqTldwMAYUxL/fVkKeKU4fPYdIU04NiJ2IGQ
	 20BwgDMW/84oKZASxGYZVdH//2FE0G7Lin8WdNN1AqFY/wElGfqllLy2fBvdCtpsB0
	 a4BDQicl0b1E1APlLBUgIUmeYBhYWZcJFJeLKwnaJf+cMHivX4y2w15Blq7dxSoR+z
	 F7dC9cU80bSYHuqN3Ckrd9hFV+/pY0KWf7J+wJWHYCgBYjwxIdPyY5rzZYpF9i694r
	 TnTIHBoUich3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD790C71136;
	Thu, 19 Jun 2025 03:01:32 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 19 Jun 2025 11:01:07 +0800
Subject: [PATCH v2] Bluetooth: Prevent unintended pause by checking if
 advertising is active
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-bluetooth_adv-v2-1-4bfc32941e53@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAHJ9U2gC/3WMQQ6CMBBFr0JmbQ1tSkVX3sMQ05YBJgGGtNhoC
 He3snf5/s97G0QMhBFuxQYBE0XiOYM6FeAHO/coqM0MqlRVaaQRbnzhyrwOT9smYfTVoPQ2PxV
 kZwnY0fvoPZrMA8WVw+fIJ/lb/5WSFFKY+mJcp7GunL7baeSe/NnzBM2+718eiJMYrAAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750302090; l=2205;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=zqpWcoSKZb3WumuLKkTEfxcwWCSRId/gZHkwKVrcGKU=;
 b=24TQwijOi7LIMktrRdEmqkKnfohxW0SdB+kh0ufia9f6OhSuTtcAncI121uI/gMll0TfkIENj
 Z0M47/loVqKBTjnjWjh0UwOByAp9UC9gntmKIMTojJIq9iKFQnlzRmr
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
Changes in v2:
- Replace HCI_ADVERTISING with HCI_LE_ADV
- Link to v1: https://lore.kernel.org/r/20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com
---
 net/bluetooth/hci_sync.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6687f2a4d1eb..42d3696227af 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2481,6 +2481,10 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	int err;
 	int old_state;
 
+	/* If controller is not advertising we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_ADV))
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


