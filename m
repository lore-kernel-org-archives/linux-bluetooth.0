Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7CBC678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 15:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCGPLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCGPKl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 10:10:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F297B59
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 07:05:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15BE661265
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 15:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F3E1C4339C
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678201466;
        bh=DlcmFZCpEWuLWrx1ym//BU2ErBujZkk6+5qle8p3P1M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NOPQ9mlMUKB2RaRUzvDnd855HInDQFwHxIGxJcESdj5REAp807V2MpR+Exxyunw+D
         f4HB2dKCARAPJQ0DBamsrMvS4bUTebxDqJmXU+XlxMxU/q7YuaNGrSPH/3efDrWpKh
         kadpLJc/HrJYaygZAmZtNJT84HxcWm97rP5b9vmSTejgVEHdIHP45D+kz1bBTYPT4F
         RLRWEYbbzUHP3e5VVw9T/DTyl2G4FCBxIYIdOjZO2YgC+gzd6qt8FxZyEkJ4r02m16
         H9TyoPOPA0JDk1DfRdiq5naAX0Mjdg4ARynWBio6yfrrxYXjdnjQASwJyCb1s9E+go
         u+vFsLOA5fbaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 611B7C43141; Tue,  7 Mar 2023 15:04:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 15:04:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cmarobnjak@cock.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217150-62941-KO1e0E3jnW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

--- Comment #3 from Smokus (cmarobnjak@cock.email) ---
Created attachment 303895
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303895&action=3Dedit
6.2.2 dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
