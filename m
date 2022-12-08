Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91C5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Dec 2022 21:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLHVsk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLHVsc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 16:48:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E19493B
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 13:48:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB2BFB825A6
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 21:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85B43C433F0
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670536103;
        bh=g7L33BiMJEBDilBhfGixGHal1QDHHMhGbPfxsdc5mhc=;
        h=From:To:Subject:Date:From;
        b=jE3QsxYmVkS0O3QLhEqmHEM94IKbajlQtaWZaFNkUPlCOuxgAkKzPd8NoMJHKiNgR
         1Aom5WkdwnkYQyfvZ7Nqt5yoSMv3oCI3D7PXs6UDcMt/Tl1/RQBtNoYIYmEzLOD6yI
         W4DUipJZgTmJKXW1rGlwOWprUIkF5rxUO/ylSf9gXqcmjQg/7O7kZw5B8EtR004rPg
         68wo8FjiiSJifN/O2yk2eXZQxhjf+wxpQ5t8wzKzyhGvKeETxY9bVwdnJOFaWGytIP
         V+bHWE+0m2y5wzJ/onAh2a7P38ul12vVmnfJsj+bdTrKiYo9lTHTv1ueEpi3Sw6EmS
         H6oRBQo913whw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6B27BC43143; Thu,  8 Dec 2022 21:48:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216792] New: bluetoothd:
 src/adapter.c:set_device_privacy_complete() Set device flags return status:
 Invalid Parameters
Date:   Thu, 08 Dec 2022 21:48:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@e3q.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216792-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216792

            Bug ID: 216792
           Summary: bluetoothd:
                    src/adapter.c:set_device_privacy_complete() Set device
                    flags return status: Invalid Parameters
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.80
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bugzilla.kernel.org@e3q.eu
        Regression: No

I have "Intel Corp. AX200 Bluetooth" in a Lenovo Thinkpad T14 AMD.
Every time I boot, I get the following error in my logs:

bluetoothd: src/adapter.c:set_device_privacy_complete() Set device flags re=
turn
status: Invalid Parameters

I cannot say whether this has any actual impact, as my bluetooth devices mo=
stly
work, but sometimes have issues (disconnecting for a while, not appearing in
list of audio devices,=E2=80=A6). In any case, it is a message at the error=
 level, so
ideally it is fixed.

In context:

kernel: Bluetooth: hci0: Waiting for firmware download to complete
kernel: Bluetooth: hci0: Firmware loaded in 1684355 usecs
kernel: Bluetooth: hci0: Waiting for device to boot
kernel: Bluetooth: hci0: Device booted in 14608 usecs
kernel: Loading firmware: intel/ibt-20-1-3.ddc
kernel: Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-1-3.ddc
kernel: Bluetooth: hci0: Applying Intel DDC parameters completed
[=E2=80=A6]
kernel: Bluetooth: hci0: Firmware revision 0.3 build 106 week 39 2022
[=E2=80=A6]
bluetoothd[705]: src/device.c:device_set_wake_support() Unable to set
wake_support without RPA resolution
bluetoothd[705]: src/adapter.c:set_device_privacy_complete() Set device fla=
gs
return status: Invalid Parameters
kernel: Bluetooth: hci0: Bad flag given (0x2) vs supported (0x1)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
