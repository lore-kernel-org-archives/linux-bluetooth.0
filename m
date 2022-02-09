Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EE4C43217
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 06:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiBIGbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiBIGau (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 01:30:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B48E05B1F3
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 22:30:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59CDFB81F1F
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 06:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D62CC340F1
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 06:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644388245;
        bh=WkgjiXhAY76l7hnxTuwVODvptO9Ja2eaP8RGn+xclkM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TYvfoM+y+ZJDl1bbU94H+MR4esWdBuBG/6ZFVAnx3GUbqbiA95L2q3cn3yYapuQMt
         GAVWbLsKnQ0NRdKu7XbR6Gcx7KNVPfSA4/92Hj7MR6FMUwJc0ZrY4C4qBYBMyo5Gcm
         1nJiPiTkmuJTzpRDzZq1GnRFIob1JLfS9UFC3yITYWqOPhutRCnjAESUG0KFCEmVA2
         S7xByr3g28quePGCILoo5Jq6QdMTYBJ4eMxyxI97boJSZN5gRkYMY0nS2T46BmmzYx
         74X9Rp7KE/RdAaG7ejh8k49U1DJJ8BuV40Ux7n12Q4XYiww0ghSX1pdFPUInPQB/Za
         tan1sViagAhwQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1DAFEC05FCE; Wed,  9 Feb 2022 06:30:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209745] Bluetooth connection to Logitech MX Master 2S lost
 after each reboot
Date:   Wed, 09 Feb 2022 06:30:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gochkin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209745-62941-KEJWWX3wYY@https.bugzilla.kernel.org/>
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

Yegor Yegorov (gochkin@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gochkin@gmail.com

--- Comment #19 from Yegor Yegorov (gochkin@gmail.com) ---
It seems that I have a similar problem, but on the 5.17-RC kernel. I have
Logitech MX Anywhere 3 mouse. It works properly on 5.16 kernel. I have noti=
ced
that on every repair to my computer the mouse changes its MAC address, but =
it
seems to be unrelated to this bug. On 5.17-RC kernel the mouse is working r=
ight
after pairing to the computer, but stops working on the first disconnect fr=
om
my computer (on computer sleep or reboot, on mouse standby or power down, a=
nd
on software disconnect from the mouse in bluetoothctl). The mouse start wor=
king
again only after removing the mouse from paired devices and repairing again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
