Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFFBC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDEF20768
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDFTn0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgDFTn0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:26 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 06 Apr 2020 19:43:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexplose@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-VPrYoKar22@https.bugzilla.kernel.org/>
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

Alexandre (alexplose@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alexplose@gmail.com

--- Comment #59 from Alexandre (alexplose@gmail.com) ---


(In reply to Alex from comment #55)
> Hi,
> My issue with this device looks a little different, and after applying the
> latest patch from the thread I still have the issue.
> 
> btmon shows the following (last lines, see Set Event Filter error):
> 
> #20 [hci0] 9.289041
>       Read Number of Supported IAC (0x03|0x0038) ncmd 1
>         Status: Success (0x00)
>         Number of IAC: 2
> < HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0                    
> #21 [hci0] 9.289050
> > HCI Event: Command Complete (0x0e) plen 8                                   
> >                                                          #22 [hci0]
> 9.291043
>       Read Current IAC LAP (0x03|0x0039) ncmd 1
>         Status: Success (0x00)
>         Number of IAC: 1
>         Access code: 0x9e8b33 (General Inquiry)
> < HCI Command: Set Event Filter (0x03|0x0005) plen 1                        
> #23 [hci0] 9.291049
>         Type: Clear All Filters (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                                   
> >                                                          #24 [hci0]
> 9.293040
>       Set Event Filter (0x03|0x0005) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
> = Close Index: 00:1A:7D:DA:71:12                                            
> [hci0] 9.293052
> 
> 
> and the device stays down and inaccessible
> Here is data from my system:
> 
> hciconfig -a 
> hci0: Type: Primary  Bus: USB
>       BD Address: 00:1A:7D:DA:71:12  ACL MTU: 679:8  SCO MTU: 48:16
>       DOWN 
>       RX bytes:706 acl:0 sco:0 events:22 errors:0
>       TX bytes:68 acl:0 sco:0 commands:22 errors:0
>       Features: 0xbf 0x2e 0x4d 0xfa 0xd8 0x3d 0x7b 0x87
>       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3 
>       Link policy: 
>       Link mode: SLAVE ACCEPT 
> 
> hciconfig  hci0 up
> Can't init device hci0: Invalid argument (22)
> 
> [bluetooth]# list
> [bluetooth]# 
> 
> lsusb
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 005: ID 14cd:125c Super Top SD card reader
> Bus 001 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
> Bus 001 Device 018: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
> Bus 001 Device 003: ID 04b3:3025 IBM Corp. NetVista Full Width Keyboard
> Bus 001 Device 002: ID 0bda:b812 Realtek Semiconductor Corp. 
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> dmesg (extract)
> [ 5284.357208] usbcore: deregistering interface driver btusb
> [ 5287.608129] usb 1-7: new full-speed USB device number 18 using xhci_hcd
> [ 5287.758895] usb 1-7: config 1 interface 1 altsetting 0 endpoint 0x3 has
> wMaxPacketSize 0, skipping
> [ 5287.758904] usb 1-7: config 1 interface 1 altsetting 0 endpoint 0x83 has
> wMaxPacketSize 0, skipping
> [ 5287.759639] usb 1-7: New USB device found, idVendor=0a12, idProduct=0001,
> bcdDevice=88.91
> [ 5287.759647] usb 1-7: New USB device strings: Mfr=0, Product=2,
> SerialNumber=0
> [ 5287.759651] usb 1-7: Product: BT DONGLE10
> [ 5287.785780] btusb: New fixups. Device: 0x0a12:0x0001/0x8891. Rule 1/1 (5
> terms): 0x0a12:0x0001/0x8891
> [ 5287.785781] btusb: driver flags: initial => 0x0000000000000004
> [ 5287.785783] btusb: driver flags: masked  => 0x0000000000800000
> [ 5287.785902] usbcore: registered new interface driver btusb
> [ 5395.553658] debugfs: File 'dut_mode' in directory 'hci0' already present!
> 
> hcidump -X is attached
> Any suggestions/fixes are really appreciated.
> Please let me know if some info is missing.
> 
> Thanks,
> Alex.



I'm having the same issue on a raspberry with an aliexpress dongle, Set Event
fails, looking at hci_core.c the set filter and previous calls are made only if
device supports BREDR, is there any way to tell device doesn't support, or
patch this ? 
I'm on latest raspberry pi 4, latest kernel 4.19.113-v7l+

-- 
You are receiving this mail because:
You are the assignee for the bug.
