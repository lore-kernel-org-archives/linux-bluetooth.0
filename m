Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jan 2012 14:22:53 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH 1/2] Bluetooth: Make l2cap_ertm_data_rcv static
Message-ID: <20120117122250.GA18057@aemeltch-MOBL1>
References: <1326796951-16377-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326796951-16377-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jan 17, 2012 at 11:42:30AM +0100, Szymon Janc wrote:
> It is not used outside of l2cap_core.c.

Actually I am going to use it outside of l2cap_core. I will send my
patches implementing A2MP without using kernel sockets soon.

Best regards 
Andrei Emeltchenko 

> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0087db8..d66c368 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4139,7 +4139,7 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_cont
>  	return 0;
>  }
>  
> -int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
> +static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>  {
>  	u32 control;
>  	u16 req_seq;
> -- 

