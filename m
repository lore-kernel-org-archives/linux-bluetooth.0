Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1487FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB78F610A0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 09:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhKMJWe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Nov 2021 04:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231803AbhKMJWe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Nov 2021 04:22:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D720610CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Nov 2021 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636795182;
        bh=NuBqsJ/cWRp4sdkiZl13yGna53RYenVLfWwbYWv+l4w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rWPxzQ2J6LHDX53iHk/wtVKU7kSf2FSnu5aOCrZKg038vWoWGi5qpgxUFp2yefdxB
         XLY+o6+cnLqjvQm5iYKgkLp+sAUIJpSlalydl9X4smYLMCp2w2+tlWCDGSWfDGr1cp
         34MF3r8aOgKTUq9cFaL8QV2JHmjNU4srvAMHKqHHYCB5rRJkuu8/dUKw+AcddiOxJ9
         P6/mcMoZqWVVrkuhRE1iGBEKxgYE+PWlqmJXAqWUX4oO5BWQTF4QkA38vlIgDwiTtO
         lHTl+iZvevOyLCV/hoBSImr2C+2HSQOanp6lM5cOHQgmL6nzOBRUm0sTLJx9nh8kj7
         ulkAWDo63jwsg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sat, 13 Nov 2021 09:19:41 +0000
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
Message-ID: <bug-213829-62941-6k9eV0gnQR@https.bugzilla.kernel.org/>
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

--- Comment #25 from Marco (rodomar705@protonmail.com) ---
(In reply to Josh Ellithorpe from comment #24)
> (In reply to Tedd An from comment #23)
> > Could you try with the latest firmware from linux-firmware.git?
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git
> >=20
> > Copy the intel/*.sfi to /lib/firmware/intel/ and cold boot.
> >=20
> > It will help to rule out if it is fw issue or not.
>=20
> I just tried. I installed the latest linux-firmware-git package that pull=
ed
> latest.
>=20
> On cold boot I had `bluetoothctl list` hang after boot. Then after
> restarting the bluetooth service, it showed the device but still refused =
to
> even do a basic scan.
>=20
> `Failed to start discovery: org.bluez.Error.NotReady`
>=20
> Then after doing another quick cold boot (stayed off only a few seconds),=
 no
> device was listed at all. =3D\

Same thing here, just tested with the latest 5.15 that supposedly should
contains the aforementioned fix above:

With the current firmware in linux-firmware, the issue is still the same af=
ter
a reboot. With the latest firmware (just downloaded ibt-0041-0041.ddc and s=
fi,
but if the wireless portion is needed, I can add that too) and that made th=
ings
even weirder and weirder. After a cold boot, the adapter was working as
standard. Rebooted and the device was disabled by default (my machine is
configured to auto enable the bluetooth at boot), but after disabling and
reenabling the radio from my DE, the bluetooth reconnected to my mouse for =
the
first time since I've got this adapter under Linux. After another reboot, t=
he
radio completely disappeared (not even detected from my DE). I don't really
know where the problem resides, but I'm happy that someone is trying to see=
 to
the bottom of this.

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
