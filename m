Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25592C43217
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Nov 2022 23:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKZX01 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Nov 2022 18:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZX00 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Nov 2022 18:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC031837E
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 15:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB4060C6F
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 23:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79426C433D7
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Nov 2022 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669505184;
        bh=Wqx4jzLBbZ9+bzMaGdr/rrgp7xMmHA9lZ8mPm9JiirE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UPtpblBhrbDusT7qdZZ4BEavF9hdb/pRGK5QGLvfvRof2AvVU5KGTY4erO/xWHy5j
         pX/datmEU6n+Q53kdscxKn+sFQLf+7jlLybqmm/e4/LKI8+FHrBuvQakN3VvOTNEci
         oWrz526kdejcjsoMFGaNE03YFENaZ9QoENHzjIY9SOtMFPzkrOBh6xQ24+V0rFjZPy
         JnWx1n7q/BkaA35D28jySg3LzXQTmkDH4fVZPGpupGOs2r8/liDf4LUOFCNxGbEJf6
         i4zMqbzqbq7fofCT9XjHrHYUOeTmIz/rNbF6GI2zl7yr8wsebDOPahhN2pkOmvXaMw
         ZF8F8Sm1SfboA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 620ECC433E7; Sat, 26 Nov 2022 23:26:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sat, 26 Nov 2022 23:26:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-tvvWcDO0f3@https.bugzilla.kernel.org/>
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

--- Comment #6 from Jack (ostroffjh@users.sourceforge.net) ---
Per Comment#4 commenting out that one line does seem to prevent the crash. =
 In
6.0.8, with the patch from Comment #0 applied, and also in 6.0.9 without th=
at
patch applied.  In 6.0.9 (Gentoo sources) the dongle is never recognized, b=
ut
the crash happens anyway.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
