Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6DBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC13611C9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 07:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhHFHSW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhHFHSV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 03:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C79561179
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628234286;
        bh=/my4fZZViSV8Q3FTvu5IFhrSelsHa0Uvv3nlbO/KWt8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BIRTZagnGZwuPikK5U74UUstlYi45FIeyzJ2Qo7h8pzykkoUAm9KTN++O7fci2ooK
         nCHeTPsL8dlxN3LGnbGy9dzG9H6h9N+soarXHOTbqKplgBZkj7SBrHweH7dGD168Y6
         wDt+wqAQ+v/JJRvrQ0xG368rqjxdMuneDPG9rcgg5Lpjf6so9six6+Q1r/CTv06zfe
         mSE1NDaX0sqNenHwFu/oUQc6UbOHX0wAzt4yaWmOA3JPwgXk0BB3UWKWCx7WeKDdmo
         WH40HgvY/Q8LKG+r65YOklfbZHTE0/YMU+lAb05Jfiqxh/DCpb3bDyRm3E3c2mYBAM
         hYoBDUyy+g46A==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213923] Bluetooth: AC9560 doesn't respond any more after
 suspend multiple times
Date:   Fri, 06 Aug 2021 07:18:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: koba.ko@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213923-62941-LfirhVpNGQ@https.bugzilla.kernel.org/>
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

--- Comment #4 from KobaKo (koba.ko@canonical.com) ---
Here's a full btmon log during reproducing issue.
https://drive.google.com/file/d/1wSn1wugdp73ntt0tsYoxfdu-SRgumECv/view?usp=
=3Dsharing

btmon_20210802 is only contained btmon log after turn on bt.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
