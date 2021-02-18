Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76066C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2423264E3E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhBRRYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 12:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhBROGB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 09:06:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DEB5D64EAF
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613656423;
        bh=ROnvhmI2YHMLSu6DQGJtJMzQpqfoIv08hM2eGJnyOgQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VSFU9B1MKQps3KRgSZMoR6gx/iVdNzBskFEZFcYFG45rBmEfW0009jTMp0ye58CEu
         i5fJ5mXP8vFaObYJx0EBjq80tYYCQ/17MkNUQRkTXjRAtVl7hOjDlzEY2aK5wabxY+
         rxVohzUWhgtrpTGee9jBtYRi29WSewft8V69PjvsvB2e4LVb3D7RvkpkPS69tzRO1o
         Ix4OvfkjY3xpOe/6W7ZmrQemJRzTOOstcis5amxjgo9REslkhBFhcfl5fXWlovSQzv
         tRMf67/ormj60gQLcpJe+re/TBTpBOOzTAOi2pEH+/so5g4LiTBRKSCkcs0e0F/Wqt
         FalcKM/lxhkSg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware rome
 0x31010000
Date:   Thu, 18 Feb 2021 13:53:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210681-62941-xGRnAmRxVw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210681-62941@https.bugzilla.kernel.org/>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210681

--- Comment #38 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Unfortunately it is taking quite a long time to get the fix for this into
Linus' tree and the stable rules say that only fixes which are in Linus' tr=
ee
can be cherry-picked into the stable series.

For Fedora users I've added the upstream patch:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D234f414efd1164786269849b4fbb533d6c9cdbbf

Fixing this as a downstream patch for the Fedora kernels. So this should be
fixed in the next F32 and F33 kernel builds, which will likely be the 5.10.=
18
builds.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
