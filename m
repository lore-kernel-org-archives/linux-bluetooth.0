Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Oct 2014 03:07:01 -0700 (PDT)
From: Szymon Janc <szymon.janc@tieto.com>
To: Alex Gal <a.gal@miip.ca>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adds Sony Move Navigation controller.
Message-ID: <2485489.uEt5Y7pmtU@uw000953>
In-Reply-To: <1412697877-7508-1-git-send-email-a.gal@miip.ca>
References: <1412697877-7508-1-git-send-email-a.gal@miip.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

Thanks for patch, some small comments from my side.

On Tuesday 07 of October 2014 12:04:37 Alex Gal wrote:
> Signed-off-by: Alex <a.gal@miip.ca>

We don't use SOB in userspace so this is not needed.

Also I'd prefer if you could put plugin change into separate patch.
And prefix them appropriately ie. "sixaxis: " for plugin and "input: "
for input change.

> ---
>  plugins/sixaxis.c       | 7 +++++++
>  profiles/input/server.c | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index b09404a..6f7893e 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -60,6 +60,13 @@ static const struct {
>  		.pid = 0x0268,
>  		.version = 0x0000,
>  	},
> +	{
> +		.name = "PLAYSTATION(R)3 Controller", /* Move Navigation */

Does Move Navigation use same name as DS3?

> +		.source = 0x0002,
> +		.vid = 0x054c,
> +		.pid = 0x042f,
> +		.version = 0x0000,
> +	},
>  };
>  
>  struct leds_data {
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index 307db96..5463311 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -140,6 +140,10 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
>  	if (vid == 0x054c && pid == 0x05c4)
>  		return true;
>  
> +    /* Move Navigation */
> +	if (vid == 0x054c && pid == 0x042f)
> +		return true;
> +
>  	return false;
>  }
>  
> 

-- 
Best regards, 
Szymon Janc
