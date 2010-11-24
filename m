Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Fix error handling for l2cap_init()
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
In-Reply-To: <1290423434-2920-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1290423434-2920-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 13:42:34 +0100
Message-ID: <1290602554.13641.13.camel@aeonflux.mpl.access-company.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> create_singlethread_workqueue() may fail with errors such as -ENOMEM. If
> this happens, the return value is not set to a negative value and the
> module load will succeed. It will then crash on module unload because of
> a destroy_workqueue() call on a NULL pointer.
> 
> Additionally, the _busy_wq workqueue is not being destroyed if any
> errors happen on l2cap_init().
> 
> Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
> ---
>  net/bluetooth/l2cap.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 18a802c..7980e24 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -4875,8 +4875,10 @@ static int __init l2cap_init(void)
>  		return err;
>  
>  	_busy_wq = create_singlethread_workqueue("l2cap");
> -	if (!_busy_wq)
> -		goto error;
> +	if (!_busy_wq) {
> +		err = -ENOMEM;
> +		goto error_busy_wq;
> +	}

aren't these returning PTR_ERR etc.?

Regards

Marcel


