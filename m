Return-Path: <SRS0=39yq=DL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D0CC4363C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Oct 2020 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AA8206B6
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Oct 2020 15:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgJDPSg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 4 Oct 2020 11:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgJDPSg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 4 Oct 2020 11:18:36 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209493] New: Intel 9260 Wifi/BT USB Resets Repeatedly
Date:   Sun, 04 Oct 2020 15:18:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: parker@finest.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-209493-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209493

            Bug ID: 209493
           Summary: Intel 9260 Wifi/BT USB Resets Repeatedly
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9.0-rc7+
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: parker@finest.io
        Regression: No

Created attachment 292807
  --> https://bugzilla.kernel.org/attachment.cgi?id=292807&action=edit
Full dmesg log

On a Lenovo T495 with AMD Ryzen 3700U PRO and Intel 9260 WiFi/BT the BT USB
resets approximately every 4 seconds. It starts at reboot and happens
regardless if BT and/or WiFi are in use. 

BT still works although there is sometimes lag with my Logitech MX Anywhere 2
BT mouse when it resets.

OS is Debian Bullseye, fully up to date. Issue happens on Distro kernel
(5.8.0-2) as well as upstream built from git. 

[  200.978296] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  204.882294] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  208.786259] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  212.658660] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  216.562736] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  220.434207] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  224.338571] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  228.210158] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  232.114168] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  236.018643] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  239.890136] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  243.794141] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd
[  247.666226] usb 3-2.4: reset full-speed USB device number 5 using xhci_hcd

root@debian-PN:~# lsusb -tv
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/1p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/1p, 10000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Wireless, Driver=btusb, 12M
        ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
    |__ Port 1: Dev 2, If 1, Class=Wireless, Driver=btusb, 12M
        ID 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
    |__ Port 2: Dev 3, If 0, Class=Hub, Driver=hub/4p, 480M
        ID 05e3:0610 Genesys Logic, Inc. Hub
        |__ Port 1: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
            ID 5986:2113 Acer, Inc SunplusIT Integrated Camera
        |__ Port 1: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
            ID 5986:2113 Acer, Inc SunplusIT Integrated Camera
        |__ Port 4: Dev 5, If 0, Class=Vendor Specific Class, Driver=, 12M
            ID 06cb:00bd Synaptics, Inc. Prometheus MIS Touch Fingerprint
Reader
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub

root@debian-PN:~# dmesg |grep iw |grep firmware
[    4.434848] iwlwifi 0000:01:00.0: loaded firmware version 46.8902351f.0
9260-th-b0-jf-b0-46.ucode op_mode iwlmvm

-- 
You are receiving this mail because:
You are the assignee for the bug.
