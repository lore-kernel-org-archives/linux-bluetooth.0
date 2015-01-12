Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jan 2015 22:32:47 +0100
From: Reinhard Speyerer <rspmn@arcor.de>
To: marcel@holtmann.org
Cc: Reinhard Speyerer <rspmn@arcor.de>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] make Belkin F8T013 devices work again by adding
 BTUSB_BROKEN_STORED_LINK_KEY flag
Message-ID: <54b43d7f.uI8BccxO1tuiQhzKxGDn6Zl3@arcor.de>
References: <54b19c34.HFakUiNRADxA91CC0vhvfVD1@arcor.de>
 <558296E1-B802-4B20-BE09-9C154C16F90F@holtmann.org>
 <54b2c4ba.ejKVqomjev/ni7OD+L8fy9Fa@arcor.de>
 <A4D80118-BF74-44FD-A72D-F4D7B9E0CEAA@holtmann.org>
In-Reply-To: <A4D80118-BF74-44FD-A72D-F4D7B9E0CEAA@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann <marcel@holtmann.org> wrote:

>
> I wonder if we should issue Read Stored Link Key command and only try to clear all link keys if there are actual link key stored in the first place. Maybe this is what the command is complaining about.
>
> Read all stored link keys:
>
> 	hcitool cmd 0x03 0x000d 0x00 0x00 0x00 0x00 0x00 0x00 0x01
>
> What does this actually return.

Hi Marcel,

although not listed in "hciconfig hci0 commands" output Read Stored Link Key
returns Status: 0x11 instead of Invalid HCI command according to btmon:

# hcitool cmd 0x03 0x000d 0x00 0x00 0x00 0x00 0x00 0x00 0x01
< HCI Command: ogf 0x03, ocf 0x000d, plen 7
  00 00 00 00 00 00 01 
> HCI Event: 0x0e plen 4
  01 0D 0C 11 

> It seems it does not even support the Read Stored Link Key command. Can you include /sys/kernel/debug/usb/devices from this dongle.

T:  Bus=05 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  6 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=0013 Rev= 0.00
S:  Manufacturer=Broadcom Corp
S:  Product=Belkin Bluetooth Device
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

Regards,
Reinhard
