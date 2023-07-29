Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB20C0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 20:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjG2UJW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2UJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jul 2023 16:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9935E7E
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 13:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4340760A0A
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 20:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97812C433CA
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690661358;
        bh=Pz+6+XTsOemN0fYjjj6XoVRU/Jt+lRZskZVCzars434=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q3zGJ2xIxShurXBzduCc9dR46K307C0+6293R77m56W2TB341XrBRkvUHUaVd2jEO
         d7rnSIOPI3cLGk0zf3Y95RnyXX/naAC2wwTxE3kNBFEkylsjKZCNTKWRWxAtrV7jlF
         vtOsXIFNMNBPIlNBW8ArD3cekdTy4zfHNDvIaC1TWjjyKlCX5QOlo8vZdeBzzvrQhe
         nwuJFKUaNhiT8/u5Hhm41tHYEtEmO3wUUegvwykPMOrT/8wAQVASpX2TOqnL4wp7n1
         kGcKLCBoSdoCOnDZBBQKAof3PJokATVyOrhSDmV5G7xJMminLoF1WIcBKSVeS6fG4v
         Eyxb/cPqpXM4A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 7FAD6C53BD0; Sat, 29 Jul 2023 20:09:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sat, 29 Jul 2023 20:09:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: espritlibre@yadim.dismail.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-t0Cxx1oTyY@https.bugzilla.kernel.org/>
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

--- Comment #17 from espritlibre (espritlibre@yadim.dismail.de) ---
sorry for getting back to this late and the confusion i caused, it's a busy
time... the kernels i use are arch kernel, according to the ArchWiki they a=
re
pretty much vanilla upstream kernel with some patches applied, but for the
current kernel i'm running i see no patches in the PKGBUILD.
i have been observing journal in the and can say that even though i'm booti=
ng
without being in flightmode but wifi turned on, sometimes

> kernel: Bluetooth: hci0: Failed to send firmware data (-19)
> kernel: Bluetooth: hci0: sending frame failed (-19)
> kernel: Bluetooth: hci0: FW download error recovery failed (-19)
> kernel: Bluetooth: hci0: sending frame failed (-19)
> kernel: Bluetooth: hci0: Reading supported features failed (-19)
> kernel: Bluetooth: hci0: Error reading debug features
> kernel: Bluetooth: hci0: sending frame failed (-19)
> kernel: Bluetooth: hci0: Failed to read MSFT supported features (-19)

appears, or:

> kernel: Bluetooth: hci0: Failed to send firmware data (-19)
> kernel: Bluetooth: hci0: FW download error recovery failed (-108)
> kernel: Bluetooth: hci0: sending frame failed (-19)
> kernel: Bluetooth: hci0: sending frame failed (-19)
> kernel: Bluetooth: hci0: Reading supported features failed (-19)
> kernel: Bluetooth: hci0: Error reading debug features
> kernel: Bluetooth: hci0: sending frame failed (-19)
> kernel: Bluetooth: hci0: Failed to read MSFT supported features (-19)

i played with bluetooth and the kernel didn't panic.


the last panic i got was 2 days ago and it went like this:
https://0x0.st/H2bz.txt (uploaded for better readability, no javascript nee=
ded)

i haven't tried 6.5-rc1, but yesterday i updated to linux-6.4.7.arch1-1. si=
nce
this bug is so annoying and they happen at random it's hard for me to bisect
and i'm not confident in saying kernel X is bad or good. i have set up kdump
now, which will automatically dump the crash. i hope this will lead to
something useful, i just booted the system 7-8 times but couldn't trigger a
panic.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
