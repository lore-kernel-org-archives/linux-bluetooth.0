Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F169C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 13:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiKMNX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 08:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKMNX5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 08:23:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59861092
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 05:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1375F60301
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 13:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 648CBC433D7
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668345835;
        bh=zhFbAQAclv0RxjuuFPSK/T0XDf10+MwZP15/WiP7wj8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C9Zegf0Wy4BNiwMfFES/p0VZMFzkqwwQA1945fDDH+AwR6k5OjvkQ7u8Fg38MjiSL
         W/Ma3RXsiMLmcZrMYMoY35GPnLwL3y75xgyjkYmvSzmBW+aqsEcRZWTKEHZ3E7mbWI
         E0rIvZg5YBKXpwUVYUCCsUAu+jJY2FoFPwJJihnpUKJAAdu/N6p8fnksHFZkZDy8Lp
         U07aJuV5nBtzpq/3nV8smtL+6Ilnk+MgDDYxhEx8OwNFB5TzsXS1VDahRALJKgsCMT
         VpECwRGf+ZCxZEPOQdbAGoPb8A0Rrd4K6LEKlX+6twaybGRr65pRhoVVJU9jP7Tva8
         e0a5ULz9KSYtg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4EB55C433E7; Sun, 13 Nov 2022 13:23:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 13:23:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-216686-62941-PMZMueIy5i@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

frc.gabriel@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #303162|0                           |1
        is obsolete|                            |
 Attachment #303163|0                           |1
        is obsolete|                            |
 Attachment #303164|0                           |1
        is obsolete|                            |
 Attachment #303165|0                           |1
        is obsolete|                            |

--- Comment #6 from frc.gabriel@gmail.com ---
Created attachment 303168
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303168&action=3Dedit
all kernel messages from syslog

I'm attaching a xz compressed file (via bugzilla), I hope that is okay.

This file contains all kernel messages from syslog (grep kernel
/var/log/syslog) from the past 2 days containing a bunch of oops for these
versions:

2022-11-13T06:31:12.982846+01:00 computer kernel: [    0.000000] Linux vers=
ion
6.1.0-0-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-7)
12.2.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP PREEMPT_DYNAMIC Debian
6.1~rc3-1~exp1 (2022-11-02)
2022-11-13T07:06:50.955682+01:00 computer kernel: [    0.000000] Linux vers=
ion
6.0.0-3-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-9)
12.2.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP PREEMPT_DYNAMIC Debian
6.0.7-1 (2022-11-05)
2022-11-13T07:55:59.669994+01:00 computer kernel: [    0.000000] Linux vers=
ion
6.0.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-9)
12.2.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP PREEMPT_DYNAMIC Debian
6.0.8-1 (2022-11-11)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
