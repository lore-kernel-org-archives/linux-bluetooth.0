Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 17:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiGNRmc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGNRmb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 13:42:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8A9509C3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 10:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5908B82824
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 17:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3C7C341D6
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657820548;
        bh=PwKQqHNrOJCSZLPnu7Xg42W/575Z/Q3dee76cp44qxk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gxLZE6Ia82HJRfmuW4ZtyCKzinXHDXqGu1YNiPYqpt1kQeC0PoNRIqU7wEMa5YlEp
         feMwv02ckZAKG6Y4S+/bvQzAk2i47zaA+6ZZmAhMvGS/NbBgjnI0rsxTMcP/l8YS91
         XXgRTHRJbnMD/dAKvzQvFGk7XK7yiXiGIFMuzZDqhMBdGjC+8AsMFEEXM6EX/mJ0x1
         rgwOAbYOS8NU4vSRWIHHIJEO/rZyiocDbagzpIK0k1im4lbAgNPuQppu3UMklVhcKB
         mqxOsXqbaflYAwbPHTnOJcp5uGxoBOuH6PTF+rWQu1/S0du11FVHevRxGpH2htELKY
         Cayiz9vJURyxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1AB3DCC13B9; Thu, 14 Jul 2022 17:42:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Thu, 14 Jul 2022 17:42:27 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209745-62941-KwovyuWmfb@https.bugzilla.kernel.org/>
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

--- Comment #31 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
I think I finally found what is causing these issues when LL Privacy is ena=
bled
the controller requires setting Device Privacy Mode in order to accept
reconnecting when the peripheral is using its identity address:

https://patchwork.kernel.org/project/bluetooth/patch/20220714002236.3540353=
-1-luiz.dentz@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
