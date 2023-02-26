Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C0C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Feb 2023 23:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBZXOG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBZXOF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Feb 2023 18:14:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B73FD325
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 15:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2694A60C8C
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 23:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84674C43446
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677453243;
        bh=IRDcjAd+JyPqEhOR16L1CxsJP+lULG5CY87XTFR++lg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lijszr92TJoEqxSvabC/rFjOMOVLdDKKnjYjh9kWquiljskjX62tsxpVMdmBvMU23
         LC9KpJRc7trCi9MQFB+hLbh+rjhLSs4hOL2/8XPNxWdtbFvy35K3geMPbTbrK0JTup
         ynHJCkKaA9mfT1d9RXW/wvRE00kzUrFhj4k69a64AhC6Va3Iz8EbzfAZU5/XUwtuJ3
         EW3bliUcJlEM+UH9uUJV+T+txpaFAVhF4TM6zbAYyfCCcfULbPDjMga6njfGrp1nHS
         LGW9/Rjaj3Ei99Ei1RX4bKb7wK8jJJ/ch1F74RLU7RjVcfOn+F3wau3JkVtbAPfnvB
         k25TD36jzblbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 75C5EC43165; Sun, 26 Feb 2023 23:14:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sun, 26 Feb 2023 23:14:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chaimeliyah@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-EyAkxZgeKU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Chaim Eliyah (chaimeliyah@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chaimeliyah@gmail.com

--- Comment #46 from Chaim Eliyah (chaimeliyah@gmail.com) ---
+1 AX200=20

```
07:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:27=
23]
(rev 1a)
        Subsystem: Intel Corporation Wi-Fi 6 AX200NGW [8086:0084]
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi
```

```
[   25.711840] Bluetooth: Core ver 2.22
[   25.711860] NET: Registered PF_BLUETOOTH protocol family
[   25.711861] Bluetooth: HCI device and connection manager initialized
[   25.711864] Bluetooth: HCI socket layer initialized
[   25.711866] Bluetooth: L2CAP socket layer initialized
[   25.711869] Bluetooth: SCO socket layer initialized
[   25.788390] iwlwifi 0000:07:00.0: loaded firmware version 66.f1c864e0.0
cc-a0-66.ucode op_mode iwlmvm
[   27.783372] Bluetooth: hci0: command 0xfc05 tx timeout
[   27.783378] Bluetooth: hci0: Reading Intel version command failed (-110)
[   28.785728] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   28.785731] Bluetooth: BNEP filters: protocol multicast
[   28.785733] Bluetooth: BNEP socket layer initialized
```

```
celiyah@darkunicorn:~$ sudo systemctl status bluetooth
=E2=97=8F bluetooth.service - Bluetooth service
     Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled; vendor
preset: enabled)
     Active: active (running) since Sun 2023-02-26 16:43:43 CST; 12min ago
       Docs: man:bluetoothd(8)
   Main PID: 28973 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 76959)
     Memory: 668.0K
        CPU: 38ms
     CGroup: /system.slice/bluetooth.service
             =E2=94=94=E2=94=8028973 /usr/lib/bluetooth/bluetoothd

```

```
celiyah@darkunicorn:~$ bluetoothctl=20
Agent registered
[bluetooth]# scan on
No default controller available
quitetooth]#=20
```

It's popping up in Ubuntu forums e.g.=20
https://askubuntu.com/questions/1448731/bluetooth-not-working-no-controller=
-available

| Reloading `btusb` module several times makes it working.

Any specific steps for this? I have not been able to get it to work. Issue
persists despite reboots incl. hard power off/on. This happened suddenly.

```
celiyah@darkunicorn:~$ uname -a
Linux darkunicorn 5.15.0-56-lowlatency #62-Ubuntu SMP PREEMPT Wed Nov 23
09:50:07 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
celiyah@darkunicorn:~$ lsmod | grep bt
btusb                  61440  0
btrtl                  24576  1 btusb
btbcm                  24576  1 btusb
btintel                40960  1 btusb
bluetooth             708608  12 btrtl,btintel,btbcm,bnep,btusb
```

(I believe the bleeding cutting edge 23.04.1 is the only available bunty
release with a 6 kernel line. Could be wrong.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
