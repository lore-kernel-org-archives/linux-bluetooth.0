Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BlueZ] Recognize Eddystone Configuration Service UUIDs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1461143773-17833-2-git-send-email-beaufort.francois@gmail.com>
Date: Wed, 20 Apr 2016 14:45:26 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8E9C4329-446A-437E-9602-32019A46A740@holtmann.org>
References: <1461143773-17833-1-git-send-email-beaufort.francois@gmail.com> <1461143773-17833-2-git-send-email-beaufort.francois@gmail.com>
To: Francois Beaufort <beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

> ---
> monitor/uuid.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
> 
> diff --git a/monitor/uuid.c b/monitor/uuid.c
> index 54adb0d..6c60a67 100644
> --- a/monitor/uuid.c
> +++ b/monitor/uuid.c
> @@ -540,6 +540,26 @@ static struct {
> 	{ }
> };
> 
> +static struct {

lets make the table also const.

> +	const char *uuid;
> +	const char *str;
> +} uuid128_table[] = {
> +	{ "a3c87500-8ed3-4bdf-8a39-a01bebede295", "Eddystone Configuration Service"	},
> +	{ "a3c87501-8ed3-4bdf-8a39-a01bebede295", "Capabilities"			},
> +	{ "a3c87502-8ed3-4bdf-8a39-a01bebede295", "Active Slot"				},
> +	{ "a3c87503-8ed3-4bdf-8a39-a01bebede295", "Advertising Interval"		},
> +	{ "a3c87504-8ed3-4bdf-8a39-a01bebede295", "Radio Tx Power"			},
> +	{ "a3c87505-8ed3-4bdf-8a39-a01bebede295", "(Advanced) Advertised Tx Power"	},
> +	{ "a3c87506-8ed3-4bdf-8a39-a01bebede295", "Lock State"				},
> +	{ "a3c87507-8ed3-4bdf-8a39-a01bebede295", "Unlock"				},
> +	{ "a3c87508-8ed3-4bdf-8a39-a01bebede295", "Public ECDH Key"			},
> +	{ "a3c87509-8ed3-4bdf-8a39-a01bebede295", "EID Identity Key"			},
> +	{ "a3c8750a-8ed3-4bdf-8a39-a01bebede295", "ADV Slot Data"			},
> +	{ "a3c8750b-8ed3-4bdf-8a39-a01bebede295", "(Advanced) Factory reset"		},
> +	{ "a3c8750c-8ed3-4bdf-8a39-a01bebede295", "(Advanced) Remain Connectable"	},
> +	{ NULL, NULL }

Just us an empty { } here.

> +};
> +

I am fine doing it this way, but since we might add more than just Eddystone, maybe this should be split in a prefix match table and then subtable for UUID-16 or UUID-32 matches. Main reason is so that we can prefix these with Eddystone or other project/company/vendor names. Other a UUID name that just says "Unlock" for example is a bit to generic and misleading.

> const char *uuid16_to_str(uint16_t uuid)
> {
> 	int i;
> @@ -567,6 +587,7 @@ const char *uuid128_to_str(const unsigned char *uuid)
> 
> const char *uuidstr_to_str(const char *uuid)
> {
> +	int i;
> 	uint32_t val;

Generally I prefer that i iteration variable come last.

> 
> 	if (!uuid)
> @@ -575,6 +596,11 @@ const char *uuidstr_to_str(const char *uuid)
> 	if (strlen(uuid) != 36)
> 		return NULL;
> 
> +	for (i = 0; uuid128_table[i].str; i++) {
> +		if (strcasecmp(uuid128_table[i].uuid, uuid) == 0)
> +			return uuid128_table[i].str;
> +	}
> +
> 	if (strncasecmp(uuid + 8, "-0000-1000-8000-00805f9b34fb", 28))
> 		return "Vendor specific";

Regards

Marcel

