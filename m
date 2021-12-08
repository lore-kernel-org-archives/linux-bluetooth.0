Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD88C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhLHWFp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:05:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45302 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhLHWFo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:05:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39DFCCE23E4
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 22:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E037C341C3
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639000929;
        bh=QCVouIIf76NNBGfkehe6aqMh2SK07rgwC9zut0GokQc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b05+MqxUAA7Z9ENgPUuzesVfUu8WR+30Atd/UKLaycYDwzGU2yDBHkElYzPSDFnB5
         C+M7lLEfUFK7VHMJn4Mv4g6a/lshIqeJV26YwBwbiUxA40cZkr/fTlTiGYlva5r+cx
         Dihy3WyQXyonR1n/QqTp34LdfTKCwS4PA//dyHrLwxDaTy/hpyfGLm1xJA+xGr30mC
         3i+VJtQg39nQP0PgMjrLOA5tFslYYfteh8MBzW28AOFKhJ3U/0k0btFcreAZfvgMq6
         yvmbc5+TSm8BhDukHYF61QEo1nvig/H2pov/vEC28V+7iRWHCwmGGxKS2IqrbR+Mlq
         TVF/pJoecP4Nw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4377F60F4F; Wed,  8 Dec 2021 22:02:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Wed, 08 Dec 2021 22:02:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215187-62941-q8Vexejj9s@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #4 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Takahide Nojima from comment #3)
> As written above, the kernel still failed to load intel/ibt-19-16-0.sfi
> because the 22.80 firmware tree doesn't have it.

Try renaming it then, I suspect that is because that file is missing but if=
 I
recall correctly this is just the firmware revision:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/drivers/bluetooth/btintel.c#n1793

> =E3=80=80I guess basically  the 5.16-rc3 with "iwlwifi-Quiz-a0-hr-b0-63.u=
code"
> supposes to load "intel/ibt-19-16-4.sfi"? The 22.80 firmware includes it.=
 In
> other words, does the "ver->fw_revision" in "btintel.c" supposes to be 4
> after the kernel with "iwlwifi-Quiz-a0-hr-b0-63.ucode" sends 0xfc05 to AX=
201?

I don't think the wifi firmware has any relation to the bluetooth firmware,
otherwise we would be loading just one firmware for both not each separatel=
y.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
