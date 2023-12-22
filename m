Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0918026
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 34D3761E5FE01;
	Fri, 22 Dec 2023 13:25:58 +0100 (CET)
Message-ID: <57815c6d-829b-4075-9d14-f9cfc9036017@molgen.mpg.de>
Date: Fri, 22 Dec 2023 13:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [BlueZ] adapter: Fix airpod device pair fail
Content-Language: en-US
To: 15013537245@163.com
Cc: linux-bluetooth@vger.kernel.org, zhongjun.yu@quectel.com,
 Clancy Shang <clancy.shang@quectel.com>
References: <20231222054515.1266741-1-15013537245@163.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231222054515.1266741-1-15013537245@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Clancy,


Thank you for your patch. Some nits below.

Am 22.12.23 um 06:45 schrieb 15013537245@163.com:
> From: Clancy Shang <clancy.shang@quectel.com>
> 
> Airpod is performing inquiry scans in BR/EDR and advertising in a
> unconnectabl mode whit the same public address at the same time.

a*n* unconnectabl*e* mode w*ith*

> with this featrue, when found airpod device, set the bredr support,

feat*ur*e

> fix it pair fail bug.

Do the Airpods follow the Bluetooth specification, or do they violate 
it, and need a workaround?

> 
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>   src/adapter.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 022390f0d..488355e9c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7066,6 +7066,25 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
>   	}
>   }
>   
> +#define APPLE_INC_VENDOR_ID 0x004c
> +
> +static bool eir_msd_is_apple_inc(GSList *msd_list)
> +{
> +	GSList *msd_l, *msd_next;
> +
> +	for (msd_l = msd_list; msd_l != NULL; msd_l = msd_next) {
> +

The blank line seems unnecessary.

> +		const struct eir_msd *msd = msd_l->data;
> +
> +		msd_next = g_slist_next(msd_l);
> +
> +		if (msd->company == APPLE_INC_VENDOR_ID)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
>   								int8_t rssi)
>   {
> @@ -7281,6 +7300,12 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
>   		device_update_last_seen(dev, BDADDR_BREDR, !not_connectable);
>   	}
>   
> +	if (eir_msd_is_apple_inc(eir_data.msd_list) && (not_connectable == true)
> +		&& (bdaddr_type == BDADDR_LE_PUBLIC)) {

No idea, if there is a rule, but other instances put the && on the line 
above, and align the condition with the one in the first line.

> +		device_set_bredr_support(dev);
> +		device_update_last_seen(dev, BDADDR_BREDR, true);
> +	}
> +
>   	if (eir_data.name != NULL && eir_data.name_complete)
>   		device_store_cached_name(dev, eir_data.name);
>   


Kind regards,

Paul
