Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873DDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jan 2022 21:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiABVHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jan 2022 16:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiABVHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jan 2022 16:07:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44CCC061761
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 13:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D7A2B80E45
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 21:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24049C36AF0
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641157649;
        bh=nWXmjpcbSlD/w4X+RotyY4Fh+UATq/scDy8O6zhkSM4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s3UwzkPbDUpRzICEu8WxT/6LK2++UJW10B681XiGdYgoO8l0DBsAQLsCRw9mpcy14
         w5vd6Sln3cilleFuCM+cxbZ1VbcKlBeUCiKZYgC3Z4UTniH6zfNPayXAUVEydbbXOw
         XHMQ4Br72AFAPsFtjqskJ5oNoadAxVEVEEaWiWQ9VpVVP5UToPUqluw44lpUf1AnW9
         Bh6BtyopEs1VUszi3/l5InOVr9mMbrspjoWMGyZey4ekhGy2lICm510AftZ87kacs7
         6jvdYCUWZ6BJk4/k+rTps1td3r9pyJLI79e2VoqkATMNtzWaYmEhEmyLerPr5kuBG1
         jk+yjJWNlD4aw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 14734C05FCB; Sun,  2 Jan 2022 21:07:29 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sun, 02 Jan 2022 21:07:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fabiscafe@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-uOiZDiu8Zu@https.bugzilla.kernel.org/>
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

--- Comment #48 from Fabian (fabiscafe@mailbox.org) ---
(In reply to Paul Bryan from comment #47)
>
> As far as I know, this issue hasn't been fixed in the mainline kernel.
> Distro(s) are cherry-picking patches to address it.

It's fixed upstream since 5.15.5 or 6

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
