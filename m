Return-Path: <SRS0=Pq0q=AC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FEFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jun 2020 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F9D20768
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Jun 2020 20:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgFUUad convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730604AbgFUUac (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Jun 2020 16:30:32 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 21 Jun 2020 20:30:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-w56VOQOn6r@https.bugzilla.kernel.org/>
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

Swyter (swyterzone@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |swyterzone@gmail.com

--- Comment #77 from Swyter (swyterzone@gmail.com) ---
Still having the same problem on Linux 5.7.4. 75.58, in my case it's one of
these super common, round, unmarked dongles: 
https://web.archive.org/web/https://pl.aliexpress.com/item/33058605031.html  

Here's what running `hcidump -X` while doing `hciconfig hci0 up` shows; it
errors out while trying to delete the stored link key. So, same problem and
different bcdDevice; 75.58, sounds like someone needs to add a bunch of extra
quirks:

HCI sniffer - Bluetooth packet analyzer ver 5.54
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> HCI Event: Command Complete (0x0e) plen 4
    Reset (0x03|0x0003) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 5
    status 0x00
    Features: 0xff 0xff 0xcd 0xfa 0xdb 0xbf 0x7b 0x87
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 5
    status 0x00
    HCI Version: 4.0 (0x6) HCI Revision: 0x709
    LMP Version: 4.0 (0x6) LMP Subversion: 0x709
    Manufacturer: Cambridge Silicon Radio (10)
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 5
    status 0x00 bdaddr 00:15:83:EA:<censored>:<censored>
> HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 5
    status 0x00
    ACL MTU 360:4 SCO MTU 0:0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 5
    status 0x00 class 0x000000
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 5
    status 0x00 name ''
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 5
    status 0x00 voice setting 0x0000
> HCI Event: Command Complete (0x0e) plen 5
    Read Number of Supported IAC (0x03|0x0038) ncmd 5
    0000: 00 01                                             ..
> HCI Event: Command Complete (0x0e) plen 8
    Read Current IAC LAP (0x03|0x0039) ncmd 5
    IAC 0x9e8b33 (General Inquiry Access Code)
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 7
    LE Read Buffer Size (0x08|0x0002) ncmd 5
    status 0x00 pktlen 0x001b maxpkt 0x12
> HCI Event: Command Complete (0x0e) plen 12
    LE Read Supported States (0x08|0x001c) ncmd 5
    0000: 00 ff 00 3c 1f 00 00 00  00                       ...<.....
> HCI Event: Command Complete (0x0e) plen 68
    Read Local Supported Commands (0x04|0x0002) ncmd 5
    status 0x00
    Commands: bfffff03feffffff0fffff1ff20fe8fe3ff78fff1c00000061f7ffff7f18
> HCI Event: Command Complete (0x0e) plen 4
    Write Extended Inquiry Response (0x03|0x0052) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Mode (0x03|0x0045) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 5
    Read Inquiry Response Transmit Power Level (0x03|0x0058) ncmd 5
    status 0x00 level 8
> HCI Event: Command Complete (0x0e) plen 14
    Read Local Extended Features (0x04|0x0004) ncmd 5
    status 0x00 page 1 max 0
    Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 8
    Read Stored Link Key (0x03|0x000d) ncmd 5
    status 0x00 max 0 num 0
> HCI Event: Command Complete (0x0e) plen 4
    Write Default Link Policy Settings (0x02|0x000f) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 8
    Read Page Scan Activity (0x03|0x001b) ncmd 5
    status 0x00 interval 512 window 18
> HCI Event: Command Complete (0x0e) plen 5
    Read Default Erroneous Data Reporting (0x03|0x005a) ncmd 5
    status 0x00 reporting 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Page Scan Type (0x03|0x0046) ncmd 5
    0000: 00 00                                             ..
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Event Mask (0x08|0x0001) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 5
    LE Read White List Size (0x08|0x000f) ncmd 5
    0000: 00 08                                             ..
> HCI Event: Command Complete (0x0e) plen 4
    LE Clear White List (0x08|0x0010) ncmd 5
    status 0x00
> HCI Event: Command Complete (0x0e) plen 6
    Delete Stored Link Key (0x03|0x0012) ncmd 5
    status 0x11 deleted 0
    Error: Unsupported Feature or Parameter Value

--


This is my `uname -a` shows. I'm just running the normal Arch Linux kernel:
Linux fenix 5.7.4-arch1-1 #1 SMP PREEMPT Thu, 18 Jun 2020 16:01:07 +0000 x86_64
GNU/Linux

--

This is what `lsusb -v` shows for this device. As you can see in my case it has
bcdDevice 75.58:

Bus 008 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle
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
  bcdDevice           75.58
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
  (Bus Powered)

--

This is what `dmesg` shows at startup with the thingie connected:

[  293.350687] usb 8-1: new full-speed USB device number 3 using ohci-pci
[  293.528946] usb 8-1: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice=75.58
[  293.528953] usb 8-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  295.680774] Bluetooth: hci0: command 0x2003 tx timeout
[  298.027478] Bluetooth: hci0: command 0x2007 tx timeout

--

Seems like they have stolen bdaddr space from 00:15:83 IVT corporation. Anyway,
hope that helps, let me know if anyone needs something else to diagnose to test
a proper Kernel patch that gets mainlined. I'm all ears. :)

-- 
You are receiving this mail because:
You are the assignee for the bug.
