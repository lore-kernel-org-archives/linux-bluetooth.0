Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB16DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B896660F51
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Nov 2021 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhKNLZa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Nov 2021 06:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhKNLZR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Nov 2021 06:25:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2EF2160184
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Nov 2021 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636888944;
        bh=yRSmr3NSvPNpsxnro2Qh8lFRQyU/TMScRL5y8wNtA7w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oWQ69vCgOa2xVp+5JLU/GauQ8BcadlOMG57mswKTicmREEvR1JbIh30KWjdYxVsS6
         wolZu7Yra4idk4M/FpwVQbHxuswVp8urD9esRr16oAfNCpIKX9EJqo4mQTaeUmFD1v
         2u4Jyej8A2HDw8QEwcIdYdnzGpLJltOqsC8GPDKPjE/iCH9ufjYXOkmLm9ZSdwxuhC
         Z4mxHhejQOpA8o4Gnte9YpUqP5Ls3NAqu+JvLFExt0YeImOWihCO1dY4LcJbGXb5zd
         xUMKjqWAZxeTVLBn891VTC8a2pu8nxgszYLbx0jMKwsKB0Lzp0C4VIYVKW4B99bn2d
         egnzP5Zy6mLgw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215015] rtl8723bs restarting loop
Date:   Sun, 14 Nov 2021 11:22:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: serg@podtynnyi.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_regression
Message-ID: <bug-215015-62941-kIUd9CRXhP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215015-62941@https.bugzilla.kernel.org/>
References: <bug-215015-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215015

Serg Podtynnyi (serg@podtynnyi.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |serg@podtynnyi.com
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
