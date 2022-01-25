Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55788C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 10:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiAYKUN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:20:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57932 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243257AbiAYKP6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 05:15:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D67615D7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 545A1C340E5
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643105757;
        bh=DECwr90umq0eXtm10rcNJtEXY7jlzTpiG90A+eAMDiQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=embRDOtI43N2jDy9Y4Dab6ofHkoOz+uVgHiewDDinA945/HkU3xkV4m48x1hWJbtZ
         leJD5tL4w77OghLO3W//IyYIYPmwlQrTmP4cmY8IRXGGBpoC04Rig9Ij1zWb6LFnuI
         Lz2c+pKnnlxPCBzEvu3g9EEL70fAf/TJQEqtldaMenhsy2C6/A9VgJzs8Dau88pjp2
         /FBbNY/Xp+Pzt2AIPhKj5ZLAms4UUtJBARxYTxe2+Sf446QnkQ/uD5R1tuvBuolXs+
         pk++a9PdQcXyZDJcOYK1hoqjtgA2kqTuB/q7sT729jXobwZ316v69ooFP1jEQ1yi7V
         EtQVXI5NcxWRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A68ACC13B0; Tue, 25 Jan 2022 10:15:57 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 25 Jan 2022 10:15:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215528-62941-top4aGK1B2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Created attachment 300316
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300316&action=3Dedit
/sys/kernel/debug/usb/devices

(In reply to Paul Menzel from comment #3)
> Is this a regression? Please attach the full output of `dmesg`, and
> `hciconfig`, and `lsusb` and `/sys/kernel/debug/usb/devices`.

This is not a regression, I had this issue with previous kernels as well.

I'm not sure why you need all this info but whatever:

hci0:   Type: Primary  Bus: USB
        BD Address: 48:89:E7:XX:XX:XX  ACL MTU: 1021:4  SCO MTU: 96:6
        UP RUNNING PSCAN=20
        RX bytes:1738 acl:0 sco:0 events:200 errors:0
        TX bytes:19726 acl:0 sco:0 commands:200 errors:0

Bus 008 Device 002: ID 2109:0813 VIA Labs, Inc. VL813 Hub
Bus 008 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 007 Device 004: ID 046d:c084 Logitech, Inc. G203 Gaming Mouse
Bus 007 Device 003: ID 046d:c31d Logitech, Inc. Media Keyboard K200
Bus 007 Device 002: ID 2109:2813 VIA Labs, Inc. VL813 Hub
Bus 007 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 0b05:18f3 ASUSTek Computer, Inc. AURA LED Controller
Bus 003 Device 004: ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Ada=
pter
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
