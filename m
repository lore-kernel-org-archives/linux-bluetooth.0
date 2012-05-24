Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 12:22:08 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 3/3] Blueooth: Remove parent socket usage from l2cap_core.c
Message-ID: <20120524092206.GG24715@aemeltch-MOBL1>
References: <1337821964-4618-9-git-send-email-gustavo@padovan.org>
 <1337839374-20443-1-git-send-email-gustavo@padovan.org>
 <1337839374-20443-2-git-send-email-gustavo@padovan.org>
 <1337839374-20443-3-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337839374-20443-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 24, 2012 at 03:02:54AM -0300, Gustavo Padovan wrote:
> @@ -900,16 +900,21 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
>  {
>  	struct sock *sk, *parent = data;
>  
> +	lock_sock(parent);
> +
>  	/* Check for backlog size */
>  	if (sk_acceptq_is_full(parent)) {
>  		BT_DBG("backlog full %d", parent->sk_ack_backlog);
> +		release_sock(parent);
>  		return NULL;
>  	}

You seems to forget to post patch adding sk_acceptq_is_full to
l2cap_sock_new_connection_cb

Best regards 
Andrei Emeltchenko 

