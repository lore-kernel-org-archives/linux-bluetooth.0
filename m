Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C6E5C3CA-7CA5-4FD5-8A2C-F6525E905BB8@holtmann.org>
References: <1421468952-79433-1-git-send-email-marcel@holtmann.org>
	<C6E5C3CA-7CA5-4FD5-8A2C-F6525E905BB8@holtmann.org>
Date: Sat, 28 Feb 2015 15:07:26 -0500
Message-ID: <CABPUHrboC8nYJaf-hw1Etv1jzFxeGk+JFbXofCO35y9cHxh5fw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Broadcom patchram support for
 ASUSTek devices
From: Rick Dunn <rick@rickdunn.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel I am running the latest rev of the Ubuntu 14.04 kernel that
came out as 3.13.0-46-generic, now the mods and possibly the firmware
is now longer working?? I also now see the Bluetooth device as an
ASUSTek device vise a Broadcom. Do your mods upstream make it this
version of kernel?

When I tried to load my mod'd previous version of btusb.ko I got:

modprobe: ERROR: could not insert 'btusb': Exec format error  <----
this module worked on rev 45 and below... ?? Any help is appreciated.


Bus 003 Device 003: ID 0b05:17cf ASUSTek Computer, Inc.
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x0b05 ASUSTek Computer, Inc.
  idProduct          0x17cf




On Mon, Jan 19, 2015 at 4:20 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Rick,
>
>> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0b05 ProdID=17cf Rev= 1.12
>> S:  Manufacturer=Broadcom Corp
>> S:  Product=BCM20702A0
>> S:  SerialNumber=54271E3298CD
>> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>>
>> Firmware is extracted from the latest Broadcom BCM4352 Windows driver
>> by extracting the zip and searching the .hex file names for '17cf'.
>>
>> The hex file must then be converted to hcd format using the hex2hcd
>> utility and then moved to /lib/firmware/brcm/.
>>
>> Signed-off-by: Rick Dunn <rick@rickdunn.com>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> drivers/bluetooth/btusb.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
