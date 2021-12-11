Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Dec 2021 07:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhLKHXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:23:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41692 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHXu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Dec 2021 02:23:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA06BB80763
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Dec 2021 07:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA145C341C7
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Dec 2021 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639207427;
        bh=V6hDB5xrfotTNN9Zn3LbWh+tltaaQLZh31h3t+tVH5U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k+9fvgBIIzhc7gHZgUDG7PAX8z81d/zObeQKlRcp8EpCowiyxAKTBulsVzkle+d+T
         YTS+o/I3KCP9XsgUapYjlcHRkM3CzL2mMuPwPYj0FeYnK63s0oeNFVV284fG+BS8ld
         To80FiEqUViX1GGxlVOWWcFXJevkTvR0isNW1JEowwH6334CX0gomaHqco0fp6r8PT
         gQW0m31GLED5T3HOLRtgNMx0nwunjCqdNLbqvLFfMxAFxW2mskCIulXlrhwGzLbCCD
         qtnJW+lYHaaj/UIMtuAVvXeWm9fw36toYeK6DX0R1lMz6y04dvbBDJsvdZtMTKoQMU
         2kuUDdYnwVieg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9195A60FEE; Sat, 11 Dec 2021 07:23:47 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Sat, 11 Dec 2021 07:23:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nozzy123nozzy@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215187-62941-wa5nwpHmgd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215187-62941@https.bugzilla.kernel.org/>
References: <bug-215187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215187

Takahide Nojima (nozzy123nozzy@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #6 from Takahide Nojima (nozzy123nozzy@gmail.com) ---
Hi all,

 After I renamed "ibt-19-16-4.*" to "ibt-19-16-0.*" and the kernel failed to
load just once, I rebooted and switched off again and again until today.
However, I've never seen the attempt of the kernel to try to load
"ibt-19-16-0.*"  since that. The kernel came to load "ibt-19-0-4.*' at the
beginning of boot.

 I guess that an internal failure in the AX201 caused my problem. I hypothe=
size
that trial to load the wrong(broken) Bluetooth firmware caused an invocatio=
n of
internal resetting to the AX201. After then, the AX201 became to return the
correct version information to the "btintel" driver, and the kernel
successfully loads the correct bt firmware, "ibt-19-0-4.*'.

 Whether my hypothesis is true or not, my problem appeared to solve. I will
mark this thread as resolved.=20=20=20=20

 Many thanks all,

Takahide Nojima

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
