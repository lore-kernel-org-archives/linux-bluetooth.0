Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864ADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 03:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B44C610FF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 03:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhKMDqm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhKMDql (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 22:46:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3FBE561179
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Nov 2021 03:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636775030;
        bh=igJkAnGoYEyadFHaZrYiIkK6NH2vbV57nCmipTMdJS4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KzDUm1lQ44KdCuD8/cway3Im/AmtAqxig350ujfSXXCvL6wWVG17AafcbFbpKtegS
         eMbNh0UkCvgo77yqAD+NgEPCLsv+YrWO1EHzDI0rK3FLmoziI0hF+4IZirO6zRHpEg
         Yg7Au4EwdX8DGd1TteiR2I9RFixmiz94JAIkw7HNjgUB7zPHLuN0NKB/QIObot+e75
         kRSJbX8yuiwKVVYmVelU/9KZYHve+8hA80H6c4W9ZomGog8bHQbbYeaYlrDsBro8aE
         09ZOaIG33RJAea/2GhP81kiwxzf1qG2O1QSVbjpldBjh7iGMxP+W9LoVFWfs7jO+d1
         4OYsTBxw3cJZA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sat, 13 Nov 2021 03:43:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quest@mac.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-EC0vYVPgRW@https.bugzilla.kernel.org/>
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

--- Comment #24 from Josh Ellithorpe (quest@mac.com) ---
(In reply to Tedd An from comment #23)
> Could you try with the latest firmware from linux-firmware.git?
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it
>=20
> Copy the intel/*.sfi to /lib/firmware/intel/ and cold boot.
>=20
> It will help to rule out if it is fw issue or not.

I just tried. I installed the latest linux-firmware-git package that pulled
latest.

On cold boot I had `bluetoothctl list` hang after boot. Then after restarti=
ng
the bluetooth service, it showed the device but still refused to even do a
basic scan.

`Failed to start discovery: org.bluez.Error.NotReady`

Then after doing another quick cold boot (stayed off only a few seconds), no
device was listed at all. =3D\

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
