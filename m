Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 08/14] tools/btgatt-client: Print type of service
Date: Wed, 22 Oct 2014 20:00:15 +0200
Message-ID: <2910797.H92HIHLy1G@athlon>
In-Reply-To: <1413454646-23076-9-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com> <1413454646-23076-9-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 16 October 2014 12:17:20 Marcin Kraglak wrote:
> ---
>  tools/btgatt-client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index d900e08..5c692ff 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -182,8 +182,9 @@ static void print_service(const bt_gatt_service_t
> *service) return;
>  	}
> 
> -	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
> +	printf(COLOR_RED "service %s" COLOR_OFF " - start: 0x%04x, "
>  				"end: 0x%04x, uuid: ",
> +				service->primary ? "primary" : "second.",
>  				service->start_handle, service->end_handle);

As we discussed offline, maybe having "type: foo" would be nicer instead of 
"serivce second." ?

>  	print_uuid(service->uuid);

-- 
Szymon K. Janc
szymon.janc@gmail.com
