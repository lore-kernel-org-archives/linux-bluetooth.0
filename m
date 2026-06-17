Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B33B42FA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679488; cv=none; b=HLCeFm7vK+TERey/JL8GbW+o9azY8aKnG9YlPRIFPIEJ7FRlXd6HgwXgAS1O8ac8UXnihBlnaBzLs/h9Xgy1hON6AbejQwMaDVQLpDOp2MrSgmVwkW7RWxp9Usl+DwxidJ37RiFqtuDDOalZWpbiZ7C2yd9p+8rGuyKxHmW38is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679488; c=relaxed/simple;
	bh=Pr+cliIEe+YItP1n/fovfNDbomZ//W1AIoAD4WNAPeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pFSxvdzivu3BdFDOoyq/pt0aVLmD2yS2tfo+AUXWJmHg7duGKkCs2sfyv+5npljeEtL142oEexz0o6/DsnOjgCnVt3ZNkzYniM6cPdsPxOVBAhgnDo4cSuJL9e7gFqjoP6JVpKXggTMkwDsFmBxMx+dKdjWvGCj73f3orxE/Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p57bd9073.dip0.t-ipconnect.de [87.189.144.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A64E54C1A4F360;
	Wed, 17 Jun 2026 08:57:41 +0200 (CEST)
Message-ID: <3147f351-22bb-4d2a-aab5-58cf208ca735@molgen.mpg.de>
Date: Wed, 17 Jun 2026 08:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 221660] New: btmtk (MT7921K / RZ608): BR/EDR outgoing
 connection always fails with Page Timeout (0x04); scan/receive works, same
 device pairs fine on Windows
To: Sean Wang <sean.wang@mediatek.com>, Sean Wang <sean.wang@kernel.org>
References: <bug-221660-62941@https.bugzilla.kernel.org/>
Content-Language: en-US
Cc: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <bug-221660-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Mediatek]

Am 17.06.26 um 00:39 schrieb bugzilla-daemon@kernel.org:
> https://bugzilla.kernel.org/show_bug.cgi?id=221660
> 
>              Bug ID: 221660
>             Summary: btmtk (MT7921K / RZ608): BR/EDR outgoing connection
>                      always fails with Page Timeout (0x04); scan/receive
>                      works, same device pairs fine on Windows
>             Product: Drivers
>             Version: 2.5
>      Kernel Version: 7.0.12-arch1-1
>            Hardware: AMD
>                  OS: Linux
>              Status: NEW
>            Severity: normal
>            Priority: P3
>           Component: Bluetooth
>            Assignee: linux-bluetooth@vger.kernel.org
>            Reporter: bynxmusic@gmail.com
>          Regression: No
> 
> Created attachment 310333
>    --> https://bugzilla.kernel.org/attachment.cgi?id=310333&action=edit
> btmon HCI trace (binary + decoded) of the Page Timeout + system info
> 
> btmtk (MT7921K / RZ608): every BR/EDR outgoing connection fails with Page
> Timeout (0x04). Scan/receive works, and the same device pairs fine on Windows.
> 
> HARDWARE
>    WiFi+BT combo: MediaTek MT7921K (RZ608) Wi-Fi 6E, PCI 14c3:0608, driver mt7921e
>    Bluetooth function: USB 0e8d:0608 (MediaTek Inc. Wireless_Device), btusb + btmtk
>    Motherboard onboard radio, AMD desktop platform
> 
> SOFTWARE
>    Kernel: 7.0.12-arch1-1 (x86_64), Arch Linux (rolling)
>    linux-firmware: 20260519-1 ; linux-firmware-mediatek: 20260519-1
>    BlueZ: 5.86
>    BT controller firmware: HW/SW Version 0x008a008a, Build Time 20260224111243
>    BT firmware blob loads OK: mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
> 
> WHAT WORKS
>    Controller initializes cleanly every boot ("hci0: Device setup in ~160000
>    usecs", AOSP extensions v1.00). Inquiry/scan works: remote devices (a
>    Skullcandy Crusher Evo headset and a Samsung TV) are reliably discovered with
>    RSSI, so the RX path is fine.
> 
> THE BUG
>    Every outgoing connection (page) to any BR/EDR device times out. HCI Create
>    Connection is issued and accepted (Command Status: Success), but roughly 7.7
> s
>    later the controller returns Connect Complete with Status: Page Timeout (0x04).
>    BlueZ reports org.bluez.Error.ConnectionAttemptFailed. The remote device never
>    registers a connection. The same headset on the same PC pairs and works
>    perfectly under Windows, so this is not dead hardware or a peripheral issue;
>    it is the btmtk/MT7921K outgoing-connection path on Linux.
> 
> KEY HCI TRACE (btmon), captured with the WiFi driver (mt7921e) UNLOADED, i.e.
> WiFi/BT coexistence ruled out:
> 
>    < HCI Command: Create Connection (0x01|0x0005) plen 13   #9  [hci0] 14.208614
>            Address: 88:08:94:13:8F:94 (Skullcandy)
>            Packet type: 0xcc18 (DM1/DH1/DM3/DH3 ...)
>    > HCI Event: Command Status (0x0f) plen 4               #10 [hci0] 14.209664
>          Create Connection (0x01|0x0005) ncmd 1
>            Status: Success (0x00)
>    > HCI Event: Connect Complete (0x03) plen 11            #11 [hci0] 21.899975
>            Status: Page Timeout (0x04)
>            Handle: 0
>            Address: 88:08:94:13:8F:94 (Skullcandy)
>            Link type: ACL (0x01)
> 
>    Also seen intermittently in dmesg during attempts:
>    Bluetooth: hci0: ACL packet for unknown connection handle 3837
> 
> STEPS TO REPRODUCE
>    1. Boot with MT7921K onboard Bluetooth.
>    2. Put any BR/EDR device (e.g. a freshly factory-reset BT headset) in pairing
>       mode.
>    3. In bluetoothctl: scan on (device IS discovered), then pair <MAC>.
>    4. Pairing fails with org.bluez.Error.ConnectionAttemptFailed; btmon shows
>       Connect Complete: Page Timeout (0x04).
> 
> EXPECTED vs ACTUAL
>    Expected: Create Connection succeeds and pairing/bonding proceeds (as on
>    Windows).
>    Actual: every Create Connection ends in Page Timeout; no outgoing connection
>    ever completes.
> 
> ALREADY RULED OUT
>    - USB autosuspend: disabled via options btusb enable_autosuspend=0 (confirmed
>      power/control=on). No change.
>    - WiFi/BT coexistence: Page Timeout persists even with mt7921e fully unloaded
>      (modprobe -r mt7921e); the trace above is from that state. Also tested with
>      rfkill block wifi. No change.
>    - LE vs BR/EDR bearer: tested with and without Experimental, and with
>      ControllerMode = bredr. No change.
>    - Stale/half state: reproduced after a fresh cold boot (controller not
> wedged).
>    - Remote device: Crusher Evo factory-reset; nothing else paired to it
>      (phone/TV BT off); works on Windows.
> 
> ATTACHMENTS
>    - bt-hci-trace.btsnoop: full binary btmon capture of one failed pairing.
>    - bt-bugreport.txt: full system diagnostic bundle (versions, lspci/lsusb, dmesg).
