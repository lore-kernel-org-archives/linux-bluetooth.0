Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?TWljaGHFgg==?= Narajowski
        <michal.narajowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] doc/mgmt-api: Allow set appearance only for LE capable controllers
Date: Wed, 21 Sep 2016 20:20:30 +0200
Message-ID: <1944213.CKoTx5OuZl@ix>
In-Reply-To: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Micha=C5=82,

On Tuesday, 20 September 2016 14:02:06 CEST Micha=C5=82 Narajowski wrote:
> ---
>  doc/mgmt-api.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 334c884..a7bd6e4 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2908,7 +2908,11 @@ Set Appearance Command
>  	This command generates a Command Complete event on success
>  	or a Command Status event on failure.
>=20
> -	Possible errors:	Invalid Parameters
> +	This command is only available for LE capable controllers.
> +	It will return Not Supported otherwise.
> +
> +	Possible errors:	Not Supported
> +				Invalid Parameters
>  				Invalid Index

All patches applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc
