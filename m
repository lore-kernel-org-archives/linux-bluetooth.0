Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84EEC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 22:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBXWFp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXWFm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 17:05:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBD1C326
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 14:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620F0619D0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 22:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBEEAC4339E
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677276340;
        bh=x5tn8XpTiv591qn9w3xp3BwK/n2w4wT5SomgClM9nV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IgFGgxvVUqUfiuNZsPr4fSr4+MW3DbK04kBgBvoUHI6qchQecxYTIJDUcNTjC5Njl
         47ksx9mHnnb2y+s0zG/0EVyXQn2nntHK2DDY76oF2vYw6ofCRqVChi4GIxaLmrJ4sS
         TEO8EWj25Ge72vm6OBBqN84a2hwTOsfcR7GmcPZss6FtJv/Pb3Z64Un40hNx6laCr5
         nBHFmMgu3rBk+zjXUsIo9Doe/fBcMTFVesjksB8q0ymVep7IF81apKrZlnSn8K2qjF
         HJ8rzLXZfFx6OhRETyG3baMihL/RYPtCUmWH96nFCIqVLoLfyEvIzJ+SfmIwxZB+TL
         fHFx8cVbsD+TQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AD73DC43142; Fri, 24 Feb 2023 22:05:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 24 Feb 2023 22:05:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: olevenets2@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-kfS9ZfQSTQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

olevenets2@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |olevenets2@gmail.com

--- Comment #267 from olevenets2@gmail.com ---
(In reply to Swyter from comment #263)
> For those using Arch Linux, the patches arrived to the =C2=ABcore=C2=BB r=
epo yesterday
> with the linux 6.1.1.arch1-1 package. Your dongles should work out of the
> box again:
>=20
> https://github.com/archlinux/linux/commit/
> 42d7731e3e7409f9444ff44e30c025958f1b14f0
> https://github.com/archlinux/linux/commit/
> 955aebd445e2b49622f2184b7abb82b05c060549
>=20

Hello, I tried to build a kernel from the 6.1 branch that already has these
patches for my Raspberry pi, but it still doesn't work with my Cambridge
Silicon Radio

olevenets2@raspberrypi:~ $ dmesg | grep Bluetooth
[    8.232694] Bluetooth: Core ver 2.22
[    8.232849] Bluetooth: HCI device and connection manager initialized
[    8.232883] Bluetooth: HCI socket layer initialized
[    8.232906] Bluetooth: L2CAP socket layer initialized
[    8.232939] Bluetooth: SCO socket layer initialized
[    8.639913] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9 rev=
=3D3120;
LMP ver=3D9 subver=3D22bb; manufacturer=3D10
[    8.639963] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[   13.791472] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[   13.791497] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[   13.791501] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[   13.791506] Bluetooth: hci0: HCI Set Event Filter command not supported.
[   15.810307] Bluetooth: hci0: Opcode 0x c03 failed: -110
[   15.816711] Bluetooth: hci0: CSR: Local version failed (-32)
[   15.816732] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[   15.816737] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[   15.816742] Bluetooth: hci0: HCI Set Event Filter command not supported.
[   16.080095] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   16.080119] Bluetooth: BNEP filters: protocol multicast
[   16.080140] Bluetooth: BNEP socket layer initialized

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
