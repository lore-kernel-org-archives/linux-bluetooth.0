Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F041C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BB960F9D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 15:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhKFPbz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Nov 2021 11:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhKFPbz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Nov 2021 11:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 85CA160F9D
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 Nov 2021 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636212553;
        bh=V16gVPt8fB9tnN8FhlTbtq2eDRCXOznQOUZ8k7lgcjc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S338zruus+1Sm8QQ9SQVz6z6SzQJ5gNyCIZUmCdrCb2B1vn49h0h95usBzb5+XpSu
         MsVpu8SWVm870rUS/nwh+c7DJ0gTL0U4iXlzqRZvPtD+VLSWP9N17uj8KpimIAN5Is
         2tkOHEfrTWYyj9vzjiZ8liO+R1LAFRt7xOEhpQuzhVh5aVYUoBCMAHKSXq1L8YbdkI
         K77YQ2FyX4vLYr5i09uE4WU6R5y26NdqrNh6As9AMqbYIMOLBy4TYTgKsLXGOROuMH
         xmMORORRivyCP9OqM/EP2kWPqT6Vw5DurObQJnTIKtfsUEbtp1Gnx93RFyGkdmfQ+U
         dCwMebVRMz/QQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214823] RTL8821CE Bluetooth adapter randomly stopped working,
 only suspend then resume can reset it
Date:   Sat, 06 Nov 2021 15:29:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: thanhdatwarriorok@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214823-62941-puAcvqXdqe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214823-62941@https.bugzilla.kernel.org/>
References: <bug-214823-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214823

--- Comment #2 from thanhdatwarriorok@gmail.com ---
Alright, since no one on the team is responding anytime soon, I even report=
ed
to https://github.com/lwfinger/rtw88/issues/72 also with no respond

I will leave my workaround here:

Add blacklist rtw88_8821ce to /etc/modprobe.d/blacklist.conf

Install https://github.com/tomaspinho/rtl8821ce

modprobe rtw88_8821ce before suspend
modprobe -r rtw88_8821ce after resume

To do this automatically see
https://wiki.archlinux.org/title/Power_management#Sleep_hooks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
