Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986F3C3A5A7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiLBApZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLBApY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:45:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8209AE16
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:45:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACDC621D5
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 00:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A958CC433B5
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669941922;
        bh=7CkoJiCEPuTeNvqrVcefftge1c3k2D0/KYpetPqyzCU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OhyTa+N9z6h8vRMUWZt0mt+QOH59251TRbfZONIG6Abokvo8cqKFf0btQzaJhO60y
         VEmzZS9T61HCRYUxt9MZMkJcrdwjqXJpDp8NjDmOOfd4+WwyEYWkpLSLiD0ZItA9qE
         v2HAqR7AxDHn7t4Fg22HEPddryLR5cUj1vRTW20/clUW9dw58o1nuBrWxcdPo1vsMo
         4K60Kjh+3SV4xkG0B9S5qF+zSj9ZJvN7ak8UH4Q2Cstkgq9xZEoMj4rWSm3dcLPQhO
         xeijhtTNuSsUb2n/tDJNku6HufylZpIZxbPBXH7fqXREC8ajL7BPBQXhDb/3tGLIYU
         +o0slD69twZrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9319FC433E4; Fri,  2 Dec 2022 00:45:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Fri, 02 Dec 2022 00:45:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-qivqJMCBME@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #20 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Daniel from comment #18)
> I also need all four patches to make it work. However, after a sleep I get
> the following in my dmesg output:
>=20
> ```
> [32332.754468] Bluetooth: hci0: command 0x0405 tx timeout
> ```
>=20
> After that I get the following repeating:
>=20
> ```
> [36431.813695] Bluetooth: hci0: command 0x0c24 tx timeout
> [36431.813705] Bluetooth: hci0: Opcode 0x c24 failed: -110
> [36533.323814] Bluetooth: hci0: command 0x0408 tx timeout
>=20
> ```

Your controller is probably in a bad state, perhaps something like hciconfig
reset hci0, anyway this is probably no related to this bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
