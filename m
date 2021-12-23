Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 05:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbhLWF2Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 00:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLWF2X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 00:28:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D5C061401
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 21:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA1D361DBE
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 05:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20F48C36AEA
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 05:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640237302;
        bh=oIcDb87ehty1SuMnOmHFRIKHMBc9HToT8g9OSeMGC4E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=e2em7nvu3KGwBnC8GjHHnbWIQnaLhHGDz7hvY4KmZEqn5NY4rzzEH8s3sYC16ULom
         7J8B86y/5Irq1/odth/6dR32oH9zgs4DceGJihMMgodXN/liNgvQio/5pZkx9Ive9P
         1OFbTRLXVKtjEjIAxy/v7/gyroVGCrCkOzl8L2K2H/jDz2mNJZLuiGPCMRAXgPNzdu
         ZAUwecrOJKD9IGCHa9lA18Ia4RwSg0YK96RDSnLFbcvJWIWjBowhNw9cIb3/IhDTCy
         uNQ3BJbvsG43RSaHabDiHMiwifsAdjNPCJF6awF9kxOWWBmLEdfe0ckuzhuoYb0PUV
         BtromZGEH/BXA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id F24BB60351; Thu, 23 Dec 2021 05:28:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Thu, 23 Dec 2021 05:28:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-DgLn6xgXNI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #10 from Hui Wang (hui.wang@canonical.com) ---
@Tedd and Luiz,


Got it, will re-test with the latest bluetooth-next. And we didn't experien=
ce
the kernel oops with ubuntu kernel 5.13 and 5.14, this kernel oops only hap=
pen
in the bluetooth-next kernel, so I guess the root cause is not the kernel o=
ops.

Anyway, I will try to catch the log without the kernel oops (with the fix of
comment 9).

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
