Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C68DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 15:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351502AbiCPPJC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356949AbiCPPIx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 11:08:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754433C70A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 08:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF395615E6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 15:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ACEDC36AEF
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647443257;
        bh=KJORzPmDRP5LVMEpt0bJx8ZpHFiKzSBYQ9hsUTWm4S4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HFwdqxz0m8Gea9qskgYxD1BSrcJM+T4Xfh+fiwhve9jQB54WimRQyU5SwyLj60zmF
         u7J6TqLrVXlUKm2HBuIqh6E5QQ1kR5tZnSiPL7de1dlNxZF+CrN3zBZ4No+PSBXATi
         ZgbpmMfmUECTVHP/9OpODxCf0/NxpjkbIJWMkxRh386qVRxb09yDYCTF7gVdOeYfTt
         I/LWJY2zvKGLrVEqA2f+jMXPguBfez1jKqGEY+mj6mCM8AR07+BFpgb8+HJWYusZ6T
         a2l2VwuvhTTB8zVYEBrPXsoO7FlXb5s5+oDThPTjuibcV38DnvFSqbTUVGBl5OfxO3
         +kyJbO988VQxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4B617C05FD5; Wed, 16 Mar 2022 15:07:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Wed, 16 Mar 2022 15:07:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pieroavola@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-kXwOHkfhCl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #31 from Piero Avola (pieroavola@gmail.com) ---
(In reply to Piero Avola from comment #30)
> However modprobe -r btusb && modprobe btusb seems to make bluetooth worki=
ng
> again.

I have to take this back. After rebooting I repeatedly see the errors when
trying this:
> Bluetooth: hci0: Reading Intel version command failed (-110)
> Bluetooth: hci0: command tx timeout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
