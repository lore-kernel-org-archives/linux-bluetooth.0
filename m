Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EE664D9A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 15:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBKPZb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 10:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhBKPWw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 10:22:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0563E64F4E
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613056333;
        bh=hYUMARrhOw4/ZjlT0BM7/G3+YUyHzHb25HBkSPAYnHA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=esE5EAl749Io1VrUirn6fuLgfu6FY+bOYlCEvd5n/318FFZaLWT9kAhqwGf0jOIHZ
         MmQYk13j+faTkmXXRVRy4WB3MxhyHEZhFRFty4YmUAHx0/uUhVxm7GcHpa992nEDCx
         nwqHuWK+p6HWyYRfQRXdCJAQ1pgK1JOuoEjAmVOkRlrmPPwozT1+KplihLLgxIrQMO
         ZEMza5avTVd1S2GoQ3f7YPCSLoZQqZ4ne52EMo3XAqczrsLVYRr4dsmWqtEISMVN4X
         fSaAbEdGSVqn5gTrZBHgER+FGW9wOfa2p4PITV1aXX8Jgzp91lteYPmqLHsr+olCew
         9qfw12aA+089g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211571] Bluetooth: hci0: don't support firmware rome 0x1020200
Date:   Thu, 11 Feb 2021 15:12:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: helbermg@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-211571-62941-X19xxkLXli@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211571-62941@https.bugzilla.kernel.org/>
References: <bug-211571-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211571

Helber Maciel Guerra (helbermg@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |helbermg@gmail.com

--- Comment #6 from Helber Maciel Guerra (helbermg@gmail.com) ---
I have tested this patch and works using latest kernel source:

commit 291009f656e8eaebbdfd3a8d99f6b190a9ce9deb (HEAD -> master, origin/mas=
ter)
Merge: a3961497bd9c d11a1d08a082
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Feb 10 12:03:35 2021 -0800

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
