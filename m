Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DCC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD81610A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 15:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHRP2w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239411AbhHRP2u (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 11:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F96D610E5
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629300496;
        bh=bkzLADR/4kU4xpQ9m12IeSPX8nwtF0MgO9TUDTmHU1g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lVPYNJGTWkJlQ/+HHyau84cIzBF36/tyHf0YFeEEVH+8zmdCnNzoSnhVT19Y/SLDv
         Jd4Vi3OuZPfUWhznXCgRInrmJn1JqzFQ/N5CEZsCu+l7XtR2zTQSesctyBaiRtKQsQ
         /9BhUDgSgox175ILMdZN98FeRTMnCYe2l3qkzrjLI++NJUksdvLHqIVHrrh/cvPDET
         97l6NGVAM04m28WJKYPARIT06mKaTPOh7FC6ihG0luEovaQmF7rbi1cWoSPMJoOzNp
         7D7ig/s75gxWijcVv5wxJFSlXxZwSkm8Rg997wlT9QvNoBTq/39NKaj8Y8Pa3dmsf5
         gxoxjM+yKrKUg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213923] Bluetooth: AC9560 doesn't respond any more after
 suspend multiple times
Date:   Wed, 18 Aug 2021 15:28:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: chethan.tumkur.narayan@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213923-62941-qgM5vv5eH6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213923-62941@https.bugzilla.kernel.org/>
References: <bug-213923-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213923

Chethan T N (chethan.tumkur.narayan@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chethan.tumkur.narayan@inte
                   |                            |l.com

--- Comment #5 from Chethan T N (chethan.tumkur.narayan@intel.com) ---
Would you please help to provide more details on the test setup and test ca=
se.

Setup details:
Linux distribution : Ubuntu/Fedora  ??
kernel version: 5.xx??
Model name: ??

From the logs shared looks like one every suspend/resume Bluetooth device is
getting enumerated and FW download sequence is initiated.

May i know why the above behavior ?

And also noticed that in most of the suspend/resume flow during the FW down=
load
sequence itself the system is entering the suspend state.

//System entering SUSPEND State=20
37213   2021-08-06 12:39:52.879966      host    controller      252=20=20=
=20=20=20=20=20=20=20=20=20=20
                Sent Intel Secure Send

//System RESUME state
37222   2021-08-06 12:40:16.529947      host    controller      3=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
                Sent Intel Read Version=20

May i know why the above behavior?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
