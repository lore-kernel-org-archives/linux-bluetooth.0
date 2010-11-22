Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 15:34:47 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix error handling for l2cap_init()
Message-ID: <20101122173447.GA23109@vigoh>
References: <1290423434-2920-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290423434-2920-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2010-11-22 06:57:14 -0400]:

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

I prefer if you move the workqueue creation to after the
hci_register_proto block. That will make things easier.

-- 
Gustavo F. Padovan
http://profusion.mobi
