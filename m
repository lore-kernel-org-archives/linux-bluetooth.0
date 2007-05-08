Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4640FF63.8070403@am.sony.com>
Date: Tue, 08 May 2007 15:53:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>, maxk@qualcomm.com,
        bluez-devel@lists.sf.net, dwmw2@infradead.org
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
References: <463F7386.6050900@am.sony.com>	 <1178608551.8628.52.camel@aeonflux.holtmann.net>	 <1178622391.2824.34.camel@pmac.infradead.org>	 <1178630359.8628.63.camel@aeonflux.holtmann.net>	 <1178639244.2824.40.camel@pmac.infradead.org> <1178642601.8628.67.camel@aeonflux.holtmann.net>
In-Reply-To: <1178642601.8628.67.camel@aeonflux.holtmann.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi David,
> 
>> [root@ps3 ~]# hciconfig hci0 revision
>> hci0:   Type: USB
>>         BD Address: 00:13:A9:79:09:C3 ACL MTU: 384:8 SCO MTU: 64:8
>>         Build 3608
>>         Chip version: Unknown
>>         Max key size: 128 bit
>>         SCO mapping:  HCI

hci0:   Type: USB
        BD Address: 00:13:A9:73:1F:0D ACL MTU: 384:8 SCO MTU: 64:8
        Build 3608
        Chip version: Unknown (4h)
        Max key size: 128 bit
        SCO mapping:  HCI

> 
> the chip version is unknown. That is strange. I need to modify bccmd to
> read the raw value of the chip version. Can you quickly poke around the
> hciconfig code to get me the raw value of it.
> 
>> [root@ps3 ~]# bccmd builddef
>> Build definitions:
>> 0x0009 - TRANSPORT_BCSP
>> 0x000a - TRANSPORT_H4
>> 0x000b - TRANSPORT_USB
>> 0x000d - MAX_CRYPT_KEY_LEN_128
>> 0x0012 - REQUIRE_8MBIT
>> 0x0013 - RADIOTEST
>> 0x0015 - INSTALL_FLASH
>> 0x0016 - INSTALL_EEPROM
>> 0x0017 - INSTALL_COMBO_DOT11
>> 0x001d - CHIP_BASE_BC3
>> 0x0020 - INSTALL_HCI_MODULE
>> 0x002a - BT_VER_1_2
>> 0x0031 - CHIP_BASE_BC4
>> [root@ps3 ~]# bccmd buildname
>> Build name: sly_8hci_fl_bt2.0_tachikoma-rc29_encr128_tachikoma
>> 2006-10-16
> 
> This looks like a specific firmware build. Need to investigate what is
> so special about it.
> 
> Can you dfutool archive it for me.

The device seems to disconnect when you try to read
the firmware.  I get this when I try:

[root@ps3-nfs ~]# dfutool archive ps3.dfu
Available devices with DFU support:

         1) Bus 002 Device 003: ID 054c:0267 Interface 3

Select device (abort with 0): 1

Can't identify device with DFU mode

And see this in the log:

May  8 15:50:07 ps3-nfs kernel: usb 2-2: reset high speed USB device using ps3-ehci-driver and address 3
May  8 15:50:07 ps3-nfs kernel: usb 2-2: USB disconnect, address 3
May  8 15:50:07 ps3-nfs hcid[2286]: HCI dev 0 down
May  8 15:50:07 ps3-nfs hcid[2286]: Device hci0 has been disabled
May  8 15:50:07 ps3-nfs hcid[2286]: HCI dev 0 unregistered
May  8 15:50:07 ps3-nfs hcid[2286]: Unregister path: /org/bluez/hci0
May  8 15:50:07 ps3-nfs hcid[2286]: Device hci0 has been removed

Any suggestions?

-Geoff
