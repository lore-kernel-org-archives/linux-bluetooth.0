Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ v5 11/11] monitor: Refactor print_enable function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170731133910.26745-12-michal.narajowski@codecoup.pl>
Date: Fri, 4 Aug 2017 16:23:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <62FB6FF1-8A57-42CE-81BD-FC187FF85D62@holtmann.org>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
 <20170731133910.26745-12-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> ---
> monitor/packet.c | 321 +++++++------------------------------------------------
> 1 file changed, 37 insertions(+), 284 deletions(-)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index e1f69b145..c697890cf 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -557,6 +557,25 @@ void packet_print_error(const char *label, uint8_t error)
> 	print_error(label, error);
> }
> 
> +static void print_enable(const char *label, uint8_t enable)
> +{
> +	const char *str;
> +
> +	switch (enable) {
> +	case 0x00:
> +		str = "Disable”;

“Disabled”.

> +		break;
> +	case 0x01:
> +		str = "Enabled";
> +		break;
> +	default:
> +		str = "Reserved";
> +		break;
> +	}
> +
> +	print_field("%s: %s (0x%2.2x)", label, str, enable);
> +}
> +
> static void print_addr_type(const char *label, uint8_t addr_type)
> {
> 	const char *str;
> @@ -1198,21 +1217,7 @@ static void print_power_level(int8_t level, const char *type)
> 
> static void print_sync_flow_control(uint8_t enable)
> {
> -	const char *str;
> -
> -	switch (enable) {
> -	case 0x00:
> -		str = "Disabled";
> -		break;
> -	case 0x01:
> -		str = "Enabled";
> -		break;
> -	default:
> -		str = "Reserved";
> -		break;
> -	}
> -
> -	print_field("Flow control: %s (0x%2.2x)", str, enable);
> +	print_enable("Flow control", enable);
> }

Don’t do this. Use print_enable right where used to have print_sync_flow_control (and so on). Too many indirections are a bad thing.

Regards

Marcel

