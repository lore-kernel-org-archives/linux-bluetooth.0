Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6417FBF0;
	Mon, 28 Jul 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693727; cv=none; b=s5qrLcl7hxF40ElfOtPOnVgLjPkaFLmMavGm/XZ8o9VHqyu9jCZ9nk9UdpBgVjEfl27oEtecGyhgWW4w1CP0QUomp3SEPySWH5kPounDfee4jk7lDJ+GWYcEHgfewacf1I2HRqCEa2sK1Jdwzm3qWPkNX8dlsj6FNXSlIWehtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693727; c=relaxed/simple;
	bh=OfRUM38b3EvY9TW41XVgHbkrwnuWmdvU9NPcj+KLAvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T+pmoGE3TQVdal/S5Kep6+Gzsrkfnz8hEPM/x6xvEQzGn7uzEuIEmoeuq3m8JVAKJmgwkGVRfFE4lliu4ceFQs01+pix8zj7F13hmJyVQTWVMWS0rVDn8eg9WK1dq5VaBY0F0voFBajxFLUhKZu68WPBIaE+3gSQJdgmPIenxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVPcWcbT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVPcWcbT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33BF8C4CEE7;
	Mon, 28 Jul 2025 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753693727;
	bh=OfRUM38b3EvY9TW41XVgHbkrwnuWmdvU9NPcj+KLAvs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UVPcWcbTjfQXJUIRVAFajDAJ3HLVCEgM17Kx0vXkxsPC7ZpMqX75yAZ31XswwQpXH
	 7dxwpDeY3KKoiAOL47z74844C80U/jdBbmc73pzV3FjGCMA4Xvs2Um5hXzvrjtUVHZ
	 utyCw9aiNxwJbDVlG4bpQN1epBysZd0bjwlpdYDb3bweNsh583sriZCVDWPAsm3rGR
	 vFVDVXTLnaVM1xrxYfFNa89tOgDw2vuFnHbPQ20kDV7DyepLAY97iJqMYD5oexk4ng
	 MzMj4gHyW66KWxT+rJMzMCBuRggc/1t0gn2g6Yvturl6ZvP3ZPlyym2bY3ZybXIEOv
	 59/X1kYt/ldNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1809BC83F17;
	Mon, 28 Jul 2025 09:08:47 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 28 Jul 2025 17:08:44 +0800
Subject: [PATCH] Bluetooth: hci_sync: Avoid adding default advertising on
 startup
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-default_adv-v1-1-a1164ff502a7@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABs+h2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3ZTUtMTSnJL4xJQy3WRTUxPzxBTjpOQUIyWgjoKi1LTMCrBp0bG
 1tQDCYAdmXQAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753693725; l=1557;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=+a7zu6df7P6AdI4x7RiSKdHUqD0wbm828ppOC8TJSaI=;
 b=3UX/dEiKfIm3KVtx2p0CoOiWQL25So1OuJjvoy/lEZDif1Ww60eWJtqHWw9ayCrEuH8iV8jRV
 /X/OX2px1S7ChY3zt/VYeNXg5TY9mrMNLvEJI2rntOkkG8hhZ8qIfBh
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

list_empty(&hdev->adv_instances) is always true during startup,
so an advertising instance is added by default.

Call trace:
  dump_backtrace+0x94/0xec
  show_stack+0x18/0x24
  dump_stack_lvl+0x48/0x60
  dump_stack+0x18/0x24
  hci_setup_ext_adv_instance_sync+0x17c/0x328
  hci_powered_update_adv_sync+0xb4/0x12c
  hci_powered_update_sync+0x54/0x70
  hci_power_on_sync+0xe4/0x278
  hci_set_powered_sync+0x28/0x34
  set_powered_sync+0x40/0x58
  hci_cmd_sync_work+0x94/0x100
  process_one_work+0x168/0x444
  worker_thread+0x378/0x3f4
  kthread+0x108/0x10c
  ret_from_fork+0x10/0x20

Fixes: https://github.com/bluez/bluez/issues/1442

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2b4f21fbf9c1..7397b6b50ccb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3344,7 +3344,7 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	 * advertising data. This also applies to the case
 	 * where BR/EDR was toggled during the AUTO_OFF phase.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	    list_empty(&hdev->adv_instances)) {
 		if (ext_adv_capable(hdev)) {
 			err = hci_setup_ext_adv_instance_sync(hdev, 0x00);

---
base-commit: d1b3de23042b0aac0145fdf071d6ac81ec3727b4
change-id: 20250728-default_adv-c5547ad3bcd2

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


