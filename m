Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Linux-4.9.30] Broadcom BCM20702 bluetooth in ThinkPad-T530 not
 usable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+icZUWf1EyPJDOTO-xos=QwQ0DWLOg3goiSX_X2C01QpVqU1w@mail.gmail.com>
Date: Fri, 9 Jun 2017 17:37:08 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <D83A359C-829A-4DBC-B5CE-1B077CE6B0E4@holtmann.org>
References: <CA+icZUWf1EyPJDOTO-xos=QwQ0DWLOg3goiSX_X2C01QpVqU1w@mail.gmail.com>
To: sedat.dilek@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sedat,

> I have some problems using my BCM20702 adapter on my Debian/stretch
> 9.0 AMD64 system with Linux v4.9.30 on a ThinkPad-T530 notebook.
> 
> [ FIRMWARE ]
> 
> First, I needed and have "stolen" a working firmware from [1] and
> loading/unloading works fine with it.
> 
> root# modprobe -r -v btusb && modprobe -v btusb
> 
> [ 4606.883980] Bluetooth: hci0: BCM: chip id 63
> [ 4606.899963] Bluetooth: hci0: Broadcom Bluetooth Device
> [ 4606.905045] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1757
> [ 4606.905114] bluetooth hci0: firmware: direct-loading firmware
> brcm/BCM20702A1-0a5c-21e6.hcd
> [ 4607.845000] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1757
> [ 4607.862024] Bluetooth: hci0: Broadcom Bluetooth Device
> 
> [ LSUSB ]
> 
> lsusb shows me...
> 
> root# lsusb -s 001:008
> Bus 001 Device 008: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0
> [ThinkPad]
> 
> [ RFKILL ]
> 
> I played with rfkill [2] and block/unblock of bluetooth works...
> 
> # rfkill block bluetooth
> 
> # rfkill list bluetooth
> 0: tpacpi_bluetooth_sw: Bluetooth
>        Soft blocked: yes
>        Hard blocked: no
> 
> # rfkill unblock bluetooth
> 
> # rfkill list bluetooth
> 0: tpacpi_bluetooth_sw: Bluetooth
>        Soft blocked: no
>        Hard blocked: no
> 11: hci0: Bluetooth
>        Soft blocked: yes
>        Hard blocked: no
> 
> # rfkill unblock 11
> 
> # rfkill list bluetooth
> 0: tpacpi_bluetooth_sw: Bluetooth
>        Soft blocked: no
>        Hard blocked: no
> 11: hci0: Bluetooth
>        Soft blocked: no
>        Hard blocked: no
> 
> [ HCICONFIG ]
> 
> With a rfkill-unblocked bluetooth I cannot get hci0 up...
> 
> root# hciconfig hci0 up
> Can't init device hci0: Invalid request code (56)
> 
> [ INVESTIGATING WITH HCIDUMP  ]
> 
> root# apt-get update && apt-get install bluez-hcidump
> 
> Sniffing with hcidump...
> 
> [ hcidump.txt ]
> 
> HCI sniffer - Bluetooth packet analyzer ver 5.43
> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> < HCI Command: Reset (0x03|0x0003) plen 0
>> HCI Event: Command Complete (0x0e) plen 4
>    Reset (0x03|0x0003) ncmd 1
>    status 0x00
> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
>> HCI Event: Command Complete (0x0e) plen 12
>    Read Local Version Information (0x04|0x0001) ncmd 1
>    status 0x00
>    HCI Version: 4.1 (0x7) HCI Revision: 0x16dd
>    LMP Version: 4.1 (0x7) LMP Subversion: 0x220e
>    Manufacturer: Broadcom Corporation (15)
> < HCI Command: Vendor (0x3f|0x0079) plen 0
>> HCI Event: Command Complete (0x0e) plen 10
>    Vendor (0x3f|0x0079) ncmd 1
> < HCI Command: Read Local Name (0x03|0x0014) plen 0
>> HCI Event: Command Complete (0x0e) plen 252
>    Read Local Name (0x03|0x0014) ncmd 1
>    status 0x00 name 'Broadcom Bluetooth Device'
> < HCI Command: Vendor (0x3f|0x005a) plen 0
>> HCI Event: Command Complete (0x0e) plen 8
>    Vendor (0x3f|0x005a) ncmd 1
> < HCI Command: Vendor (0x3f|0x002e) plen 0
>> HCI Event: Command Complete (0x0e) plen 4
>    Vendor (0x3f|0x002e) ncmd 1
> < HCI Command: Vendor (0x3f|0x004c) plen 44
>> HCI Event: Command Complete (0x0e) plen 4
>    Vendor (0x3f|0x004c) ncmd 1
> < HCI Command: Vendor (0x3f|0x004c) plen 255
>> HCI Event: Command Complete (0x0e) plen 4
>    Vendor (0x3f|0x004c) ncmd 1
> 
> Full hcidump is attached.
> 
> I looked into btusb.c and wondered if my bluetooth-device needs to be
> added with vendorid:productid and/or need some quirks to be set.
> But I have no glue...
> 
> Attached are my linux-config, dmesg, lsusb and hcidump logs and outputs.
> 
> If you need more specific infos let me know and give clear
> human-understable instructions.

can you run “btmon -w trace.log” and attach that log. I think that I know what is going on, but I want to confirm this.

Regards

Marcel

