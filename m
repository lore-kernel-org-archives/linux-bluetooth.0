Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE43C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 08:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbjELI6s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 04:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbjELI6i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 04:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69BA269D
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 01:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0E6653F6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 08:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5743BC433A1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683881906;
        bh=6X6E35Sdwymafopj+4FVOV7o0tdYQ64cBlGB/YXasxo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=krGWrNahXBqYIKycvclHRutqiK+/ATOSiTHwx2AQC5UMq1saMYfYvdeEOz7RAMvnb
         m+KGDcEdoaZ0KUlGfOcRMc9za49/wfsDLs+814mtiQWg5bBGhbjcl00LfSfpyt8x7p
         2GR5WdDOOvTF7ZZBfIuG8gvAlULVosRDiaFOIx3d3oteX9wa0Vzi/GO68nftbQP+D3
         bUBNgzCIKDuGlbZdCvBvHNoAYwYB5V3f2zzKP3TF64HNN2hqNL5dedaLs2M44Qq6/q
         5TxpO39B5LPwZ/V6Oe4AikUdqa2+pkdbmAMQs1BaLBKCjJfzdQ5HNjAxtheYFzdbAm
         YC9nzbncG5tlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 40DF9C43144; Fri, 12 May 2023 08:58:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Fri, 12 May 2023 08:58:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-oe9P9XFQLT@https.bugzilla.kernel.org/>
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

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
I can confirm that firmware gets loaded fine on a cold boot and

I get errors after rebooting from Windows.

This is reproducible in 6.2.10.

Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 214-6.22
Bluetooth: hci0: FW download error recovery failed (-19)
Bluetooth: hci0: sending frame failed (-19)
Bluetooth: hci0: Failed to read MSFT supported features (-19)
Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
Bluetooth: hci0: Device revision is 2
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
Bluetooth: hci0: Boot Address: 0x40800
Bluetooth: hci0: Firmware Version: 214-6.22
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1104392 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 14640 usecs
Bluetooth: hci0: Malformed MSFT vendor event: 0x02
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware revision 0.1 build 214 week 6 2022

BTW "Secure boot is enabled" is wrong. I have it disabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
