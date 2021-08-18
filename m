Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF29C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 17:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B8460EFE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhHRRpn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhHRRpm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 13:45:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BBC55610CB
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629308707;
        bh=EZuPOAXy4C5pKGV4yG9d4e9WtZOmPj8DI3uz+IVMzDc=;
        h=From:To:Subject:Date:From;
        b=jFhzZlKTx+9baLR2f3TUjlTQA8yJm2o/gHsQVn319KbxlGJR1aQL9muDINH7scsKn
         Whw/lLUP9Iy1toHQoT2l17belmtub+oAXgYWrnTjHOZm/YKuFr/jIjvjUAoVVuOM1/
         rY4ywsk/6nlpe7qLoeDYAD3NuRCmSIvHySFcJh1VkwI4Axcv3a2/CdhrebgQERblpg
         0qz2VFCLUMudeOYHkYL0tOGGZJhHwTOwz6MAIVe4KC9chyFSPRQm/Jls2MvIS9kvTy
         g4JOOKHsahrsXk+FljusYRXRZLPt8vNwSzyD4tgGU3Es/5tSAc9TiI4qQ7RWeukOE1
         /xf7iH4jo6vcw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214103] New: HCI_CHANNEL_USER sockets leave device running
 after exit
Date:   Wed, 18 Aug 2021 17:45:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pab@pabigot.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214103-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214103

            Bug ID: 214103
           Summary: HCI_CHANNEL_USER sockets leave device running after
                    exit
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.0-7620-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pab@pabigot.com
        Regression: No

Created attachment 298353
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D298353&action=3Dedit
code to reproduce behavior

HCI_CHANNEL_USER is documented[1] as providing an exclusive (?[2]) Bluetooth
socket channel for application use given CAP_NET_ADMIN. This channel type
requires that the device be down when the socket is bound.  The device
transitions to UP RUNNING as a side-effect of a successful binding.

When the socket is closed and the application exits, the device remains up =
and
running.  It's unclear whether this is a bug or a feature; in any case it is
not what somebody might expect, as it prevents the application from starting
again without external action to bring the device back down.

Reproducing example attached, and command sequence below.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv5.13.12&id=3D23500189d7e03a071f0746f43f2cce875a62c91c

[2]: https://bugzilla.kernel.org/show_bug.cgi?id=3D135431


tirzah[1050]$ sudo hciconfig hci0 down
tirzah[1051]$ hciconfig hci0
hci0:   Type: Primary  Bus: USB
        BD Address: A4:C3:F0:F2:23:E3  ACL MTU: 1021:4  SCO MTU: 96:6
        DOWN=20
        RX bytes:64500 acl:0 sco:0 events:4125 errors:0
        TX bytes:650824 acl:0 sco:0 commands:3992 errors:0

tirzah[1052]$ gcc repro.c
tirzah[1053]$ sudo setcap cap_net_raw,cap_net_admin=3Dep ./a.out
tirzah[1054]$ getcap ./a.out
./a.out =3D cap_net_admin,cap_net_raw+ep
tirzah[1055]$ ./a.out=20
opening device 0
dd=3D3; binding to user channel
bound to user channel; closing
closed
tirzah[1056]$ hciconfig hci0
hci0:   Type: Primary  Bus: USB
        BD Address: A4:C3:F0:F2:23:E3  ACL MTU: 1021:4  SCO MTU: 96:6
        UP RUNNING=20
        RX bytes:65256 acl:0 sco:0 events:4180 errors:0
        TX bytes:653053 acl:0 sco:0 commands:4047 errors:0

tirzah[1057]$

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
