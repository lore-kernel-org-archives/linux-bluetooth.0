Return-Path: <cyrus@holtmann.org>
Message-id: <52FE0582.3010702@samsung.com>
Date: Fri, 14 Feb 2014 13:01:06 +0100
From: Michael Knudsen <m.knudsen@samsung.com>
MIME-version: 1.0
To: Kirill Tkhai <ktkhai@parallels.com>,
	linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] bluetooth: Do not free priv until timer handler hasn't
 actually stopped using it
References: <1392377748.5384.28.camel@tkhai>
In-reply-to: <1392377748.5384.28.camel@tkhai>
Content-type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/14/2014 12:35 PM, Kirill Tkhai wrote:
> Function del_timer() does not guarantee that timer was really deleted.
> If the timer handler is beeing executed at the moment, the function
> just returns. So, it's possible to use already freed memory in the handler:

This is not enough.  The timer must be deleted in bcsp_close() before
hu->priv is set to NULL as the timer code dereferences hu->priv.

There is a similar issue in hci_h5.c where the timer must be stopped
before purging h5->unack.

-m.
