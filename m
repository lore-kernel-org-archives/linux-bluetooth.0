Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF9EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 12:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGJMNu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGJMNt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 08:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A828BA
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 05:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD3660FD4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41056C433C9
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688991228;
        bh=gsGrB6nZQe/R/w+eVkSJBjXiARbGDHb67aF824gQwYA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jev0KML7J07uWp7f82xEyAaZPU6wQrT3IOfdKm8WSdr0KEN59M0ExZ0k8d+ZGWskk
         txjhn14uzy4rOCepjxev7w11wo7JvFOj+7t4U22K+NNdZ05ARIjZBPA0TyF9P81zA0
         Xb0oBgkW0h6yn3aVi1JPzOimQ7JQtWQaND6//AJizXYyDYfnB8kB3ZFdXb53lFlX4y
         e+UMWKM1HKDICGf8B9P2sa7NHX/I8+O5MK04D/zTyYjmAqv9qjuwm+5enfljgokuYx
         bex+Lotx+O1ZUjzyIB4eSTMp225qMakAqn0c3ioSKbsHRpo+T1xL5EeVHPiFFCRo5b
         9+4qcb5f6fmVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 188F6C4332E; Mon, 10 Jul 2023 12:13:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Mon, 10 Jul 2023 12:13:47 +0000
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
Message-ID: <bug-217651-62941-JlCuHGapxl@https.bugzilla.kernel.org/>
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

--- Comment #8 from johnbholland@icloud.com ---
(In reply to Bagas Sanjaya from comment #2)
> Can you attach lspci and dmesg? Can you also perform bisection to find the
> culprit commit (see Documentation/admin-guide/bug-bisect.rst for details)?
> You'll most likely need to compile your own kernel anyway, so read
> Documentation/admin-guide/quickly-build-trimmed-linux.rst for the
> instructions.

Hi,
I installed 6.3.9 and 6.4.1 kernels from arch archive and found that 6.3.9
produces working bluetooth and 6.4.1 does not. I will look into building and
running from mainline but that may be beyond my skills.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
