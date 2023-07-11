Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A8C001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGKOtC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjGKOtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 10:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F07C10D2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 07:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9547961529
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 14:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F156CC433C9
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689086932;
        bh=K9v7YLB9PAUAgHqp3LlCNwYpvKW8mR+mQY3SXvlCm1I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E/PeZdMi4cQHuN1MGxE9eWt8pVyw69n6Ks6URKuYMfVpqc3IjARdTCNxQdhqZSahM
         NHfrDzrfyXugzyHhd16GXNo6uXK68owgNi7ALW/eOF3+Yf6hA36tC4QnyOQ+8CiTCt
         eJKbcrnTrND3hkGNcLIzNE36UWEu67DKaZK4A4fRmkpCK6/uM0AQJruJmhvEuu8Vhl
         7QtPmBsXnvTdqbO9NTtSrOhuKFI+Ao9aw55VBaC1YeQ5f4eOPxNsd/zKYwhZLOYsZ+
         lehodQBXmdkXCmGNDaWcq+yp8lPIwB2I3ubMkQVuOEQpTfvi1F0DGxADTMx/6W1Bu3
         2VS8U3K2WWwQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D8E14C53BC6; Tue, 11 Jul 2023 14:48:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Tue, 11 Jul 2023 14:48:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-fruyyHgFrl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #13 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
https://www.kernel.org/doc/html/v6.4/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
