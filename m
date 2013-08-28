Return-Path: <cyrus@holtmann.org>
Message-ID: <521DCB16.9000606@linux.intel.com>
Date: Wed, 28 Aug 2013 12:04:06 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] sdp: Make sdp_record_remove to be handled by adapter
References: <1377522441-28671-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1377522441-28671-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1377522441-28671-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Grzegorz,

On 26/08/2013 15:07, Grzegorz Kolodziejczyk wrote:
<snip>
> diff --git a/src/adapter.c b/src/adapter.c
> index 8e897ce..8a5398f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6338,6 +6338,46 @@ int adapter_add_record_to_server(const bdaddr_t *device, sdp_record_t *rec)
>   	return chck;
>   }
>
> +int adapter_remove_record_from_server(uint32_t handle)
> +{
> +	int chck;
> +	sdp_list_t *p;
> +	sdp_record_t *r;
> +	sdp_access_t *a;
> +	sdp_record_t rh, ah;
> +
> +	chck = remove_record_from_server(handle);
> +
> +	if (chck == 0) {
> +		//	record_locate section

Please use C89 coding style for comments.

> +		rh.handle = handle;
> +		p = sdp_list_find(sdp_get_record_list(), &rh, record_sort);
> +
> +		r = p->data;
> +
> +		//	access_locate section

idem here

> +		ah.handle = handle;
> +		p = sdp_list_find(sdp_get_access_list(), &ah, record_sort);
> +
> +		if (p == NULL || p->data == NULL)
> +			return 0;
> +
> +		a = p->data;
> +
> +		//	remove from adapter services

and here

> +		if (bacmp(&a->device, BDADDR_ANY) != 0) {
> +			struct btd_adapter *adapter = adapter_find(&a->device);
> +			if (adapter)
> +				adapter_service_remove(adapter, r);
> +		} else
> +			adapter_foreach(adapter_service_remove, r);
> +
> +		free(a);
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

