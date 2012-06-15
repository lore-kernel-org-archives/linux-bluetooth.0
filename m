Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 10:49:09 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/8] Added /proc/net/hci via bt_procfs_init()
Message-ID: <20120615074907.GA7205@aemeltch-MOBL1>
References: <20120615.021718.862586446299200414.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120615.021718.862586446299200414.yamato@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Masatake,

On Fri, Jun 15, 2012 at 02:17:18AM +0900, Masatake YAMATO wrote:
> Added /proc/net/hci via bt_procfs_init().
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  net/bluetooth/hci_sock.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 5914623..3452d27 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1107,21 +1107,32 @@ int __init hci_sock_init(void)
>  		return err;
>  
>  	err = bt_sock_register(BTPROTO_HCI, &hci_sock_family_ops);
> -	if (err < 0)
> +	if (err < 0) {
> +	  	BT_ERR("HCI socket registration failed");
>  		goto error;
> +	}
> +
> +	err = bt_procfs_init(THIS_MODULE, &init_net, "hci", &hci_sk_list, NULL);
> +	if (err < 0) {
> +		BT_ERR("Failed to create HCI proc file");
> +		bt_sock_unregister(BTPROTO_HCI);
> +		goto error;
> +	}
> +
>  

too much spaces here?

Best regards 
Andrei Emeltchenko 

>  	BT_INFO("HCI socket layer initialized");
>  
>  	return 0;
>  
>  error:
> -	BT_ERR("HCI socket registration failed");

