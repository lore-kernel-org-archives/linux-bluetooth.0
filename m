Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2C6C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 08:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiFMIga (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbiFMIgX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 04:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557391EC72
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 01:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBA5F61220
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43EF0C341CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655109375;
        bh=qpvFvh2wfWtecddaVf1b7LAOWnELMTIcuBCWFjT5ou0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UL9KGQoA62IeqJ2sHUz7hwv2HVgEtOOE9+gTEvyPSOaROGnfVlh3bQ0ugP9uiINbp
         n4yB6uLAiGYYKum9K7PyZWBgeNmOO6nLy3sjrM+sWVejbZosePGYZDwK3deuqDL8Jw
         Zqc9yEcVHpOKXt159b50+SapNMfinPGKwcXI8Q7HkgY7D2JWI4Nz3zHHIVWfCcoCkS
         JyLKMAb89qOFuq11uepzz3UrTdUXyHGBvcmjnF/Ug0bcv5Fo+5hT2Z3sscDEt+JMNR
         2StRy7yLgh4F0/2lcQx1rWQ/3EqjocntOeDjvLz5jejcXgNuQNv33P2JJ7u4RA8TlT
         gpaBdiRjfWVFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 326E2C05FD5; Mon, 13 Jun 2022 08:36:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Mon, 13 Jun 2022 08:36:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hyperair@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-crLt7UT6Pf@https.bugzilla.kernel.org/>
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

--- Comment #24 from Chow Loong Jin (hyperair@ubuntu.com) ---
Looks like I have `bluetoothd` running with `-E`, probably from my initial
setup of Pipewire's HFP/HSP stuff. I guess that's what the issue was on my =
end.
I haven't rebooted into a kernel that doesn't have this patch to test the
theory, but it seems plausible.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
