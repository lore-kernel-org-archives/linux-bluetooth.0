Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F4CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Jan 2021 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B40224D3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Jan 2021 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbhAJRQS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Jan 2021 12:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbhAJRQS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Jan 2021 12:16:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6EA64224D2
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Jan 2021 17:15:37 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211121] New: Bluetooth not working after suspend
Date:   Sun, 10 Jan 2021 17:15:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aymang.abdallah@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211121-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211121

            Bug ID: 211121
           Summary: Bluetooth not working after suspend
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.11.0-051100rc2-generic
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: aymang.abdallah@gmail.com
        Regression: No

Hi,

The bluetooth with device RLT8821CE stops working after resume from suspend (S3
cycle). It requires restarting the laptop to work again. I noticed that lsusb
and rfkill list shows hci0 device after booting, but when waking up from
suspend, hci0 no longer shows in rfkill, and is not listed in lsusb.

rfkill list

1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no


dmesg | grep -i bluetooth

[    1.456943] usb 1-10: Product: Bluetooth Radio
[    1.608363] Bluetooth: Core ver 2.22
[    1.608400] Bluetooth: HCI device and connection manager initialized
[    1.608404] Bluetooth: HCI socket layer initialized
[    1.608408] Bluetooth: L2CAP socket layer initialized
[    1.608412] Bluetooth: SCO socket layer initialized
[    1.622244] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c
lmp_ver=0a lmp_subver=8822
[    1.623042] Bluetooth: hci0: RTL: rom_version status=0 version=3
[    1.623045] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[    1.625528] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[    1.625643] Bluetooth: hci0: RTL: cfg_sz 6, total sz 31422
[    1.779046] Bluetooth: hci0: RTL: fw version 0x09993aa1
[    2.457853] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.457860] Bluetooth: BNEP filters: protocol multicast
[    2.457867] Bluetooth: BNEP socket layer initialized
[   10.739657] Bluetooth: RFCOMM TTY layer initialized
[   10.739667] Bluetooth: RFCOMM socket layer initialized
[   10.739673] Bluetooth: RFCOMM ver 1.11


lsusb

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 0408:5365 Quanta Computer, Inc. HP TrueVision HD Camera
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Laptop is HP 14-dq1059wm running Ubuntu 20.04

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
