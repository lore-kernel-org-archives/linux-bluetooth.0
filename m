Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Nov 2010 14:07:59 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v3 2/4] Advertising data: extract local name
Message-ID: <20101115140759.GB11936@jh-x301>
References: <1289518769-3009-1-git-send-email-vinicius.gomes@openbossa.org>
 <1289518769-3009-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289518769-3009-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010, Vinicius Costa Gomes wrote:
> @@ -3159,6 +3160,12 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>  
>  	adapter->found_devices = g_slist_sort(adapter->found_devices,
>  						(GCompareFunc) dev_rssi_cmp);
> +
> +	if (info->length) {
> +		char *tmp_name = bt_extract_eir_name(info->data, &type);
> +		if (tmp_name)
> +			dev->name = tmp_name;
> +	}
>  }

This looks like a potential memory leak to me. What if dev->name was
already set (e.g. by a previous event for the same device)?

Johan
