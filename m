Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323793282-24497-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323793282-24497-1-git-send-email-mikel.astiz@bmw-carit.de>
Date: Wed, 14 Dec 2011 12:21:15 +0200
Message-ID: <CABBYNZJaFHYYHtPEj5zqOoSHEjiMKL6rtbGqimFVn=1BMFKyKg@mail.gmail.com>
Subject: Re: [PATCH obexd] gobex: fix transfer search in transfer_complete
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Dec 13, 2011 at 6:21 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> The previous approach searched the transfer pointer itself, assuming
> that the transfers has not been modified if the pointer is in the list.
> However the callback could have removed the transfer and registered
> another one, which can eventually point to the same memory location.
>
> This is solved by looking for the transfer id instead of the pointer.
> ---

Ack.

-- 
Luiz Augusto von Dentz
