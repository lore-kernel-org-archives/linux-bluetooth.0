Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA19C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE0220663
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 11:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJLYy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfLJLYy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 06:24:54 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 205821] New: ID 0a12:0001 Cambridge Silicon Radio, Ltd
 Bluetooth Dongle (HCI mode)
Date:   Tue, 10 Dec 2019 11:24:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: demonik_82@mail.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205821-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205821

            Bug ID: 205821
           Summary: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
                    Dongle (HCI mode)
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.0-6-amd64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: demonik_82@mail.ru
        Regression: No

$ hcitool dev
Devices:
$ hcitool scan
Device is not available: No such device

$ lsusb
Bus 003 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 005: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
(HCI mode)
Bus 001 Device 004: ID 046d:c05a Logitech, Inc. M90/M100 Optical Mouse
Bus 001 Device 003: ID 040b:2000 Weltrend Semiconductor 
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

$ systemctl status bluetooth.service
● bluetooth.service - Bluetooth service
   Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled; vendor
preset
   Active: active (running) since Tue 2019-12-10 15:23:47 +05; 53min ago
     Docs: man:bluetoothd(8)
 Main PID: 604 (bluetoothd)
   Status: "Running"
    Tasks: 1 (limit: 4915)
   Memory: 3.0M
   CGroup: /system.slice/bluetooth.service
           └─604 /usr/lib/bluetooth/bluetoothd

rfkill list all
0: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no

journalctl -b | grep firmware
дек 10 15:23:48 dev NetworkManager[606]: <info>  [1575973428.5871]
manager[0x557f0fb14020]: monitoring kernel firmware directory '/lib/firmware'.
дек 10 15:23:51 dev kernel: r8169 0000:03:00.0: firmware: direct-loading
firmware rtl_nic/rtl8168f-1.fw
дек 10 15:24:16 dev systemd[1]: Startup finished in 8.999s (firmware) + 6.482s
(loader) + 4.575s (kernel) + 45.463s (userspace) = 1min 5.521s.

hciconfig
hci0:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:11  ACL MTU: 679:9  SCO MTU: 48:16
        DOWN 
        RX bytes:574 acl:0 sco:0 events:30 errors:0
        TX bytes:368 acl:0 sco:0 commands:30 errors:0

hciconfig hci0 up
Can't init device hci0: Operation not supported (95)

Help please

-- 
You are receiving this mail because:
You are the assignee for the bug.
