Return-Path: <SRS0=BfG3=A5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B04CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jul 2020 21:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5643B22CAD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jul 2020 21:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGRVjF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jul 2020 17:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgGRVjF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jul 2020 17:39:05 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 18 Jul 2020 21:39:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gustavoyaraujo@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-LwPZKg0xkK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #103 from AndreyTarkovsky (gustavoyaraujo@gmail.com) ---

(In reply to Real Name from comment #102)
> (In reply to AndreyTarkovsky from comment #101)
> > Unfortunately I can not say the same. Using Arch Linux here and tried a lot
> > of patches on kernel 5.7.7 and 5.7.8 as showed on my forum post here
> > https://bbs.archlinux.org/viewtopic.php?pid=1915544#p1915544
> 
> Did you try running 'sudo hciconfig hci0 up'? Unless Arch does something
> different to their kernels. I patched a stock Fedora kernel (built from
> source RPM).

hciconfig dev
hci0:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:10  ACL MTU: 640:4  SCO MTU: 64:8
        DOWN 
        RX bytes:1084 acl:0 sco:0 events:50 errors:0
        TX bytes:662 acl:0 sco:0 commands:50 errors:0

sudo hciconfig hci0 up
Can't init device hci0: Invalid request code (56)

Looks like there is something special on my dongle. dmesg showed it was
recognized as a CSR clone:

[  194.023832] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...
[  194.032848] debugfs: File 'dut_mode' in directory 'hci0' already present!
[  194.077761] audit: type=1106 audit(1595108086.134:91): pid=1605 uid=0
auid=1000 ses=3 msg='op=PAM:session_close
grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/0 res=success'
[  194.077970] audit: type=1104 audit(1595108086.134:92): pid=1605 uid=0
auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_unix,pam_permit,pam_env
acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0
res=success'

-- 
You are receiving this mail because:
You are the assignee for the bug.
