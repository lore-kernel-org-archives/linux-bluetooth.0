Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Dec 2013 10:03:11 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] obex: Fix checking incorrect error code
Message-ID: <20131209080310.GC6506@aemeltch-MOBL1>
References: <1386086694-22682-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386086694-22682-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Tue, Dec 03, 2013 at 06:04:54PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> chdir return -1 if error and 0 in success. Checking for > 0 is pointless.
> ---
>  tools/obex-server-tool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/obex-server-tool.c b/tools/obex-server-tool.c
> index e37c56f..86c2271 100644
> --- a/tools/obex-server-tool.c
> +++ b/tools/obex-server-tool.c
> @@ -427,7 +427,7 @@ int main(int argc, char *argv[])
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	if (option_root && chdir(option_root) > 0) {
> +	if (option_root && chdir(option_root) < 0) {
>  		perror("chdir:");
>  		exit(EXIT_FAILURE);
>  	}
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
