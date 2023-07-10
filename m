Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EBEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 12:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGJMOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGJMOR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 08:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35278118
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 05:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8734F60FD6
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEC06C433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688991251;
        bh=P2BdlTBaaLYtv0qzz8EkdqIOKVgO3wxNiWzAkWmAJPE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=imZ/O3KZQeIWIBzo27VIUrZVBHKMA2+uG6HLMuryx7+9MZNYHbstAkiTjKbQuq3Cm
         JdM3PJ9o1ZY00xpB+b9wSHIhbmF5uU8EDY/eQQ4vFi1nSQgT5EcmP9h/MfMd6G2zAa
         EJjHqF93/MQzmbQmBb+sK4Quq16b7gIGhRTc2m2ZUJ/QHTt4U5q2hdZnnVwsYlnUXO
         3+/8iL9Z2vTFtust8805SxwjEE7yUOdsJHlTZZtLtN3FwVIhMrgGPzCGtpaIde7F3D
         CYwelp83qUF4VzXCUaRORMyIF8wsStALkEgVO4SwMDnuTWGrxSpEytQsEGec5EGY8d
         P70g+acCTd3gw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DD7B7C4332E; Mon, 10 Jul 2023 12:14:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 12:14:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-aMBQJecDMp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #9 from johnbholland@icloud.com ---
(In reply to Bagas Sanjaya from comment #2)
> Can you attach lspci and dmesg? Can you also perform bisection to find the
> culprit commit (see Documentation/admin-guide/bug-bisect.rst for details)?
> You'll most likely need to compile your own kernel anyway, so read
> Documentation/admin-guide/quickly-build-trimmed-linux.rst for the
> instructions.

working and non-working lspci and dmesg output is attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
