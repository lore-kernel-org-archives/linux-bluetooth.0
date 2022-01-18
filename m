Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1B4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jan 2022 12:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiARMUA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiARMT7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 07:19:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5364CC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 04:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05B87B8167A
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 12:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B11CBC340E5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642508396;
        bh=qUmS6h5gi37m/3ItUhvF4wLQy0IZ/Mt3He+f8ZHMs6U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aGsyCoMFgAgYnJ605yEMAJHUQPGkvdxgISE4cvHpjmrUiy9b+Wm/bmmqGHAbQsab6
         Lo8Es+3kV+Nm9JOYjyDE60K2yRcKHeOPHS/F705rs1atKh9Ns5rZ+5fjzZ3tAsWiCJ
         s9TIVLjIF6b5zn6W0MU7IuwkXNh8/Dkmpk1TO5M/nQPpwQoLhr3yA5oKrQW9X2pxK9
         uWr7OH/6TFWHQ9JkDQNqKS4tmzc3WpmZzDQTRiycKCHxaPrv8Rsyw856/a73cRG85D
         ILyYYPUlJna9VwQZGgFI+VR1oDpifotK5BHOkz4HnaBsSPQ5oybjrjqgHl0CR3XFo3
         19knz9My3+wMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0A84CC13AA; Tue, 18 Jan 2022 12:19:56 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Tue, 18 Jan 2022 12:19:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-VHBDh7epAJ@https.bugzilla.kernel.org/>
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

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #218 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.d=
e) ---
Second iteration of the patch *[PATCH v2] Bluetooth: btusb: Add a new quirk=
 to
skip HCI_FLT_CLEAR_ALL on fake CSR controllers* [1].

[1]:
https://patchwork.kernel.org/project/bluetooth/patch/4957ed07-36b8-58a0-230=
7-d2e6e2940527@gmail.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
