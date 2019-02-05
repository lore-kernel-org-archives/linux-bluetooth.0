Return-Path: <SRS0=J43N=QM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD2C282CB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19342175B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Feb 2019 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfBEWtn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:49:43 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:47582 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730450AbfBEWtm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Feb 2019 17:49:42 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4BB192B288
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Feb 2019 22:49:41 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 4002F2B318; Tue,  5 Feb 2019 22:49:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202465] Bluetooth adaptor dies - 0489:e0a2 Foxconn / Hon Hai
Date:   Tue, 05 Feb 2019 22:49:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jccantele49@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202465-62941-C5AUG88KoZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202465-62941@https.bugzilla.kernel.org/>
References: <bug-202465-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202465

--- Comment #4 from Jacob C (jccantele49@gmail.com) ---
Not sure if it was related, but I see this in my journalctl -b -k

Feb 05 16:44:16 xps-laptop kernel: input: Surface Mouse Mouse as
/devices/virtual/misc/uhid/0005:045E:0919.000B/input/input39
Feb 05 16:44:16 xps-laptop kernel: input: Surface Mouse Consumer Control as
/devices/virtual/misc/uhid/0005:045E:0919.000B/input/input40
Feb 05 16:44:16 xps-laptop kernel: input: Surface Mouse as
/devices/virtual/misc/uhid/0005:045E:0919.000B/input/input41
Feb 05 16:44:16 xps-laptop kernel: input: Surface Mouse as
/devices/virtual/misc/uhid/0005:045E:0919.000B/input/input42
Feb 05 16:44:16 xps-laptop kernel: hid-generic 0005:045E:0919.000B:
input,hidraw5: BLUETOOTH HID v1.10 Mouse [Surface Mouse] on 9C:B6:D0:91:CA:40
Feb 05 16:44:21 xps-laptop kernel: search_pkgs[1987]: segfault at 2d6a6e616d ip
00007ff9dbf59a26 sp 00007ff9cf3caa80 error 4
Feb 05 16:44:21 xps-laptop kernel: search_pkgs[1988]: segfault at 2d6a6e6100 ip
00007ff9dbf59a26 sp 00007ff9cebc9a80 error 4
Feb 05 16:44:21 xps-laptop kernel:  in libc-2.28.so[7ff9dbef6000+14b000]
Feb 05 16:44:21 xps-laptop kernel:  in libc-2.28.so[7ff9dbef6000+14b000]
Feb 05 16:44:21 xps-laptop kernel: Code: 84 46 
Feb 05 16:44:21 xps-laptop kernel: ff 
Feb 05 16:44:21 xps-laptop kernel: Code: 
Feb 05 16:44:21 xps-laptop kernel: ff 
Feb 05 16:44:21 xps-laptop kernel: 84 46 
Feb 05 16:44:21 xps-laptop kernel: ff 0f 
Feb 05 16:44:21 xps-laptop kernel: ff ff 
Feb 05 16:44:21 xps-laptop kernel: 1f 
Feb 05 16:44:21 xps-laptop kernel: ff 0f 
Feb 05 16:44:21 xps-laptop kernel: 80 00 
Feb 05 16:44:21 xps-laptop kernel: 1f 
Feb 05 16:44:21 xps-laptop kernel: 00 
Feb 05 16:44:21 xps-laptop kernel: 80 00 
Feb 05 16:44:21 xps-laptop kernel: 00 00 
Feb 05 16:44:21 xps-laptop kernel: 00 
Feb 05 16:44:21 xps-laptop kernel: 4a 
Feb 05 16:44:21 xps-laptop kernel: 00 
Feb 05 16:44:21 xps-laptop kernel: 8d 0c 
Feb 05 16:44:21 xps-laptop kernel: 00 4a 
Feb 05 16:44:21 xps-laptop kernel: e0 48 
Feb 05 16:44:21 xps-laptop kernel: 8d 
Feb 05 16:44:21 xps-laptop kernel: 8b 
Feb 05 16:44:21 xps-laptop kernel: 0c 
Feb 05 16:44:21 xps-laptop kernel: 51 
Feb 05 16:44:21 xps-laptop kernel: e0 
Feb 05 16:44:21 xps-laptop kernel: 40 
Feb 05 16:44:21 xps-laptop kernel: 48 
Feb 05 16:44:21 xps-laptop kernel: 48 
Feb 05 16:44:21 xps-laptop kernel: 8b 
Feb 05 16:44:21 xps-laptop kernel: 85 d2 
Feb 05 16:44:21 xps-laptop kernel: 51 
Feb 05 16:44:21 xps-laptop kernel: 0f 84 
Feb 05 16:44:21 xps-laptop kernel: 40 
Feb 05 16:44:21 xps-laptop kernel: 2e 
Feb 05 16:44:21 xps-laptop kernel: 48 
Feb 05 16:44:21 xps-laptop kernel: ff ff 
Feb 05 16:44:21 xps-laptop kernel: 85 d2 
Feb 05 16:44:21 xps-laptop kernel: ff 48 
Feb 05 16:44:21 xps-laptop kernel: 0f 
Feb 05 16:44:21 xps-laptop kernel: 81 fb 
Feb 05 16:44:21 xps-laptop kernel: 84 
Feb 05 16:44:21 xps-laptop kernel: ff 03 
Feb 05 16:44:21 xps-laptop kernel: 2e 
Feb 05 16:44:21 xps-laptop kernel: 00 00 
Feb 05 16:44:21 xps-laptop kernel: ff ff 
Feb 05 16:44:21 xps-laptop kernel: 0f 87 
Feb 05 16:44:21 xps-laptop kernel: ff 48 
Feb 05 16:44:21 xps-laptop kernel: aa 01 
Feb 05 16:44:21 xps-laptop kernel: 81 fb 
Feb 05 16:44:21 xps-laptop kernel: 00 00 
Feb 05 16:44:21 xps-laptop kernel: ff 03 
Feb 05 16:44:21 xps-laptop kernel: <48> 8b 
Feb 05 16:44:21 xps-laptop kernel: 00 00 
Feb 05 16:44:21 xps-laptop kernel: 32 
Feb 05 16:44:21 xps-laptop kernel: 0f 
Feb 05 16:44:21 xps-laptop kernel: 48 89 
Feb 05 16:44:21 xps-laptop kernel: 87 aa 
Feb 05 16:44:21 xps-laptop kernel: 71 
Feb 05 16:44:21 xps-laptop kernel: 01 
Feb 05 16:44:21 xps-laptop kernel: 40 42 
Feb 05 16:44:21 xps-laptop kernel: 00 00 
Feb 05 16:44:21 xps-laptop kernel: 80 2c 
Feb 05 16:44:21 xps-laptop kernel: <48> 8b 
Feb 05 16:44:21 xps-laptop kernel: 20 
Feb 05 16:44:21 xps-laptop kernel: 32 48 
Feb 05 16:44:21 xps-laptop kernel: 01 
Feb 05 16:44:21 xps-laptop kernel: 89 
Feb 05 16:44:21 xps-laptop kernel: 48 
Feb 05 16:44:21 xps-laptop kernel: 71 
Feb 05 16:44:21 xps-laptop kernel: 83 
Feb 05 16:44:21 xps-laptop kernel: 40 
Feb 05 16:44:21 xps-laptop kernel: c4 08 
Feb 05 16:44:21 xps-laptop kernel: 42 80 
Feb 05 16:44:21 xps-laptop kernel: 48 89 
Feb 05 16:44:21 xps-laptop kernel: 2c 20 
Feb 05 16:44:21 xps-laptop kernel: d0 5b 
Feb 05 16:44:21 xps-laptop kernel: 01 48 
Feb 05 16:44:21 xps-laptop kernel: 5d 
Feb 05 16:44:21 xps-laptop kernel: 83 
Feb 05 16:44:21 xps-laptop kernel: 41 
Feb 05 16:44:21 xps-laptop kernel: c4 08 
Feb 05 16:44:21 xps-laptop kernel: 48 89 d0 5b 5d 41 
Feb 05 16:44:21 xps-laptop kernel: audit: type=1701 audit(1549406661.761:62):
auid=1000 uid=1000 gid=1000 ses=3 pid=1809 comm="search_pkgs"
exe="/usr/bin/pamac-manager" sig=11 res=1
Feb 05 16:44:21 xps-laptop kernel: audit: type=1701 audit(1549406661.761:63):
auid=1000 uid=1000 gid=1000 ses=3 pid=1809 comm="search_pkgs"
exe="/usr/bin/pamac-manager" sig=11 res=1
Feb 05 16:44:21 xps-laptop kernel: audit: type=1130 audit(1549406661.768:64):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@0-1990-0
comm="systemd" exe="/usr/lib/systemd/syste>
Feb 05 16:44:22 xps-laptop kernel: audit: type=1130 audit(1549406662.014:65):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-timedated
comm="systemd" exe="/usr/lib/systemd/systemd" host>
Feb 05 16:44:22 xps-laptop kernel: audit: type=1131 audit(1549406662.599:66):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-coredump@0-1990-0
comm="systemd" exe="/usr/lib/systemd/syste>
Feb 05 16:44:30 xps-laptop kernel: audit: type=1130 audit(1549406670.474:67):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fprintd comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? add>
Feb 05 16:44:37 xps-laptop kernel: audit: type=1131 audit(1549406677.632:68):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-localed
comm="systemd" exe="/usr/lib/systemd/systemd" hostna>
Feb 05 16:44:38 xps-laptop kernel: audit: type=1131 audit(1549406678.035:69):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed
comm="systemd" exe="/usr/lib/systemd/systemd" host>
Feb 05 16:44:46 xps-laptop kernel: audit: type=1131 audit(1549406686.615:70):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=geoclue comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? add>
Feb 05 16:44:52 xps-laptop kernel: audit: type=1131 audit(1549406692.091:71):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-timedated
comm="systemd" exe="/usr/lib/systemd/systemd" host>
Feb 05 16:45:00 xps-laptop kernel: audit: type=1131 audit(1549406700.634:72):
pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fprintd comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? add

-- 
You are receiving this mail because:
You are the assignee for the bug.
