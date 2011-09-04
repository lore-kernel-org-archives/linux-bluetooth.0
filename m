Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <654DF80AD31A344E93DBCC6280BD6DEF22247990@NL0230MBX08N1.DIR.slb.com>
References: <654DF80AD31A344E93DBCC6280BD6DEF222465B6@NL0230MBX08N1.DIR.slb.com>
	<CABBYNZLTJQkm0jv6NpmyoFV8sPUeLbrb+8DAUEBPB2J5yGfEsA@mail.gmail.com>
	<654DF80AD31A344E93DBCC6280BD6DEF22247990@NL0230MBX08N1.DIR.slb.com>
Date: Sun, 4 Sep 2011 21:12:34 +0300
Message-ID: <CABBYNZJ_qVo1npo2XhjA4C3d2ss66CS-hKPtsFXC0M=_Er0sww@mail.gmail.com>
Subject: Re: Is bluetooth supported on lastest mac-mini?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Sun, Sep 4, 2011 at 6:55 AM, John Frankish <j-frankish@slb.com> wrote:
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Thursday, 01 September, 2011 13:53
>> To: John Frankish
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: Is bluetooth supported on lastest mac-mini?
>>
>> Hi John,
>>
>> On Thu, Sep 1, 2011 at 11:38 AM, John Frankish <j-frankish@slb.com> wrote:
>> > Using bluez-4.96, things work fine on:
>> >
>> > dell latitude d430
>> > Bus 002 Device 004: ID 413c:8140 Dell Computer Corp. Wireless 360
>> > Bluetooth
>> >
>> > ..but don't work on:
>> >
>> > 2011 unibody mac mini server
>> > Bus 001 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub
>> > (part of BCM2046 Bluetooth)
>> >
>> > "bluetoothd -nd" does not throw up any error messages, but "hcitool scan"
>> > fails with a "no device" found message.
>> >
>> > Is there any further troubleshooting I could try?
>>
>> It might need some change in the kernel to able to load the proper driver,
>> something like the following should do it:
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
>> 91d13a9..16abfd1 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
>>         /* Apple MacBookPro8,2 */
>>         { USB_DEVICE(0x05ac, 0x821a) },
>>
>> +       /* Apple Mac Mini */
>> +       { USB_DEVICE(0x05ac, 0x4500) },
>> +
>>         /* AVM BlueFRITZ! USB v2.0 */
>>         { USB_DEVICE(0x057c, 0x3800) },
>>
>>
> Thanks, I recompiled the 3.0.3 kernel with the patch, but my machine crashed as soon as the driver tried to load..

Maybe it needs more changes, iirc this new mac minis have BT 4.0
controllers... Can you get any logs where it is crashing?


-- 
Luiz Augusto von Dentz
