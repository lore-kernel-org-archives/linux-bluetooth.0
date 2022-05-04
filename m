Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiEDNPl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiEDNPk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 09:15:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250731DA79
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 06:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EB8B82577
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 13:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6546DC385AF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651669921;
        bh=hoN7OEOQbUIpkkO1fDoLkmcgsVUEDks4K4SwyEzL29k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H8H/XuwE3XX5lfD337sq558rEKSHeRWjWzn8q/ZN5NyrOM36buifMLK64DkP4skKd
         Q9AC6PI+XfWZHXqY4Pb/iaQuKapt9gxNnYae9gtvGICPL3ph+0E5SlQo31Vsb9wfGH
         pV8OqYHIapR1rJON6lskaHYoKlqAgpL7dX4qbJG+Kurg+cMRiQjVzvgSs+Ej3lBEXf
         vNHO1t65FftTqS9lJ2imZGJpP+/qqMFamJhmPRIberLqs7gEinNzWndATa33LIQ0RG
         InUAc0Z5xgXzYhYzfO2rF8an6ht3wPw9+v75Z+BZ9dMTGY7S+upKGfZW1TN7igSBMm
         qgTAXJeGn5ECw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4EE6BC05FF5; Wed,  4 May 2022 13:12:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215725] Basilisk X Hyperspeed Bluetooth LE mouse fail to
 connect under 5.17 with Opcode 0x2043 failure
Date:   Wed, 04 May 2022 13:12:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215725-62941-PKErHMWtIk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215725-62941@https.bugzilla.kernel.org/>
References: <bug-215725-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215725

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Luiz Von Dentz from comment #2)
> (In reply to Winston Wu from comment #0)
> > I am using AX201 wireless card (lsusb shows Bus 001 Device 004: ID
> 8087:0026
> > Intel Corp. AX201 Bluetooth) and the mouse stopped working with bluetoo=
th
> > mode under 5.17. 5.16 does not have such problem.
>=20
> Could you please attach the HCI trace using btmon -w?

Winston Wu, did you miss this, are you having trouble with this, or what's =
the
status here?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
