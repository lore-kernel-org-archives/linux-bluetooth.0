Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED4C77B60
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Apr 2023 16:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjD2Qfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Apr 2023 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2Qfc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Apr 2023 12:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DB1BFE
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Apr 2023 09:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B6E60AB7
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Apr 2023 16:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6689C4339B
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Apr 2023 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682786130;
        bh=0FcJ7X02lMzIIfMCq61XugoZU1GglwwahuY18zpVzPQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IqaejQK98vxKFYS72L33h9dleMpmhhyCMexrfhwiNLzKHlwd1VbsuF3r4bANZVwj5
         3whApx4t9m4EAY8C9ukiYNJ6tmKjmbPGB/A0DCDBorUOWyLKthAoMozhmn9hx5TtQp
         xxlmTqaei8lGYRiy7baqzFDHbsUIWHvmqQm1MDbaPB7YbAOcECUjCEWRx8CFdiQ7tV
         NrxIm9KQtZfEAnOUws2kIcBgXQVx3PcQM3W0jWhXe3hSQLozn2VQ7nzwANMQWdrTeQ
         N+4/u19BLZdahh78Hxy91nfbjCnXq1+AdCDRk824bR9NFDuadf4aQSglws0Z3E/LRj
         a2D8NlhMf+TcA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8C18EC43143; Sat, 29 Apr 2023 16:35:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Sat, 29 Apr 2023 16:35:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jay+bko@jp-hosting.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216936-62941-HRxQIpzMhw@https.bugzilla.kernel.org/>
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

James Addison (jay+bko@jp-hosting.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jay+bko@jp-hosting.net

--- Comment #8 from James Addison (jay+bko@jp-hosting.net) ---
I'm seeing a similar problem intermittently, since at least 6.1.0 of the
kernel.

Hardware: Intel Corporation Wireless 8260 [8086:24f3]

(yes, it reads like the name a wi-fi card, but it does also contain a bluet=
ooth
controller)

Here are the oldest relevant logs that I have available:

Mar 23 21:19:13 kernel: Linux version 6.1.0-6-amd64
(debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld =
(GNU
Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 6.1.15-1 (2023-03-=
05)
...
Mar 23 21:19:14 kernel: usb 1-7: USB disconnect, device number 2
Mar 23 21:19:14 kernel: Bluetooth: hci0: Failed to send firmware data (-19)
Mar 23 21:19:14 kernel: Bluetooth: hci0: sending frame failed (-19)
Mar 23 21:19:14 kernel: Bluetooth: hci0: FW download error recovery failed
(-19)


The logs contain 165 occurrences of "hci0: Waiting for firmware download to
complete", and 9 occurrences of "hci0: FW download error recovery failed".

I'm not yet sure whether there's a specific series of actions to recreate t=
he
failure.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
