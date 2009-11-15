Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1258286281.3299.28.camel@violet>
References: <dfb262380911140245v20973542v61cc82ba1071064d@mail.gmail.com>
	 <1258286281.3299.28.camel@violet>
Date: Sun, 15 Nov 2009 14:26:25 +0200
Message-ID: <dfb262380911150426i3fe8c155sd232cdedec24579d@mail.gmail.com>
Subject: Re: 'cat /dev/rfcomm0' yields strange data
From: Ramagudi Naziir <naziirr@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 15, 2009 at 1:58 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> you have to switch the device into raw mode before cat will work. The
> rfcomm utility should have a --raw option.

Do I have to do that also if I plan to open /dev/rfcomm0 with an
application that expects a standard serial tty device (e.g. I usually
feed it with /dev/ttyS1) ?

Can you please explain in a few words what exactly does --raw do ?

Thanks!
Naziir
>
> Regards
>
> Marcel
>
>
>
