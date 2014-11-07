Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Alex Gal <a.gal@miip.ca>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] plugins/sixaxis: Add Sony Navigation Controller
Date: Fri, 07 Nov 2014 22:00:37 +0100
Message-ID: <11059845.T45spOuEj8@leonov>
In-Reply-To: <1415287754-868-1-git-send-email-a.gal@miip.ca>
References: <1415287754-868-1-git-send-email-a.gal@miip.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thursday 06 of November 2014 10:29:13 Alex Gal wrote:
> ---
>  plugins/sixaxis.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index b09404a..ac53ba9 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -60,6 +60,13 @@ static const struct {
>  		.pid = 0x0268,
>  		.version = 0x0000,
>  	},
> +	{
> +		.name = "Navigation Controller",
> +		.source = 0x0002,
> +		.vid = 0x054c,
> +		.pid = 0x042f,
> +		.version = 0x0000,
> +	},
>  };
> 
>  struct leds_data {

Both patches applied, thanks.

-- 
BR
Szymon Janc
