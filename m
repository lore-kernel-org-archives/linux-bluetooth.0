Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bnep: Add extra debug information for bnep_up
Date: Thu, 09 Oct 2014 13:30:44 +0200
Message-ID: <3300021.NoEnUzGqr8@uw000953>
In-Reply-To: <1412849863-6691-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1412849863-6691-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 09 of October 2014 13:17:43 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adding extra debug information helps to investigate failing cases
> ---
>  profiles/network/bnep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 136709d..a6b8728 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -210,7 +210,8 @@ static int bnep_if_up(const char *devname)
>  	close(sk);
>  
>  	if (err < 0) {
> -		error("Could not bring up %s", devname);
> +		error("Could not bring up %s: %s(%d)", devname, strerror(errno),
> +									errno);
>  		return err;
>  	}

You should use -err no errno here. Errno might be already overwritten by call
to close().
 

-- 
Best regards, 
Szymon Janc
