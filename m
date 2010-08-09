Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Aug 2010 17:51:49 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Scherba <dscherba@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/2] Remove non-functional hci_devinfo calls in
 init_device()
Message-ID: <20100809215149.GA25488@jh-x301>
References: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org>
 <1281388059-15945-2-git-send-email-dscherba@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1281388059-15945-2-git-send-email-dscherba@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Aug 09, 2010, David Scherba wrote:
> ---
>  plugins/hciops.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/plugins/hciops.c b/plugins/hciops.c
> index 5775cf1..b38c056 100644
> --- a/plugins/hciops.c
> +++ b/plugins/hciops.c
> @@ -175,12 +175,6 @@ static void init_device(int index)
>  		goto fail;
>  	}
>  
> -	if (hci_devinfo(index, &di) < 0)
> -		goto fail;
> -
> -	if (hci_test_bit(HCI_RAW, &di.flags))
> -		goto done;
> -
>  done:
>  	hci_close_dev(dd);
>  	exit(0);

Nice catch, but that's not quite enough:

plugins/hciops.c: In function ‘init_device’:
plugins/hciops.c:178: error: label ‘done’ defined but not used
plugins/hciops.c:125: error: unused variable ‘di’

Always check that your patch compiles cleanly with ./bootstrap-configure
before submitting upstream.

Johan
