Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100718200429.GB17706@joshua.mesa.nl>
References: <20100718200429.GB17706@joshua.mesa.nl>
Date: Mon, 19 Jul 2010 00:29:23 +0300
Message-ID: <AANLkTik21yk-zvNw9nzHnkQgoR1meBhTEhLVoGvCcRg9@mail.gmail.com>
Subject: Re: obexd TARGET_SIZE question
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Jul 18, 2010 at 11:04 PM, Marcel J.E. Mol <marcel@mesa.nl> wrote:
> Hi,
>
> I'm trying to understand a part of the obexd code, to see if somehow a
> IrMC server can be implemented. Pierre Ossman already started a bit on this.
>
> I am a bit confused about the obex_mime_type driver structure.
> The find_driver() function does a memcmp0(target, driver->target, TARGET_SIZE),
> but it seems not all drivers have target of size TARGET_SIZE.
>
> The syncevolution plugin has a target of size 11 (whereas TARGET_SIZE=16).
> So the find_driver() probably fails the memcmp0 for this driver as
> the extra 5 bytes to compare my be undefined...
> A IrMC Sync target will have a target_size of 9.
>
> I also noticed the obex_service_driver, which is handled in a similar
> way as the rbex_mime_type_driver. Forrest added a target_size element
> in for this struct (commit b38537e5f12decc4b2444112f4363ff1aa5326c6):
>
>        Forrest Zhao [Mon, 16 Nov 2009 07:17:47 +0000]
>        Introduce target_size to struct obex_service_driver{}
>        Because the OBEX target header length for each OBEX service layer
>        may not be the same.
>
> Shouldn't the same happen for the obex_mime_type_driver() ?
>
> (actually Pierre Ossman did this in his local obexd tree to test IrMC
>  which also has a different target size, I copied these changes in
>  a clone of obexd 0.29)

Yep, that should be fixed, if you guys have patch for it please submit
so we can review/apply.


-- 
Luiz Augusto von Dentz
Computer Engineer
