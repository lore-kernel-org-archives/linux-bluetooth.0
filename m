Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 17:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA0611C0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 17:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhKMR56 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Nov 2021 12:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhKMR56 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Nov 2021 12:57:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9DBD961215
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Nov 2021 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636826105;
        bh=WZ41dkGEpYLi2vCrZW2IckFPTea0CGOiBRM/ml42eEo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EihV2jEcgmmppIJRDgYQuw9KB+fkBLDwUKypeEa4FWb5KOxtsFOSqhuZC519QylZo
         XH0OlkywOGOYoTdoSBO+NqHbx1vKslJzww9atKDLEsTmGtRcmSmYpgb6WKTJ3tW7bI
         r6Rf6rFGb8KMSS8/g/IvyjNtNaz6tKrOSwmeZQjI2jpO7N6FvV0R7ZPokDmBvhS+hp
         DKF6HdYeKKMgAd4iOIfHy3J/NcJci36bjar0XeDe5sEZuYGZzU1BduKn4Gmr3Cu0fh
         KAVSKfX3VI6sSHQAT+zYZy+HFT+nociEbEyRJqpRRY80f6tnKykDd1joCQk3XK9bHc
         +CVpj9Fz7VMkw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Sat, 13 Nov 2021 17:55:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-vInPdCG4k3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

--- Comment #27 from Marco (rodomar705@protonmail.com) ---
(In reply to Guillaume Binet from comment #26)
> Alright, talking with Intel directly, this patch seems to fix it for 5.15=
.2:
>=20
> https://patchwork.kernel.org/project/bluetooth/patch/20211013080511.23945=
-1-
> kiran.k@intel.com/
>=20
> I have a bunch of other regressions like GPU hangs with 5.15 but at least=
 I
> see the controller showing up consistently warm reboot after warm reboot.
>=20
> Can anyone else confirm it works?

Nope, running 5.15.2 and now bluetooth disappears after a reboot. This hasn=
't
fixed the problem for me, it just changed behaviour.

I can confirm that the patch is present, I do see the message added for that
patch:

...
[ 2470.756299] Bluetooth: hci0: Timed out waiting for suspend events
[ 2470.756315] Bluetooth: hci0: Suspend timeout bit: 6
[ 2470.756345] Bluetooth: hci0: Suspend notifier action (3) failed: -110
[13556.607173] Bluetooth: hci0: Firmware timestamp 2021.39 buildtype 1 build
31878
[13556.611182] Bluetooth: hci0: No device address configured
[13556.611197] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[13556.611306] Bluetooth: hci0: Boot Address: 0x100800
[13556.611308] Bluetooth: hci0: Firmware Version: 134-39.21
[13556.611310] Bluetooth: hci0: Firmware already loaded
...

But there is no bluetooth adapter available from both my DE nor from
bluetoothctl info command.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
