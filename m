Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?xYF1a2Fzeg==?= Rymanowski
        <lukasz.rymanowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/5] monitor: Add description for filter in scan parameters
Date: Wed, 19 Apr 2017 16:12:26 +0200
Message-ID: <2270039.JPxRPnK7gO@ix>
In-Reply-To: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
References: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi =C5=81ukasz,

On Wednesday, 12 April 2017 14:41:23 CEST =C5=81ukasz Rymanowski wrote:
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>         Type: Active (0x01)
>         Interval: 30.000 msec (0x0030)
>         Window: 30.000 msec (0x0030)
>         Own address type: Public (0x00)
>         Filter policy: Accept all advertisement, inc. directed unresolved
> RPA (0x02) ---
>  monitor/packet.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 5d927f5..219542e 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -6309,6 +6309,12 @@ static void le_set_scan_parameters_cmd(const void
> *data, uint8_t size) case 0x01:
>  		str =3D "Ignore not in white list";
>  		break;
> +	case 0x02:
> +		str =3D "Accept all advertisement, inc. directed unresolved RPA";
> +		break;
> +	case 0x03:
> +		str =3D "Ignore not in white list, exc. directed unresolved RPA";
> +		break;
>  	default:
>  		str =3D "Reserved";
>  		break;

All patches applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc
