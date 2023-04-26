Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F71C77B60
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 04:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbjDZElX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 00:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjDZElV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 00:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0816F26AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 21:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DDD6323E
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 04:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F11A2C4339C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 04:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682484079;
        bh=42j1m3ClBBUlnJ2/k/qkkDPrL2cYEJxhTJ6wOLFatx8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MmdWaq0A5F9erSgnLyx/VKf51P1rZAtIY/VDiciAKYBzj5N+UE0Zn1dBAnbi6wGxU
         XVWl+vWcXKEvlXwOe5sdsA3hly9wxF1bq1z4qb88OpovWhBw7W3tT4eNHSFWRbIVPD
         8wIwMMI8eMaUq59u/R1YQzaw2nDqMXh3BYLJVlmVoMzlgoJQ98Su4dplLpuRcX4ji1
         +F/LU06/sK8cUI4QH2fqpgdpS/lD5DTaMYaVEIU65JCetM5D/g1HNX+c6bBeaXjWj6
         NWg5nI0+sBXa8ogHnInYQID5kKRPTck7URN6DDL/rh3Pk9Yqu1v6iJvEdAJVvn9um/
         4oZXwbCNigS0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DD3CFC43141; Wed, 26 Apr 2023 04:41:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Wed, 26 Apr 2023 04:41:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: einhalb@gmx.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217023-62941-FaAiJSdTrh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

--- Comment #5 from einhalb@gmx.net ---
Same error on boot for me with AMD CPU und Intel Wifi AX210:

dmesg
[   12.374403] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.374413] Bluetooth: BNEP filters: protocol multicast
[   12.374421] Bluetooth: BNEP socket layer initialized
[   13.343660] Bluetooth: hci0: Waiting for firmware download to complete
[   13.343931] Bluetooth: hci0: Firmware loaded in 1275748 usecs
[   13.344049] Bluetooth: hci0: Waiting for device to boot
[   13.373944] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[   13.373952] Bluetooth: hci0: Device booted in 29263 usecs
[   13.374278] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0041-0041.ddc
[   13.382017] Bluetooth: hci0: Applying Intel DDC parameters completed
[   13.390994] Bluetooth: hci0: Firmware timestamp 2022.5 buildtype 1 build
38020
[   13.563429] loop42: detected capacity change from 0 to 8
[   13.623805] NET: Registered PF_ALG protocol family
[   13.791859] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[   13.802577] Bluetooth: RFCOMM TTY layer initialized
[   13.802593] Bluetooth: RFCOMM socket layer initialized
[   13.802605] Bluetooth: RFCOMM ver 1.11



lscpu
AMD Ryzen 7 2700U with Radeon Vega Mobile Gfx

lsusb
Bus 001 Device 002: ID 8087:0032 Intel Corp. AX210 Bluetooth

lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.2 LTS
Release:        22.04
Codename:       jammy

uname -a
Linux NB-1 5.19.0-41-generic #42~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr=
 18
17:40:00 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
