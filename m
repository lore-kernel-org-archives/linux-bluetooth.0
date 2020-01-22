Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7289BC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 05:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E932253D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 05:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgAVFbI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgAVFbI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 00:31:08 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204765] debugfs: File 'le_min_key_size' in directory 'hci0'
 already present!
Date:   Wed, 22 Jan 2020 05:31:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alfonso.chacon@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204765-62941-57pwpSMIZh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204765-62941@https.bugzilla.kernel.org/>
References: <bug-204765-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204765

Alfonso Chacón (alfonso.chacon@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alfonso.chacon@protonmail.c
                   |                            |om

--- Comment #3 from Alfonso Chacón (alfonso.chacon@protonmail.com) ---
I have the same issue

Device was discovered and connected fine the first time, then it was
disconnected immediately.

Every time I try to connect it again, it disconnects.

s@OrangeDemon:~$ sudo hciconfig hci0 -a
hci0:   Type: Primary  Bus: USB
        BD Address: DC:FB:48:28:FA:95  ACL MTU: 1021:4  SCO MTU: 96:6
        UP RUNNING PSCAN ISCAN 
        RX bytes:76148 acl:16 sco:0 events:2184 errors:0
        TX bytes:13222 acl:14 sco:0 commands:589 errors:0
        Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH SNIFF 
        Link mode: SLAVE ACCEPT 
        Name: 'OrangeDemon'
        Class: 0x100104
        Service Classes: Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Version: 5.0 (0x9)  Revision: 0x100
        LMP Version: 5.0 (0x9)  Subversion: 0x100
        Manufacturer: Intel Corp. (2)

dmesg:
[    4.172065] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.172066] Bluetooth: BNEP filters: protocol multicast
[    4.172068] Bluetooth: BNEP socket layer initialized
..
[   13.392448] Bluetooth: RFCOMM TTY layer initialized
[   13.392452] Bluetooth: RFCOMM socket layer initialized
[   13.392456] Bluetooth: RFCOMM ver 1.11
[  246.531147] debugfs: File 'le_min_key_size' in directory 'hci0' already
present!
[  246.531153] debugfs: File 'le_max_key_size' in directory 'hci0' already
present!
[  275.658457] debugfs: File 'le_min_key_size' in directory 'hci0' already
present!
[  275.658463] debugfs: File 'le_max_key_size' in directory 'hci0' already
present!

-- 
You are receiving this mail because:
You are the assignee for the bug.
