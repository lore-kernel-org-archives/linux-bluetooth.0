Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877ECC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Dec 2022 18:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiLWSge (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Dec 2022 13:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLWSgc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Dec 2022 13:36:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EBB6250
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 10:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9935961D04
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 18:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 031ABC433A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671820591;
        bh=MDoBt0Xfe23uuUdhujvEyeAJajf3S9E/W2dNUEJh9AY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OyOFcoyY+L1IzQw4P+Qr6haJKE6CPJChZeEZEH2JOrkgPT4JVkEw7qS8VwBuDafGJ
         A61Ofc/ZKOBA3urEPhfkKHcvICAvWg78P03Rfe5TgVZoEOEbT9/5Y29pQ7VXw+ZS39
         Z5J+GhJB5+LnLtTWcQDDzOniXe5kqz7a0lFnViee/qXs3jpo8PeBAoWCgxjZdeHUFk
         WPEXriV3mC9G8b/9dk1gXWt1pMuJqEgbAt8IdtIm9OLIlNTU0abj/AcdUfBF7iMBXA
         VXXjarCE+R4mcv3cTnr6FEXMUcswU6UJtd9pDKpkH3OE8mP67L/E9xGJnwPYjtiZjB
         8ZphQ9ePW9Cog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E69E5C43141; Fri, 23 Dec 2022 18:36:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 23 Dec 2022 18:36:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-87LSm83Dri@https.bugzilla.kernel.org/>
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

--- Comment #263 from Swyter (swyterzone@gmail.com) ---
For those using Arch Linux, the patches arrived to the =C2=ABcore=C2=BB rep=
o yesterday
with the linux 6.1.1.arch1-1 package. Your dongles should work out of the b=
ox
again:

https://github.com/archlinux/linux/commit/42d7731e3e7409f9444ff44e30c025958=
f1b14f0
https://github.com/archlinux/linux/commit/955aebd445e2b49622f2184b7abb82b05=
c060549

https://github.com/archlinux/linux/commits/v6.1.1-arch1?after=3D56bc7b09f76=
40a2b6e974ccbb191693fbb25f4d9+174&branch=3Dv6.1.1-arch1

Some other mainstream distros may be in a similar situation, let me know ho=
w it
goes. Happy to see this going downstream fast. :)

[    6.711218] Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D9 rev=
=3D0810;
LMP ver=3D9 subver=3D2312; manufacturer=3D10
[    6.711226] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[    7.061122] systemd[1]: Starting Bluetooth service...
[    7.083941] Bluetooth: hci0: HCI Delete Stored Link Key command is
advertised, but not supported.
[    7.083945] Bluetooth: hci0: HCI Read Default Erroneous Data Reporting
command is advertised, but not supported.
[    7.083948] Bluetooth: hci0: HCI Set Event Filter command not supported.

Check your `dmesg | grep Bluetooth` out.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
