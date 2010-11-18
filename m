Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 14:33:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Advertising data: extract local name
Message-ID: <20101118123310.GA4101@jh-x301>
References: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Nov 17, 2010, Bruna Moreira wrote:
> @@ -3007,6 +3007,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>  	bdaddr_t bdaddr;
>  	gboolean new_dev;
>  	int8_t rssi;
> +	uint8_t type;
>  
>  	rssi = *(info->data + info->length);
>  	bdaddr = info->bdaddr;
> @@ -3023,6 +3024,14 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>  
>  	adapter->found_devices = g_slist_sort(adapter->found_devices,
>  						(GCompareFunc) dev_rssi_cmp);
> +
> +	if (info->length) {
> +		char *tmp_name = bt_extract_eir_name(info->data, &type);
> +		if (tmp_name) {
> +			g_free(dev->name);
> +			dev->name = tmp_name;
> +		}
> +	}

Variables should be always declared in the smallest possible scope, so
your new type variable is in the wrong place (it should be declared
inside the if-statement. Since this was the only issue I found with this
patch I fixed it myself and pushed it upstream. Btw, is it really safe
to ignore the type here? What if it's EIR_NAME_SHORT? Wouldn't you then
want to perform full name discovery using e.g. the GAP GATT service
later?

Johan
