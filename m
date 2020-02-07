Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AA3C352A2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0108320715
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 13:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGNfN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGNfN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 08:35:13 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 206457] New: Gamepad Dualshock4 CUH-ZCT2U doesn't pair or
 connect
Date:   Fri, 07 Feb 2020 13:35:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: arael78@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206457-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206457

            Bug ID: 206457
           Summary: Gamepad Dualshock4 CUH-ZCT2U doesn't pair or connect
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.5+
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: arael78@gmail.com
        Regression: No

Pairing the Dualshock4 controller does not complete correctly, even after
several attempts.

Once the pairing is apparently completed (I have to switch off the controller
to interrupt the pairing process), when I try to connect it it doesn't stay
connected.

I have checked the dmesg and apparently there is a buffer overflow.

I can pair a bluetooth headset to my laptop and the Dualshock4 pairs with my
samsung tablet without problems but when I try to pair the dualshock4 to the
laptop, running kernel 5.5 and current 5.5+ it doesn't work. I tried other
kernels from 5.0 up. None worked.

Dmesg output:

[ 4.099796] Bluetooth: Core ver 2.22
[ 4.099833] Bluetooth: HCI device and connection manager initialized
[ 4.099837] Bluetooth: HCI socket layer initialized
[ 4.099839] Bluetooth: L2CAP socket layer initialized
[ 4.099842] Bluetooth: SCO socket layer initialized
[ 4.128978] Bluetooth: hci0: Firmware revision 0.0 build 10 week 41 2018
[ 6.855412] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 6.855413] Bluetooth: BNEP filters: protocol multicast
[ 6.855416] Bluetooth: BNEP socket layer initialized
[ 14.234706] Bluetooth: RFCOMM TTY layer initialized
[ 14.234711] Bluetooth: RFCOMM socket layer initialized
[ 14.234715] Bluetooth: RFCOMM ver 1.11
[ 117.427931] Bluetooth: Dropping L2CAP data: receive buffer overflow

If I try to use USB cable I get this error:

[ 1882.762621] usb 1-1: new full-speed USB device number 6 using xhci_hcd
[ 1882.913951] usb 1-1: New USB device found, idVendor=054c, idProduct=09cc,
bcdDevice= 1.00
[ 1882.913956] usb 1-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[ 1882.913960] usb 1-1: Product: Wireless Controller
[ 1882.913962] usb 1-1: Manufacturer: Sony Interactive Entertainment
[ 1882.951627] usbcore: registered new interface driver snd-usb-audio
[ 1882.952799] sony 0003:054C:09CC.0004: failed to retrieve feature report 0x81
with the DualShock 4 MAC address
[ 1882.952943] sony 0003:054C:09CC.0004: hidraw1: USB HID v81.11 Gamepad [Sony
Interactive Entertainment Wireless Controller] on usb-0000:00:14.0-1/input3
[ 1882.952945] sony 0003:054C:09CC.0004: failed to claim input
[ 1883.072399] retire_capture_urb: 28 callbacks suppressed

My distro is Ubuntu 19.04 and I have already filed a bug there. I was asked to
submit a report here too. On that report there are other logs which might be
useful here. Let me know if it is enough or if you need more info.

https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1861063

Thank you very much for your help.

-- 
You are receiving this mail because:
You are the assignee for the bug.
