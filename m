Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95A9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 21:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiC2VGP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VGO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 17:06:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2211B6D21
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 14:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8811BB819B2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 21:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2718FC34100
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648587868;
        bh=8h+6+NIx8247vJkOkN4Lf5+hA+jhkekJ8FPPVcWhVlA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uhsQ2s5lIqYwbQqTcM27DVlwBMd5XO4oz5H+D7v8L3GqAAj/4IdMRopAwTVfq0CQk
         1OMpz18M4qb3waZV7a1YweQdrpPRXEEslUI3BLYyX2bpmnbyD6RVG/VrMiy86czY46
         7rftm3jXwRgP3ooCI8t9G3O3QLBnltnJQH3ygLJauYVVCxqmKGsbRb/22Vk+SNl6wQ
         KtaHgcRpGkej8wPBYgmDc+6Fc+WPvBpcPVCuU3ilXqHu3IpykIPgkAcfFN5gudeNDO
         xTEl9f2tni7DMTo0o3Rppg01uFSSwTgRZyFerC+JuHFLXnuATfkqfKcvSEDUH13GTC
         IzGkqeqq4luFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 16015C05FD5; Tue, 29 Mar 2022 21:04:28 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215725] Basilisk X Hyperspeed Bluetooth LE mouse fail to
 connect under 5.17 with Opcode 0x2043 failure
Date:   Tue, 29 Mar 2022 21:04:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215725-62941-K1NwFcW0jw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215725-62941@https.bugzilla.kernel.org/>
References: <bug-215725-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215725

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #2 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Winston Wu from comment #0)
> I am using AX201 wireless card (lsusb shows Bus 001 Device 004: ID 8087:0=
026
> Intel Corp. AX201 Bluetooth) and the mouse stopped working with bluetooth
> mode under 5.17. 5.16 does not have such problem.

Could you please attach the HCI trace using btmon -w?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
