Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 BlueZ 3/3] src: make att max le mtu configurable in
 main.conf
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <B79Xs2cdPmQL7qvBHyDWRN6gANE7p-5iiOJb80T_jboNC718mSOqDlCU_oiY9iFnrSlpudEgwF0fkEGXcawdSejgkAQCJVZ9aNq7bguKq7c=@krauser.org>
Date: Sat, 7 Jul 2018 20:23:27 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <EF690F2A-E8C3-4902-A0E9-5F689C7CDF6A@holtmann.org>
References: <B79Xs2cdPmQL7qvBHyDWRN6gANE7p-5iiOJb80T_jboNC718mSOqDlCU_oiY9iFnrSlpudEgwF0fkEGXcawdSejgkAQCJVZ9aNq7bguKq7c=@krauser.org>
To: David Krauser <david@krauser.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> ---
> src/device.c  |  2 +-
> src/hcid.h    |  1 +
> src/main.c    | 16 ++++++++++++++++
> src/main.conf |  5 +++++
> 4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 4f1af7012..75340cabe 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4986,7 +4986,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
> 		}
> 	}
> 
> -	dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
> +	dev->att_mtu = MIN(mtu, main_opts.gatt_max_le_mtu);
> 	attrib = g_attrib_new(io,
> 			cid == ATT_CID ? BT_ATT_DEFAULT_LE_MTU : dev->att_mtu,
> 			false);
> diff --git a/src/hcid.h b/src/hcid.h
> index 2c2b89d9c..bcb077dde 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -54,6 +54,7 @@ struct main_opts {
> 
> 	bt_mode_t	mode;
> 	bt_gatt_cache_t gatt_cache;
> +	uint16_t	gatt_max_le_mtu;
> 
> 	uint8_t		min_enc_key_size;
> };
> diff --git a/src/main.c b/src/main.c
> index 7e6af42cd..5e19d68b3 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -50,6 +50,7 @@
> #include "log.h"
> #include "backtrace.h"
> 
> +#include "shared/att-types.h"
> #include "lib/uuid.h"
> #include "hcid.h"
> #include "sdpd.h"
> @@ -104,6 +105,7 @@ static const char *policy_options[] = {
> static const char *gatt_options[] = {
> 	"Cache",
> 	"MinEncKeySize",
> +	"MaxLeMtu",
> 	NULL
> };

I prefer DefaultMTU or something along the lines. Since MaxMaxTransferUnit sounds weird.

Also while at it, I am not going to git blame who added MinEncKeySize needs to rethink it. We don't abbreviate in main.conf. So that should have been MinEncryptionKeySize and it needs to be fixed.

Also ..

# Minimum required Encryption Key Size for accessing secured characteristics.
# Possible values: 0 and 7-16. 0 means don't care.
# Defaults to 0
# MinEncKeySize = 0

It is #MinEncKeySize.. here. The extra space behind # is not used.

Regards

Marcel

