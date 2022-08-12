Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC5C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 18:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiHLSLA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLSK7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 14:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8206714D
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 11:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17BF761730
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80575C433D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660327857;
        bh=w1QP+QMd/u88/+zr6J+PBhn2Rj/8dJ+8oiaHoM9+UPI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aOIyKJxZNgCmP6RvV8wcgAo25S01YSHMckAi4caBPxH4jkdbw8Ov0MbJJa6/S4Es3
         4DJXId4Xrz0kO/KfGN4nL0ziN2/kbGrQF1tly1PerSBzCTCrseblpqLhadSurqICs7
         ycj2GGDu12YGVQjpISWzUfBwhW/oSpjBaiELrJOgAlZeOJjokfQhE1tJDXdr6gCmVM
         2hvmamSxtCGIpygbu/m4251GZythK3HcZnnvZwv7NPD5cE8wzzW0Ti9OpsXwEN0xzR
         T6CqSp/gpEZCBo3p5IjOV8zlz656Nybci6UI1IQXzR6A6pS5i/6ujC4IFpo25P3fJ9
         65rcXlFqs5nvA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6D197C433E6; Fri, 12 Aug 2022 18:10:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216352] [BISECTED] 250 ms system suspend performance regression
Date:   Fri, 12 Aug 2022 18:10:57 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216352-62941-afkYDnUxLs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216352-62941@https.bugzilla.kernel.org/>
References: <bug-216352-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216352

--- Comment #6 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
@Len Brown any chance to test with the above patch?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
