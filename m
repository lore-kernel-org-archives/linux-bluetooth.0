Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOazyz3PxrYfXXy4Weh68Vkz7Atp3nUFG14ufivcFrQJH65p5Q@mail.gmail.com>
References: <CAOazyz26ywy+OWMCbL6JMdEd3zt9Ui8XTAWVXtLLRj_wKq+Uvw@mail.gmail.com>
	<1321139715.15441.438.camel@aeonflux>
	<CAOazyz3PxrYfXXy4Weh68Vkz7Atp3nUFG14ufivcFrQJH65p5Q@mail.gmail.com>
Date: Sat, 12 Nov 2011 19:43:33 -0400
Message-ID: <CAJdJm_MSSsDqzFCmbQGVZ+3dyJ-dghwGJ3OuBoAQBP29rsAc3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alon,

On Sat, Nov 12, 2011 at 7:24 PM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>> And also please send patches inline and via attachments.
>
> This would be difficult, as gmail does not allow no wrapping.
> git accepts this correctly, I use:
>
> $ curl article.gmane.org/gmane.linux.bluez.kernel/18337/raw | git am
>
> If this is really important I will try to find some other mail client.

Complementing Marcel's suggestion, you can have this in your ~/.gitconfig:

[sendemail]
	smtpserver = smtp.gmail.com
	smtpuser = your.email@gmail.com
	smtpssl = 1

And to send e-mail:

git send-email --to linux-bluetooth@vger.kernel.org patch1.patch ...

It will then ask for your password after confirmation.

More information: man git-send-email

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
