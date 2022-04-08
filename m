Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Apr 2022 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiDHVmM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Apr 2022 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiDHVmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Apr 2022 17:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C06369
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 14:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29BE262075
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 21:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80706C385B5
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649454004;
        bh=5S8ve6HFPRbaHK96dLm6ZZcbob1ABg8qkHbMNvb0emE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bzh7Kad8Zpi3bpwotw2Pt+6Tr7Kkyx2bGsn2wjtDjjwk+SZg9VOwFIBDMMg1oXTbH
         N7hGungpp3uHUHw09KZ+RnqtGKfpEwqh1Ot1b9sVlR9mFD2b8+RJFmadEzkcquMwgd
         jyjlukN9wtARvuqtqoQhQUR6ZOZXvT/QrVydwGth+hyOKhxDR4puDPw8t8J9ypPNsR
         gljzMbfcInO05pHJ52dXJ32BOEf5owx9IdpLz6AEqw6CCNhH3Wit7DfWlIQKsyD7dk
         4nk1nzV7GFHcrz3GqQRcsImIf0LGzDX4tyFSL+uz7xJI4qBPZKD/dwRYmpR9SVtYg+
         /8heuWN6jyXfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6F930CC13AF; Fri,  8 Apr 2022 21:40:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Fri, 08 Apr 2022 21:40:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bram@vandenheuvel.online
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-kfltIgfSsD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Bram van den Heuvel (bram@vandenheuvel.online) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bram@vandenheuvel.online

--- Comment #33 from Bram van den Heuvel (bram@vandenheuvel.online) ---
Another occurance on 5.17.1 with Intel AX200:

> Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: Core ver 2.22
> Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: HCI device and connection
> manager initialized
>Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: HCI socket layer initiali=
zed
>Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: L2CAP socket layer
>initialized
>Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: SCO socket layer initiali=
zed
>Apr 08 23:19:05 ArchFrameWork systemd[1]: Starting Bluetooth service...
>Apr 08 23:19:05 ArchFrameWork bluetoothd[1198]: Bluetooth daemon 5.64
>Apr 08 23:19:05 ArchFrameWork systemd[1]: Started Bluetooth service.
>Apr 08 23:19:05 ArchFrameWork systemd[1]: Reached target Bluetooth Support.
>Apr 08 23:19:05 ArchFrameWork bluetoothd[1198]: Bluetooth management inter=
face
>1.21 initialized
>Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: BNEP (Ethernet Emulation)=
 ver
>1.3
>Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: BNEP filters: protocol
>multicast
>Apr 08 23:19:05 ArchFrameWork kernel: Bluetooth: BNEP socket layer initial=
ized
>Apr 08 23:19:07 ArchFrameWork kernel: Bluetooth: hci0: command 0xfc05 tx
>timeout
>Apr 08 23:19:07 ArchFrameWork kernel: Bluetooth: hci0: Reading Intel versi=
on
>command failed (-110)
>Apr 08 23:21:35 ArchFrameWork systemd[1]: Stopped target Bluetooth Support.
>Apr 08 23:21:38 ArchFrameWork systemd[1575]: Reached target Bluetooth.
>Apr 08 23:21:38 ArchFrameWork systemd[1]: Reached target Bluetooth Support.
>Apr 08 23:21:40 ArchFrameWork kernel: Bluetooth: hci0: command 0xfc05 tx
>timeout
>Apr 08 23:21:40 ArchFrameWork kernel: Bluetooth: hci0: Reading Intel versi=
on
>command failed (-110)

uname:
> Linux X 5.17.1-arch1-1 #1 SMP PREEMPT Mon, 28 Mar 2022 20:55:33 +0000 x86=
_64
> GNU/Linux

lsusb:
> Bus 003 Device 004: ID 8087:0029 Intel Corp. AX200 Bluetooth

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
