Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/7] Bluetooth: Initialize variables and timers for
 both channel's sides
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 21:55:30 -0700
Message-Id: <1254200130.2659.72.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> ERTM entity need to handle state vars, timers and counters to send and
> receive I-frames. We initialize all of them to the default values here.

while this is a good idea. Where is the justification for pushing this
after the merge window?

> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> ---
>  net/bluetooth/l2cap.c |   53 ++++++++++++++++++++++++++++++++----------------
>  1 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 9d586fb..3f9d74b 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2169,6 +2169,20 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
>  	*ptr += L2CAP_CONF_OPT_SIZE + len;
>  }
>  
> +static inline void l2cap_ertm_init(struct sock *sk) {
> +	l2cap_pi(sk)->expected_ack_seq = 0;

Coding style! The {  belong on the next line.

Regards

Marcel


