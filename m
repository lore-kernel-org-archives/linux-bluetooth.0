Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v1 03/10] monitor: Add support PHY management commands and
 event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1523532061-17192-4-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Thu, 21 Jun 2018 16:29:56 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <E9C51ED9-BDA2-4EFF-A4FA-3F8B5129432C@holtmann.org>
References: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1523532061-17192-4-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> ---
> monitor/packet.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 65 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index b800a2d..e3b5ab7 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -97,6 +97,7 @@
> #define COLOR_UNKNOWN_ADDRESS_TYPE	COLOR_WHITE_BG
> #define COLOR_UNKNOWN_DEVICE_FLAG	COLOR_WHITE_BG
> #define COLOR_UNKNOWN_ADV_FLAG		COLOR_WHITE_BG
> +#define COLOR_UNKNOWN_PHY		COLOR_WHITE_BG
> 
> #define COLOR_PHY_PACKET		COLOR_BLUE
> 
> @@ -10611,6 +10612,7 @@ static const struct {
> 	{ 13, "Privacy"			},
> 	{ 14, "Controller Configuration"},
> 	{ 15, "Static Address"		},
> +	{ 16, "PHY Configuration"	},
> 	{ }
> };
> 
> @@ -11905,6 +11907,54 @@ static void mgmt_set_apperance_cmd(const void *data, uint16_t size)
> 	print_appearance(appearance);
> }
> 
> +static const struct {
> +	uint8_t bit;
> +	const char *str;
> +} mgmt_phy_table[] = {
> +	{  0, "1MTX"	},
> +	{  1, "1MRX"	},
> +	{  2, "2MTX"	},
> +	{  3, "2MRX"	},
> +	{  4, "CODEDTX"	},
> +	{  5, "CODEDRX"	},
> +	{ }
> +};

this is unreadable. Use full strings like “LE 1M TX” etc.

Regards

Marcel

