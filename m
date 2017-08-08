Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Nicolas Werner <nicolas.werner@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] plugins/sixaxis: Use the same device name as the kernel
Date: Tue, 08 Aug 2017 13:52:58 +0200
Message-ID: <1738480.akGYgfIP2l@ix>
In-Reply-To: <20170807224833.17861-1-nicolas.werner@gmx.net>
References: <20170807224833.17861-1-nicolas.werner@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicolas,

On Tuesday, 8 August 2017 00:48:33 CEST Nicolas Werner wrote:
> Some games check the device name to recognize a playstation controller.
> This changes the device name, when using a PS3 controller over
> bluetooth, to match the device name, that is advertised when using the
> controller via USB.
> ---
>  plugins/sixaxis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index fcc93bc60..7e3c950b4 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -56,7 +56,7 @@ static const struct {
>  	uint16_t version;
>  } devices[] = {
>  	{
> -		.name = "PLAYSTATION(R)3 Controller",
> +		.name = "Sony PLAYSTATION(R)3 Controller",
>  		.source = 0x0002,
>  		.vid = 0x054c,
>  		.pid = 0x0268,

Patch applied, thanks.

-- 
pozdrawiam
Szymon Janc
