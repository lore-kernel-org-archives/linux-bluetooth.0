Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C03C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBB960FA0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhHBVtb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhHBVta (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 17:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B882960F9C
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 21:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627940960;
        bh=yUeg86chpFaZB6i0pSaoDG6obIJVhLEoUpRmxJCKuek=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jWBs4eITHK3+KQHpnDbF4y8yBICbLUtkJVuZxWu7O3LaF1G6vfp3kQ7Ve6YYIVg69
         RUvq6X7u8tuSGr4hHC8VChowBD7EI53uJ1sz9xZQDoucszgKGhBWdJ+PP7Hs85ZyDV
         jT8X4BnSZ3fjfDdqDl3Oo2ZitZsbPIhp8fF0G2PfrSPKMZIzxMO1TVzrmG0yY4Nr+4
         WCCSbPH6oRez4s0jUW1oLXRP/r83nJWmKAI/I2eQllpuFO+j3IvKs/s5RaBmt0wlWf
         HVqFVdYG9ESFqoM520+qK7fGaR2vqJyDhVw8Jsikofxgox9U1n1NFW5QLC0mmhAXnT
         FF+vwVif5HUdg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213369] Bluetooth Will Not Enable Intel AX200
Date:   Mon, 02 Aug 2021 21:49:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tomek@kolosowscy.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213369-62941-BUGgslcSzJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213369-62941@https.bugzilla.kernel.org/>
References: <bug-213369-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213369

--- Comment #3 from Tomasz Ko=C5=82osowski (tomek@kolosowscy.pl) ---
No, dmesg looks clean

$ sudo dmesg | egrep -i 'bluetooth|firmware'=20=20=20=20
[    1.276885] i915 0000:00:02.0: Direct firmware load for
i915/gvt/vid_0x8086_did_0x9b41_rid_0x02.golden_hw_state failed with error -2
[    1.353260] i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/kbl_dmc_ver1_04.bin (v1.4)
[    1.398367] i915 0000:00:02.0: [drm] GuC firmware i915/kbl_guc_49.0.1.bin
version 49.0 submission:disabled
[    1.398376] i915 0000:00:02.0: [drm] HuC firmware i915/kbl_huc_4.0.0.bin
version 4.0 authenticated:yes
[   11.400827] platform regulatory.0: Direct firmware load for regulatory.db
failed with error -2
[   11.786671] snd_hda_intel 0000:00:1f.3: Applying patch firmware
'system76-audio-patch'
[   11.945138] iwlwifi 0000:27:00.0: loaded firmware version 63.c04f3485.0
ty-a0-gf-a0-63.ucode op_mode iwlmvm
[   12.856911] Bluetooth: Core ver 2.22
[   12.872636] Bluetooth: HCI device and connection manager initialized
[   12.872640] Bluetooth: HCI socket layer initialized
[   12.872643] Bluetooth: L2CAP socket layer initialized
[   12.872649] Bluetooth: SCO socket layer initialized
[   13.386729] Bluetooth: hci0: Firmware timestamp 2021.19 buildtype 1 build
25171
[   13.388842] Bluetooth: hci0: No device address configured
[   13.393579] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[   13.393627] Bluetooth: hci0: Boot Address: 0x100800
[   13.393629] Bluetooth: hci0: Firmware Version: 83-19.21
[   13.393631] Bluetooth: hci0: Firmware already loaded
[   14.130910] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   14.130915] Bluetooth: BNEP filters: protocol multicast
[   14.130920] Bluetooth: BNEP socket layer initialized
[   16.065398] usb 1-3.4: Direct firmware load for ti_usb-v0451-p3410.fw fa=
iled
with error -2
[   16.912255] usb 1-3.4: device firmware changed

The last two lines are about different device, not bluetooth related

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
