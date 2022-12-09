Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71050C10F1B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 11:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLILaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLILaA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 06:30:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A161DA44
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 03:29:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FB17B82868
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 11:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 534F3C433F2
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670585397;
        bh=NqHLET32f0iBWfcm98WTL9n+2+bjE/b2HteLQ7U7KnE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PDAxPx8Pcls3O6xyWJLMSbMrckrFx1TBdSt+D67XvbwvlwbMy7gUJXyKQSvH2PTz6
         WMEb/kN5pfwd2UhoNmYlWMIvbiIWTQVWCOeX5eeQyZfmhx1XSeQoyfh39N+VbqPqXY
         MHsh9i1sI6ucQ6LTy0081VWWlbex0jMM+CBp931qHur36ro0YVm6RBZJ9giTBOWl4K
         BQpd0yPRkZHji4Kic2TrO+4raUfLSud8gIfyz3F3BZcvLrytyo4KhiZQRc+tgs9V5z
         AVfj+UWg67PF7IQzpLnyPqU3rBnF8vVDjiUq/VAdvT2a0NjwyqDphPVr6Pj2oOKOGj
         Ty+BZJBpDrvbg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3EC2CC43144; Fri,  9 Dec 2022 11:29:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215197] Memory leaks show up when using Edimax Wi-Fi N150
 Bluetooth/Wireless USB Adapter (RTL8XXXU)
Date:   Fri, 09 Dec 2022 11:29:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rtl8821cerfe2@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215197-62941-UKBVDAycXg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215197-62941@https.bugzilla.kernel.org/>
References: <bug-215197-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215197

--- Comment #11 from rtl8821cerfe2@gmail.com ---
Thanks for testing. Can I say "Tested-by: Erhard F. <your email>" in the co=
mmit
message when I send the patch upstream? And also "Reported-by: ..."

I'll remove the goto because it causes memory leaks with the RTL8192EU.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
