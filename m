Return-Path: <cyrus@holtmann.org>
Message-ID: <51E6B63D.8000709@hurleysoftware.com>
Date: Wed, 17 Jul 2013 11:20:29 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 8/8] Add module_put in rfcomm_dev_add error path
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-8-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-8-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/12/2013 04:40 PM, Gianluca Anzolin wrote:
> rfcomm_dev_add doesn't call module_put() in its error path when it took a
> reference.

Good catch.

> Fix by always calling __module_get() and module_put() in the error path.
>
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>   net/bluetooth/rfcomm/tty.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 7bc603a..40288c3 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -357,11 +357,11 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
>
>   	rfcomm_dlc_unlock(dlc);
>
> +out:
>   	/* It's safe to call __module_get() here because socket already
>   	   holds reference to this module. */
>   	__module_get(THIS_MODULE);
>
> -out:
>   	spin_unlock(&rfcomm_dev_lock);
>
>   	if (err < 0)

Is it possible to reverse the order-of-operations here:

	spin_unlock(&rfcomm_dev_lock);
	__module_get(THIS_MODULE);

Then the out: label could be moved to the function exit as noted below.

The rfcomm_dev_lock use here is what creates the mess in rfcomm_dev_state_change().
Anyone know why the rfcomm_dev_lock critical section is so ridiculously large
here? Does it really protect the module count??


> @@ -386,6 +386,7 @@ out:
>   	return dev->id;
>
>   free:
> +	module_put(THIS_MODULE);

     out:
	spin_unlock(&rfcomm_dev_lock);

>   	kfree(dev);
>   	return err;
>   }
>
