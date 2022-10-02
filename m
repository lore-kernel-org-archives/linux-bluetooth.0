Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Oct 2022 04:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJBE6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Oct 2022 00:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJBE6S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Oct 2022 00:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2F4B9B7
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 21:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB16B60C1E
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Oct 2022 04:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BA63C433D6
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Oct 2022 04:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664686696;
        bh=Eb4dgPBcYMlqE+InIrJpkwutGKf18Nxv92XZGkHdhiY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lDDFMuLn5F+a6f+mSNF8/TE0fTpDvaB3Iyp28VdqUX0ZhZnbEedptyEtTMh8giQeP
         lO+8zG83DMuwvTgeiFRRvGLiBQgMTQk3y9FW4rQGJppQfI7fUnQ6wlR3pCSU51YYsO
         3mse+G1kqIb3xCRjL2W4+YmhRPfZxH+E8DeJ+nv2aRzPf4PoeF2zUnMeAuMmLuYXbi
         v1ad2c0SCu1YD8xheqR4CiN7yGAfVSTc0CCqBUisjW0+w9XOOaMmqVxqWmoI3XhOHg
         RLk6ObcEz42dZtzzO+N442o1YsxJffupu5x2Ya1XjZXZ9SDDGVLNBoPvO5jN9Z6xBg
         h/w1Fp/CoH4Vw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EAEBAC433E4; Sun,  2 Oct 2022 04:58:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216546] ( ID 1131:1001) Integrated System Solution Corp.
 KY-BT100 Bluetooth Adapter fails to Initialize.
Date:   Sun, 02 Oct 2022 04:58:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ivalin1996@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_severity
Message-ID: <bug-216546-62941-UhpVQRrSDY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216546-62941@https.bugzilla.kernel.org/>
References: <bug-216546-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216546

Zetta1 Reid0 (ivalin1996@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Severity|blocking                    |high

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
