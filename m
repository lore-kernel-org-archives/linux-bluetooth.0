Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E16C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 17:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiKMRWo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMRWn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 12:22:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CCFFADD
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 09:22:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CAE9B80CAD
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 17:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69B3C4FEBD
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668360159;
        bh=H8cPyCdeuk2nITB9GLeyXqrpuAiFkFd41XWUw0EMIhY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FugnNENUeU4MxdNO8HHXYoyW+f8k1st02RFAHq7CG1Rz3s0DiPMcPDmWu9AIFdAcd
         grRJSJEiLriLbH1HkEMTul0+2k+BF1+X+OXaknN1U1yyyY+RlgSJBEM6uUoYn+6rBO
         MSJMneD6Sqp9VSOdWEhKQPkbDH8JfvdrxKwswBsnO4OD4iQ2ZFPY6CBAndw9zJ7TXS
         5eNgBVKsl8r+GsoEGTezY8xSh1Ws/geVxdAvy+jXc71gO7h2hoqnGPEqgPaAzxpwep
         Q2NMe5GF4dr2ifQ/6MOshqh9a/8WyyjalJRuaWb7eBhWTyUYZn9c2vSrtCrQYvsLN+
         bP3n+7l3d+UnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B98D8C433E9; Sun, 13 Nov 2022 17:22:39 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 13 Nov 2022 17:22:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-eCbiYaWZNG@https.bugzilla.kernel.org/>
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

--- Comment #257 from JustANormalTinkererMihir (justanormaltinkerermihir@du=
ck.com) ---
It seems that these v5.0 bluetooth dongle cause kernel panic at times, Swyt=
er
can you unplug and replug your bluetooth dongle a lot of times and reproduce
this issue. I've made a bug report here
https://bugzilla.kernel.org/show_bug.cgi?id=3D21668 but just wanted to chec=
k if
you can reproduce this too

Thanks,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
