Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB6C07E9D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 02:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiI0C6U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiI0C5t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 22:57:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8423FAC7A
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 19:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FD7ACE16B6
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 02:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD2AC4314A
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 02:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664247197;
        bh=6V86AVXCcZJ6EvN+wPL91RTkiw56dz6GsvKJCGkp4RE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fl6KPD5sEpg1/rxhyC3Q7HerMQQ76cn7kt0qmwAf2P2ClkeBfTrL+scV/Q7pNn3Mj
         vitvDRgOpTNd9J7T/V1bK4uMUOxwuLDcivsIh3r3jjW+EyQoZkI3EUQrMRQkGv3DTo
         6Hag8tBFMP4yR9H3/OuUel4NwMbVLJ/jghZLtQWBWQJEn0RNme1i7jJeh5q6lfMES0
         HaL7ClCLrtxccKDZ9YN5ZUXG6eIRDRRSA7pAgH1nYYOfr4rSsDj+y7NdkWG0ZoqqqX
         /j/Hm7R25fSaNmJzKFlO75NmAMBb2wEw8WyghYB82MItv1HyuehiuLkaqZqwiTjTRv
         GK40yFr+Wb7yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08BBCC433E6; Tue, 27 Sep 2022 02:53:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Tue, 27 Sep 2022 02:53:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: patrick.blesi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-w0S7VcLVoR@https.bugzilla.kernel.org/>
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

Patrick Blesi (patrick.blesi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |patrick.blesi@gmail.com

--- Comment #41 from Patrick Blesi (patrick.blesi@gmail.com) ---
I am experiencing the same problem with 5.15.67 for USB Device
USB_DEVICE(0x8087, 0x0aaa).

~ $ uname -a
Linux a0d7b954-ssh 5.15.67 #1 SMP Tue Sep 13 13:54:38 UTC 2022 x86_64 Linux

~ $ lsusb
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 003: ID 1043:8012
Bus 002 Device 001: ID 1d6b:0003
Bus 001 Device 002: ID 8087:0aaa

~ $ dmesg | grep -i bluetooth
[    0.454719] Bluetooth: Core ver 2.22
[    0.454904] NET: Registered PF_BLUETOOTH protocol family
[    0.455504] Bluetooth: HCI device and connection manager initialized
[    0.455896] Bluetooth: HCI socket layer initialized
[    0.456392] Bluetooth: L2CAP socket layer initialized
[    0.456894] Bluetooth: SCO socket layer initialized
[    4.452912] Bluetooth: hci0: Reading Intel version command failed (-110)
[    4.452955] Bluetooth: hci0: command 0xfc05 tx timeout
[    4.498402] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.498405] Bluetooth: BNEP filters: protocol multicast
[    4.498409] Bluetooth: BNEP socket layer initialized

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
