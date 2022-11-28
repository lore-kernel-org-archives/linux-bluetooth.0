Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E41C4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Nov 2022 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiK1SYh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiK1SYU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Nov 2022 13:24:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD2729822
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 10:14:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7101A611B0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 18:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF78DC433B5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Nov 2022 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669659258;
        bh=93hd8qldF16MselnW47zv+oXIH1NrBUwrx3K36HfEkY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BqtZ2+XR3+g6RWS+454VWUuDYvV73mRUyhCiosjYavYi9wJCe+46+RpXhfFzN7J53
         xLgrctpifl4Kz1IqCO4HC7kWC4TG6XFkSEeOEzqNZpy1X5QlaVmcp07yGiLol2MBGs
         Lrv8xJN/L3PZzZwmx4mULTJRxTKtsM7Mgeq0VDYwE8Rra6KlL/fEbBWJn/kDJN1ywE
         AAeJEYA1KQLMRFBQNkNJTdWbzqGHxxnj0FYR25r8hsP2UTvmG8x65RQOVK7vV8tEvU
         /dHfjn8JIrEintTT/9MaEuTYWV7fD0TgZ7QyO8SXPspzyzo5yJYcIAHZ10bjEjkaNh
         x7QooZC9DITbg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B9418C433E9; Mon, 28 Nov 2022 18:14:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Mon, 28 Nov 2022 18:14:18 +0000
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
Message-ID: <bug-216683-62941-h19XGaw2lk@https.bugzilla.kernel.org/>
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

--- Comment #14 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
@JustANormalTinkererMihir

Could you try something like bellow:

https://gist.github.com/Vudentz/0e0cb034a434e94daaf219f26f921aa2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
