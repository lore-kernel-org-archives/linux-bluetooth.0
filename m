Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 15:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355641AbiBNPKB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:10:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355636AbiBNPKA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 10:10:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72B4D9DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 07:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA0F6B810D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0501C340EF
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644851389;
        bh=o5xdBkoGhSvKNmvxN3lnpDSW0gJMfj4xtnW2CXNW/yQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SZ3ZGiVTSLWS/JnZvFE73T2lK2jCizQm8vGYtA7QvTpfR3d7nab74k/vg67zc3Y56
         9L3Notjx2ROJ01Oit/b2ULYXnd9FRMwTKMk8FgmhbAoYW3gmbywLpJjNjbPYjn2EL/
         qot31vS7nLUwbRhwqYmZmPmRoHdM7ZCS76UBAdK0IYiBaqqeuE5MB2RwKrsNcuYFUa
         3tVh8nZEO1pOGLtqeeyxNydrLahFwhQGRT+xX223dRV3bBmrYtK5V5dghjMYwDuqAZ
         SEktcdMVWBH4H/NEAqZFvh7TGpTGJaaqQGHA1mCSIssn2x9XKm+XHpmECtxDTb+LOL
         xK7GyuKDflCNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9903CC05FF5; Mon, 14 Feb 2022 15:09:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Mon, 14 Feb 2022 15:09:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wavexx@thregr.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215576-62941-8w3Kahr3cX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #2 from wavexx@thregr.org ---
Same regression on a mediatek mt7921e, so unlikely to be controller specifi=
c?
I also confirm that downgrading to 5.15 fixes mSBC.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
