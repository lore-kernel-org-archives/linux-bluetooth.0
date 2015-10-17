Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?Q?Julio_Gonz=c3=a1lez_Mej=c3=adas?= <juliolokooo@gmail.com>
Subject: Can't bring bluetooth controller up
To: linux-bluetooth@vger.kernel.org
Message-ID: <56222AC0.4090302@gmail.com>
Date: Sat, 17 Oct 2015 13:02:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a card reader with bluetooth controller built-in (Broadcom 
BCM2045A) and it stopped working suddenly some days ago as it appears 
down and I can't bring it up with hciconfig, this is what happens:

sudo hciconfig hci0 up
Can't init device hci0: Operation not supported (95)

This is the output of hcidump when running this command:

hcidump
HCI sniffer - Bluetooth packet analyzer ver 5.35
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> HCI Event: Command Complete (0x0e) plen 4
     Reset (0x03|0x0003) ncmd 1
     status 0x00
> HCI Event: Command Complete (0x0e) plen 12
     Read Local Supported Features (0x04|0x0003) ncmd 1
     status 0x00
     Features: 0xff 0xff 0x8d 0xfe 0x8f 0xf9 0x00 0x80
> HCI Event: Command Complete (0x0e) plen 12
     Read Local Version Information (0x04|0x0001) ncmd 1
     status 0x00
     HCI Version: 2.0 (0x3) HCI Revision: 0x2000
     LMP Version: 2.0 (0x3) LMP Subversion: 0x410d
     Manufacturer: Broadcom Corporation (15)
> HCI Event: Command Complete (0x0e) plen 10
     Read BD ADDR (0x04|0x0009) ncmd 1
     status 0x00 bdaddr 25:7B:43:51:08:D3
> HCI Event: Command Complete (0x0e) plen 11
     Read Buffer Size (0x04|0x0005) ncmd 1
     status 0x00
     ACL MTU 1017:8 SCO MTU 64:0
> HCI Event: Command Complete (0x0e) plen 7
     Read Class of Device (0x03|0x0023) ncmd 1
     status 0x00 class 0x000000
> HCI Event: Command Complete (0x0e) plen 252
     Read Local Name (0x03|0x0014) ncmd 1
     status 0x00 name 'BCM2045'
> HCI Event: Command Complete (0x0e) plen 6
     Read Voice Setting (0x03|0x0025) ncmd 1
     status 0x00 voice setting 0x0060
> HCI Event: Command Complete (0x0e) plen 5
     Read Number of Supported IAC (0x03|0x0038) ncmd 1
> HCI Event: Command Complete (0x0e) plen 8
     Read Current IAC LAP (0x03|0x0039) ncmd 1
     IAC 0x9e8b33 (General Inquiry Access Code)
> HCI Event: Command Complete (0x0e) plen 4
     Set Event Filter (0x03|0x0005) ncmd 1
     status 0x00
> HCI Event: Command Complete (0x0e) plen 4
     Write Connection Accept Timeout (0x03|0x0016) ncmd 1
     status 0x00
> HCI Event: Command Complete (0x0e) plen 68
     Read Local Supported Commands (0x04|0x0002) ncmd 1
     status 0x00
     Commands: ffffff03feffcfffffffffff0300f8ff07
> HCI Event: Command Complete (0x0e) plen 4
     Write Inquiry Mode (0x03|0x0045) ncmd 1
     status 0x00
> HCI Event: Command Complete (0x0e) plen 14
     Read Local Extended Features (0x04|0x0004) ncmd 1
     status 0x00 page 1 max 0
     Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> HCI Event: Command Complete (0x0e) plen 4
     Set Event Mask (0x03|0x0001) ncmd 1
     status 0x00
> HCI Event: Command Complete (0x0e) plen 4
     Write Default Link Policy Settings (0x02|0x000f) ncmd 1
     status 0x00
> HCI Event: Command Complete (0x0e) plen 8
     Read Page Scan Activity (0x03|0x001b) ncmd 1
     status 0x00 interval 2048 window 18
> HCI Event: Command Complete (0x0e) plen 4
     Delete Stored Link Key (0x03|0x0012) ncmd 1
     status 0x11 deleted 2048
     Error: Unsupported Feature or Parameter Value


I have looked on rfkill and everything seems correct and the LED is lit, 
I'm using Arch Linux 4.2.3 kernel.
It still works on Windows, so I'm lost here, is the device faulty or 
something?

Thanks in advance,

