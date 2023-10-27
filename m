Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BBC27C47
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Oct 2023 08:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjJ0IjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Oct 2023 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbjJ0IjC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Oct 2023 04:39:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD81BF
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 01:39:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9804EC433A9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698395940;
        bh=ol7//XjYgYvbJBUKViX/+r5q3ScbxGW5DccQ1USE/As=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ORv1RbCDCZKUmReJPvJHUBwXK7wqIrl5TsULi944QNuksvm+bABzLpZA8zeesndQy
         eQvnZcJy+wHexx3Dpgx0o1rZ0e/a+SPos57ANUYsneYIISqH4bkMgsVITC/TYe5hpO
         GWNojmLxb3fSu9n/YsttKX9bSHDBiKvkk52OnmxokFDRWruDhcLny3Lu+h1Cp6L2Wb
         bHNEOFD3t9LTCnNAONQOGrsUN2iB1pthBYzrkgB9Jqn5bO2/hbMADr8o3Q7UW11E2F
         hiZNhCUp4e1LFOubEPKiHI//HAjsD2m3znFGW9T0SwCNjD+6IE5GpLecJRWWRK7Mu3
         U2UDLtiNWUzgw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 88FC1C53BD3; Fri, 27 Oct 2023 08:39:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date:   Fri, 27 Oct 2023 08:39:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-80791-62941-JiweH5aJrD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
The issue has now been known for close to a decade.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
