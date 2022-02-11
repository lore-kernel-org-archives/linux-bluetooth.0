Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A66CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 11:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347607AbiBKLYo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 06:24:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBKLYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 06:24:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B3E5D
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 03:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72CAC616EF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 11:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB9C9C340E9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644578681;
        bh=E4hHUpZPzCLJql9Olb4RpG+ZOJ30xzqsSf8wtQ/2IJ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R52OTcGHjJyF4V0wauQctvii+/UU6OpYv/nIhSWkIgGC+I5sVHTu6ielZX9xYycoD
         oaJxWgOfbC2UA7+W0ymhjMCov6kaW6kfOP9NqpEw/XEd16Y5Oj16MaG5yfLvzOmVx8
         jfJlEcjYIpciqqk12inrkDdjB/6RO+A6f/uCDILGlEnDS2s9IZ+EXgK0SBaZUxB+An
         4ICOiE8tBP12YtxXRbxefVd26uymacxUKiwwQDA9kC5xxoFNYwDqEgzlihJvZt0f7N
         5Y088w4eJn5Zkitg5MrpEQ6Q1IrIUG4o1hzndAp06wMVgbM5yO16hkUz7nnd1xV1m1
         CpygUrPgdph3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CBA21C05FCE; Fri, 11 Feb 2022 11:24:41 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215589] Random bluetooth dropout after sleep.
Date:   Fri, 11 Feb 2022 11:24:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215589-62941-GHLfuNSJ7Z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215589-62941@https.bugzilla.kernel.org/>
References: <bug-215589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215589

--- Comment #2 from Marco (rodomar705@protonmail.com) ---
Created attachment 300432
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300432&action=3Dedit
List stack trace

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
