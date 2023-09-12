Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D6CCA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 07:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjILHqc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjILHqb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 03:46:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB68FE78
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:46:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 549A9C433CA
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694504787;
        bh=HO3V95A/LcjyhO0fdL1zhQj5iujp4axJ/HMvysWPh98=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FnXLI77rQW9tyGEuSxzQc9n3zloYDGIXW2KInZ7LE5ow6OEWbp7qW8+uMKSLzLOHe
         IgyagLkWACHB7cVA7SH6RLH4xWBwMu94+fLMm+JKbnmVVBoA5LOTBLx1qb2k8NaJJy
         jHnPPRf0nIxuQhuU2N2AIYA9W9HEJrbd7c5LeHnxcDkAzLWVZZKNjbfgNO8l2Bp5PB
         hwXhPU+UvVg41rZ4h8exSNRXWUgThHoz3D+M4JhrhfZOphlX7QLDb0A+s5BdEcA85A
         ZRpIrxNBbm4Z32vebh4SbaaBr8nEXhIkLda3P6Ee92dwrERIcfmlQlSoge10MOcjmV
         HXtl+icKDkazQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 40E4AC53BD3; Tue, 12 Sep 2023 07:46:27 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217903] Bluetooth doesn't work after trigger bluetoothctl scan
 on
Date:   Tue, 12 Sep 2023 07:46:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: koba.ko@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217903-62941-dxizS5nA5L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217903-62941@https.bugzilla.kernel.org/>
References: <bug-217903-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217903

KobaKo (koba.ko@canonical.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |koba.ko@canonical.com

--- Comment #1 from KobaKo (koba.ko@canonical.com) ---
even the error isn't triggered,
just switch power off/on and wait a while the devices were deleted.
1. power off/on
2. wait a while
3. devices are deleted

*discovering: yes
*hci0 rx counter keeps increasing
~~~
ubuntu@ubuntu:~$ hciconfig -a
hci0: Type: Primary Bus: USB
BD Address: 50:28:4A:FA:9D:11 ACL MTU: 1021:4 SCO MTU: 96:6
UP RUNNING
RX bytes:25930 acl:39 sco:0 events:828 errors:0
TX bytes:10395 acl:36 sco:0 commands:598 errors:0
Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH SNIFF
Link mode: PERIPHERAL ACCEPT
Name: 'ubuntu'
Class: 0x6c0104
Service Classes: Rendering, Capturing, Audio, Telephony
Device Class: Computer, Desktop workstation
HCI Version: (0xc) Revision: 0x46c8
LMP Version: (0xc) Subversion: 0x46c8
Manufacturer: Intel Corp. (2)

ubuntu@ubuntu:~$ hciconfig -a
hci0: Type: Primary Bus: USB
BD Address: 50:28:4A:FA:9D:11 ACL MTU: 1021:4 SCO MTU: 96:6
UP RUNNING
RX bytes:26207 acl:39 sco:0 events:831 errors:0
TX bytes:10404 acl:36 sco:0 commands:601 errors:0
Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH SNIFF
Link mode: PERIPHERAL ACCEPT
Name: 'ubuntu'
Class: 0x6c0104
Service Classes: Rendering, Capturing, Audio, Telephony
Device Class: Computer, Desktop workstation
HCI Version: (0xc) Revision: 0x46c8
LMP Version: (0xc) Subversion: 0x46c8
Manufacturer: Intel Corp. (2)
~~~
[bluetooth]# show
Controller 50:28:4A:FA:9D:11 (public)
Name: ubuntu
Alias: ubuntu
Class: 0x006c0104
Powered: yes
Discoverable: no
DiscoverableTimeout: 0x000000b4
Pairable: yes
Modalias: usb:v1D6Bp0246d0540
Discovering: yes
Roles: central
~~~

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
