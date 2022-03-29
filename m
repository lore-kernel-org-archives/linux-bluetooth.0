Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34750C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 20:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiC2UXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiC2UXh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E59E23C0CC
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2144D616E2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 20:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80951C3410F
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648585312;
        bh=sPTdxomtpuCKZ6e80yWT76k/nOM2heeN+SnCAW1hixw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RgdGuKUgc2QAU3Xu58R+qrDOteQk2o1qCJ/Lxpg5m3ZjHjGHgrFC4EL7FC50XSEmK
         q9VGPpgkju/RPRiY+sBcP4oz5+YvkuAB2WNryJ+dSWMdHXC0XwT/E71BVp9yLIjwCw
         F1npZo0ZROnQJrzfWqf5AVxp3A7kNQe/3SLkXJ1WBsh7KSpYbX+XMrj0IP+/20MjAN
         lVMU7HfX6ywqSNFNrlokfRuPPMr0//Smoe20oidd6asG+KIG7n0uG5gUoMINW6XZg8
         LSBV1LzWeuLAAVU5TdwR4qQplVKqRdejr3aiIhX1grzWKmpEf8WJgLONQNNTJLFUG6
         Hwzq+bH3nXOVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6D957CAC6E2; Tue, 29 Mar 2022 20:21:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Tue, 29 Mar 2022 20:21:52 +0000
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
Message-ID: <bug-215576-62941-uU5fYjm5qC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

--- Comment #10 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Posted a new series about this:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D627309

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
