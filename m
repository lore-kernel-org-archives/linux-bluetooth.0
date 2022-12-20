Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F38C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 03:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLTDZU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 22:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiLTDZH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 22:25:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B37E1400E
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 19:25:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19D46B80F9E
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 03:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9A97C433F0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671506703;
        bh=G+9a+/ZcXQPSCUhxCSMfqTB+AkPaUJwZ2tTLiMwRxcc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UyIiNGGQVlDTjaYeCjM1s5YIzD8kpLrGki0IFha5WX98QWQ8SShJUFfo5xYyIRWmn
         zFy1ah1Z7VNVaeRyqHxNoLIBCi5hi51bZjiVrPiCHl8lP62fMjmEoQUyL/40ZY8PYd
         ScFXwAyqhYpJRgBmoK9dn0Lua8okQtJIz9uBWTMKFpvwfJSO01+NrEvi7/and8/Yli
         szAO9BAt+Uw5YHkVFEKxKb0NVKMdo5bX8wB/aBagx8Nh0bz3hkrSkvVvi/7tLBM7ki
         zXzaTBP8aX+eX+8nu/AI0pPUhT5oOm18i1hhYvtPdBLwN+MLKAndNBxzH29WgTaYGK
         ioK5aYfaDClEg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B231FC43143; Tue, 20 Dec 2022 03:25:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Tue, 20 Dec 2022 03:25:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quantumphazor@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-Rd3xovqjt0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

--- Comment #6 from Andrew M (quantumphazor@gmail.com) ---
(In reply to Luiz Von Dentz from comment #5)
> Can you try with the following patch

Thanks for the quick response. Tried the patch and it has solved the problem
for me on both 6.1.0 and git.
I hope it makes it into 6.1.1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
