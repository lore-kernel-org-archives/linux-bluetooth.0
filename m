Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FEFCD6E7F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 15:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjJKPfP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjJKPfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 11:35:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7D398
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 08:35:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF7BFC433C9
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697038512;
        bh=py+qlTe+/nJG0cKgBue4BnYNZmPRYbVN638rBi0IHKI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qgvmj04SlYL0bI/E7YqlAF4DdBgNQXpwxpIO36Ij0Zz8SeeCU1WhgUwUPdqdYos86
         tG9kPNWE+QQ9TOBUmefDGaIvo8sfKHJLplcqPlhMTauL6xAuOQQpGp48Pc0fROA2kN
         ZhMcW25merN9lBJiPf2y04MPs3fuKhBvsgOLK03Ql0W+5xas3pCaHvhmsGFc7n1Bbl
         mjHWRDYVnVeGnUBxdcPjPJSs1utbw4mXCVanKcjMhS6FuLAbvRPRysn+53406yvCCV
         P1KMGfh9X+TQd6lSQ4qUFM/FMvC+oKUOEzY/P1wMA4+e+K+o7gPr/yDNRBq4WQK3vJ
         zOApexti3Y+pA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0E29C53BD4; Wed, 11 Oct 2023 15:35:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Wed, 11 Oct 2023 15:35:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.rodolfi@tuta.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214111-62941-6DqKX0fYpE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214111-62941@https.bugzilla.kernel.org/>
References: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

--- Comment #11 from Marco (marco.rodolfi@tuta.io) ---
New firmware available here, BTW.
https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drv=
s/2023/06/e2278f13-95a3-48ad-bcc9-5506763c2b79_bb3aa78b80786fb50d13e9e7af5c=
b6c1e8b809f3.cab

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
