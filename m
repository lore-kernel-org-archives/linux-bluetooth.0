Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N1-r=ncOd=u6BMXDUMhQocYxU_X-z1Wo=W5ah4Wf6bmw@mail.gmail.com>
References: <CALdY0K7bMd=kX1zZ-XiZe58G-fZ1X8rHNdsp05cZ8RwSiUc08A@mail.gmail.com>
	<CAJdJm_N1-r=ncOd=u6BMXDUMhQocYxU_X-z1Wo=W5ah4Wf6bmw@mail.gmail.com>
Date: Wed, 19 Mar 2014 16:29:33 +0000
Message-ID: <CALdY0K4spmU6SsCZM3bWevG_0cjHQmec8N7oe9mCbgRTGJAocQ@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Christian Bianchini <christian.bianchini@euservers.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> This error actually means "Write not permitted". One first error is
> that you are trying to write to the characteristic declaration
> attribute, which is always read-only. To enable notification, you
> should write to the Client Characteristic Configuration (CCC)
> descriptor, which for the first characteristic is probably 0x000c (you
> can confirm by running "char-desc 0x000c 0x000c", if it appears one
> attribute with UUID 0x2902, it is a CCC).
>
> Can you try this instead:
>
> char-write-req 0x000c 0100

OK this worked but didnt activate any input.

>
> By the way, I strongly suggest you read a bit more on GATT (there are
> some good resources on bluetooth.org), so you understand better what
> are notifications, descriptors, characteristics, services etc.

I read a lot about it. I understood that I have 2 services:

1) Jawbone service where I should be able to read and active sensors
2) Default service where I can read Firmware, model, etc...

I was able to read everything about the 2° service, and I am happy with that.
I tried to get  characteristics for the 1° service and I found 3 of
them, this let me think I have 3 sensors. Can the vibrate motor be a
sensor as well?

Doing char-desc of each of three ranges, I couldn't find something
helpful, only UUID with 0x2803 and 0x2800
I read about these two UUIDs are for the whole system to help the
discovery of Characteristics or Descriptions, what I need is to
discover on with 0x2902 (CCC) , am I right?

Let do a summary, maybe you just give me some input:

**First service ( Jawbone ) :
   attr handle: 0x0009, end grp handle: 0x0012 uuid:
f7c9ba7e-6658-4390-b53c-1de5e1453654
   Range: 0x0009 - 0x0012

  The characteristics from this range are:

  handle: 0x000a, char properties: 0x18, char value handle: 0x000b,
uuid: f7c9b162-6658-4390-b53c-1de5e1453654
  handle: 0x000d, char properties: 0x10, char value handle: 0x000e,
uuid: f7c9ba82-6658-4390-b53c-1de5e1453654
  handle: 0x0010, char properties: 0x10, char value handle: 0x0011,
uuid: f7c9ba91-6658-4390-b53c-1de5e1453654

  So what I discovered from your last email is that my CCC are:

  0x000c , 0x000f , 0x0012

  also doing the char-desc I can see that the uuid is 0x2902

  I discovered that sending 01 to the 0x000f I get one notification

char-write-req  0x000f 01
[CON][DC:7A:F8:10:AF:A5][LE]> Characteristic value was written successfully

Notification handle = 0x000e value: 20 0f 1f aa f9 84 d5 e1 78 29 23
2d 14 bc fb c4 ef 71

Probably I need to do a custom activation, because pairing the device
with the specific app I get a vibration on the device.

I might be on the right track, I would like to know if my discovery
are right and I am not floating around.


> PS: When replying to e-mails on the mailing list, be sure to not
> top-post (i.e. write your reply before the original message) and
> remember to trim the original message to only show the relevant part
> of the original message (like I did above), otherwise it is difficult
> to follow discussion.
>
> Best Regards,

thanks for the advice, I am not really expert on this maillist system :(
