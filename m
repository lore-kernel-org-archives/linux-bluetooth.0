Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C63225784
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981965; cv=none; b=JDP0wmbbl7nsTjNL+R42pxcBw9VX3aQHiylMToEX0uonJw9BL/vn8VSWvwjTMWs3kAHUCbZXXTrqsGcYzfPmIQD56ckPu31iTBbHWvZYfWq32OHgk6YsRPxwnH58wyR0wyEKkQHevPn65tjq5WCtGpmUdoN7h6aKjMZIj9K5LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981965; c=relaxed/simple;
	bh=jzF5wdew2Mmr58fUzkNZCdhhp1vbEn2owfFJkBtWdW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=r0l/Y5xwZcPhAzlcs0/mxC7PsbAaZtWk7+u0f+dpGzA8WHmXYb7gw43r2nGeX5ZJhJY7utMnM12uzB0GVIWrSU7O2kT6aJk1/5FJGIXFYaMzMnfm3b7g+ZFvXhuhcaIZzal4lHXBompFm4y4RSBl5J5jDeGqUuLVX1s20u0cyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p57bd9767.dip0.t-ipconnect.de [87.189.151.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AAEE761E64850;
	Thu, 31 Jul 2025 19:12:30 +0200 (CEST)
Message-ID: <15bf85af-eae7-416c-9feb-ef744cdf4b0a@molgen.mpg.de>
Date: Thu, 31 Jul 2025 19:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Headset is disconnected immediately
To: Antti Garding <antti.garding.oss@gmail.com>
References: <CA+nAgFfu-0=hRWNOomWiJvhutY0mEBqD23mhBDF+WdVkn0MWNg@mail.gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CA+nAgFfu-0=hRWNOomWiJvhutY0mEBqD23mhBDF+WdVkn0MWNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dera Antti,


Thank you for your report.

Am 31.07.25 um 19:07 schrieb Antti Garding:
> I am having a issue using my Bluetooth headset (Sony WH-1000XM3) in
> Linux. When I turn it on, the headset is immediately connected, but
> after that, it is also immediately disconnected. This
> connect-disconnect is automatically repeated three times with some
> seconds between the occasions.
> 
> My environment is a Lenovo Thinkpad E14 Gen 4 laptop running Xubuntu
> 22.04. The computer has an integrated WLAN + Bluetooth adapter based
> on Intex AX201, connected on USB bus. WLAN works fine and also the
> Bluetooth works when running Windows. I have read on Intel’s forum
> that the driver for the chip should have been ok since kernel version
> 5.10. My distribution comes with 6.8 so this issue shouldn’t be about
> that.

Please attach the full output of `dmesg`.

> Log time ago, I managed to pair the headset and it is still listed as
> a paired device. Trying to unpair it in the bluetoothctl console
> results in error message saying the device doesn’t exist.
> 
> Here is what happens in bluetoothctl console when I try to connect the
> headset manually:
> 
> [bluetooth]# connect 38:18:4C:D4:C2:94
> Attempting to connect to 38:18:4C:D4:C2:94
> [CHG] Device 38:18:4C:D4:C2:94 Connected: yes
> Failed to connect: org.bluez.Error.Failed br-connection-canceled
> [CHG] Device 38:18:4C:D4:C2:94 Connected: no
> [CHG] Device 38:18:4C:D4:C2:94 Connected: yes
> [CHG] Device 38:18:4C:D4:C2:94 Connected: no
> [CHG] Device 38:18:4C:D4:C2:94 Connected: yes
> [CHG] Device 38:18:4C:D4:C2:94 Connected: no
> 
> Here are some log prints related to Bluetooth in general:
> 
> sudo dmesg | grep -i blue
> [    2.899284] Bluetooth: Core ver 2.22
> [    2.899534] NET: Registered PF_BLUETOOTH protocol family
> [    2.899535] Bluetooth: HCI device and connection manager initialized
> [    2.899574] Bluetooth: HCI socket layer initialized
> [    2.899593] Bluetooth: L2CAP socket layer initialized
> [    2.899601] Bluetooth: SCO socket layer initialized
> [    2.951909] Bluetooth: hci0: Device revision is 2
> [    2.951914] Bluetooth: hci0: Secure boot is enabled
> [    2.951915] Bluetooth: hci0: OTP lock is enabled
> [    2.951916] Bluetooth: hci0: API lock is enabled
> [    2.951917] Bluetooth: hci0: Debug lock is disabled
> [    2.951918] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [    2.951920] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
> [    2.952008] Bluetooth: hci0: DSM reset method type: 0x00
> [    2.960708] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4150.sfi
> [    2.960752] Bluetooth: hci0: Boot Address: 0x100800
> [    2.960754] Bluetooth: hci0: Firmware Version: 107-51.22
> [    3.272512] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is blocked
> [    4.012759] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.012763] Bluetooth: BNEP filters: protocol multicast
> [    4.012770] Bluetooth: BNEP socket layer initialized
> [    4.684563] Bluetooth: hci0: Waiting for firmware download to complete
> [    4.684902] Bluetooth: hci0: Firmware loaded in 1683777 usecs
> [    4.685041] Bluetooth: hci0: Waiting for device to boot
> [    4.700965] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [    4.701034] Bluetooth: hci0: Device booted in 15702 usecs
> [    4.701904] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0040-4150.ddc
> [    4.704071] Bluetooth: hci0: Applying Intel DDC parameters completed
> [    4.707146] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1 build 56683
> [    4.707151] Bluetooth: hci0: Firmware SHA1: 0xe2305c5c
> [    4.776168] Bluetooth: MGMT ver 1.22
> [    6.448715] Bluetooth: RFCOMM TTY layer initialized
> [    6.448724] Bluetooth: RFCOMM socket layer initialized
> [    6.448727] Bluetooth: RFCOMM ver 1.11
> 
> Are there any known solutions to this issue? If not, are there any
> recommendations where to look for a solution? If this could be a bug,
> I might be interested in trying to fix it.
> 
> By the way, I would have asked this on the user mailing list first,
> but the BlueZ web page didn't mention how to subscribe to it, so I
> decided to try this developer list.

Please run `btmon -w /dev/shm/20250731--linux-6.8-pairing-issue.cap` and 
provide that. (The developers often ask for this.)

(You could create an issue in the Linux Kernel Bugzilla to attach the logs.)


Kind regards,

Paul
