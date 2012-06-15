Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 10:53:06 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/8] Added /proc/net/rfcomm via bt_procfs_init()
Message-ID: <20120615075305.GC7205@aemeltch-MOBL1>
References: <20120615.021835.1759601069982013045.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120615.021835.1759601069982013045.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Fri, Jun 15, 2012 at 02:18:35AM +0900, Masatake YAMATO wrote:
> Added /proc/net/rfcomm via bt_procfs_init().
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  net/bluetooth/rfcomm/sock.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index e8707de..0d0a35f 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -1052,8 +1052,18 @@ int __init rfcomm_init_sockets(void)
>  		return err;
>  
>  	err = bt_sock_register(BTPROTO_RFCOMM, &rfcomm_sock_family_ops);
> -	if (err < 0)
> +	if (err < 0) {
> +	  	BT_ERR("RFCOMM socket layer registration failed");
>  		goto error;
> +	}
> +
> +	err = bt_procfs_init(THIS_MODULE, &init_net, "rfcomm", &rfcomm_sk_list, NULL);
> +	if (err < 0) {
> +		BT_ERR("Failed to create RFCOMM proc file");
> +		bt_sock_unregister(BTPROTO_RFCOMM);
> +		goto error;
> +	}
> +
>  

Extra space here.

Best regards 
Andrei Emeltchenko


