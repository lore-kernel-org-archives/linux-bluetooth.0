Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADA6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 12:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiI3MJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiI3MJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 08:09:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333E16EA83
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 05:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9744F622AC
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 12:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F148AC433C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664539750;
        bh=cvMaqRB18tjUF3CwaF7k/DR2IENyupljHJm5xJRlBBo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GioEnL6VL9XuZ8n2nCtH9c690C8Z4xFHGr9Ldv5hGzmsPgN15sV0wMzhUfBCLORme
         osA6k54hadWiVX7AQ5Cq08iGQk4mHZkvk2ftPqH1MFoAtJcu0x5l4e/hBis8jSEnZM
         i/R9TQh5Q3PSFR1fx4LFfuBLPCjRW0dgs94jLWsV9NCBKdoof9JjxRjluTgV5sy9Yj
         xxIIFA27jmKR3CNStDkTOk3C3cH/gNyIxGrc6iRXgXc/UnO6mAPVNE+cssWiPj7qHO
         j8+4usuxaLoCmvSBduYSQMjWBrbDS4rthO7OeRP7jsveOH1YQOp/cg1yk/OkZESQ2M
         +W4MHuMgASWqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D87E9C433E4; Fri, 30 Sep 2022 12:09:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 12:09:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216532-62941-pPBrQSKYhx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #9 from epistemepromeneur@free.fr ---
I forgot

pipewire 3.58

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
