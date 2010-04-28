Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 22:17:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update service class on adapter-by-adapter basis
Message-ID: <20100428191753.GA19843@jh-x301>
References: <1272476798-10161-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272476798-10161-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 28, 2010, Elvis Pfutzenreuter wrote:
> +sdp_list_t *adapter_service_list(struct btd_adapter *adapter)
> +{
> +	return adapter->services;
> +}

To make this consistent with other exported adapter functions please
call it adapter_get_services().

> +	for (; adapters; adapters = adapters->next) {
> +		adapter_get_address(adapters->data, &bdaddr);
> +
> +		if (bacmp(src, BDADDR_ANY) == 0 || bacmp(src, &bdaddr) == 0)
> +			update_adapter_svclass_list(adapters->data);
> +	}

I think it'd be good to make it explicit which type of objects are part
of the list, so add to the beginning of the loop:
	struct btd_adapter *adapter = adapters->data;

Other than those issues the patch looks ok to me.

Johan
