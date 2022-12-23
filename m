Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A949C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Dec 2022 22:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiLWWdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Dec 2022 17:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiLWWdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Dec 2022 17:33:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C65FD4
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 14:33:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1444A61F84
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 22:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EAA7C43398
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671834785;
        bh=5DJnhZZ5q0r0m5gDnxq4taIFClsXFrAZ3jXpT/uq7RU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A/rI5fk2X81YoVCCuACRi1edXGdLOMDu2Ffprsu68gA5T5M5Oz59Hx8l4EGeglZWu
         7KjzmPw9YEWK4qrKVm3YO2+fYccWhc9BbYg5XCAGquVSh7K3Zq5u4S+GohjMKJTRJz
         eHvThPj3cdNH6COqOnYoHARNHpWF9TiDkDPDStXDd9lMF55lpGs4JsGTTa51QEq061
         G8t38Cjx3oi9jVG4AIcEb0oOfLaAF2QwYDC1KsIUZ1VmHEa2nlVu0WEOBJddlGvoCU
         SZ7NHFpmOwFbwTR9dArYCuyxfPPZMwCC7kkQtTc6xZbYOOMdt7AtypOd7aMyF+rmX2
         O/UgTEI1ExKIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5F4E0C05FD2; Fri, 23 Dec 2022 22:33:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 23 Dec 2022 22:33:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guimarcalsilva@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-VvgpMY362q@https.bugzilla.kernel.org/>
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

--- Comment #265 from guimarcalsilva@gmail.com ---
Let me preface this by saying that this specific dongle might be already br=
oken
since even on Windows it works but disconnects after a while. Personally, I=
've
given up on those fake adapters and ended up buying a good one, but I'll sh=
are
my test results here just in case it helps someone else.


For me, with this latest patch (On Arch with kernel 6.1.1-arch1-1) the dong=
le
still doesn't work.


When I boot up with it connected, btmon gives it an empty index:


> New Index: 00:00:00:00:00:00 (Primary,USB,hci0)


dmesg outputs:


> [    4.915236] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9
> rev=3D3120; LMP ver=3D9 subver=3D22bb; manufacturer=3D10
> [    4.915243] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
> workarounds and force-suspending once...
> [    5.466031] usb 1-5: new full-speed USB device number 5 using xhci_hcd
> [    9.953845] Bluetooth: hci0: CSR: Couldn't suspend the device for our
> Barrot 8041a02 receive-issue workaround
> [    9.953958] Bluetooth: hci0: HCI Delete Stored Link Key command is
> advertised, but not supported.
> [    9.953967] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
> command is advertised, but not supported.
> [    9.953974] Bluetooth: hci0: HCI Set Event Filter command not supporte=
d.
> [   12.086015] Bluetooth: hci0: Opcode 0x c03 failed: -110


Curiously, if I disconnect it and reconnect it quickly, btmon does give it a
valid index:


> =3D New Index: 00:1A:7D:DA:71:10 (Primary,USB,hci0)


And Dmesg outputs the following (notice the two last messages are different=
):


> [   79.189612] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9
> rev=3D3120; LMP ver=3D9 subver=3D22bb; manufacturer=3D10
> [   79.189644] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
> workarounds and force-suspending once...
> [   79.189654] Bluetooth: hci0: CSR: Couldn't suspend the device for our
> Barrot 8041a02 receive-issue workaround
> [   79.190111] Bluetooth: hci0: HCI Delete Stored Link Key command is
> advertised, but not supported.
> [   79.190124] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
> command is advertised, but not supported.
> [   79.190131] Bluetooth: hci0: HCI Set Event Filter command not supporte=
d.
> [   79.231713] Bluetooth: hci0: unexpected cc 0x0c25 length: 2 < 3
> [   79.231781] Bluetooth: hci0: Opcode 0x c25 failed: -38


This only happens if I connect it quickly after disconnecting, it I take a =
few
more seconds, btmon still gives it an empty Index.

Either way, the dongle doesn't work at all and doesn't even show up in Plas=
ma,
even with a non-zero Index.

I hope this can be useful.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
