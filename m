Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122DDC433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 03:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0CA6120A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 03:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhDLDfL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhDLDfK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Apr 2021 23:35:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4CBF36120C
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 03:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618198493;
        bh=hr0GXXG1DaMB+WBhpVPzf+HoOzD0rLZPmVbJ41CcdlA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=na/OJynZQ6mQG4J7R18CCowDx4t9UAY1uzCa7zGjLti5rByyIhx1uRLhXffE4Rmv5
         xU7ZFEhLXUD6Lo2TFBvt/XKQDdMQZBwgFgqVkt/IOYwOego5ue9NRAuv0IjhrIWDAQ
         h8G7lJrbDYhEiceaoDof2pJIKQQe7lWGbpLUWj5vcICQnJwKlboQ8qkzKnE+tVVSVj
         8IJ1c34Uxu+kRbes9auNIHp3tpxgdlvsp5PcREwYpt6Rv2nwOZiNrH4SEusWnz3EEU
         vxIeBIB16JJsc7YMjKVrtfcCAaWbOut9NroE1Clq14TzyRFGEvBkP6VDFPKZKsHB2Y
         2IJh+oTPQMBMQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211969] AX200 Bluetooth audio devices disconnect after random
 intervals
Date:   Mon, 12 Apr 2021 03:34:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jacksondm33@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211969-62941-pVo5SHwtVf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211969-62941@https.bugzilla.kernel.org/>
References: <bug-211969-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211969

Jackson McClintock (jacksondm33@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jacksondm33@gmail.com

--- Comment #1 from Jackson McClintock (jacksondm33@gmail.com) ---
I looked at the commits from version 20201218 to 20210208 of linux-firmware=
 and
found 3 commits which updated the firmware for Intel Bluetooth AX200, AX201,
and AX210, which are the cards others and I seem to be having issues with. =
I'm
pretty sure this firmware is proprietary, so I don't know the best way to t=
ry
to get a fix for this bug, since kernel developers don't have access to the
source code. I did notice that that these were updated again, though, but t=
he
bug stills exists as of linux-firmware version 20210315.

These are the links to the original commits that probably created this bug:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3D3027ae40cf3e43725c45e53085b5e0484f09ea71
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3D13979c3a51d068fc1b66df1065d9479bddcb418f
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3Dd33d2d86ce3ad2ed1a4e196840fdd3a814d34433

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
