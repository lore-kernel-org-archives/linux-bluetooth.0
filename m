Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4865C282CA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 21:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9243C2147A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 21:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfA0V7L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:59:11 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35878 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbfA0V7K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jan 2019 16:59:10 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 81F152A59C
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jan 2019 21:59:09 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 701602A5A1; Sun, 27 Jan 2019 21:59:09 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 202429] New: No Bluetooth Adapter on boot - Works after woekn
 up from suspend/sleep - Intel Ac 9260
Date:   Sun, 27 Jan 2019 21:59:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cordleztoaster@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-202429-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202429

            Bug ID: 202429
           Summary: No Bluetooth Adapter on boot - Works after woekn up
                    from suspend/sleep - Intel Ac 9260
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.20.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: cordleztoaster@gmail.com
        Regression: No

Created attachment 280815
  --> https://bugzilla.kernel.org/attachment.cgi?id=280815&action=edit
dmesg

Hi All

Using a Lenovo e485 laptop which i replaced the wifi card with an intel AC 9260
wireless with Bluetooth 5.0 (rev 29).

Booting either ubuntu 18.04 or 18.10 with kernel 4.18.* through to 4.20.* the
bluetooth is not detected and can't be switched on.

After updating the firmware with the latest from here
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/

I'm now at a point where if i let the laptop go into sleep/suspend, then wake
the laptop up bluetooth starts to work and successfully discovers and can
connect to devices.

Here is the dmesg output after the laptop has woken from sleep/suspend

$ dmesg | egrep -i 'blue|firm'
[ 0.364229] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[ 0.406110] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus
00-3f] only partially covers this bridge
[ 2.788840] Bluetooth: Core ver 2.22
[ 2.788859] Bluetooth: HCI device and connection manager initialized
[ 2.788878] Bluetooth: HCI socket layer initialized
[ 2.788881] Bluetooth: L2CAP socket layer initialized
[ 2.788885] Bluetooth: SCO socket layer initialized
[ 2.810244] Bluetooth: hci0: Firmware revision 0.1 build 130 week 44 2018
[ 2.817186] iwlwifi 0000:04:00.0: loaded firmware version 41.fc1a7aea.0 op_mode
iwlmvm
[ 3.042541] [drm] Found VCN firmware Version: 1.73 Family ID: 18
[ 3.042568] [drm] PSP loading VCN firmware
[ 3.401831] psmouse serio2: trackpoint: Elan TrackPoint firmware: 0x11,
buttons: 3/3
[ 4.065429] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 4.065430] Bluetooth: BNEP filters: protocol multicast
[ 4.065434] Bluetooth: BNEP socket layer initialized
[ 4.933825] Bluetooth: hci0: command 0x080f tx timeout
[ 4.933855] Bluetooth: hci0: sending frame failed (-19)
[ 6.949824] Bluetooth: hci0: command 0x0c1b tx timeout
[ 6.949845] Bluetooth: hci0: sending frame failed (-19)
[ 8.970148] Bluetooth: hci0: command 0x0c46 tx timeout
[ 8.970210] Bluetooth: hci0: sending frame failed (-19)
[ 10.981885] Bluetooth: hci0: command 0x2001 tx timeout
[ 10.982056] Bluetooth: hci0: sending frame failed (-19)
[ 12.998061] Bluetooth: hci0: command 0x200f tx timeout
[ 12.998122] Bluetooth: hci0: sending frame failed (-19)
[ 2705.041640] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[ 2705.044665] Bluetooth: hci0: Device revision is 2
[ 2705.044668] Bluetooth: hci0: Secure boot is enabled
[ 2705.044670] Bluetooth: hci0: OTP lock is enabled
[ 2705.044672] Bluetooth: hci0: API lock is enabled
[ 2705.044674] Bluetooth: hci0: Debug lock is disabled
[ 2705.044677] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 2705.048826] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[ 2706.367400] Bluetooth: hci0: Waiting for firmware download to complete
[ 2706.367614] Bluetooth: hci0: Firmware loaded in 1298523 usecs
[ 2706.367724] Bluetooth: hci0: Waiting for device to boot
[ 2706.383685] Bluetooth: hci0: Device booted in 15620 usecs
[ 2706.385856] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-18-16-1.ddc
[ 2706.397687] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 2706.578691] Bluetooth: RFCOMM TTY layer initialized
[ 2706.578698] Bluetooth: RFCOMM socket layer initialized
[ 2706.578705] Bluetooth: RFCOMM ver 1.11
[ 2718.694753] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[ 2718.694760] Bluetooth: HIDP socket layer initialized
[ 2718.702815] input: MagicMouse as
/devices/pci0000:00/0000:00:08.1/0000:05:00.4/usb3/3-1/3-1:1.0/bluetooth/hci0/hci0:256/0005:05AC:030D.0001/input/input16
[ 2718.703050] magicmouse 0005:05AC:030D.0001: input,hidraw0: BLUETOOTH HID
v3.06 Mouse [MagicMouse] on fc:77:74:eb:f6:2b

-- 
You are receiving this mail because:
You are the assignee for the bug.
