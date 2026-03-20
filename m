Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96B3A3E9D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007077; cv=none; b=eUEPnJoM1RP1iFWYJ/kEw2PYGYIa52Pb1mORVZvgxj3QC8aEhxr1hu8Y0gnCF5AfMGK2jVsrsfgAE7ngE6CzcGcPd/734C+5cZ1PIikoVpB1khVM5rOzHs8zzHjEEpopWHLiS3N2N21iTa9JbVRsMuZ57cju6FC127eDV2ITh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007077; c=relaxed/simple;
	bh=j/eB35Z7+xOegNXYnCSg9oh0p/zar5whORBeRzFo2Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmFYN70SGCDjoDlKm9NoQ66LTT+JN3qJfv4frOcVaorORmWbCQBgd4f3hePpgLYCzaH8lDDdUvh3ZW3e5GAh0i8wl+ngZmktjh8c1ZphjAoDKWD5qRF03w4N86I+tuJEW3c1NhpWK9W0Cx8VdYLeAUZy07vJXa+eT3O2ubRBbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=lc4DfAha; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="lc4DfAha"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E4ABF240027
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 12:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1774007072; bh=1ZsKJ4guZAh0sfzfu3w3oNDNPaTsENIdjk3BLCE8/so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=lc4DfAhaOZdBlgxuiQH2WAk6FRIB+gdDjKJxSh1s0dKnhzWEl9fyqkZXyRb6Et+kN
	 DxAbU59DVkOo1NBwKgoWT3VHrpkZORo+zyQ/x33jr/fBE1QrsR/OybwIQK5eLQMv3R
	 MaIL6Tui/09/qtbqZsZe56DMWAY8K6UQFcaF46d3FLS2KycYiht5qP4uC/4CwCJGD2
	 SqRere3vYm3II3sUYo56DIq3omK+cPF3xeBJikO5XxkrWUCjehsMujFcVosl//i7CC
	 ANINNpkO1auHKNwd5SB5ZDpIYQDaPtBkP8NsjFx8bosWdG58I4N6Xk3sYdVeYApHNk
	 Mj+2KDc4His2g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fcghc1Knlz9rxM;
	Fri, 20 Mar 2026 12:44:32 +0100 (CET)
From: Frederik Berg <fberg@posteo.de>
To: linux-bluetooth@vger.kernel.org
Cc: Frederik Berg <fberg@posteo.de>
Subject: [PATCH] Bluetooth: btusb: cancel pending HCI commands before USB suspend
Date: Fri, 20 Mar 2026 11:44:32 +0000
Message-ID: <20260320114347.2340528-1-fberg@posteo.de>
In-Reply-To: <cd1ec531-1603-4788-952d-ff256c898e0b@posteo.de>
References: <cd1ec531-1603-4788-952d-ff256c898e0b@posteo.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During system suspend, the PM notifier and USB subsystem suspend run
concurrently without synchronization. If the PM notifier's
hci_power_off_sync() is blocked waiting for an HCI command response
(e.g., Write Scan Enable, opcode 0x0c1a) when the USB subsystem tears
down the device, the command fails with -ENODEV.

Unlike a timeout (-ETIMEDOUT), an ENODEV cancellation does not trigger
hci_cmd_timeout(), which means hdev->reset() is never called and the
Intel ACPI reset method (_PRR/_RST) that would recover the device is
bypassed. The device then fails to re-enumerate on resume (detected as
low-speed instead of full-speed, error -71) and is permanently lost
until the xHCI host controller is reset or the system is rebooted.

Cancel any pending synchronous HCI commands in btusb_suspend() before
btusb_stop_traffic() kills the URBs, but only for non-autosuspend
(system suspend). This matches the pattern used by hci_suspend_dev()
which calls hci_cancel_cmd_sync(hdev, EHOSTDOWN) before proceeding
with HCI-level suspend.

Signed-off-by: Frederik Berg <fberg@posteo.de>
---
Proposed fix for the race described in the parent email. This cancels
any pending synchronous HCI commands in btusb_suspend() before
btusb_stop_traffic() kills the URBs, preventing the race. Only for
system suspend, not autosuspend. Same pattern used by hci_suspend_dev()
which calls hci_cancel_cmd_sync(hdev, EHOSTDOWN).

I haven't been able to build-test this against a running kernel yet,
so consider this an RFC.

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a1c5eb993e4..acec484b495 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4497,6 +4497,9 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	cancel_work_sync(&data->work);
 
+	if (!PMSG_IS_AUTO(message))
+		hci_cmd_sync_cancel_sync(data->hdev, EHOSTDOWN);
+
 	if (data->suspend)
 		data->suspend(data->hdev);
 
-- 
2.53.0

