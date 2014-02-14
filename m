Return-Path: <cyrus@holtmann.org>
Message-ID: <1392379810.5384.34.camel@tkhai>
Subject: Re: [PATCH] bluetooth: Do not free priv until timer handler hasn't
 actually stopped using it
From: Kirill Tkhai <ktkhai@parallels.com>
To: Michael Knudsen <m.knudsen@samsung.com>
CC: <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
Date: Fri, 14 Feb 2014 16:10:10 +0400
In-Reply-To: <52FE0582.3010702@samsung.com>
References: <1392377748.5384.28.camel@tkhai> <52FE0582.3010702@samsung.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

В Птн, 14/02/2014 в 13:01 +0100, Michael Knudsen пишет:
> On 02/14/2014 12:35 PM, Kirill Tkhai wrote:
> > Function del_timer() does not guarantee that timer was really deleted.
> > If the timer handler is beeing executed at the moment, the function
> > just returns. So, it's possible to use already freed memory in the handler:
> 
> This is not enough.  The timer must be deleted in bcsp_close() before
> hu->priv is set to NULL as the timer code dereferences hu->priv.
> 
> There is a similar issue in hci_h5.c where the timer must be stopped
> before purging h5->unack.
> 
> -m.

Good, consider my email as reported-by. Please, fix that if you get on
well with bluetooth stack. I am far from it.

Kirill
