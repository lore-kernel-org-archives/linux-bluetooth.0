Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH] tools/hciconfig:Fixed Memory Leak
Date: Mon, 27 Jul 2015 12:07:30 +0200
Message-ID: <5618947.PXfyCffJ71@leonov>
In-Reply-To: <1437989799-17394-1-git-send-email-anchit.n@samsung.com>
References: <1437989799-17394-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Monday 27 of July 2015 15:06:39 Anchit Narang wrote:
> Freed memory allocated to structure hci_dev_list_req to avoid memory leak
> ---
>  tools/hciconfig.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> index 6397e71..0738b53 100644
> --- a/tools/hciconfig.c
> +++ b/tools/hciconfig.c
> @@ -69,6 +69,10 @@ static void print_dev_list(int ctl, int flags)
> 
>  	if (ioctl(ctl, HCIGETDEVLIST, (void *) dl) < 0) {
>  		perror("Can't get device list");
> +
> +		if (dl)
> +		    free(dl);
> +

There is no need to check for non-NULL pointer as free() handles this 
internally.

>  		exit(1);
>  	}
> 
> @@ -78,6 +82,9 @@ static void print_dev_list(int ctl, int flags)
>  			continue;
>  		print_dev_info(ctl, &di);
>  	}
> +
> +	if (dl)
> +	    free(dl);

Same here.

>  }
> 
>  static void print_pkt_type(struct hci_dev_info *di)

-- 
BR
Szymon Janc
