Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9350C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348776AbiBCVTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiBCVTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 16:19:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8382FC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 13:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B292B835AE
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 21:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B3D3C34106
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643923142;
        bh=r2msGrHPXM7S7ZkkcbaSe1VJSXWOhcRaaAJNjF4cQ0w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u11EsoCf/LyFuE+l2DoufMQcn7Usfrx+endfRgpSTJoz241hlT3EXSDZMILJ1GmkO
         qgxnESJ/g29EzlAvx7jgwzUVFJIRxYzkUIZFwyGsafEmj/R22L4U8AcW5AHOUetXVA
         y/RqsiMcbd+d3TkvHpRIUMGyjUqcDi/gLxJKfdkL71ugWb8Mi6D86EXcHCRw6e7NpY
         CapseO3O3WAjBCrnEaRydPvac/zYMRAeIBlGfOMOATi5HoZx556gT1f/0fQ7Y55Msl
         Z3cU/l5hTAudL2rHO5sR1hey8xD/s26CKUw413aeXANTqI/D6DyTqIK3f1qhRlBU9F
         s7iYRcUGb1oBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4B978C05FD2; Thu,  3 Feb 2022 21:19:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 03 Feb 2022 21:18:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: illialoo99@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-B8PgPfzmv8@https.bugzilla.kernel.org/>
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

ekusupuroito (illialoo99@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |illialoo99@gmail.com

--- Comment #224 from ekusupuroito (illialoo99@gmail.com) ---
Just updated to 5.17-rc2, with my USB dongle I got this in dmesg:

[   75.841855] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[   75.841861] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround
[   75.883842] Bluetooth: hci0: unexpected cc 0x0c25 length: 2 < 3
[   75.883849] Bluetooth: hci0: Opcode 0x c25 failed: -38

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
