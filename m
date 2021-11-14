Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D11C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 08:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53235610FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 08:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKNIKf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Nov 2021 03:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhKNIKV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Nov 2021 03:10:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AEBB660F41
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Nov 2021 08:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636877247;
        bh=kNKIWSpjzDLA0Q7+5P0eLmb/2zd4qAqJJoNIRGvPM/k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B17dRrawIphfrHaCbBq3paeGBFqpq1SsMEmdA9B0lLUH/51MLvgDGgPFDlQrA5rjv
         mRbr2TNDURqmDCvScGZ+zq6AVMoqOrf0PPkXPCpJU1mvOlaXWuXl3G+9cmid3g6OG4
         Qw1sdJzBnZ17YL1ga3IaAW82TCySVYVDnvh8VpUaILuslhAVgw44V4EVW6OXrmRnI9
         ck0E/bqI+WDNO8wzyfUOz5QfwLJQx+M1zL5q1nWJ/PmyOV1kVFOT8Rn6A8G5vlGYc+
         OMqCyly6359a3lI9B0/U+yvlPSDmhZrHAKh68b4DD4DHhkAFXy9M9NzaTfvt8DfaFo
         ksGedbFz5QO3Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sun, 14 Nov 2021 08:07:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kiran.k@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213829-62941-KiWJZCNdRE@https.bugzilla.kernel.org/>
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

Kiran (kiran.k@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kiran.k@intel.com

--- Comment #29 from Kiran (kiran.k@intel.com) ---


(In reply to Marco from comment #27)
> (In reply to Guillaume Binet from comment #26)
> > Alright, talking with Intel directly, this patch seems to fix it for
> 5.15.2:
> >=20
> >
> https://patchwork.kernel.org/project/bluetooth/patch/20211013080511.23945=
-1-
> > kiran.k@intel.com/
> >=20
> > I have a bunch of other regressions like GPU hangs with 5.15 but at lea=
st I
> > see the controller showing up consistently warm reboot after warm reboo=
t.
> >=20
> > Can anyone else confirm it works?
>=20
> Nope, running 5.15.2 and now bluetooth disappears after a reboot. This
> hasn't fixed the problem for me, it just changed behaviour.
>=20
> I can confirm that the patch is present, I do see the message added for t=
hat
> patch:
> ....
> [13556.611182] Bluetooth: hci0: No device address configured
> [13556.611197] Bluetooth: hci0: Found device firmware:
> ...
>=20
> But there is no bluetooth adapter available from both my DE nor from
> bluetoothctl info command.

The log "No device address configured" was present even before this patch.
https://patchwork.kernel.org/project/bluetooth/patch/20211013080511.23945-1=
-kiran.k@intel.com/

Now its getting printed conditionally based on the mode of the controller. =
Are
your sure that this patch is present in your test? As of now I can see this
patch merged only in maintainer tree but not in 5.15-rc2

Thanks,
Kiran

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
