Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Mar 2015 10:25:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix use after free in l2cap_chan_timeout
Message-ID: <20150319082539.GA29243@t440s.lan>
References: <1426753191-9468-1-git-send-email-harish_kandiga@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426753191-9468-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 19, 2015, Harish Jenny K N wrote:
> There is a potential use after free in bt_sock_poll when a
> socket gets killed without getting unlinked from accept_q.
> Hence added code to unlink from accpept_q by calling teardown
> before freeing the socket for channel type L2CAP_CHAN_CONN_ORIENTED.
> 
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>  net/bluetooth/l2cap_core.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6ba33f9..c6955fb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -415,6 +415,11 @@ static void l2cap_chan_timeout(struct work_struct *work)
>  
>  	l2cap_chan_close(chan, reason);
>  
> +	if ((chan->state == BT_CONNECTED || chan->state == BT_CONFIG) &&
> +	    chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
> +		chan->ops->teardown(chan, 0);
> +	}

Looks quite ok to me, except for a minor issue: we generally don't use
{} for single-line branches.

Do you have some simple way to reproduce this? It'd be nice if we could
add a test case for it to our user space l2cap-tester tool.

Johan
