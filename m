Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALdY0K4spmU6SsCZM3bWevG_0cjHQmec8N7oe9mCbgRTGJAocQ@mail.gmail.com>
References: <CALdY0K7bMd=kX1zZ-XiZe58G-fZ1X8rHNdsp05cZ8RwSiUc08A@mail.gmail.com>
	<CAJdJm_N1-r=ncOd=u6BMXDUMhQocYxU_X-z1Wo=W5ah4Wf6bmw@mail.gmail.com>
	<CALdY0K4spmU6SsCZM3bWevG_0cjHQmec8N7oe9mCbgRTGJAocQ@mail.gmail.com>
Date: Wed, 19 Mar 2014 13:22:09 -0400
Message-ID: <CAJdJm_OxZ0dKDPaPgsYX7UQDczEYgv+Ym6ZZK18h_Yv9zkH=vg@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Christian Bianchini <christian.bianchini@euservers.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Wed, Mar 19, 2014 at 12:29 PM, Christian Bianchini
<christian.bianchini@euservers.net> wrote:
>> Can you try this instead:
>>
>> char-write-req 0x000c 0100
>
> OK this worked but didnt activate any input.

It might be just that the device does not have any notification to
send immediately. Also try reading the descriptor value back (using
char-read-hnd 0x000c) to make sure the correct value was written.

> I tried to get  characteristics for the 1° service and I found 3 of
> them, this let me think I have 3 sensors. Can the vibrate motor be a
> sensor as well?

It's hard to guess here, as they are proprietary services (i.e. not
defined by the Bluetooth SIG and not found on
developer.bluetooth.org). Did you find any information about this
device on the internet? I.e. whether someone already reverse
engineered it, of if it is already documented somewhere. Or at least
some sample code.

>   The characteristics from this range are:
>
>   handle: 0x000a, char properties: 0x18, char value handle: 0x000b,
> uuid: f7c9b162-6658-4390-b53c-1de5e1453654

Note that this characteristic is also writable (the other two are only
notifiable), as shown by the "char properties" value. It could be used
to send commands to the device.

>   handle: 0x000d, char properties: 0x10, char value handle: 0x000e,
> uuid: f7c9ba82-6658-4390-b53c-1de5e1453654
>   handle: 0x0010, char properties: 0x10, char value handle: 0x0011,
> uuid: f7c9ba91-6658-4390-b53c-1de5e1453654

>   I discovered that sending 01 to the 0x000f I get one notification
>
> char-write-req  0x000f 01
> [CON][DC:7A:F8:10:AF:A5][LE]> Characteristic value was written successfully
>
> Notification handle = 0x000e value: 20 0f 1f aa f9 84 d5 e1 78 29 23
> 2d 14 bc fb c4 ef 71

You still need to figure out what those bits mean. They are not
documented in developer.bluetooth.org.

> Probably I need to do a custom activation, because pairing the device
> with the specific app I get a vibration on the device.
>
> I might be on the right track, I would like to know if my discovery
> are right and I am not floating around.

Everything you described here makes sense. But you will need to figure
out how to use those characteristics so you can do what you want.

>> PS: When replying to e-mails on the mailing list, be sure to not
>> top-post (i.e. write your reply before the original message) and
>> remember to trim the original message to only show the relevant part
>> of the original message (like I did above), otherwise it is difficult
>> to follow discussion.
>>
>> Best Regards,
>
> thanks for the advice, I am not really expert on this maillist system :(

No problem, it is just that your e-mails are more likely to be ignored
by others if they get long due to top-posting and not trimming the
original message.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
