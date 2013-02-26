Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 16:56:29 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 03/16] Bluetooth: hidp: simplify error path in sock-init
Message-ID: <20130226195629.GC10898@joana>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
 <1361731026-7428-4-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361731026-7428-4-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-02-24 19:36:53 +0100]:

> We currently print errors twice when doing a "goto error;". Avoid this and
> also use labels for each error-condition. We shouldn't mix
> "inline-cleanup" and "goto-cleanup" in a single function. It makes
> extending the function later just more work.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  net/bluetooth/hidp/sock.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
> index 5d0f1ca..ca86436 100644
> --- a/net/bluetooth/hidp/sock.c
> +++ b/net/bluetooth/hidp/sock.c
> @@ -281,22 +281,22 @@ int __init hidp_init_sockets(void)
>  	err = bt_sock_register(BTPROTO_HIDP, &hidp_sock_family_ops);
>  	if (err < 0) {
>  		BT_ERR("Can't register HIDP socket");
> -		goto error;
> +		goto err_proto;
>  	}
>  
>  	err = bt_procfs_init(THIS_MODULE, &init_net, "hidp", &hidp_sk_list, NULL);
>  	if (err < 0) {
>  		BT_ERR("Failed to create HIDP proc file");
> -		bt_sock_unregister(BTPROTO_HIDP);
> -		goto error;
> +		goto err_sock;

Actually I'm ok with mixing inline and goto clean up here, It's simpler
than add another goto.

>  	}
>  
>  	BT_INFO("HIDP socket layer initialized");
>  
>  	return 0;
>  
> -error:
> -	BT_ERR("Can't register HIDP socket");

So just remove this error message and we should be fine. 

	Gustavo
