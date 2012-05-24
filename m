Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 12:50:06 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 7/8] Bluetooth: Create DEFER_SETUP flag in conf_state
Message-ID: <20120524095005.GN24715@aemeltch-MOBL1>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
 <1337821964-4618-5-git-send-email-gustavo@padovan.org>
 <1337821964-4618-6-git-send-email-gustavo@padovan.org>
 <1337821964-4618-7-git-send-email-gustavo@padovan.org>
 <1337821964-4618-8-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337821964-4618-8-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 23, 2012 at 10:12:43PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Remove another socket usage from l2cap_core.c

Good idea.

...
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -623,10 +623,15 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
>  			break;
>  		}
>  
> -		if (opt)
> +		if (opt) {
>  			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> -		else
> +			set_bit(CONF_DEFER_SETUP, &chan->conf_state);
> +		} else {
>  			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> +			clear_bit(CONF_DEFER_SETUP, &chan->conf_state);

Do we now have 2 similar flags?

> +		}
> +
> +

Remove extra line

Best regards 
Andrei Emeltchenko 

