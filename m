Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Dec 2022 22:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLXWDg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Dec 2022 17:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLXWDe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Dec 2022 17:03:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F26563
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Dec 2022 14:03:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D5F0B80066
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Dec 2022 22:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C746C433EF
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Dec 2022 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671919411;
        bh=FPZXSaQN0/ZXBJY8r+RaSlnYYu++3/yiRl5KWVUyDEA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=spKMUW/n9hus1an1U9W1RHYYG4rnWxWTpMDyhBpzJa7XbifChCmO8k7WUkHlNUeQv
         Cg8AN5iSTpVmV2T+X0G7Gm3GsFqegfniOKuriqCuUwDmUqNhJyrXs6CYD2Qg9s0ay6
         PWwgxnb5XuWiqg6yV7Wv6cOxNujsa/iiE2cVBv+0phHEFCJfLwOVs4nxn7Dc5bSxdv
         4TgMYsxpzFDIHPpvoxfu5+32RtbNms0TymDSqRBfwW9NeNwXeRFjTzo3UhYWA53M3Y
         CofXDEvLbjQdJikT6EtOraiQDxqks381zGMKxpX40t2ESw3bf5M9NezKdb4Y/M9N7c
         M3GLdhRmjQP+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0B5BFC43141; Sat, 24 Dec 2022 22:03:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216845] JBL GO 2 only recognized after restarting `bluetoothd`
Date:   Sat, 24 Dec 2022 22:03:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216845-62941-ijCTGU8hcU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216845-62941@https.bugzilla.kernel.org/>
References: <bug-216845-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216845

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
```
[Sa Dez 24 21:32:00 2022] calling  af_alg_init+0x0/0x1000 [af_alg] @ 41404
[Sa Dez 24 21:32:00 2022] NET: Registered PF_ALG protocol family
[Sa Dez 24 21:32:00 2022] initcall af_alg_init+0x0/0x1000 [af_alg] returned=
 0
after 1 usecs
[Sa Dez 24 21:32:00 2022] calling  algif_skcipher_init+0x0/0x1000
[algif_skcipher] @ 41405
[Sa Dez 24 21:32:00 2022] initcall algif_skcipher_init+0x0/0x1000
[algif_skcipher] returned 0 after 0 usecs
[Sa Dez 24 21:32:00 2022] calling  algif_hash_init+0x0/0x1000 [algif_hash] @
41411
[Sa Dez 24 21:32:00 2022] initcall algif_hash_init+0x0/0x1000 [algif_hash]
returned 0 after 0 usecs
[Sa Dez 24 21:32:00 2022] calling  crypto_cmac_module_init+0x0/0x1000 [cmac=
] @
41415
[Sa Dez 24 21:32:00 2022] initcall crypto_cmac_module_init+0x0/0x1000 [cmac]
returned 0 after 0 usecs
[Sa Dez 24 21:32:06 2022] calling  bnep_init+0x0/0xc0 [bnep] @ 41430
[Sa Dez 24 21:32:06 2022] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[Sa Dez 24 21:32:06 2022] Bluetooth: BNEP filters: protocol multicast
[Sa Dez 24 21:32:06 2022] Bluetooth: BNEP socket layer initialized
[Sa Dez 24 21:32:06 2022] initcall bnep_init+0x0/0xc0 [bnep] returned 0 aft=
er 6
usecs
[Sa Dez 24 21:32:06 2022] Bluetooth: MGMT ver 1.22
[Sa Dez 24 21:32:06 2022] calling  rfcomm_init+0x0/0xda [rfcomm] @ 41433
[Sa Dez 24 21:32:06 2022] Bluetooth: RFCOMM TTY layer initialized
[Sa Dez 24 21:32:06 2022] Bluetooth: RFCOMM socket layer initialized
[Sa Dez 24 21:32:06 2022] Bluetooth: RFCOMM ver 1.11
[Sa Dez 24 21:32:06 2022] initcall rfcomm_init+0x0/0xda [rfcomm] returned 0
after 87 usecs
[Sa Dez 24 21:34:42 2022] calling  uinput_misc_init+0x0/0x1000 [uinput] @ 4=
1567
[Sa Dez 24 21:34:42 2022] initcall uinput_misc_init+0x0/0x1000 [uinput]
returned 0 after 112 usecs
[Sa Dez 24 21:34:42 2022] input: JBL GO 2 (AVRCP) as
/devices/virtual/input/input20
[Sa Dez 24 21:35:58 2022] input: JBL GO 2 (AVRCP) as
/devices/virtual/input/input21
[Sa Dez 24 21:36:10 2022] Bluetooth: hci0: Opcode 0x2005 failed: -22
[Sa Dez 24 21:36:10 2022] Bluetooth: hci0: Opcode 0x200b failed: -22
[Sa Dez 24 21:36:12 2022] Bluetooth: hci0: command 0x200b tx timeout
[Sa Dez 24 21:36:31 2022] input: JBL GO 2 (AVRCP) as
/devices/virtual/input/input22
[Sa Dez 24 21:48:47 2022] Bluetooth: hci0: Opcode 0x2005 failed: -22
[Sa Dez 24 21:48:47 2022] Bluetooth: hci0: Opcode 0x200b failed: -22
[Sa Dez 24 21:48:49 2022] Bluetooth: hci0: command 0x200b tx timeout
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
