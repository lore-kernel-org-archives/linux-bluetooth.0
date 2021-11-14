Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F55C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED06A60EE7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 14:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhKNOjg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Nov 2021 09:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhKNOj0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Nov 2021 09:39:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E4A6F6120E
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Nov 2021 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636900590;
        bh=vT3L+9wOhswvhO3WbZwOFmwnGjJUbGMygLsebJ47Ztc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gTCtDTH+PFX3p5lz1AtN8W5wNz0yr1kIda//cGCLzTbQiA1o5R5gIt05jKOd6fj0E
         l3Y1C3dRtF9kmyC+t3AoW+GmvjrejGufQAaMAnRBBXE0blNvqUTwGSe4IVt4+tRa7i
         JrZ6QJqYrXPTYJS52qcOL9iWivMQAqjHi6UNxicYPIIJNbfUs7/g+YoByPS5fAezae
         5XIeagtYD2tIPSYQhi3yniPqdIwjVpajSLVQRq8WEArynBk/kOwRRnTv/mBYSMS/QH
         OpLodeajMQjYBH+wAXM16begssTLalmxVdHYdoAer1UIWJBfyH2RfdRfQ0SXxlO4RH
         CUr3sd1OXO0Ag==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sun, 14 Nov 2021 14:36:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-Qx3oRcxj2t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

--- Comment #30 from Marco (rodomar705@protonmail.com) ---
(In reply to Kiran from comment #29)
>=20
> (In reply to Marco from comment #27)
> > (In reply to Guillaume Binet from comment #26)
> > > Alright, talking with Intel directly, this patch seems to fix it for
> > 5.15.2:
> > >=20
> > >
> >
> https://patchwork.kernel.org/project/bluetooth/patch/20211013080511.23945=
-1-
> > > kiran.k@intel.com/
> > >=20
> > > I have a bunch of other regressions like GPU hangs with 5.15 but at l=
east
> I
> > > see the controller showing up consistently warm reboot after warm reb=
oot.
> > >=20
> > > Can anyone else confirm it works?
> >=20
> > Nope, running 5.15.2 and now bluetooth disappears after a reboot. This
> > hasn't fixed the problem for me, it just changed behaviour.
> >=20
> > I can confirm that the patch is present, I do see the message added for
> that
> > patch:
> > ....
> > [13556.611182] Bluetooth: hci0: No device address configured
> > [13556.611197] Bluetooth: hci0: Found device firmware:
> > ...
> >=20
> > But there is no bluetooth adapter available from both my DE nor from
> > bluetoothctl info command.
>=20
> The log "No device address configured" was present even before this patch.
> https://patchwork.kernel.org/project/bluetooth/patch/20211013080511.23945=
-1-
> kiran.k@intel.com/
>=20
> Now its getting printed conditionally based on the mode of the controller.
> Are your sure that this patch is present in your test? As of now I can see
> this patch merged only in maintainer tree but not in 5.15-rc2
>=20
> Thanks,
> Kiran

I'm sorry, Kiran, you were 100% right, even the stock kernel hasn't yet
included that patch. After compiling 5.15.2 plus the above mentioned patch,=
 I
can definitively confirm that on my system the issue is completely fixed.
Rebooted 5 times, each time the bluetooth was working correctly. Finally th=
is
bug is fixed, I hope it will be merged soon, at least on the 5.15 series.

Thanks a lot for your work,

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
