Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D07C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Oct 2021 03:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357A0610A0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Oct 2021 03:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhJQDqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Oct 2021 23:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231972AbhJQDqM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Oct 2021 23:46:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 070A1610A0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Oct 2021 03:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634442243;
        bh=iOE2j9eBKEtmxfdUknp84N5WjMvkc6GRHGoACL6ZF9g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DYhHxR938/xbYAVCWrOjahRphUOX49Hk95LNeddPp4SCHCkafajLirYyEWuF6fz3b
         dB08HT2udD/CANDBmBAvvh77SDGKPvLrzYQDbfHvhV55hMGhJLPeKC8xV/W0gMfL4A
         skPfR3aHzH0witfdB1E/a74nAi2CVQSiuaREj2+Hwm2zfk4v5qcVuGlMYcQUtRfiMH
         Hzqa3XREe909t2uhMwVICIKfhAx84ed1avvbuv1H3RnCqQYKlKJfgUkiUqc0HpzR0C
         47cqWxQnxnAXuVgY2wxKUYcRs/VyEvMBICLSfpSekh2KIlVi03gLxRrNEQQu0n+XD7
         arU0FxLtT1Z5g==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204629] Bluetooth headset auto connected but failed to
 recognize as audio device
Date:   Sun, 17 Oct 2021 03:44:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: codyrude@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204629-62941-LE5E4fob7y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204629-62941@https.bugzilla.kernel.org/>
References: <bug-204629-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204629

Cody Rude (codyrude@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |codyrude@gmail.com

--- Comment #4 from Cody Rude (codyrude@gmail.com) ---
I'm having this same problem in bluez 5.62, which contains the commit to
provide more updated logging information. However, the original error messa=
ge
is appearing, which I guess implies that this is an io error and not a regu=
lar
error.

Here are my bluetooth logs:

> Oct 16 21:58:51 Neltharion bluetoothd[413]: Bluetooth daemon 5.62
> Oct 16 21:58:51 Neltharion bluetoothd[413]: Starting SDP server
> Oct 16 21:58:51 Neltharion bluetoothd[413]: Bluetooth management interface
> 1.21 initialized
> Oct 16 21:58:51 Neltharion dbus-daemon[414]: [system] Activating via syst=
emd:
> service name=3D'org.freedesktop.hostname1'
> unit=3D'dbus-org.freedesktop.hostname1.service' requested by ':1.2' (uid=
=3D0
> pid=3D413 comm=3D"/usr/lib/bluetooth/bluetoothd ")
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSink/sbc
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSource/sbc
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSink/sbc_xq_453
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSource/sbc_xq_453
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSink/sbc_xq_512
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSource/sbc_xq_512
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSink/sbc_xq_552
> Oct 16 22:09:46 Neltharion bluetoothd[413]: Endpoint registered: sender=
=3D:1.37
> path=3D/MediaEndpoint/A2DPSource/sbc_xq_552
> Oct 16 22:11:32 Neltharion bluetoothd[413]:
> src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free
> Voice gateway: getpeername: Transport endpoint is not connected (107)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
