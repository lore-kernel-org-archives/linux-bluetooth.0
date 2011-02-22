Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Feb 2011 11:05:12 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] Fix --enable-usb build
Message-ID: <20110222140512.GA12838@piper>
References: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
 <1298367822-27766-5-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298367822-27766-5-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11:43 Tue 22 Feb, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> ---
>  configure.ac |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 602c948..fc63b8c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -156,7 +156,7 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--enable-usb],
>  	enable_usb=${enableval}
>  ])
>  AM_CONDITIONAL(USB, test "${enable_usb}" = "yes" &&
> -				test "${enable_server}" != "no")
> +				test "${enable_usb}" != "no")

I failed to notice how the new line that you added is different from the
first line of the AM_CONDITIONAL(). Perhaps just removing the "enable_server"
test is enough. Or am I missing something?

>  
>  AC_ARG_ENABLE(pcsuite, AC_HELP_STRING([--enable-pcsuite],
>  				[enable Nokia PcSuite plugin]), [
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
