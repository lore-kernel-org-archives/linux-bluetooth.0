Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 12:15:36 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/7] Add ATT find info req/resp dump
Message-ID: <20110209141536.GB1995@joana>
References: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
 <1297260110-10515-4-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297260110-10515-4-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Dieb Martins <andre.dieb@signove.com> [2011-02-09 11:01:47 -0300]:

> ---
>  parser/att.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 112 insertions(+), 1 deletions(-)
> 
> diff --git a/parser/att.c b/parser/att.c
> index 526b7bf..79a74b5 100644
> --- a/parser/att.c
> +++ b/parser/att.c
> @@ -36,6 +36,27 @@
>  
>  #include "parser.h"
>  
> +#define GATT_PRIM_SVC_UUID		0x2800
> +#define GATT_SND_SVC_UUID		0x2801
> +#define GATT_INCLUDE_UUID		0x2802
> +#define GATT_CHARAC_UUID		0x2803
> +
> +#define GATT_CHARAC_DEVICE_NAME			0x2A00
> +#define GATT_CHARAC_APPEARANCE			0x2A01
> +#define GATT_CHARAC_PERIPHERAL_PRIV_FLAG	0x2A02
> +#define GATT_CHARAC_RECONNECTION_ADDRESS	0x2A03
> +#define GATT_CHARAC_PERIPHERAL_PREF_CONN	0x2A04
> +#define GATT_CHARAC_SERVICE_CHANGED		0x2A05
> +
> +#define GATT_CHARAC_EXT_PROPER_UUID	0x2900
> +#define GATT_CHARAC_USER_DESC_UUID	0x2901
> +#define GATT_CLIENT_CHARAC_CFG_UUID	0x2902
> +#define GATT_SERVER_CHARAC_CFG_UUID	0x2903
> +#define GATT_CHARAC_FMT_UUID		0x2904
> +#define GATT_CHARAC_AGREG_FMT_UUID	0x2905
> +
> +
> +
>  /* Attribute Protocol Opcodes */
>  #define ATT_OP_ERROR			0x01
>  #define ATT_OP_MTU_REQ			0x02
> @@ -196,6 +217,47 @@ static const char * atterror2str(uint8_t err)
>  	}
>  }
>  
> +static const char *uuid2str(uint16_t uuid)
> +{
> +	switch (uuid) {
> +	case GATT_PRIM_SVC_UUID:
> +		return "GATT Primary Service";
> +	case GATT_SND_SVC_UUID:
> +		return "GATT Secondary Service";
> +	case GATT_INCLUDE_UUID:
> +		return "GATT Include";
> +	case GATT_CHARAC_UUID:
> +		return "GATT Characteristic";
> +	case GATT_CHARAC_DEVICE_NAME:
> +		return "GATT(type) Device Name";
> +	case GATT_CHARAC_APPEARANCE:
> +		return "GATT(type) Appearance";
> +	case GATT_CHARAC_PERIPHERAL_PRIV_FLAG:
> +		return "GATT(type) Peripheral Privacy Flag";
> +	case GATT_CHARAC_RECONNECTION_ADDRESS:
> +		return "GATT(type) Characteristic Reconnection Address";
> +	case GATT_CHARAC_PERIPHERAL_PREF_CONN:
> +		return "GATT(type) Characteristic Preferred Connection Parameters";
> +	case GATT_CHARAC_SERVICE_CHANGED:
> +		return "GATT(type) Characteristic Service Changed";
> +	case GATT_CHARAC_EXT_PROPER_UUID:
> +		return "GATT(desc) Characteristic Extended Properties";
> +	case GATT_CHARAC_USER_DESC_UUID:
> +		return "GATT(desc) User Description";
> +	case GATT_CLIENT_CHARAC_CFG_UUID:
> +		return "GATT(desc) Client Characteristic Configuration";
> +	case GATT_SERVER_CHARAC_CFG_UUID:
> +		return "GATT(desc) Server Characteristic Configuration";
> +	case GATT_CHARAC_FMT_UUID:
> +		return "GATT(desc) Format";
> +	case GATT_CHARAC_AGREG_FMT_UUID:
> +		return "GATT(desc) Aggregate Format";
> +	default:
> +		return "Unknown";
> +	}
> +}
> +
> +

And a extra blank line here. ;)

-- 
Gustavo F. Padovan
http://profusion.mobi
