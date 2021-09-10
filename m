Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 04:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E758F6113E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Sep 2021 04:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhIJEmx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Sep 2021 00:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhIJEmw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Sep 2021 00:42:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 55D576113A
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Sep 2021 04:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631248902;
        bh=1+FI6K7EuCTIxPsAUjjGM6OA2eabX15STnA70KOxNek=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HQIukAGJ/ZzX+mTlDyNj8/SVXtGhMxgbg+gHvIOVVciWaR8TO/clYwDaph13OVodK
         4emdZFKaxY2ywsrNdW+MNMuNG7ih+Y4AyTnuaiQqqsb4dlWczSAS+x3x6dV781SiBt
         GtgSdfeT8Ibc3lDWGTseb0OJzVzfmWjWpOgucOwyaETGfNzwzF1KnjMtPu14bUAQMa
         RZEyXu383uRiEj2XB309Wf5lk1TzA+UXE6UiyaH/XAsBoaxawhAURIHssKn5ugAS5h
         yM9+15PMU5g+4bozc4TsXwlmyLSgTvaai4+BqGTARSfv3IIWgJisqrFlb3DsLn9CJ6
         xZ745vyb2PBSg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Fri, 10 Sep 2021 04:41:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ron@cloudswarm.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213829-62941-xFtvYYu7vR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

Ron M (ron@cloudswarm.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ron@cloudswarm.net

--- Comment #4 from Ron M (ron@cloudswarm.net) ---
I have verified this issue is still present in 5.14.0 (and not present in
5.12.19)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
