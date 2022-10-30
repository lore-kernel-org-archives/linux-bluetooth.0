Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712EFA373D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 10:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJ3Kps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Kpr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 06:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E5215
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 03:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FAC0B80E26
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 10:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 109EBC43142
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667126743;
        bh=O+wKpDC7+g4w0PyjWvOPqtWMbO0nfTHstYC5ZIGsd9A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AnxCxyUxl1TAxkdbn43ABTDkalmoCjzeaVX+/KIFIX8rTvGV9+YcIC2vRnBZtsTF+
         lzvRLgJWq35+T/Ql5wqtUMdSJjMHSAyCt00F5nqC9LZbR2YYlCxOajN0c8XeytHh/c
         +PAE7lRQeJ6iSTspJeHTsUWUxiGM3nfF9WbwHESTXqQl46t9BtKQU2/NJtIqlCGmqv
         +AyWSWHkh6HxnPtpDv036wbys+kdD8zu/dv2aBXwRxmOJuYiZhHb7qI1pKppAOfVSi
         W5Ry4xNjUmoazeukR3e2Jj7RGVHsUr/pwMMryukxtK2z4X1WEqNEDMKU3BVHC5kdTy
         cYVXZueP2JtQg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 00CC9C433E4; Sun, 30 Oct 2022 10:45:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 30 Oct 2022 10:45:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-3BIS0e4jOg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

justanormaltinkerermihir@duck.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |justanormaltinkerermihir@du
                   |                            |ck.com

--- Comment #244 from justanormaltinkerermihir@duck.com ---
Recompiled the kernel using the patch, doesn't work for me.
Here's the dmesg log
[ 4192.433733] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9 rev=
=3D0810;
LMP ver=3D9 subver=3D2312; manufacturer=3D10
[ 4192.433750] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds...
[ 4192.433752] Bluetooth: hci0: CSR: Unbranded CSR clone detected;
force-suspending once...
[ 4192.792888] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[ 4192.792896] Bluetooth: hci0: HCI Read Transmit Power Level command is
advertised, but not supported.
[ 4192.792898] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[ 4195.075805] Bluetooth: hci0: command 0x0c5a tx timeout
[ 4195.075813] Bluetooth: hci0: Opcode 0x c5a failed: -110

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
