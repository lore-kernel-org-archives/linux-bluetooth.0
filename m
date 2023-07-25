Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D1FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGYUyO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGYUyN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 16:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB21736
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 13:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5919761648
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 20:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB742C433C7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 20:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690318451;
        bh=klz8lUzIz+CcDlwOwRp+BB4noft+zHlA2xjfvJL7PEk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GBFteSdmeIWI4pPjE8yvTQkk9T9/yZqgs192NRws6XMcsoXHKd9FDm6LmQKSNAOJm
         nde/Hetx5jM0X/81fENVWLTAN58UkUStQeJxnnJFl3rHfFRkIuhovztM5VvQz5O6NB
         aIpoN5GPY+ORbDzY4lLMh/sSg0gjDn1fZfrq6Hd/Guo//kHdf+8TLVf9Ea1t+AD+9D
         BuAdm1wzjQF13+v1N92EydVkTXspGV31V1FyCgSFKro2Kzy5CldNAZXSqA6sp3BXyT
         9QmSoLinzn+MsA94RhmgAc6302o99VIo6IsEW68r37kVFscOTsUFnrA9jHPPoFrvsA
         XcdqeZVWgOy3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 97908C4332E; Tue, 25 Jul 2023 20:54:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216819] kernel detects Mediatek bluetooth does not work
Date:   Tue, 25 Jul 2023 20:54:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216819-62941-NNgx9shjV1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216819-62941@https.bugzilla.kernel.org/>
References: <bug-216819-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216819

--- Comment #3 from jeremy (jeremy53561@gmail.com) ---
This can be closed, fixed with
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.5-rc3&id=3D13209415d0e88396d99d346b184864834d70d68a

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
