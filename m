Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jul 2022 15:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiGDPzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiGDPzr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jul 2022 11:55:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB1BC97
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 08:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD6C4CE184C
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 15:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF379C341D7
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656950143;
        bh=lCXxjijsK2aIrMjATCZW8Ys2pLq+hYtLZCa9GovA+98=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=chG4FbiugYpGNCLfZlKI1q2kV2WoasxQRm38El8YQwPG7A61x21UnKuxnINAKjyE8
         wdFZHmO7nUj7wEbLALuk3kWYaE/U0qOJ8r0gDvIZOoq7MICRmGkeMno71kQ8THOSJ5
         Z1nI2sn3ddl2d8Hg7hyiVTOz4thrELmsuOtzs8o+huQvq4BCIhUO5PUOAwwGEFLOJm
         QYRk2X0GwT2laNznzhL6l1Hbw3Wyu9pwqE/WHIaOEODAxONbMwWolxNgHDod5Ozt9a
         pr5Gkw9FngJGCTlr5VbEfylfYjVo8fZ3v1cPMvYxcwzBAAMvcQFKKRDD5u8LOJu+KS
         mc1PtYDYXy2UA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DEBD5CC13B5; Mon,  4 Jul 2022 15:55:42 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Mon, 04 Jul 2022 15:55:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dion@inhex.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215576-62941-Pa6TTmpNWs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

Dmitry Nezhevenko (dion@inhex.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dion@inhex.net

--- Comment #19 from Dmitry Nezhevenko (dion@inhex.net) ---
I think that I've same problem with followed bluetooth adapter:

Bus 001 Device 005: ID 8087:0026 Intel Corp.

[   41.184754] Bluetooth: hci0: Bootloader revision 0.4 build 0 week 30 2018
[   41.185760] Bluetooth: hci0: Device revision is 2
[   41.185769] Bluetooth: hci0: Secure boot is enabled
[   41.185775] Bluetooth: hci0: OTP lock is enabled
[   41.185780] Bluetooth: hci0: API lock is enabled
[   41.185784] Bluetooth: hci0: Debug lock is disabled
[   41.185789] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   41.187739] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-4.sfi
[   41.187762] Bluetooth: hci0: Boot Address: 0x24800
[   41.187763] Bluetooth: hci0: Firmware Version: 191-21.21
[   41.884145] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   41.884148] Bluetooth: BNEP filters: protocol multicast
[   41.884150] Bluetooth: BNEP socket layer initialized
[   42.786061] Bluetooth: hci0: Waiting for firmware download to complete
[   42.786699] Bluetooth: hci0: Firmware loaded in 1561482 usecs
[   42.786723] Bluetooth: hci0: Waiting for device to boot
[   42.801703] Bluetooth: hci0: Device booted in 14639 usecs
[   42.801733] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-19-0-4.ddc
[   42.803713] Bluetooth: hci0: Applying Intel DDC parameters completed
[   42.804752] Bluetooth: hci0: Firmware revision 0.0 build 191 week 21 2021
[   42.887147] Bluetooth: RFCOMM TTY layer initialized
[   42.887153] Bluetooth: RFCOMM socket layer initialized
[   42.887156] Bluetooth: RFCOMM ver 1.11


Also running debian 5.18.5 kernel and getting cracking sound recorded from =
mic.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
