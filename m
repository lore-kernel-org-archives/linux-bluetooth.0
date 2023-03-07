Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3DC678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 19:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjCGTgB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjCGTfm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 14:35:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC2C0812
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 11:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ECEF6150F
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 19:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 121E0C433EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678216939;
        bh=7XfBkRpk7mhTXl3NoZGoeYtzUuTgCjaVvaGcvFX+BKg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CG5JtkihDSBR9X/eEbucW9pR3cP2+baYt1c4xuS7HM3MvSKba2o+l18jxpPkCKJqf
         FOwP1gnbtiWHwaa68DMhxBlGmQVPf3j/XpeKl6JZNcbRZHIsMP3LRmh14FJyVEzGOR
         R5uWDUpxZeP8UXIB/OB3ovSHEEpBR00/f4beax/uVqmphbGWnqXdlIB5KFJD/VhJE+
         l98Zx45Yp1V23cZIQSnTNDQPBgkAZ/MvMKRfGOTKLKe6KPvL998krkZH/R8VnoQOLV
         m2tWjXG2oF7cq7qdOQmsysXydfLs5Gragjqdwm+SNDNF3kEC7QnDqkMRuBAToiNHvH
         v/I6L7iKtV7oQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id ECD72C43141; Tue,  7 Mar 2023 19:22:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 19:22:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217150-62941-kCihOhvHO1@https.bugzilla.kernel.org/>
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

--- Comment #8 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Smokus from comment #7)

> Have I done something wrong, or was it never supposed to work on 6.3?

It *afaics* doesn't even work in 6.2; it *afaics* only works with your 6.2
kernel because it uses an external add-on driver. Only the developers of th=
at
driver or those who added it to your kernel (the arch developers?) can help=
 you
there.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
