Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALF0-+X7_B8M6By5YuS7uHAYGGhS6FisUSq-RwgESMSQxtgpaA@mail.gmail.com>
References: <CALF0-+U0YwO+1BtXC4rz0hGNR7AjEjwUnF+MAnAX+SiOTSujDQ@mail.gmail.com>
	<CALF0-+W=io9JZZz9gX71tGyYZnh_idcRWRSjP0RFkLjFmm0bfQ@mail.gmail.com>
	<CALF0-+X7_B8M6By5YuS7uHAYGGhS6FisUSq-RwgESMSQxtgpaA@mail.gmail.com>
Date: Mon, 7 May 2012 20:30:56 -0300
Message-ID: <CALF0-+WusJk7TQ2OkqGk5o_hnsVfopSQSrd=weLbMu=k7K4K2g@mail.gmail.com>
Subject: Re: [Q] Crappy bluetooth usb adapter is timing out
From: Ezequiel Garcia <elezegarcia@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, May 7, 2012 at 5:07 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> FWIW ^2, maybe it's my kernel (old, vendor-provided, and not-so-supported):
>

I just reproduced the buggy behavior on my 3.4.0 kernel.
So if I can get it to work on some other kernel (so I can
discard hw failures) I could conclude this is a kernel bug after all.

Ubuntu guys think it's kernel related:

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/268502
>

and here too:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/460743

If someone is reading this, and has any ideas...
I'm listening.

Thanks,
Ezequiel.
