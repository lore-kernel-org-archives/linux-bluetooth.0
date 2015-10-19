Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] Bluetooth: hidp: fix device disconnect on idle timeout
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441620341-553-1-git-send-email-dh.herrmann@gmail.com>
Date: Mon, 19 Oct 2015 22:44:53 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mark Haun <haunma@keteu.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	stable@vger.kernel.org
Message-Id: <17A816CE-E802-4735-86D8-E9FB5E2E183E@holtmann.org>
References: <1441620341-553-1-git-send-email-dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> The HIDP specs define an idle-timeout which automatically disconnects a
> device. This has always been implemented in the HIDP layer and forced a
> synchronous shutdown of the hidp-scheduler. This works just fine, but
> lacks a forced disconnect on the underlying l2cap channels. This has been
> broken since:
> 
>    commit 5205185d461d5902325e457ca80bd421127b7308
>    Author: David Herrmann <dh.herrmann@gmail.com>
>    Date:   Sat Apr 6 20:28:47 2013 +0200
> 
>        Bluetooth: hidp: remove old session-management
> 
> The old session-management always forced an l2cap error on the ctrl/intr
> channels when shutting down. The new session-management skips this, as we
> don't want to enforce channel policy on the caller. In other words, if
> user-space removes an HIDP device, the underlying channels (which are
> *owned* and *referenced* by user-space) are still left active. User-space
> needs to call shutdown(2) or close(2) to release them.
> 
> Unfortunately, this does not work with idle-timeouts. There is no way to
> signal user-space that the HIDP layer has been stopped. The API simply
> does not support any event-passing except for poll(2). Hence, we restore
> old behavior and force EUNATCH on the sockets if the HIDP layer is
> disconnected due to idle-timeouts (behavior of explicit disconnects
> remains unmodified). User-space can still call
> 
>    getsockopt(..., SO_ERROR, ...)
> 
> ..to retrieve the EUNATCH error and clear sk_err. Hence, the channels can
> still be re-used (which nobody does so far, though). Therefore, the API
> still supports the new behavior, but with this patch it's also compatible
> to the old implicit channel shutdown.
> 
> Cc: <stable@vger.kernel.org> # 3.10+
> Reported-by: Mark Haun <haunma@keteu.org>
> Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi Mark & Luiz
> 
> Can you give this a spin? This should fix the reported issues! I like the
> implementation much more than calling shutdown(2) implicitly in the kernel.
> With sk_err we avoid enforcing a behavior and let user-space deal with it.
> 
> Btw., this needs back-porting to >=3.10 (which introduced the new session
> management).
> 
> Thanks for the report!
> David
> 
> net/bluetooth/hidp/core.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

