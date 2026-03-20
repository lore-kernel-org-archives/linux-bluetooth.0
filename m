Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E1399376
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006846; cv=none; b=TVq+dFtsrp86hYNo+DA/JzwbKr6BdozDipJgVnYk0mRsvXV/yAv5AhTR9y1orlSOnJWW9Wjhii5kyEdyH8HUS76qId70ET9fxmXhxRRn+R42mU4nlDgSQfa4r7nnfmBEUmrPR3KEPLYFIC7BPR2dDDlGaghdXy4YrLxwPGckL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006846; c=relaxed/simple;
	bh=+1Ti3b4o1796Rp+ghtNweHJ07G+Dy4mv73ZTW1J7VQU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lgA0Ys6UVafC8XiEn6eXjpAXCDEEr1+BNisBEI/s3ZV1dHkQlzXPx41SPHpkq8JbhPsz2uoGZBTHz1Kp1iUeLorUISTh2dwbtNnYy/dYMGfuIccBW+oTu7FTGaO+wqUzjrv7q0iFh9PBKhDYxOZw28yMu+1LWDu+5niqCZnvmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=o9u9cRqa; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="o9u9cRqa"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 88418240101
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 12:40:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1774006840; bh=3pd2XzDpzXdSuC/K0Aie6jDJF4mSKeX97Oi9P9OJ54Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:From;
	b=o9u9cRqaRSGDw9aQtDgKKRljEy4yZIT4xNz2bg3X8TYuubPmaTJYkrjJCKoytmwTt
	 RBrIvJUeKGvsJYVB5d+2cf28cwiOIds7uNIDhtc+WqEEfnj0gwi7PM3d7J5N1oy8rk
	 Xwid1NO0EwGWUvYWQpFF7mz2OkFA2c9DVoUuDz8kF7Kc1pAXajqht4vbh5pIdZdO9K
	 8SUYL6V4okHT2PU9+bhEIwRI1R0l1WHJZLRq1AwFjj3d4ZJXs1hwlUT77Mj23FUn2Y
	 W0cnQMlnfZ54O3oPkWIMkcuaE60ERcUD1sOyvvmJ2OsE1niZQlLXoe2lUdFmTm92p6
	 iNLiwegShl4QA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fcgc81ZcPz9rxD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 12:40:40 +0100 (CET)
Message-ID: <cd1ec531-1603-4788-952d-ff256c898e0b@posteo.de>
Date: Fri, 20 Mar 2026 11:40:40 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-MW
To: linux-bluetooth@vger.kernel.org
From: Frederik Berg <fberg@posteo.de>
Subject: Bluetooth: btusb: Intel AX211 (8087:0033) permanently lost after
 suspend/resume
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm hitting an issue where my Intel AX211 Bluetooth controller (USB 
8087:0033) permanently vanishes after suspend/resume. The device 
disappears from lsusb entirely and doesn't come back, even across 
further suspend/resume cycles. Only way to recover without rebooting is 
resetting the xHCI host controller.

I traced this across multiple suspend/resume cycles in the same boot and 
found what looks like a race condition between the PM notifier's HCI 
shutdown and the USB subsystem tearing down the device. I also took a 
look at the btusb source and believe I found the root cause, included as 
a patch in a follow-up.

*Setup:*

  * Lenovo ThinkPad T14 Intel
  * Intel AX211 Bluetooth, USB ID 8087:0033
  * Internal USB port 3-10, xHCI at PCI 0000:00:14.0
  * Firmware: intel/ibt-0040-0041.sfi, version 133-20.25
  * Kernel: 6.17.0-14-generic (Ubuntu)

*What I'm seeing:*

On successful resumes, the HCI power-off command (Write Scan Enable, 
0x0c1a) times out with -ETIMEDOUT. The ACPI reset method then kicks in, 
the device re-enumerates at full-speed, firmware loads, everything works:

|Bluetooth: hci0: command 0x0c1a tx timeout Bluetooth: hci0: Initiating 
acpi reset method Bluetooth: hci0: Opcode 0x0c1a failed: -110 usb 3-10: 
new full-speed USB device using xhci_hcd usb 3-10: New USB device found, 
idVendor=8087, idProduct=0033 Bluetooth: hci0: Found device firmware: 
intel/ibt-0040-0041.sfi Bluetooth: hci0: Firmware loaded in 1602079 usecs |

On the failed resume, the USB subsystem disconnects the device before 
the HCI command can timeout. The error is -ENODEV instead of -ETIMEDOUT:

|usb 3-10: USB disconnect, device number 19 Bluetooth: hci0: Opcode 
0x0c1a failed: -19 Bluetooth: hci0: Error when powering off device on 
rfkill (-19) Bluetooth: hci0: sending frame failed (-19) Bluetooth: 
hci0: HCI reset during shutdown failed usb 3-10: new low-speed USB 
device number 30 using xhci_hcd usb 3-10: Device not responding to setup 
address. usb 3-10: device not accepting address 30, error -71 |

After this, /sys/bus/usb/devices/3-10/ is gone, bluetoothctl says "No 
default controller available", and btusb is loaded with 0 users. rfkill 
block/unblock does nothing since the USB device itself no longer exists.

*What I think is happening in the code:*

hci_cmd_timeout() (hci_core.c:1462) is the only path that calls 
hdev->reset(), which for Intel devices triggers 
btintel_acpi_reset_method() via btusb_intel_reset(). But when the 
pending HCI command is canceled with ENODEV (via 
hci_cmd_sync_cancel_sync in hci_dev_close_sync), hci_cmd_timeout never 
fires, so the ACPI reset that would recover the device is bypassed entirely.

The race exists because the PM notifier (hci_suspend_notifier -> 
hci_suspend_dev) and USB suspend (btusb_suspend) run concurrently with 
no synchronization. Whether the device survives depends on whether the 
HCI command times out before or after the USB subsystem tears things down.

*Recovery* (without reboot):

|echo "0000:00:14.0" > /sys/bus/pci/drivers/xhci_hcd/unbind sleep 3 echo 
"0000:00:14.0" > /sys/bus/pci/drivers/xhci_hcd/bind |

*Reproduction:*

Intermittent, timing-dependent. In my case, the first two suspend/resume 
cycles in a boot succeeded and the third failed. I haven't bisected to a 
specific commit yet.

Thanks,
Frederik Berg


