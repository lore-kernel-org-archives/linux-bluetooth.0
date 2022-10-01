Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E137C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 18:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJASQt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Oct 2022 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiJASQs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Oct 2022 14:16:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB1312AB3
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 11:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3609B8076C
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 18:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DAF3C433D7
        for <linux-bluetooth@vger.kernel.org>; Sat,  1 Oct 2022 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664648204;
        bh=SZ7pNUTkXfbCFwx60vU2QaY8EOt+3OPdYkcmfWdOF8A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FDNYmtMcoKcmnb1kYTdxfIMbUEpY/RRPp1y/2gHsuvNjk4qQ0lTfjLQ0uVl/yF7jN
         YAEM52ub909SdgzIxgOI5sVwsFD0totcudXiRgJXj/fsOWzS9wqrhdoq7ddljk8Cz8
         mJ0f8qq51lUITr/H15Z/awu/F1/eud9OikK5AqubWGY9G6hXPHXCDb6e1Iu/+1mpBh
         pCoksMXkJOFCoJCv3c9sp0fEjjH/FBmkYk9mkhwuUMw4H8JuoQvi10Z37aguL1fW8s
         p01Uc3MwwwRqqNd1EwIDDG++7j+PyVH1tGcBHq0yn5Sqss8MmW3D5OhiMguZoUPZEP
         cWemQU9gu8phg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4C769C433E4; Sat,  1 Oct 2022 18:16:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216546] ( ID 1131:1001) Integrated System Solution Corp.
 KY-BT100 Bluetooth Adapter fails to Initialize.
Date:   Sat, 01 Oct 2022 18:16:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: ivalin1996@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216546-62941-MIyeCQfajA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216546-62941@https.bugzilla.kernel.org/>
References: <bug-216546-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216546

--- Comment #2 from Zetta1 Reid0 (ivalin1996@gmail.com) ---
Created attachment 301938
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301938&action=3Dedit
Patch that fixes the bug.

This patch seems to fix it, and bluetooth initializes properly.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
