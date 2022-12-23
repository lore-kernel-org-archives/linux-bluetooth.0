Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Dec 2022 18:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiLWSmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Dec 2022 13:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiLWSmU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Dec 2022 13:42:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE01F608
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 10:42:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0779BB8210A
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 18:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B761FC433AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671820935;
        bh=YwiVw6PeXZnaskbtiR6SnH5zDlxVPUm4J94pKP39Iek=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rqLGpeAFbrqEKhI4uOT1v5QOgjCDFhwWme+8g7wKguHgTgUmpZVg2kSBHz3NlUCNE
         /pjRoD1ivJU0HCiIs9D/CHvulUGBJb09cjWpRnxGvYqetWLSimGAWWIUBfJ0DW+/Gm
         cY+5hsK6ykdaw5P7IZqYAxZjjN2zM1tj2ziUW5Q43iYmR/HHRvzPebVvMSyhRyZH57
         wGREGT27IntrwWATZBjkTPNe/EZIGbiSxcS7Y4vWXlCX3MLyXRpFZLw3plrtB02kef
         Mxh8JEM2ie8B7VVwHqvnThs2g8GAB5H9aYq2NgIU0Rj1kqlxGm0n5OO5Czbqo9Olhp
         UziPxxTImWuEA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A987AC43143; Fri, 23 Dec 2022 18:42:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 23 Dec 2022 18:42:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yrds96@protonmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-FOR6l3ngRz@https.bugzilla.kernel.org/>
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

--- Comment #264 from Yuri Santos (yrds96@protonmail.com) ---
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
> https://github.com/archlinux/linux/commits/v6.1.1-
> arch1?after=3D56bc7b09f7640a2b6e974ccbb191693fbb25f4d9+174&branch=3Dv6.1.=
1-arch1
>=20
> Some other mainstream distros may be in a similar situation, let me know =
how
> it goes. Happy to see this going downstream fast. :)
>=20
> [    6.711218] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9
> rev=3D0810; LMP ver=3D9 subver=3D2312; manufacturer=3D10
> [    6.711226] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
> workarounds and force-suspending once...
> [    7.061122] systemd[1]: Starting Bluetooth service...
> [    7.083941] Bluetooth: hci0: HCI Delete Stored Link Key command is
> advertised, but not supported.
> [    7.083945] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
> command is advertised, but not supported.
> [    7.083948] Bluetooth: hci0: HCI Set Event Filter command not supporte=
d.
>=20
> Check your `dmesg | grep Bluetooth` out.

Can confirm. It's now working on my machine with Archlinux kernel
6.1.1-zen1-1-zen. I was experiencing crashes when plugging my usb dongle, b=
ut
I'm not sure the root of the problem. But after this patch I'm not experien=
cing
any crashes.

My `dmesg | grep Bluetooth` output:
[19477.778324] Bluetooth: Core ver 2.22
[19477.778352] Bluetooth: HCI device and connection manager initialized
[19477.778355] Bluetooth: HCI socket layer initialized
[19477.778357] Bluetooth: L2CAP socket layer initialized
[19477.778361] Bluetooth: SCO socket layer initialized
[19477.809618] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D6 rev=
=3D3120;
LMP ver=3D6 subver=3D22bb; manufacturer=3D10
[19477.809623] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[19477.809626] Bluetooth: hci0: CSR: Couldn't suspend the device for our Ba=
rrot
8041a02 receive-issue workaround
[19477.809632] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[19477.809634] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[19477.809636] Bluetooth: hci0: HCI Set Event Filter command not supported.
[19484.411012] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[19484.411016] Bluetooth: BNEP filters: protocol multicast
[19484.411022] Bluetooth: BNEP socket layer initialized
[19484.412616] Bluetooth: MGMT ver 1.22

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
