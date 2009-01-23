Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2C0A35D3-4DD9-4089-8061-F596A8A5A4B8@tiscali.it>
References: <2C0A35D3-4DD9-4089-8061-F596A8A5A4B8@tiscali.it>
Date: Fri, 23 Jan 2009 09:34:36 +0200
Message-ID: <664d43d60901222334h4e1cb498hf8b3b01433e3ab92@mail.gmail.com>
Subject: Re: [PATCH] BlueZ support for audio gateway role (HFP/HSP)
From: event <event.riga@gmail.com>
To: Michele Noberasco <michele.noberasco@tiscali.it>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jan 22, 2009 at 18:43, Michele Noberasco
<michele.noberasco@tiscali.it> wrote:
> Hello list,
>
> some time ago my company tasked me to develop this feature, but
> unfortunately they changed their mind before I could complete development. I
> sought to finish it on my own, but my spare time is dwindling lately.
>
> So I thought that someone might be interested to pick development up where I
> left it off.
>
> If anyone is interested, I'm willing to provide the source code of my own
> work. I implemented it for HSP up to the actual creation of audio channels
> (excluded). Mostly implemented and working is rfcomm connection and event
> passing ("RING", ...).
>
> My modifications are made against bluez-3.36 (latest version of the 3.x
> branch), but I think it should be trivial to forward port them to bluez 4
> (if you have a look at audio/gateway.c you will notice there is nothing in
> there), so I would provide a patch that applies against that codebase.
>
> Best regards,
> Michele Noberasco
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hello Michele,

I'm doing the same function just now :).
So please send your code and I will look there for something I've missed.

Vale,
Leonid Movshovich
