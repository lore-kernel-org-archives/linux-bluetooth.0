Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiLLNvT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiLLNuu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 08:50:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB715A2D
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 05:50:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95CE0B80D56
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 13:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 542AAC43396
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670853007;
        bh=YpZCRqR0KfX4mdrAErPtr0iuwyDB1f0uvkfoOjLLsP4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NSSiroZxN4GO3gKikamaypxVfdfFCUEMGiSCCbjYa9UuEWO47G65NujdW+cKQUKua
         v3sVrGDLvVXSOsRlzmWpcIYDdzaukfv+aEPHRGjrmN/Qn6PvS6iPg/I9HVScCuOOv3
         Xn3qa496LRK2sLCWePwJig1QSqBiv5DitG3Ze1ve+FNO43Xonp5hpdZ0lVhBK01RFC
         XF5WEn0V6Omu6XhrUbMINaUudo1sdjTmtnnCKTh3F1taxsOj52H1nDkmMESgiH6M5P
         nZrjmKOihlMvcGnxGjUjBRvaKUD0yFVbYLH8AkEKpD7ge82BEPhGJ5Q8/VDEOIMTay
         L7ip1/Qe0XXVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3CC6DC43141; Mon, 12 Dec 2022 13:50:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 12 Dec 2022 13:50:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216683-62941-l7yB7RVhTF@https.bugzilla.kernel.org/>
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

JustANormalTinkererMihir (justanormaltinkerermihir@duck.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
