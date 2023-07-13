Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E16C001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 14:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjGMOGL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 10:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGMOGK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 10:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF071FD8
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 07:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E1216153D
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 14:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7EBBC433C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689257168;
        bh=gcQgD0i3qmIZ5xvSlsU/tInMhd0j+E7N0WXsrHDpWVQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LOrCJs/Iv9gOAGaK1sxpDNATViGsLT/GzS+HdJW2LjnGTxINPg0TmgsLwPTzgvD+T
         d2u4iV55d/Azfu3ayogjlkJwhN+2RUyjslB6FG6/LoY45ChWLxdDmi2Q0s8jqSsDVZ
         MdpoDp8YM8/aLxEj/TGlPwntbY04cXiHQ66yM/euHhKhKD2TCJDt9k3CVOb1pQ1f+m
         rRP3LuhVtrOT4iL5L5FndvARpo1s7YyulbflHlySm23OrUDuAh/GqCWLEsirvu3SpZ
         JXCaGvJhWO+qhY4EMNpqxwCVQJuagoxx2vwNfTCF5v8u3E/qZrFTtyCV+J2nUBhkvO
         E+/ST9Zwo4eDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8C2CCC53BD1; Thu, 13 Jul 2023 14:06:08 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Thu, 13 Jul 2023 14:06:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-nQP7DS09rx@https.bugzilla.kernel.org/>
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

--- Comment #16 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to espritlibre from comment #14)
> i made some progress, i found the kernel version which introduced this bu=
g.
> good linux-5.19.9.arch1-1

Here you talk about a arch kernel, but...

(In reply to espritlibre from comment #15)
> sorry! forget what i wrote, 5.19.11 seems to be bad too...

...here you do not. If that's also an arch kernel and if arch kernels are
really close to vanilla, than you want to bisect between the two (unless 5.=
19.9
turns out to be broken on retesting).

Sight note: it's unlikely that 6.5-rc1 accidentally fixes this, but might be
worth a quick test.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
