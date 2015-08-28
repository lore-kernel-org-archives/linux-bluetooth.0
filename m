Return-Path: <cyrus@holtmann.org>
Subject: Re: USB  BT gives problem If device plugged during boot to platform.
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
Date: Fri, 28 Aug 2015 12:07:55 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FEE7B28F-3BB4-4AC4-8EEC-962B8C1D192F@holtmann.org>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
To: krishnaks@iwavesystems.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I am porting bluez 5.33 to android kitkat 4.4.3.I am using USB based
> Bluetooth device. I referred instruction in
> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README and
> able to build.
> After botting Android image with USB dongle connected and type "hciconfig
> hci0 up" on console, It is throwing following error.
> Can't init device hci0: Unknown error 132 (132)
> 
> If I Type hciconfig -a . It gives following.
> hci0:   Type: BR/EDR  Bus: USB
>        BD Address: 5C:F3:70:6C:5E:FB  ACL MTU: 1021:8  SCO MTU: 64:1
>        DOWN
>        RX bytes:547 acl:0 sco:0 events:27 errors:0
>        TX bytes:384 acl:0 sco:0 commands:27 errors:0
>        Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH SNIFF
>        Link mode: SLAVE ACCEPT
> 
> 
> 
> But If I unplug and plug USB dongle, and then try same command (hciconfig
> hci0 up), It works. Even "hcitool scan" command also working after that.
> 
> Why 1st time not working when USB dongle is connected?
> Also when I check Bluez debug log in logcat.
> I am getting one error log when USB dongle connected during boot.
> E/bluetoothd(  841): Failed to set mode: Blocked through rfkill (0x12).

I think that blocked through rfkill is pretty obvious. Check with the rfkill tool on what the current settings are. For some reason it seems Bluetooth is blocked by default. And I remember there were some kernel patches for this. Just do not remember the details.

Regards

Marcel

