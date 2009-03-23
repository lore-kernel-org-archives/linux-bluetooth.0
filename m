Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Wacom Bluetooth mode-2 activation
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1237010988.24751.2.camel@localhost.localdomain>
References: <1237334085.15346.99.camel@cookie.hadess.net>
	 <1237010988.24751.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 23 Mar 2009 14:09:10 +0000
Message-Id: <1237817350.19118.1255.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-03-14 at 07:09 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Patch is necessary to make the Wacom Bluetooth driver I posted to
> > linux-input work as expected. I've tested this successfully with my
> > tablet[1].
> 
> this maybe sound like a nit-pick, but please add an extra empty line
> between the if-statement and the ioctl.
> 
> +               write(sk, buf, sizeof(buf));
> +       }
>         err = ioctl_connadd(req);
> 
> The original code had one and so should have the new one with this extra
> quirk.

OK.

> Also can we please check at least the return value of write().
> 
> +               write(sk, buf, sizeof(buf));
> 
> Check the return value and at minimum have an error message printed.

The writes actually fail, from what I've seen, but it works... I'll try
to get some details about what fails.
