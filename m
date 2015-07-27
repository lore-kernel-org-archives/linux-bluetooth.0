Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anupam Roy <anupam.r@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH] android/client/if-hl.c:Handle failure from malloc() request
Date: Mon, 27 Jul 2015 21:22:51 +0200
Message-ID: <1893931.omVqhXpsI8@leonov>
In-Reply-To: <1437485881-10277-1-git-send-email-anupam.r@samsung.com>
References: <1437485881-10277-1-git-send-email-anupam.r@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anupam,

On Tuesday 21 of July 2015 09:38:01 Anupam Roy wrote:
> In case malloc() request fails, just print error message
> and return. Dereferencing reg.mdep_cfg in case of failure
> can lead to crash.
> ---
>  android/client/if-hl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/client/if-hl.c b/android/client/if-hl.c
> index e0818ba..bd05671 100644
> --- a/android/client/if-hl.c
> +++ b/android/client/if-hl.c
> @@ -201,6 +201,10 @@ static void register_application_p(int argc, const char
> **argv) reg.number_of_mdeps = atoi(argv[6]);
> 
>  	reg.mdep_cfg = malloc(reg.number_of_mdeps * sizeof(bthl_mdep_cfg_t));
> +	if (!reg.mdep_cfg) {
> +		haltest_error("malloc failed\n");
> +		return;
> +	}
>  	mdep_argc_init = 7;
> 
>  	for (i = 0; i < reg.number_of_mdeps; i++) {

Patch applied, thanks.

-- 
BR
Szymon Janc
