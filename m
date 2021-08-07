Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Aug 2021 21:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D8161042
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Aug 2021 21:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhHGVQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Aug 2021 17:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhHGVQq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Aug 2021 17:16:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F1E261185
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Aug 2021 21:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628370988;
        bh=uWnpNWnU3jR3r/T+DF6i+cUNpyyxW2Eys92sRRMc+X8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OimHVCfO7bB6Mui5NsT9QJlWnvDErkHToZxsLY3PKpJ+1gXwrpRA+AWybbzcrOq0u
         ekm0AaBjcuPwkO7R4bWXqS+gUnOOBorbOXtpPZjmlMPUpEuWRggRy/QCsq4+qPSl3b
         XpYW7eXQ3XCibCsjnhjDOIVUuDS/r540E5fic289xjKKOXJzO6sBmODoUJXsYcSTiV
         Ecy3dbr5R6Ee/FpnchKgiaIgpmkaJeV6ipNB9Y4R7KsTofwoO6zu8QmYDm7TvTU14h
         k0CZ1+kkubLjV1LLMM0Tj7ks4YH2UNxtHPPIDqgmOh32ZQK1levu+hvwpJW6Or1YyJ
         CK5T5Y89IhBog==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 07 Aug 2021 21:16:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: virtuousfox@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-yfhkknJGqO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #189 from Sergey Kondakov (virtuousfox@gmail.com) ---
Both patches applied fine for me on 5.13.7 using '-p1 -F3' options. My dingy
bcdDevice=3D88.91/LMP_sv=3D0x811 CSR 4.0 seems to paired with an A2DP heads=
et.
Haven't tested DualShock 3/4 gamepads though, ones that completely failed u=
nder
it previously. I'm not confident to declare that it's 100% fine but I assume
that it is, so I've inserted that fake CSR into my backup machine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
