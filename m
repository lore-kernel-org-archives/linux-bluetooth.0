Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE20AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jan 2022 10:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbiAJKzH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jan 2022 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiAJKzG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jan 2022 05:55:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB86C06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 02:55:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CA1CB815C5
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 10:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 296D0C36AE5
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jan 2022 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641812103;
        bh=32MMOCY5mOC8zxmil/9MKrwh7bxb1iyXuSHfUdoI1do=;
        h=From:To:Subject:Date:From;
        b=ic4KuuwAYeYgS/HNlTckcq1d4Ns9DLgyJykpAFpuBlauFY4ui/V7vFzWPfzfbxTm2
         Tqoq0baodzkYst6BPcLdUr1Jz9IkS2acH0nDJOodhmvKw4JEG4R2dRHVxT/BfxHSg6
         IV1aaYpjieuTuv2jyOojmyh8v9PLXVoKd1Dpor7NDajwjNrT9Mhj/tYbg2bRdtDouZ
         +sCdtl4laU+K/hET+pkwlxDYwTMFAqnjCc15r2Kj9pMDuoNi8y8uGs+w+EF78Q/HJB
         C2/lLL0h2/4GoRm2WFXUpWB3jAj8aDJT1sdUNJHoEcQLosaUuk7LHH2begOKPvnIMU
         hgTloV3CQzl4Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0DB4FC05FD7; Mon, 10 Jan 2022 10:55:03 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215474] New: Bluetooth fails randomly.
Date:   Mon, 10 Jan 2022 10:55:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: barz621@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215474-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215474

            Bug ID: 215474
           Summary: Bluetooth fails randomly.
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.15.13
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: barz621@gmail.com
        Regression: No

Hello. I have an intel i5-1135G7 based laptop and i have a problem with
bluetooth. It disconnects at random once a day or so. The vendor is intel a=
nd
is connected via USB.

*-usb:3
                   description: Bluetooth wireless interface
                   vendor: Intel Corp.
                   physical id: a
                   bus info: usb@3:a
                   version: 0.00
                   capabilities: bluetooth usb-2.01
                   configuration: driver=3Dbtusb maxpower=3D100mA speed=3D1=
2Mbit/s

When it fails the message i get is:

=CE=99=CE=B1=CE=BD 10 11:41:29 mainland kernel: usb 3-10: Failed to suspend=
 device, error -110
=CE=99=CE=B1=CE=BD 10 11:42:00 mainland bluetoothd[412]:
src/adv_monitor.c:btd_adv_monitor_power_down() Unexpected NULL
btd_adv_monitor_manager object upon power down
=CE=99=CE=B1=CE=BD 10 11:42:02 mainland kernel: Bluetooth: hci0: command 0x=
0c1a tx timeout
=CE=99=CE=B1=CE=BD 10 11:42:04 mainland kernel: Bluetooth: hci0: command 0x=
0406 tx timeout
=CE=99=CE=B1=CE=BD 10 11:42:07 mainland kernel: Bluetooth: hci0: command 0x=
0c03 tx timeout
=CE=99=CE=B1=CE=BD 10 11:42:13 mainland rfkill[7516]: unblock set for id 0
=CE=99=CE=B1=CE=BD 10 11:42:14 mainland kernel: usb 3-10: Failed to suspend=
 device, error -110
=CE=99=CE=B1=CE=BD 10 11:42:15 mainland kernel: Bluetooth: hci0: HCI reset =
during shutdown
failed
=CE=99=CE=B1=CE=BD 10 11:42:22 mainland rfkill[7520]: unblock set for id 0
=CE=99=CE=B1=CE=BD 10 11:42:28 mainland kernel: Bluetooth: hci0: Failed to =
read MSFT supported
features (-110)
=CE=99=CE=B1=CE=BD 10 11:42:28 mainland kernel: usb 3-10: Failed to suspend=
 device, error -110
=CE=99=CE=B1=CE=BD 10 11:42:28 mainland bluetoothd[412]: Failed to set mode=
: Failed (0x03)
=CE=99=CE=B1=CE=BD 10 11:42:40 mainland kernel: usb 3-10: reset full-speed =
USB device number 5
using xhci_hcd
=CE=99=CE=B1=CE=BD 10 11:42:55 mainland kernel: usb 3-10: device descriptor=
 read/64, error
-110
=CE=99=CE=B1=CE=BD 10 11:43:11 mainland kernel: usb 3-10: device descriptor=
 read/64, error
-110
=CE=99=CE=B1=CE=BD 10 11:43:11 mainland kernel: usb 3-10: reset full-speed =
USB device number 5
using xhci_hcd

Sometimes a reboot doesn't fix it and needs a shutdown and turn on again to
work properly.

Thanks in advance.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
