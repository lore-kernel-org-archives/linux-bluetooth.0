Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63994C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 02:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLBCqk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 21:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiLBCqj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 21:46:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBEFD2D82
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 18:46:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65709B80139
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 02:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B770C433D7
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 02:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669949196;
        bh=gFYfVNbbzxdLmwO96qmX3gVQ+0fvK9xPuNO2slldoBM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e7Wcxz98Wi5z/1s0bUuEKFCDSD1hgRzm6x1/8NfM6mWvuVJ+ZGMhjIbMTXGdUTbKt
         4VBfO92qEnB/kn0ges09irx4WGXyG7cmJ91B4aQCiohehZShrMlS1DP8UbekxFFF/U
         dVh2ddAtIRidmN52Tl/F+faT4McnghaDghS/Nre+QqTDRHPOgCWcmHNeZbAWYZGYs/
         tlc+uILedM2Fb9eNRvehMyCqjyhJHBz7YlpOzORQKzCk6/n866k52LBt49fJmHx+Mv
         5XbvYIEAE8OtwXMKzzkzdblsraq2RTnZb5PGwoA7CGIHDQUdmc39YWdtOr+fP5YVV4
         njWVPjsz1vUBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 134A6C433EA; Fri,  2 Dec 2022 02:46:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Fri, 02 Dec 2022 02:46:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-kihiluYgHn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #21 from Jack (ostroffjh@users.sourceforge.net) ---
(In reply to Luiz Von Dentz from comment #19)
> What patches are you talking about, are they already in bluetooth-next?
Apologies if I wasn't clear, but this is getting too confusing.  For this
specific bug, there is really only one relevant patch.
I am confirming no more crash using your patch from Comment #16.
The patch your mention in Comment #13 is definitely in 5.17.16, but I don't
know which version it actually landed in.  Commenting out one of the set_bit
lines from that patch also avoids the crash, but your patch works without
removing that line.

The fact that my dongle is only recognized if I use the set of patches to
revert the regression regarding the cheap CSR clones (I can't easily find t=
he
other bug number) is probably irrelevant to this bug, and I mentioned it on=
ly
for completeness.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
