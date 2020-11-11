Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393AEC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB4121D46
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgKKArk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732174AbgKKArk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 19:47:40 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210141] New: Bluetooth device rtw_8822ce is lost after suspend
 to RAM
Date:   Wed, 11 Nov 2020 00:47:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: funtoos@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-210141-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210141

            Bug ID: 210141
           Summary: Bluetooth device rtw_8822ce is lost after suspend to
                    RAM
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9.7
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: funtoos@yahoo.com
        Regression: No

This is on an HP 14" laptop model: HP 14-dq1xxx with rtw_8822ce driver drives
the wifi and bluetooth.

So, everything works fine until I suspend to RAM. After waking from suspend,
the bluetooth adapter just disappears. I can see in the 'dmesg' the USB device
gets disconnected but no reason is mentioned.

Before suspend:

[    6.937836] usb 1-10: new full-speed USB device number 5 using xhci_hcd
[    7.065627] usb 1-10: New USB device found, idVendor=0bda, idProduct=b00c,
bcdDevice= 0.00
[    7.065630] usb 1-10: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    7.065632] usb 1-10: Product: Bluetooth Radio 
[    7.065633] usb 1-10: Manufacturer: Realtek

After resume, it is gone:

[  329.512699] Restarting tasks ... done.
[  329.515898] usb 1-10: USB disconnect, device number 5
[  329.585469] PM: suspend exit
[  329.585559] elogind-daemon[7406]: System resumed.

# lspci
00:00.0 Host bridge: Intel Corporation Device 8a02 (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Iris Plus Graphics G1 (Ice
Lake) (rev 07)
00:04.0 Signal processing controller: Intel Corporation Device 8a03 (rev 03)
00:14.0 USB controller: Intel Corporation Ice Lake-LP USB 3.1 xHCI Host
Controller (rev 30)
00:14.2 RAM memory: Intel Corporation Device 34ef (rev 30)
00:15.0 Serial bus controller [0c80]: Intel Corporation Ice Lake-LP Serial IO
I2C Controller #0 (rev 30)
00:15.1 Serial bus controller [0c80]: Intel Corporation Ice Lake-LP Serial IO
I2C Controller #1 (rev 30)
00:16.0 Communication controller: Intel Corporation Management Engine Interface
(rev 30)
00:17.0 RAID bus controller: Intel Corporation 82801 Mobile SATA Controller
[RAID mode] (rev 30)
00:1c.0 PCI bridge: Intel Corporation Device 34bf (rev 30)
00:1f.0 ISA bridge: Intel Corporation Ice Lake-LP LPC Controller (rev 30)
00:1f.3 Audio device: Intel Corporation Smart Sound Technology Audio Controller
(rev 30)
00:1f.4 SMBus: Intel Corporation Ice Lake-LP SMBus Controller (rev 30)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Ice Lake-LP SPI
Controller (rev 30)
01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac
PCIe Wireless Network Adapter

# lsusb
Bus 002 Device 002: ID 05e3:0626 Genesys Logic, Inc. USB3.1 Hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 13d3:56c9 IMC Networks HP TrueVision HD Camera
Bus 001 Device 008: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 007: ID 413c:2011 Dell Computer Corp. Multimedia Pro Keyboard
Bus 001 Device 006: ID 413c:1005 Dell Computer Corp. Multimedia Pro Keyboard
Hub
Bus 001 Device 004: ID 0c45:64ab Microdia Integrated Camera
Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Device 5 is gone from lsusb.

-- 
You are receiving this mail because:
You are the assignee for the bug.
