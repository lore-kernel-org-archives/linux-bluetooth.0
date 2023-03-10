Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5016CC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 07:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCJHyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 02:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJHyJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 02:54:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE3DD597
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 23:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 130BACE1CEB
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 07:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6157DC433A0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678434844;
        bh=rI7bJvTvNnAngQog2LacqqzsoEVlmrBCm6kIjeyL9NI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bb7NAmm89e0OORkWftOIZF5SvYMeoDipdCDQzInB0a5yVoZNIdRJUoYO6ivPq58GV
         95RB1TgBzv5kQeecNVPNYuUp4w5rvXozjGjHB4k6pPqzwqqjz+BI7AGkRLGw4U0i9e
         ehCqv7TjjeD8BrFqUCQzURW8xQHZBBtHTkeo+y+sPxIoL26RHX2MICPoxb9Tjur5Y0
         W9LWk97RllaS3Mq9xg99fNmMoDPleB5yCF8V4afPw+Hlu+2Ih3UFNJsIIwBU4g2a8X
         H9wQcxy9SG7MoTbOIfAFA/J91qtN9SnyTkLUawigIgAhse7EQTIjpgMNNXR10ZT7lK
         vLLZRiLNGsLpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 465B1C43142; Fri, 10 Mar 2023 07:54:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Fri, 10 Mar 2023 07:54:03 +0000
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
Message-ID: <bug-217023-62941-w3ZcjKy385@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
@Mathias, please create a separate issue for the regression also attaching =
the
btmon logs with both Linux kernel versions. Please mention the bug report
number in here.

(Best would be, if you could bisect the regression. Ubuntu offers Linux ker=
nel
mainline builds [1], which make for a good start.)


[1]: https://kernel.ubuntu.com/~kernel-ppa/mainline/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
