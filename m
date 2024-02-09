Received: from skyboo.net (skyboo.net [5.252.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9069959
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.110.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504380; cv=none; b=bqIS7KtR4j3/7Lu4svKBXzOC8D8MjTsR3zk3eAEwfyACWmG8uGUuWcMVCGuLtNOBWgfnSHQigLSpyblwmGtwbR8WP7MKu3wlv8QSijlg7blBMRFOK2j1TnAWu6T/olLnqTq07EuGxkcVC2sGeer0vGkUVHE/sxnR0DSRw3K8IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504380; c=relaxed/simple;
	bh=DoYwONgRP6hHe5t1CLjWLpOl3TlOPW84H8HmQhtQ83k=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Subject; b=Pl6ORNiNaA8M2MRrAU5sJaOtQxG1hyjpZYa6xkeUKxf4S6ETp4SvtwM0TUP4Zm8Pp969rTnI2nLOfm9xRJ1bJwbBOQRhnoybkf+ETBja2u9C/nQVSoqauOxEgA0SDEKg909HSyIQwDW1Fgaq3cHGCcREt1llHPgzI8lzP3OJBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skyboo.net; spf=pass smtp.mailfrom=skyboo.net; arc=none smtp.client-ip=5.252.110.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skyboo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyboo.net
Received: from manio by skyboo.net with local (Exim 4.96)
	(envelope-from <manio@skyboo.net>)
	id 1rYVsz-004MJl-2g;
	Fri, 09 Feb 2024 19:46:06 +0100
Date: Fri, 9 Feb 2024 19:46:05 +0100
From: Mariusz =?utf-8?B?QmlhxYJvxYRjenlr?= <manio@skyboo.net>
To: linux-bluetooth@vger.kernel.org
Cc: Andreas Radke <andyrtr@archlinux.org>,
	Robin Candau <antiz@archlinux.org>, Ziqian SUN <sztsian@gmail.com>,
	Daniel Drake <drake@endlessm.com>
Message-ID: <20240209184605.2jyteklscijegtdd@skyboo.net>
References: <20240208144505.koxpmchpkrg6r2c4@skyboo.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208144505.koxpmchpkrg6r2c4@skyboo.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-bluetooth@vger.kernel.org, andyrtr@archlinux.org, antiz@archlinux.org, sztsian@gmail.com, drake@endlessm.com
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Level: 
Subject: Re: RFCOMM not working anymore?
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)

On Thu, Feb 08, 2024 at 03:45:05PM +0100, Mariusz Białończyk wrote:
> Hi,
> I am trying to use an RFCOMM-capable dongle under Arch Linux (kernel: 6.6.10-arch1-1).
> The BT usb adapter is:
> ID 0bda:8771 Realtek Semiconductor Corp. Bluetooth Radio
> 
> dmesg:
> [   19.174428] Bluetooth: Core ver 2.22
> [   19.174448] NET: Registered PF_BLUETOOTH protocol family
> [   19.174448] Bluetooth: HCI device and connection manager initialized
> [   19.174452] Bluetooth: HCI socket layer initialized
> [   19.174454] Bluetooth: L2CAP socket layer initialized
> [   19.174460] Bluetooth: SCO socket layer initialized
> [   20.497753] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
> [   20.500891] Bluetooth: hci0: RTL: rom_version status=0 version=1
> [   20.500894] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
> [   20.502433] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
> [   20.503140] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
> [   20.898620] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   20.898620] Bluetooth: BNEP filters: protocol multicast
> [   20.898620] Bluetooth: BNEP socket layer initialized
> [   21.285074] Bluetooth: hci0: RTL: fw version 0xdfc6d922
> [   21.430191] Bluetooth: MGMT ver 1.22
> [   40.360736] Bluetooth: RFCOMM TTY layer initialized
> [   40.360743] Bluetooth: RFCOMM socket layer initialized
> [   40.360746] Bluetooth: RFCOMM ver 1.11
> 
> The rfcomm utility was not provided so I had to install:
> https://archlinux.org/packages/extra/x86_64/bluez-deprecated-tools/
> 
> unfortunately the command:
> rfcomm connect 0 B8:8B:15:0A:1C:AD
> gives:
> Can't connect RFCOMM socket: Operation now in progress
> 
> I tried also with bind - all of this gives errors.
> Finally I tried python tools to directly use RFCOMM, then even a rust
> rfcat tool from:
> https://github.com/bluez/bluer/blob/master/bluer-tools/src/rfcat.rs
> All gives various errors/timeouts and cannot connect to the dongle's
> serial port. I was also trying to pair/connect with bluetoothctl prior
> this - no change.
> In fact (see below - pairing seems not needed at all).
> 
> Finally I started very very old Asus laptop with debian.
> I invoked:
> rfcomm connect 0 B8:8B:15:0A:1C:AD
> and this immediately gives me:
> Connected /dev/rfcomm0 to B8:8B:15:0A:1C:AD on channel 1
> Press CTRL-C for hangup
> 
> ... and it works like a charm!!! I can connect minicom and communication is
> working (no pairing/connecting with bluetoothctl needed).
> 
> dmesg there:
> [  298.641307] Bluetooth: Core ver 2.22
> [  298.641393] Bluetooth: HCI device and connection manager initialized
> [  298.641405] Bluetooth: HCI socket layer initialized
> [  298.641409] Bluetooth: L2CAP socket layer initialized
> [  298.641419] Bluetooth: SCO socket layer initialized
> [  299.673331] Bluetooth: hci0: unexpected event for opcode 0x0000
> [  311.510413] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [  311.510422] Bluetooth: BNEP filters: protocol multicast
> [  311.510435] Bluetooth: BNEP socket layer initialized
> [ 1902.017008] Bluetooth: RFCOMM TTY layer initialized
> [ 1902.017026] Bluetooth: RFCOMM socket layer initialized
> [ 1902.017048] Bluetooth: RFCOMM ver 1.11
> 
> the adapter is:
> ID 0b05:1712 ASUSTek Computer, Inc. BT-183 Bluetooth 2.0+EDR adapter
> 
> I am now trying to identify the problem. I've logged all data using
> btmon from the start to invoking the rfcom connect.
> 
> I can see that the difference start when my Asus laptop is showing this:
> < ACL Data TX: Handle 42 flags 0x02 dlen 10                                                                        #13 [hci0] 40.891571
>       L2CAP: Information Request (0x0a) ident 1 len 2
>         Type: Extended features supported (0x0002)
> > HCI Event: Number of Completed Packets (0x13) plen 5                                                             #14 [hci0] 40.898476
>         Num handles: 1
>         Handle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)
>         Count: 1
> > ACL Data RX: Handle 42 flags 0x02 dlen 16                                                                        #15 [hci0] 40.899488
>       L2CAP: Information Response (0x0b) ident 1 len 8
>         Type: Extended features supported (0x0002)
>         Result: Success (0x0000)
>         Features: 0x00000000
> < ACL Data TX: Handle 42 flags 0x02 dlen 12                                                                        #16 [hci0] 40.899554
>       L2CAP: Connection Request (0x02) ident 2 len 4
>         PSM: 3 (0x0003)
>         Source CID: 64
> 
> I don't see any L2CAP and RFCOMM lines on the "bad" ArchLinux setup.
> 
> Please help! I really like to connect to this dongle (even no matter
> which software involved - I just want to access this serialport somehow).
> 
> I am attaching full logs (called good and bad). dvbsnoop logs also
> included.
> 
> ps. I tested the dongle also from Windows and Android - also works OK.

some new info on this problem:
I've exposed the laptop's bluetooth adapter to my ArchLinux using USB/IP method.
This way on the same platform where the Realtek USB adapter is not
working I was able to also use laptop's BT adapter.

Here are the results:
❯ rfcomm -i hci1 connect 0 B8:8B:15:0A:1C:AD
Connected /dev/rfcomm0 to B8:8B:15:0A:1C:AD on channel 1
Press CTRL-C for hangup
^CDisconnected
# works great

❯ rfcomm -i hci0 connect 0 B8:8B:15:0A:1C:AD
Can't connect RFCOMM socket: Operation now in progress

Conclusion: the ArchLinux platform is OK (i mean the distribution,
bluetooth stack, kernel modules and utilities).

The problem seems the buggy Realtek drivers/firmware for my rtl8761bu ?

Guys please take a look at the logs ... if you confirm than maybe some
bug report would be needed ...

I am also CC-ing Ziqian SUN (Zamir), who added RTL8761B support into the
kernel, so maybe he can take a look into this issue...
I am not attaching the logs again,
original message with attachments is available in the bluetooth ML,
and also eg here:
https://www.spinics.net/lists/linux-bluetooth/msg109274.html

-- 
regards,
Mariusz Białończyk
https://skyboo.net | https://github.com/manio
