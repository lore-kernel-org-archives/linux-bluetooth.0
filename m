Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A14C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A8664F1B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355765AbhCDAdb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359121AbhCCNhf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 08:37:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AD79D64ED0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614761271;
        bh=KDx2/sp1SyetkmRJMkT9DWx4Tbi3YQd4p8eqw1lvD/Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AGx9yYmII8Rk57BFuEwU9zAzw1uHp2gXkXaOV6Zcdty/bnB2sOxONfdBGm0JBb+8y
         kgrtvncA0VLpA5oydOLPFQvPk7ceuT0LTS2/bPuEcTSCUpPO/Dsbq0PkbpTIraBChJ
         +i21LpNMZmoG9Bj7ULj77xpw4pSIanroCJdCAWbSxPAvRjMjn1WGBkm5cFk7jdRB4V
         cQF4NJ5Tpxf2vAKgMx5SloESSC5lDJPz92crlo3pm/cSMc9S1dWG3cvDsVyNsmNfzs
         YGs979z4KSGAdhhzyLP2wJyz37wzTVxaEpzjINMlru4Pe9qQ7iKevQ/ruFMuSJ3R3e
         E/vnBw/AwwR0Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208779] V5.0 BT dongle not recognized
Date:   Wed, 03 Mar 2021 08:47:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Ed.Greshko@greshko.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: IMPLEMENTED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-208779-62941-RlAbtH1pAq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208779-62941@https.bugzilla.kernel.org/>
References: <bug-208779-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D208779

Ed Greshko (Ed.Greshko@greshko.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |IMPLEMENTED

--- Comment #2 from Ed Greshko (Ed.Greshko@greshko.com) ---
Tested again with kernel 5.10.19-200.fc33 on Fedora and
it is now working.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
