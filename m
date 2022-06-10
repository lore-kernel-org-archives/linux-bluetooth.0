Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5743C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 09:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbiFJJ6v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiFJJ6u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 05:58:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79BAFB3A
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 02:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20C1BB833C2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 09:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FE7C341CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654855123;
        bh=4VA4LNXn+oKqS168bnQpQIbB6tD5bVq7bOVroTWTNpY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fHK/0ezGBSFOfVPsJNYsP3DhSKtC3+nLqpsY5goImBqc3PSMqP7zYXHFQCcD94EaC
         y0bMSysrRq9OFsAL0VX+BdLg2TMUndelds5XNQYYoG1ZWaP8WzyEDlSGmA4q6+lSTP
         Sw1zT21rZkjGa1a9pjIoC4wVDdcTiHyEkj5t8GDRM2msAwQdzzfhPR9zgQi59LHyIm
         6hR0IDqtLqn3Ej8YcgwIubmY3a6sFTurboH0ySXQRmoms34dZYQvpAynG+I24go0XG
         aouJ93ZWfZUuQpnr8nw6OXhlA26Aw2Ul+fdUrlBipWblniE2JpBymMjMj8h/B+C0M1
         bhrhwrDYbUxtg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C391DC05FD5; Fri, 10 Jun 2022 09:58:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Fri, 10 Jun 2022 09:58:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: massimo.burcheri@gmx.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-Zh7pvisM2x@https.bugzilla.kernel.org/>
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

--- Comment #22 from Massimo Burcheri (massimo.burcheri@gmx.de) ---
Somehow I got it solved without removing IdentityResolvingKey with these
settings in /etc/bluetooth/main.conf:
AutoEnable=3Dtrue
Experimental =3D false
I guess the Experimental flag is important. However after restarting the
machine, the pointer device was just connected and working.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
