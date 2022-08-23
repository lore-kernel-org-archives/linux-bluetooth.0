Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDAC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 13:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiHWNR5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiHWNRd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 09:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2813CF90
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 03:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8E8460FDE
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B21FC433B5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661249766;
        bh=jDr/uI4wQlb3yPn6jy8vYBrH7TzatBD2PLQqt+j69nE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iJw+HV/4VRxkvjsMKCuGAtbObiPUdjMrGp1UQvq9VSeI7v8sijK+f+LP/p/OxO4w9
         AW0By270EbRu4rSK+FDRVIthqYLS7dDPPlxdliSr5fbf2pQNiWkauJHkmvMIeJIZWN
         6WuYqZJkxXxqXKsoIDEI4MAwYvsM6OBJF7AubA7XXwjlYbjJEMGGPr79ABiUN2JsTR
         t+j/YGh5QO+9vYWTNi/IpgYcQ82+DBIfAfFz7jXUDxY3uKElkvAXoWAeWj/Kteu5W7
         vQsxlpum+y+LAM9GZv4ienDN4fBT1GVNj2p5mQgJx+WHhpACs30a9t2g/KSiey6Spa
         1Zu+O/uwuzt2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 26CCDC433E4; Tue, 23 Aug 2022 10:16:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215768] Kernel 5.17 can't suspend while bluetooth is enabled.
Date:   Tue, 23 Aug 2022 10:16:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Krzysztof.Krason@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215768-62941-5uv8tuFo4h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215768-62941@https.bugzilla.kernel.org/>
References: <bug-215768-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215768

--- Comment #38 from Krzysztof.Krason@gmail.com ---
Reconnecto to BT devices started working again in 5.19.3 for me (probably
5.19.2 would be enough because I've seen a lot of BT fixes there) in 5.19.1=
 it
didn't work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
