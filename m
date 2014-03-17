Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALdY0K7bMd=kX1zZ-XiZe58G-fZ1X8rHNdsp05cZ8RwSiUc08A@mail.gmail.com>
References: <CALdY0K7bMd=kX1zZ-XiZe58G-fZ1X8rHNdsp05cZ8RwSiUc08A@mail.gmail.com>
Date: Mon, 17 Mar 2014 15:13:10 -0400
Message-ID: <CAJdJm_N1-r=ncOd=u6BMXDUMhQocYxU_X-z1Wo=W5ah4Wf6bmw@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Christian Bianchini <christian.bianchini@euservers.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Mar 17, 2014 at 2:06 PM, Christian Bianchini
<christian.bianchini@euservers.net> wrote:
> I can try with your idea but if I continue to type commands to read
> stuff, try to write, etc... the device doesn't disconnect. I guess
> it's a timeout after I dont get or send any data, probably a
> power-safe-mode.
>
> i have bluez 4.101 :
> ii  bluez                                       4.101-0ubuntu8b1
>                  amd64        Bluetooth tools and daemons
>
>
> What I dont get is that I can't write any parameters:
> char-write-req a 0100
> [CON][DC:7A:F8:10:AF:A5][LE]> Characteristic Write Request failed:
> Attribute can't be written

This error actually means "Write not permitted". One first error is
that you are trying to write to the characteristic declaration
attribute, which is always read-only. To enable notification, you
should write to the Client Characteristic Configuration (CCC)
descriptor, which for the first characteristic is probably 0x000c (you
can confirm by running "char-desc 0x000c 0x000c", if it appears one
attribute with UUID 0x2902, it is a CCC).

Can you try this instead:

char-write-req 0x000c 0100

By the way, I strongly suggest you read a bit more on GATT (there are
some good resources on bluetooth.org), so you understand better what
are notifications, descriptors, characteristics, services etc.

PS: When replying to e-mails on the mailing list, be sure to not
top-post (i.e. write your reply before the original message) and
remember to trim the original message to only show the relevant part
of the original message (like I did above), otherwise it is difficult
to follow discussion.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
