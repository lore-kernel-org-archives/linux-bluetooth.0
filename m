Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 12:39:59 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 3/8] Bluetooth: Add l2cap_chan->ops->ready()
Message-ID: <20120524093958.GL24715@aemeltch-MOBL1>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337821964-4618-4-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 23, 2012 at 10:12:39PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> This move socket specific code to l2cap_sock.c.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |   18 +++---------------
>  net/bluetooth/l2cap_sock.c    |   21 +++++++++++++++++++++
>  3 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 29f7b06..d1f6819 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -530,6 +530,7 @@ struct l2cap_ops {
>  	void			(*state_change) (void *data, int state);
>  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
>  					       unsigned long len, int nb);
> +	void			(*ready) (void *data);

Again, why void *data ?

Best regards 
Andrei Emeltchenko 

