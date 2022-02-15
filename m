Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 21:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiBOVwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:52:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiBOVwD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 16:52:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A29EB31B
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 13:51:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23B94B81D11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 21:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7B95C340F0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644961909;
        bh=cYGZM/8mbz/GiXqVesHx41OouvKj30gvRgmlEtRluuU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ti3pglyyEDJMANA2D0OG3rgm52WrF4aeIavElq11zYAu/ADSEH9yv2xoeKDf5vX3Z
         8tpH2HsY85fsdTeSiln3q+BFxGIsbwX3bMYxsikozU2neWraE7YiiEEyfLHQBzyVRI
         TissBJH7BwtFpuzAfQY5wFUFwyltTOOEor4D+aq+RBk4JRAvX1u0BJCw2IPlTKVWHV
         ZFmL/torb+0hm83Dyte2eLwqDKBmgjTWJ+5QW/S2QQ1DSE72Badwsm+/PYrNoQm6Kq
         Yyw3Ko94IFf3gNfvcaWA1sUwQYDhY4JmV6t07RUsW+P1kwlVv8UPplOp7AbVXLapQb
         3AyM9QF7yd2yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A878EC05FCE; Tue, 15 Feb 2022 21:51:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 15 Feb 2022 21:51:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215528-62941-AHVw3S8dAg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #11 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D2d4b37b67cacbbad6fdb8621333f5ce48ae0e5fd

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
