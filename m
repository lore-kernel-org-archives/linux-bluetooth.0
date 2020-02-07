Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42331C04EB5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1756F22522
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGPbs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:31:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGPbs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 10:31:48 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 07 Feb 2020 15:31:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hernando.cavalcanti@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-RPJnxVNxef@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Hernando (hernando.cavalcanti@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hernando.cavalcanti@gmail.c
                   |                            |om

--- Comment #49 from Hernando (hernando.cavalcanti@gmail.com) ---
hi guys... i can confirm this with kernel 5.5.2, i applyed every patch attached
here to kernel 5 and still not working..

uname -r
5.5.2

lsusb -v
Bus 001 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
(HCI mode)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           88.91
  iManufacturer           0 
  iProduct                2 USB1.1-A
  iSerial                 0 
  bNumConfigurations      1

hcitool dev
Devices:

dmesg
[  231.131312] usb 1-4: reset high-speed USB device number 2 using xhci_hcd
[  263.037922] usb 1-10: USB disconnect, device number 7
[  283.813572] usb 1-10: new full-speed USB device number 8 using xhci_hcd
[  283.962915] usb 1-10: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice=88.91
[  283.962916] usb 1-10: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[  283.962917] usb 1-10: Product: USB1.1-A
[  283.985700] Bluetooth: hci0: urb 000000004a48b323 failed to resubmit (2)
[  285.993511] Bluetooth: hci0: command 0x0c14 tx timeout
[  288.009434] Bluetooth: hci0: command 0x0c25 tx timeout
[  290.025410] Bluetooth: hci0: command 0x0c38 tx timeout
[  292.041395] Bluetooth: hci0: command 0x0c39 tx timeout
[  294.057297] Bluetooth: hci0: command 0x0c05 tx timeout
[  758.040593] usb 1-4: reset high-speed USB device number 2 using xhci_hcd
[ 1302.873156] usb 1-4: reset high-speed USB device number 2 using xhci_hcd
[ 1375.723184] usb 1-4: reset high-speed USB device number 2 using xhci_hcd

-- 
You are receiving this mail because:
You are the assignee for the bug.
