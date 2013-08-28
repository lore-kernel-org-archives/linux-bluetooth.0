Return-Path: <cyrus@holtmann.org>
Message-ID: <521DCAAA.8010203@linux.intel.com>
Date: Wed, 28 Aug 2013 12:02:18 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] sdp: Make sdp_record_add to be handled by adapter
References: <1377522441-28671-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1377522441-28671-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377522441-28671-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Grzegorz,

On 26/08/2013 15:07, Grzegorz Kolodziejczyk wrote:
<snip>
> diff --git a/src/adapter.c b/src/adapter.c
> index fd20d61..8e897ce 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6307,6 +6307,37 @@ void adapter_start_sdp_server(uint16_t sdp_mtu, uint32_t sdp_flags) {
>   		adapter_foreach(adapter_service_insert, services->data);
>   }
>
> +int adapter_add_record_to_server(const bdaddr_t *device, sdp_record_t *rec)
> +{
> +	int chck;
> +	struct btd_adapter *adapter;
> +
> +	chck = add_record_to_server(device, rec);
> +
> +	//  Check if rec handle error occure
> +	//
> +	//  0       - Ok
> +	//
> +	//  handle == 0xffffffff
> +	//  -ENOSPC - next handle < 0x10000
> +	//
> +	//  -EEXIST - record already exist

Please use C89 coding style for comments, like defined for the Linux 
kernel. I.e.:
	/*
	 * comment
	 * comment
	 */

> +	if (chck == 0) {
> +		//  Add rec for each adapter

idem here ( /* comment */ )

> +		if (bacmp(device, BDADDR_ANY) == 0) {
> +			adapter_foreach(adapter_service_insert, rec);
> +			return chck;
> +		}
> +
> +		//  Add rec for single adapter

and here

> +		adapter = adapter_find(device);
> +		if (adapter)
> +			adapter_service_insert(adapter, rec);
> +	}
> +
> +	return chck;
> +}
> +

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

