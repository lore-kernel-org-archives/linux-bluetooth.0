Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:29:09 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH 08/12] Bluetooth: Add chan->ops->defer()
Message-ID: <20120525072908.GD3089@aemeltch-MOBL1>
References: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
 <1337900389-30915-8-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337900389-30915-8-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 24, 2012 at 07:59:48PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> When DEFER_SETUP is set defer() will trigger an authorization request
> to the userspace.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |   14 ++++++--------
>  net/bluetooth/l2cap_sock.c    |   12 ++++++++++++
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 46b5cff..b03861f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -531,6 +531,7 @@ struct l2cap_ops {
>  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
>  					       unsigned long len, int nb);
>  	void			(*ready) (void *data);
> +	void			(*defer) (void *data);
>  };
>  
>  struct l2cap_conn {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 20e4a9b..7719508 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1058,12 +1058,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  				lock_sock(sk);
>  				if (test_bit(CONF_DEFER_SETUP,
>  					     &chan->conf_state)) {
> -					struct sock *parent = bt_sk(sk)->parent;
>  					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
>  					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);

Looks like this is not against the latest tree ;)

Otherwise looks good.

Best regards 
Andrei Emeltchenko 

