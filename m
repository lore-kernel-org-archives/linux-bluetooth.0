Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU436-SMTP18A614550DA045B553FB0B9EA10@phx.gbl>
Date: Mon, 22 Jun 2015 20:01:36 +0800
From: Xi Ruoyao <xry111@outlook.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Larry Finger <Larry.Finger@lwfinger.net>
CC: xry111@outlook.com, "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devices into module device
 table
References: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl> <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org> <55860F8C.4050205@lwfinger.net> <B0BB2A08-47CF-405D-9ACE-528550DF8337@holtmann.org>
In-Reply-To: <B0BB2A08-47CF-405D-9ACE-528550DF8337@holtmann.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 06/22/2015 06:33 PM, Marcel Holtmann wrote:
> Hi Larry,
>
>>>> In 'commit a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek
>>>> 8723A/8723B/8761A/8821A support"), support of some Realtek
>>>> devices was added to the Generic Bluetooth USB driver in kernel.
>>>> However, these devices are not in the module device table of
>>>> btusb.ko, so the kernel wouldn't probe them at all.
>>>>
>>>> To fix this, add four entries in the device table btusb_table,
>>>> based on code from <https://github.com/lwfinger/rtl8723au_bt>
>>>> ('new' branch).
>>>>
>>>> This enables bluetooth support in the Lenovo Ideapad Yoga 13
>>>> which has RTL8723AU USB device, with product ID 0bda:1724.
>>>>
>>>> Signed-off-by: Xi Ruoyao <xry111@outlook.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 6 ++++++
>>>> 1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index 3c10d4d..dd87623 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -148,6 +148,12 @@ static const struct usb_device_id btusb_table[] = {
>>>> 	{ USB_DEVICE(0x8087, 0x0a5a),
>>>> 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
>>>>
>>>> +	/* Realtek Bluetooth  */
>>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) },
>>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bd5, 0xe0, 0x01, 0x01) },
>>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xe0, 0x01, 0x01) },
>>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xe0, 0x01, 0x01) },
>>>> +
>>> I highly doubt these are needed. There is a generic entry for an USB transport that is already covering these.
>> Something changed in recent kernels, and the generic USB transport entries do not seem to be recognized in the case where a wifi and BT device share a single USB ID. As the OP's tablet has such a case, I suggest that 0bda line be accepted, but not the others. If I had a computer with an RTL8723AU, I would have a chance at debugging what changed, but sadly, that is not the case.
> these Realtek devices are causing the most messy setup in a generic driver. And Bluetooth USB support has been really clean and simple for the last 10 years. I really wonder how many ways this gets done wrong before someone gets a clue and gets this right. At the end of the day this USB transport is 15 years old.
I agree. Not only BT, but also wifi in RTL8723AU has caused me a lot of 
trouble.
> Anyway, for obvious reasons the content of /sys/kernel/debug/usb/devices should be included here so that someone can actually look at how the USB endpoints are configured.
The contents about my RTL8723AU is here:
T:  Bus=03 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=1724 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=802.11n WLAN Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 4 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8723au
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=500us
> Regards
>
> Marcel
>
We can see, since in RTL8723AU the wifi and BT share a single USB ID, 
the device
class is 0xef (misc) instead of 0xe0. And the generic entry in btusb 
driver only matches
the devices with class 0xe0. That's why RTL8723AU don't work.

I think we should change the entry from USB_DEVICE_INFO to 
USB_INTERFACE_INFO.
Then this entry can match all devices which have a Bluetooth interface. 
It works well
in my case at least.

-- 
Xi Ruoyao
School of Aerospace Science and Technology
Xidian University, Xi'an, China
