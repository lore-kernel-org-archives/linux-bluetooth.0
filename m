Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6253C001DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Oct 2023 10:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJVKLD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Oct 2023 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVKLB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Oct 2023 06:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F8E6
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Oct 2023 03:11:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D049FC433C8
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Oct 2023 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697969459;
        bh=LjxbONvt3jUctAeiSp2bgMVO2mLcbH+KDbw0E7NvqlA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HfaBbM1sqdUJvcK4ZPvJiuKKE+4kRZgUj1kw6HWRkWfzxAb3XYAb5hIxj4rS+ORTp
         wiumAcZZma5iQEcNVFszi5MOdb4/WppInife40j/pD8MZ7D1rG3yekPHIiZubjm2Ah
         Rdqf0sMpXxqRubWaRKA6kq0NO6/xV/rpWD+E/UTXslYpuM888DG4lpyh5vAPXqWW77
         WLhDgK51EtmXn4/t+niy7AG/+60Ryz5RwEOmFnFdgciZzjAdcGT9m5XUOgNDZjWXbq
         +ee0fs1ZLqoYTkO0sLMthXKRqFpNKxP5Wv0SyEgrwKRN/crtNNQT2huhrLbwnR5FsZ
         p8wcZ064pYfrg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BCEFFC4332E; Sun, 22 Oct 2023 10:10:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 218034] PC connection to smartphone, "telephone" connection
 failure
Date:   Sun, 22 Oct 2023 10:10:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218034-62941-iraEbr6Rpb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218034-62941@https.bugzilla.kernel.org/>
References: <bug-218034-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218034

--- Comment #1 from epistemepromeneur@free.fr ---
I forgot

chipset Intel AX210, Bluetooth 5.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
