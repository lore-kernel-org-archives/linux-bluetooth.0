Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCWa_U+0fh6de1yMvZLp4xhZfuLoiNNWdi8d93He-Sf0XA@mail.gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337591234-24919-6-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKxOd-1VEvQvj-KmSzTxyAXdJtz14kGDn8Qh8LNbrhyiw@mail.gmail.com>
	<CANT-zCWa_U+0fh6de1yMvZLp4xhZfuLoiNNWdi8d93He-Sf0XA@mail.gmail.com>
Date: Mon, 21 May 2012 15:39:53 +0300
Message-ID: <CABBYNZJWvq-aja2ptbdVd5-ETCQkEZW1qi67YO5X4KdtsPYFhw@mail.gmail.com>
Subject: Re: [PATCH obexd v0 05/12] client-doc: Replace SendFiles with SendFile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, May 21, 2012 at 2:40 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> In addition, this change does make some sense on its own, since it
> maps better to the OBEX spec. IIRC SendFiles was there to avoid
> creating one session per transfer, but this is no longer a problem
> once OPP is wrapped in a session type. It also allows to have a
> asynchronous call, so the client can wait until the transfer is
> finished.

I don't think the client should be waiting it to finish, it is a bad
API because it can take forever to transfer the file and eventually
the message will timeout while the transfer is still ongoing, besides
it takes away the possibility to cancel the transfer or watch its
progress.

> So I can merge both changes but I would rather keep them separated, so
> we can have more consistent APIs after each step.

Hmm, but I would have the changes to the same API at least in the same set.

-- 
Luiz Augusto von Dentz
