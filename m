Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0956025A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929047; cv=none; b=ThrWOaC9/NlGKV0ouP3zDVB500Q0KgVmjDl5c8S9LIxqo6Yv3c2fqxoWWOrsHvjYozo3ubhplYhBTdDcZT8aQUlADSYrvUaea2tFmR5fL4BQj2DAa6e5SDomdXQZrRgMGiY/qeqxg558ZWnVkEUaQLpEf0sxwtutWUiHHgSrR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929047; c=relaxed/simple;
	bh=+15TaVJ5KsHX33hAgYs65f2MSWl6CgsA1e/WPSsVdgA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CwJZgc42oHWE0i3NKj3edYtQwVpWrU7reWpG1P7Mwct4B32tDtyOs2Wd9zHy2poGa+hVopKET8OCxgzfVzgygd74gobI/u/8u1goC988L9NAUC+BQg83lI8I/x7cFzOwsiApuosNlT3WZD1LyAHhPqnI8mwDJ/9VcZST5Tf2cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq7Xx3gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq7Xx3gp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F10EC433F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929047;
	bh=+15TaVJ5KsHX33hAgYs65f2MSWl6CgsA1e/WPSsVdgA=;
	h=From:To:Subject:Date:From;
	b=iq7Xx3gpBTUeSfwSmnOHVB+O0FWTwGefoO6Rnq0FV5S07bFbWtKOSo156eJUwUBuI
	 mCATInlgZPwRCypSmVdeDUYs5UQdACN9FyMewJ5IXGPbhCaT1gW7ugrYeFIhlpxBwk
	 cc99S1mkk9pVHj0lIrLxVtYYIc6+LAtMmyKBHfPlJZh7oMtoLfF/YOSVV+8xfh9dYa
	 W7h0oymH2MF6itFxlMqrF8jFMIxzgQa57E58YSDF6Nnao261vPRaDo0jMlab0yOHbO
	 3E7sD4oMD7XN/vTFGg/34/t0Rvjzbg4riww46+RFBKVwIm0GweAf+mLyEzDcDqwY77
	 ls7sEPMd4dvyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3F6F9C4332E; Wed, 14 Feb 2024 16:44:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218494] New: btrtl/rtl8761bu: RFCOMM is not working
Date: Wed, 14 Feb 2024 16:44:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: manio@skyboo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218494-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218494

            Bug ID: 218494
           Summary: btrtl/rtl8761bu: RFCOMM is not working
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: manio@skyboo.net
        Regression: No

Hi,
I am trying to use an RFCOMM-capable dongle under Arch Linux (kernel:
6.6.10-arch1-1).
The BT usb adapter is:
ID 0bda:8771 Realtek Semiconductor Corp. Bluetooth Radio

dmesg:
[   19.174428] Bluetooth: Core ver 2.22
[   19.174448] NET: Registered PF_BLUETOOTH protocol family
[   19.174448] Bluetooth: HCI device and connection manager initialized
[   19.174452] Bluetooth: HCI socket layer initialized
[   19.174454] Bluetooth: L2CAP socket layer initialized
[   19.174460] Bluetooth: SCO socket layer initialized
[   20.497753] Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000b
lmp_ver=3D0a lmp_subver=3D8761
[   20.500891] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[   20.500894] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[   20.502433] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[   20.503140] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[   20.898620] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   20.898620] Bluetooth: BNEP filters: protocol multicast
[   20.898620] Bluetooth: BNEP socket layer initialized
[   21.285074] Bluetooth: hci0: RTL: fw version 0xdfc6d922
[   21.430191] Bluetooth: MGMT ver 1.22
[   40.360736] Bluetooth: RFCOMM TTY layer initialized
[   40.360743] Bluetooth: RFCOMM socket layer initialized
[   40.360746] Bluetooth: RFCOMM ver 1.11

The rfcomm utility was not provided so I had to install:
https://archlinux.org/packages/extra/x86_64/bluez-deprecated-tools/

unfortunately the command:
rfcomm connect 0 B8:8B:15:0A:1C:AD
gives:
Can't connect RFCOMM socket: Operation now in progress

I tried also with `bind` argument - all of this gives errors.
Finally I tried python tools to directly use RFCOMM, then even a rust rfcat
tool from:
https://github.com/bluez/bluer/blob/master/bluer-tools/src/rfcat.rs
All gives various errors/timeouts and cannot connect to the dongle's
serial port. I was also trying to pair/connect with bluetoothctl prior
this - no change.
In fact (see below - pairing seems not needed at all).

Finally I started very very old Asus laptop with debian.
I invoked:
rfcomm connect 0 B8:8B:15:0A:1C:AD
and this immediately gives me:
Connected /dev/rfcomm0 to B8:8B:15:0A:1C:AD on channel 1
Press CTRL-C for hangup

... and it works like a charm!!! I can connect minicom and communication is
working (no pairing/connecting with bluetoothctl needed).

dmesg there:
[  298.641307] Bluetooth: Core ver 2.22
[  298.641393] Bluetooth: HCI device and connection manager initialized
[  298.641405] Bluetooth: HCI socket layer initialized
[  298.641409] Bluetooth: L2CAP socket layer initialized
[  298.641419] Bluetooth: SCO socket layer initialized
[  299.673331] Bluetooth: hci0: unexpected event for opcode 0x0000
[  311.510413] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  311.510422] Bluetooth: BNEP filters: protocol multicast
[  311.510435] Bluetooth: BNEP socket layer initialized
[ 1902.017008] Bluetooth: RFCOMM TTY layer initialized
[ 1902.017026] Bluetooth: RFCOMM socket layer initialized
[ 1902.017048] Bluetooth: RFCOMM ver 1.11

the adapter is:
ID 0b05:1712 ASUSTek Computer, Inc. BT-183 Bluetooth 2.0+EDR adapter

I am now trying to identify the problem/difference. I've logged all data us=
ing
btmon from the start to invoking the rfcom connect.

I can see that the difference start when my Asus laptop is showing this:
< ACL Data TX: Handle 42 flags 0x02 dlen 10=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
                                   #13 [hci0] 40.891571
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                    #14 [hci0] 40.898476
        Num handles: 1
        Handle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)
        Count: 1
> ACL Data RX: Handle 42 flags 0x02 dlen 16=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                    #15 [hci0] 40.899488
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000000
< ACL Data TX: Handle 42 flags 0x02 dlen 12=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
                                   #16 [hci0] 40.899554
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 3 (0x0003)
        Source CID: 64

I don't see any L2CAP and RFCOMM lines on the "bad" ArchLinux setup.

ps. I tested the dongle also from Windows and Android - also works OK.

update:
I've exposed the laptop's bluetooth adapter to my ArchLinux using USB/IP
method.
This way on the same platform where the Realtek USB adapter is not
working I was able to also use laptop's BT adapter.

Here are the results:
=E2=9D=AF rfcomm -i hci0 connect 0 B8:8B:15:0A:1C:AD
Can't connect RFCOMM socket: Operation now in progress
# --> problem on realtek

=E2=9D=AF rfcomm -i hci1 connect 0 B8:8B:15:0A:1C:AD
Connected /dev/rfcomm0 to B8:8B:15:0A:1C:AD on channel 1
Press CTRL-C for hangup
^CDisconnected
# --> works great on Asus BT

Conclusion: the ArchLinux platform is OK (i mean the distribution,
bluetooth stack, kernel modules and utilities).

The problem seems to be the Realtek drivers/firmware for my rtl8761bu...

I am attaching full logs (called good and bad). dvbsnoop logs also
included.

update2: I also tested the initial firmware added (from 2021-06-09):
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/log/rtl_bt/rtl8761bu_fw.bin
also doesn't work

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
