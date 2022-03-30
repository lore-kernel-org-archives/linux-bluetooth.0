Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F13C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 12:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiC3Mac (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347995AbiC3MZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 08:25:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4452A5A9B
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 05:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2B07B81C44
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 12:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E6DC34113
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648642205;
        bh=RHjKuZgfLXcdcMXox5wi8cti/X57y1JOW1918I41mT8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qrymoXJw+nao2VIgqvIJkTa16EUSLVJKBsRWpa42KdQpmdqnonyN1B5Ub9ZX/ADJb
         MlwnM6ovbK3Jamk47rCJxZNq/w5PUYQ1VvQdd0SPXATKip5+h9/AQ22Dow8xUDd0eT
         OwRWcEVoVrwvhlAvTsbEepY2i9h70tt8IuTmRI5t4kruSHbZ2mMdSgt0LlWsq+6l+5
         IvB8QW59AlcSClhO9AWbFLlU3301TIuwe4SFqAfWkggYA4HBLrPHMFLaznPetPf3Nc
         /k+ic8eZUantjNW93xrswic4aFjVFOsiuTiPTd5KDoa/cJJi9vULlnfgBDkWIJDlgX
         3V/g5Lgww4Nqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 322F9C05FD0; Wed, 30 Mar 2022 12:10:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215425] Intel Bluetooth: hci0: Timed out waiting for suspend
 events
Date:   Wed, 30 Mar 2022 12:10:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215425-62941-BWaC3sesMq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215425-62941@https.bugzilla.kernel.org/>
References: <bug-215425-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215425

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Looks like this is fixed in 5.17.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
