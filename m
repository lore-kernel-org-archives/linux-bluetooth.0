Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C5CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 21:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhK2V4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:56:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47234 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhK2VyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 16:54:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 21012CE12F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EBE7C53FD1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638222660;
        bh=g9qMO5fRpsPQ+aA7Xgm6t27GSheNRarT0F+lxSFzFJM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=drbqS1PbNBFRKlLw7Ye3Q2slx+gtJYTvTq8zFApJT0FyXydtBZgVrdq6xkXGIBV2w
         f7UOe6fcekrX9UyBZS2iAgCbJdyG+Vpo8RR3PqWzoJdDvtyDUXWDfqNrUPFMib8ofS
         SFiLu1MDbcVFVIUMjpN6IoBXW9j3dN6RBkaOwKk6CEt06raMVrz9JWLQhihoTj+hMk
         MEgYAvuGW2BRcJbovQsvgz0g1MepMXwqkMiMKQy/PhwHMZ6gG0r8mqpvhVeJSSvNPk
         4E8I8TzrpMHKOa241Gt7QDVBB/VOf5nRvcD/wN61rlKadlTBGd9qcP6eeAt3KknLEl
         DJRZXW5VTiSzg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 34BB260F26; Mon, 29 Nov 2021 21:51:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 21:50:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tech@reachthetribes.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-xEo8REXD1K@https.bugzilla.kernel.org/>
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

George Olson (tech@reachthetribes.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tech@reachthetribes.org

--- Comment #2 from George Olson (tech@reachthetribes.org) ---
On my ASUS laptop also no bluetooth after 5.14.14 kernel.=20

Here is my journalctl after startup on 5.15.3 kernel where bluetooth failed=
 to
work:
> journalctl -b | egrep -i bluetooth
Nov 29 15:37:29 asustribetrek NetworkManager[780]: <info>  [1638221849.3430]
Loaded device plugin: NMBluezManager
(/usr/lib64/NetworkManager/1.32.12/libnm-device-plugin-bluetooth.so)
Nov 29 15:37:34 asustribetrek systemd[1]: Condition check resulted in Bluet=
ooth
service being skipped.
Nov 29 15:37:36 asustribetrek kded5[1774]: bluedevil: Bluetooth operational
changed false
Nov 29 15:38:49 asustribetrek sudo[3567]:   george : TTY=3Dpts/1 ;
PWD=3D/home/george/Documents/Tech/bluetoothFail ; USER=3Droot ;
COMMAND=3D/usr/sbin/hwinfo
Nov 29 15:46:51 asustribetrek systemd[1]: Condition check resulted in Bluet=
ooth
service being skipped.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
