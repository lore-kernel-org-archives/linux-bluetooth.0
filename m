Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3C2963DE7FB6424B9BCE227143415153@sisodomain.com>
References: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
	<1358781718-386-3-git-send-email-luiz.dentz@gmail.com>
	<3C2963DE7FB6424B9BCE227143415153@sisodomain.com>
Date: Thu, 24 Jan 2013 10:32:22 -0400
Message-ID: <CAJdJm_MG8N7gO8Wb1+Qk7AJG5hGMZUd9tF5NB7fCz9Ud33Dvcg@mail.gmail.com>
Subject: Re: Query regarding LE encryption failure
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi  Jaganath,

On Thu, Jan 24, 2013 at 9:55 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> Hello,
>
> We are using BlueZ-4.101 and the device is paired with an LE proximity
> device.
> When "DiscoverCharacteristics" is called, after creating LE connection it is
> trying to encrypt the link which fails with "Pin or key missing".
>
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>  0000: 40 00 cb 2e 2a ec a1 c5  3c ad 2d d5 02 dc 91 a5  @...*...<.-.....
>  0010: d7 7b b0 aa 82 ef cb 32  31 ce 4e 6f              .{.....21.No
>>
>> HCI Event: Command Status (0x0f) plen 4
>
>    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
>>
>> HCI Event: Encrypt Change (0x08) plen 4
>
>    status 0x06 handle 64 encrypt 0x00
>    Error: PIN or Key Missing
>
> Any idea why it is failing?

It looks to me the remote device lose the bonding. Are you sure it was
not power cycled (i.e. the battery removed or device was reset some
way)?

>
> One thing I noticed is during pairing also this encryption is being done
> and it succeeded.
>
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>  0000: 40 00 00 00 00 00 00 00  00 00 00 00 f4 33 19 ea  @............3..
>  0010: aa 35 95 5a 51 cf 15 a6  23 8a 05 27              .5.ZQ...#..'
>>
>> HCI Event: Command Status (0x0f) plen 4
>
>    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
>>
>> HCI Event: Encrypt Change (0x08) plen 4
>
>    status 0x00 handle 64 encrypt 0x01
>
>
> But both the encryption packets are different. Is it expected?

IIRC this should be the STK used for encryption right after "just
works" pairing. See Figure 5.5 from page 2005 of Core spec. It will
not match the LTK used for encryption after re-connection.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
