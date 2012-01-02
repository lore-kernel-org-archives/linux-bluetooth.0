Return-Path: <cyrus@holtmann.org>
Message-ID: <1325542769.1965.396.camel@aeonflux>
Subject: Re: [PATCH 2/5] Bluetooth: Fix context in RFCOMM tty
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:19:29 -0800
In-Reply-To: <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-12-27 at 15:28 -0200, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> We now run in process context, no need to disable interrupts.
> Calls from the tty layer also run in process context.
> 
> rw_lock was converted to spinlock, we have more writers than readers in
> this case.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/tty.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

And here also, any reason this can not be RCU?

Regards

Marcel


