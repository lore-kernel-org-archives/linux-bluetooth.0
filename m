Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B25EC63798
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 07:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E175E238E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgKTHGV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgKTHGV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 02:06:21 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210275] New: Bluetooth stopped working on kernel 5.9
Date:   Fri, 20 Nov 2020 07:06:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: m11.1l1.f64@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-210275-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210275

            Bug ID: 210275
           Summary: Bluetooth stopped working on kernel 5.9
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.9.8-2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: m11.1l1.f64@gmail.com
        Regression: No

Bluetooth stopped working on kernel 5.9
It worked well on kernel 5.8

Output of bluetoothctl:
Agent registered
[bluetooth]# show
No default controller available
[bluetooth]#

On the kernel 5.7:
[bluetooth]# show
Controller 70:66:55:BB:04:B6 (public)
        Name: MTN-Lap
        Alias: MTN-Lap
        Class: 0x00000000
        Powered: no
        Discoverable: yes
        DiscoverableTimeout: 0x00000000
        Pairable: yes
        UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
        UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
        UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
        UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
        UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0537
        Discovering: no
        Roles: central
        Roles: peripheral
Advertising Features:
        ActiveInstances: 0x00 (0)
        SupportedInstances: 0x05 (5)
        SupportedIncludes: tx-power
        SupportedIncludes: appearance
        SupportedIncludes: local-name
        SupportedSecondaryChannels: 1M
        SupportedSecondaryChannels: 2M
        SupportedSecondaryChannels: Coded

The current kernel:
5.9.8-2-MANJARO

Version of bluetoothctl:
bluetoothctl: 5.55

output of "lsmod | grep bluetooth":
bluetooth             737280  12 btrtl,btintel,btbcm,bnep,btusb
ecdh_generic           16384  1 bluetooth
rfkill                 28672  9 hp_wmi,bluetooth,cfg80211
crc16                  16384  2 bluetooth,ext4


System info:
Kernel: 5.9.8-2-MANJARO x86_64 bits: 64 compiler: gcc v: 10.2.0 Desktop: KDE
Plasma 5.20.3 tk: Qt 5.15.1 wm: kwin_x11 dm: SDDM Distro: Manjaro Linux

-- 
You are receiving this mail because:
You are the assignee for the bug.
