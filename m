Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521ABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jan 2022 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiABUhF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jan 2022 15:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABUhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jan 2022 15:37:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF5C061761
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 12:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 396D8B80952
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 20:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1FAEC36AEE
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641155821;
        bh=gWJ3V3+k8R6a55uFE2oe3mTkDoc6XZHpd5GgHMyR7VE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hAP8aS14B1B+3HVLr67wzL1HWQ/ya+lC0kKuqi3X9qlL5HP1SDXLfBIceVZi85J8o
         KDYMp5JpPQiX2q2EXNX/ohRmPpMKBZCS/cxItGRPvvx7sflY8DA2Udkos90b4PRU9m
         IgNXBAEyz1rOht6X/q37062t85Bmun/l6hTwE0tRGoxQvQS/Q3RpfMa51jZRjhdIv+
         STyudwZodYpeNIvmDnqlbdThZy8GmETgX+ZBUa8jJs7cG/tGIznypJKvdjS9gZApS9
         0RdDGdXgE2y+6QOD2aFV2xPG+wFVTwZnYqXYgaGs7huUIDy7HZPiLuC0PmMgMjdy40
         BKq92u4k9EJyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D1B29C04E57; Sun,  2 Jan 2022 20:37:01 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sun, 02 Jan 2022 20:37:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tobias.predel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-WfLBab9Ond@https.bugzilla.kernel.org/>
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

--- Comment #46 from Tobias Predel (tobias.predel@gmail.com) ---
After having been fixed for 5.15 series, the issue seems to reappear on=20
linux mainline 5.16, at least on rc 7.

Bluetooth only works after cold boot, but not after warm boot.

Can anyone look into this?
Thanks in advance!

bugzilla-daemon@bugzilla.kernel.org <bugzilla-daemon@bugzilla.kernel.org>
schrieb / wrote / a =C3=A9crit / je pisao / =D1=98=D0=B5 =D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE:=20

> https://bugzilla.kernel.org/show_bug.cgi?id=3D213829
>=20
> Tedd An (tedd.an@intel.com) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |tedd.an@intel.com
>=20
> --- Comment #19 from Tedd An (tedd.an@intel.com) ---
> This should be fixed with
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/bluetooth/btintel.c?id=3D35191a0fe986bacf69bd842de81119dca7970f11
>=20
> I tried it with 5.15 and didn't see the problem.
>=20
> --=20
> You may reply to this email to add a comment.
>=20
> You are receiving this mail because:
> You reported the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
