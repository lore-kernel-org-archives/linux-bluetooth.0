Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A775C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 09:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348826AbiFUJJL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348736AbiFUJJJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 05:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C49DD9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 02:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB5961534
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 09:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20DCFC3411D
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655802547;
        bh=bOJ2OdRdzVj7njBkQ7z1njBIAR6JWNBgXKvxpev1EPg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DTbIw7sSO82Ko6oa4TZXOmgf+RVLRZvIs7ZDN4TwgmVOlX562eyOoPqgX21CN4w7F
         KG1H7lQc1zcn4brlVnj69fOllQXWFVtDJ37/C1Mdo8YsF+yK9IjOhybvwMUov6jvUP
         jTl2TndHqh1uLy27PUf3mojrfBAI6ygutSdv8JDawfMN4ajCMBt2UyHExRR2ii995o
         6dR+Jt3LdYXUwkNWnRFj9z3/FgzRLlSs8aGcMQfor4ctq8wS7JEEEyTTsAA89/FbjN
         cvAYanDA3orshP8Tmum+nsn0ylT+tSm4rJMLqKDliLc8pXcqSDTpgBxqMpAbabGx7h
         v9UiAmjaAWd0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EE976C05FD5; Tue, 21 Jun 2022 09:09:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Tue, 21 Jun 2022 09:09:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209745-62941-DiI547WqRH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209745-62941@https.bugzilla.kernel.org/>
References: <bug-209745-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209745

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #28 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
> I didn't have the issue for few months (I'm not sure what I did back then)
> and > now when I upgraded to kernel 5.18.5 the issue is back :(

What Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
