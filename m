Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67BCC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjE3NsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 09:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjE3Nr5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 09:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B8133
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 06:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C0063086
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 13:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B73C7C4339C
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685454463;
        bh=Y16D52cSljItkkYPPZC8Ajrk+RHpuEjDOhcSvd5upYc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=II08JVLGmAH1zKEuwuQNxdL93F7rkIeAUV/ae9MH4iPR02vGqOvOFB6H7jWHNOXH4
         rvIn2kzF9HmfLpoEz68syNgzZIDVrmVKGsQoczVm5281tLfX0wqEes1vVUEv9XnVF3
         DyLujiEhbqvHHrlyPSL4fYz+y/YnKzcXSUBhumxwD4WUl8gNBBivBoqNnZHZV6WzGb
         WO7iD6xxmJLOKVgGwnwCa5KJ/Vk/CWwD7e/BKhQxYGkH2temxXqgvAIfQKMdGv5N6j
         b5sqVBK5VSZhm9BqCeOCrffJF94zM4tZ6+ejXokuBF+ivhPRCefhn547v6sCD9Wrky
         E5kgD67ulEJIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0098C43141; Tue, 30 May 2023 13:47:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200007] HP Elite Presenter Mouse support
Date:   Tue, 30 May 2023 13:47:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.morandini@polimi.it
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-200007-62941-j5qJYyA2A4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200007-62941@https.bugzilla.kernel.org/>
References: <bug-200007-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200007

marco.morandini@polimi.it changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |marco.morandini@polimi.it

--- Comment #3 from marco.morandini@polimi.it ---
See
https://lore.kernel.org/linux-input/eaa51a28-fe4a-a41f-040d-93e7a32d0a1f@po=
limi.it/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
