Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6282EC64EB0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199B520C0A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 21:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199B520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJJEpd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:45:33 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:36048 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbeJJEpd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Oct 2018 00:45:33 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E5B9929485
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Oct 2018 21:26:38 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id D7B04298C8; Tue,  9 Oct 2018 21:26:38 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201363] New: RTL8822BE Bluetooth not detected on Lenovo A485
Date:   Tue, 09 Oct 2018 21:26:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: samantham@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-201363-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=201363

            Bug ID: 201363
           Summary: RTL8822BE Bluetooth not detected on Lenovo A485
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.18.12
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: samantham@posteo.net
        Regression: No

02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8822BE
802.11a/b/g/n/ac WiFi adapter [10ec:b822]

It doesn't seem to show up in lsusb:
Bus 005 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 004 Device 007: ID 04f2:b604 Chicony Electronics Co., Ltd 
Bus 004 Device 006: ID 04f3:2398 Elan Microelectronics Corp. 
Bus 004 Device 003: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 004 Device 004: ID 06cb:009a Synaptics, Inc. 
Bus 004 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

dmesg output (gotten by doing journalctl -k | grep -Ei 'rtlwifi|blue|8822')

Oct 09 01:40:13 kernel: usb 4-2.2: Product: Bluetooth Radio 
Oct 09 01:40:13 kernel: r8822be: module is from the staging directory, the
quality is unknown, you have been warned.
Oct 09 01:40:13 kernel: Bluetooth: Core ver 2.22
Oct 09 01:40:13 kernel: Bluetooth: Starting self testing
Oct 09 01:40:13 kernel: Bluetooth: Finished self testing
Oct 09 01:40:13 kernel: Bluetooth: HCI device and connection manager
initialized
Oct 09 01:40:13 kernel: Bluetooth: HCI socket layer initialized
Oct 09 01:40:13 kernel: Bluetooth: L2CAP socket layer initialized
Oct 09 01:40:13 kernel: Bluetooth: SCO socket layer initialized
Oct 09 01:40:13 kernel: r8822be 0000:02:00.0: enabling device (0000 -> 0003)
Oct 09 01:40:13 kernel: r8822be: Using firmware rtlwifi/rtl8822befw.bin
Oct 09 01:40:13 kernel: r8822be: rtlwifi: wireless switch is on
Oct 09 01:40:13 kernel: r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
Oct 09 01:40:14 kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Oct 09 01:40:14 kernel: Bluetooth: BNEP filters: protocol multicast
Oct 09 01:40:14 kernel: Bluetooth: BNEP socket layer initialized
Oct 09 01:40:15 kernel: Bluetooth: hci0: command 0x1001 tx timeout
Oct 09 01:40:24 kernel: Bluetooth: hci0: HCI_OP_READ_LOCAL_VERSION failed
(-110)

Bluetooth works fine in Windows. The first dmesg line seems interesting: usb
4-2.2: Product: Bluetooth Radio  but somehow there's no bluetooth showing up in
lsusb

Others have this issue as well:
https://forums.lenovo.com/t5/Linux-Discussion/Thinkpad-A485-Bluetooth-not-turning-on-Linux/td-p/4219759

-- 
You are receiving this mail because:
You are the assignee for the bug.
