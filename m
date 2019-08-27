Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25913C3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F0D2186A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 08:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfH0IXr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfH0IXq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 04:23:46 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204707] New: RTL8822CE cannot discover pair-able devices
Date:   Tue, 27 Aug 2019 08:23:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jian-hong@endlessm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-204707-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204707

            Bug ID: 204707
           Summary: RTL8822CE cannot discover pair-able devices
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.3.0-rc6
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jian-hong@endlessm.com
        Regression: No

Created attachment 284625
  --> https://bugzilla.kernel.org/attachment.cgi?id=284625&action=edit
The dmesg file with 5.3.0-rc6 kernel

We have a laptop equipped with Intel i3-10110U CPU and Realtek 8822CE WiFi/BT
combo chip.

I have tested with 5.3.0-rc6 mainline kernel and the firmware from the commits:
aa703aad295d rtl_bt: Update RTL8822C BT FW to V0x098A_94A4
7e431c5dee00 rtw88: RTL8822C: add WoW firmware v7.3
2dc7023fd529 rtw88: RTL8822C: update rtw8822c_fw.bin to v7.3

However, system cannot discover any pair-able BT device.  For example, our
"pulse" BT headset, which can be discovered and paired on other laptops.

bluetoothctl 
Agent registered
[bluetooth]# show
Controller 3C:91:80:AA:80:E0 (public)
        Name: endless
        Alias: endless
        Class: 0x0008010c
        Powered: yes
        Discoverable: yes
        Pairable: yes
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0532
        Discovering: no
[bluetooth]# scan on
Discovery started
[CHG] Controller 3C:91:80:AA:80:E0 Discovering: yes
[NEW] Device 38:F9:D3:1B:1E:E1 38-F9-D3-1B-1E-E1
[NEW] Device 67:25:04:4E:E3:83 67-25-04-4E-E3-83
[CHG] Device 38:F9:D3:1B:1E:E1 RSSI: -40
[NEW] Device 7E:01:A3:AE:F0:76 7E-01-A3-AE-F0-76
[CHG] Device 67:25:04:4E:E3:83 RSSI: -72
[CHG] Device 7E:01:A3:AE:F0:76 RSSI: -66
[CHG] Device 3F:59:C8:72:74:D7 RSSI: -66
[CHG] Device 3F:59:C8:72:74:D7 UUIDs: 0000181a-0000-1000-8000-00805f9b34fb
[CHG] Device 3F:59:C8:72:74:D7 ServiceData Key:
0000fe95-0000-1000-8000-00805f9b34fb
[CHG] Device 3F:59:C8:72:74:D7 ServiceData Value:
  70 20 5b 04 a5 d7 74 72 c8 59 3f 09 06 10 02 6c  p [...tr.Y?....l
  02                                               .               
[NEW] Device 43:31:ED:A4:B4:49 43-31-ED-A4-B4-49
[NEW] Device 4A:BF:0E:E8:89:4F 4A-BF-0E-E8-89-4F
[NEW] Device 76:08:71:6E:38:D5 76-08-71-6E-38-D5
[CHG] Device 67:25:04:4E:E3:83 RSSI: -64
...
[bluetooth]# devices
Device 3F:59:C8:72:74:D7 LYWSD02
Device 38:F9:D3:1B:1E:E1 38-F9-D3-1B-1E-E1
Device 67:25:04:4E:E3:83 67-25-04-4E-E3-83
Device 7E:01:A3:AE:F0:76 7E-01-A3-AE-F0-76
Device 43:31:ED:A4:B4:49 43-31-ED-A4-B4-49
Device 4A:BF:0E:E8:89:4F 4A-BF-0E-E8-89-4F
Device 76:08:71:6E:38:D5 76-08-71-6E-38-D5
Device 7E:AE:93:95:B3:72 7E-AE-93-95-B3-72

Here is the RTL8822CE information:

sudo lspci -nnvs 02:00.0
02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. Device
[10ec:c822]
        Subsystem: Lite-On Communications Inc Device [11ad:0810]
        Flags: bus master, fast devsel, latency 0, IRQ 17
        I/O ports at 3000 [size=256]
        Memory at b1100000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-22-01
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Kernel driver in use: rtw_pci
        Kernel modules: rtwpci

-- 
You are receiving this mail because:
You are the assignee for the bug.
