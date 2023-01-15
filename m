Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1865C63797
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Jan 2023 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAOUf2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjAOUfR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Jan 2023 15:35:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25A12F29
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 12:35:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE40760DEA
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 20:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C792C433D2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jan 2023 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673814915;
        bh=PaQfeK0Ps17JPXbNzXoB7daxktKk9MprSncXFuQ075c=;
        h=From:To:Subject:Date:From;
        b=ruEmv038WfZbwrOiZvzCZ3QJqZGL+WmgLHOW+4kkzTudvJNh4MzI/geerR9g53GNG
         cXYB4wCwV12AqNKI0Z9p0dF1ABH3BhvUV9RLdocqYG9iHwDNsuXyxv/mmJda5ftAtG
         Yirka8R9geFm82RKiFoialCGkGLTMFLR5I36fjrL5TQ/MMGazTHvOjHRpTj+YN73Uz
         PEo7K+WJzweDw2TNzCADYOi//kNhbj+od4vbEAOmO2+0NHMiWuyNto7NLEeIEjdveB
         oOdOvCs8keCZPSzTdmVLvRQFCZPtH2I0djqsYJUAhUS0rIIDTTmPIRDLJxN92XC2j1
         P/WoR4+UKqeiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F19B9C43142; Sun, 15 Jan 2023 20:35:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] New: [REGRESSION] The first attempt to upload firmware
 for Intel Bluetooth fails
Date:   Sun, 15 Jan 2023 20:35:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

            Bug ID: 216936
           Summary: [REGRESSION] The first attempt to upload firmware for
                    Intel Bluetooth fails
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.1.6
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

This looks like a new regression for kernel 6.1.6.

Kernel 6.1.4 and previous kernels didn't have the issue.

Hardware: ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter

From dmesg:

Bluetooth: hci0: FW download error recovery failed (-19)
Bluetooth: hci0: sending frame failed (-19)
Bluetooth: hci0: Failed to read MSFT supported features (-19)

Full log:

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
Bluetooth: hci0: Firmware loaded in 1111205 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 14844 usecs
Bluetooth: hci0: Malformed MSFT vendor event: 0x02
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-18-16-1.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware revision 0.1 build 214 week 6 2022

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
