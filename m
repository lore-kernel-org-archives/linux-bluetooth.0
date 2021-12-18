Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Dec 2021 06:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhLRGgY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Dec 2021 01:36:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38356 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhLRGgX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Dec 2021 01:36:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76D2C60959
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93B3C36AE0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639809382;
        bh=bQpMtqE1FvVTqBQOrJ/jzNU4JddFML6hloyghLnMGlQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BBB9OrA4iHZjMPhV94J8NwTMoOCs8jtbMuZROuvJKiz6OuAEVejefSrGc98MqUHlq
         3tMx8jtbyMho+bpxaIm8DL3UkNSpyO+ryouK0uHbbgIWYE9XTtc9HQUAXdqq3y3yIE
         wNeluSi4Uy3ILv1rWmyDSmN9v+O1r/9Gedl8mr0GESUwCh+TlHzXK9pgqL+sEx/aYo
         RFgyPTJe9eQTZOIYc9jt97LtEZG4ZyDdwnPoCLIuam2Oz2CT8CBf9EKmWy0BO+IESR
         QN4WgqZ0BNBI+Yp9AuWphTlwvbmIFq0bKCGIaCvUhkX0xr3FqxFHgvFarc3oBg9K+L
         IyyQEgHuPIhZg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9F6AD60F55; Sat, 18 Dec 2021 06:36:22 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Sat, 18 Dec 2021 06:36:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-H2321OTBdp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #6 from Hui Wang (hui.wang@canonical.com) ---
And if the desktop is not gnome, we could replace "gnome-settings->bluetoot=
h"
with a command-line "bluetoothctl scan on", so the test steps are:
- boot the system
- open a terminal and run 'dmesg -w'
- open another terminal and run 'bluetoothctl scan on' and wait for 5 secon=
ds
- run bttest.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
