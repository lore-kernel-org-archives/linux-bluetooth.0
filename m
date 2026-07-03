Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDB38B7CD
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062906; cv=pass; b=GbeKPN22AN3o60s+kRnhTqbrPyCZYLpAAXJkNtPTdNMs5yLH+IZsqMmuWgdjPeQvX5EloZaUZaIaF4vge2L32EwoTTPlf5M3veaDrBB7Kgifp69b6GzP+IZUMEdzJBlAe37v5Y2qKahBitCiBdohzLYBcSdmyNfEpGZ0kVOBeis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062906; c=relaxed/simple;
	bh=pZRqlhj+SQTsD0rrAm/AfULTBzJdypVYRXTle/3TWDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PifLsF/umL/4Lkv9CTi0wdFigckQV11Kw9OsXzSOo/7cCjcey07FqUgcmzHsDXsfRF2vxcFhvazu40WF2tXZ0Z+QN/s68NCe6aQurlAh9Mwawfys7Zv1ZG5jV5vbnU3MVOnnufZJQu1aOYiSpO0WoUiUywPS3YDGPgB/xRgmVr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=hib3YOMF; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="hib3YOMF"
ARC-Seal: i=1; a=rsa-sha256; t=1783062900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P/xRyUNbwNl+YQpk6E53s5YRPpC1hgpMJ05vR5PWJ3JzfeuyvulaPLv02ca1smYXP9WG4mt7qCQOiZg1sM4mjjs7f25uu7F7TYbbfPm+aEAuXK0u01V8rNFetNfMBjCUUC9eSgAEl8fDW5Cs+LgJ0OudH6Nf26QVsMP5RznnjT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783062900; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=I+UchanmOp/QHuDw5pkYtzFNoZVV0fpxbU67L//VQ5k=; 
	b=A57UQag8rd6rT0BZa74uXdDc0ns12PJSP8OjlNfNVU2/4JrOwB5gudBR2dZ1i2R1IQUgcZ9KGoELSW+lr70rOAXW5VImnyV7ZEkZoY8jUmbTjCoIK9YFqXCUyry2tX177kuxJa8L3wlN510RmrAUPriIpbZrgGTyjehtmtwniVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783062900;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=I+UchanmOp/QHuDw5pkYtzFNoZVV0fpxbU67L//VQ5k=;
	b=hib3YOMFPCX7WD1GhNXzqg+8C0qpOMQH7d9ShAa4NoXs2TV2gKL/pi92D34Ktsjt
	AbCwbMmPN7u0CegYkTRJpRuamXOiKzkf4Ox2JxY8VWsxombwAOJR7/y7Db7/WzyDf/7
	skCwCfGYJkOvF2O4j84dMs5VqjwzC+2mzZXhJSNE=
Received: by mx.zohomail.com with SMTPS id 1783062898242535.8258730133876;
	Fri, 3 Jul 2026 00:14:58 -0700 (PDT)
Message-ID: <e9c7f5a3-5ad6-49c4-9f29-4ba9bc07e059@collabora.com>
Date: Fri, 3 Jul 2026 09:14:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1] adapter: Fix crash on dev_disconnected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20260702155037.9931-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20260702155037.9931-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 02/07/2026 17:50, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Commit 5d836f1c697c ("adapter: Fix failed bonding attempt after LE
> link disconnection") introduces a regression since it attempts to
> call device_is_connected after adapter_remove_connection which may
> free the device causing the following backtrace:
>
>      #0 0x5cd6e384262f in btd_device_bearer_is_connected src/device.c:3754
>      #1 0x5cd6e384266f in btd_device_is_connected src/device.c:3745
>      #2 0x5cd6e37f8614 in dev_disconnected src/adapter.c:8626
>
> Fixes: https://github.com/bluez/bluez/issues/2221
> ---
>   src/adapter.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 538f63e0a153..210225243f00 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7612,12 +7612,16 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter)
>   static void adapter_remove_connection(struct btd_adapter *adapter,
>   						struct btd_device *device,
>   						uint8_t bdaddr_type,
> -						uint8_t reason)
> +						uint8_t reason,
> +						bool *removed)
>   {
>   	bool remove_device = false;
>   
>   	DBG("");
>   
> +	if (removed)
> +		*removed = false;
> +
>   	if (!g_slist_find(adapter->connections, device)) {
>   		btd_error(adapter->dev_id, "No matching connection for device");
>   		return;
> @@ -7638,6 +7642,9 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
>   
>   		DBG("Removing temporary device %s", path);
>   		btd_adapter_remove_device(adapter, device);
> +
> +		if (removed)
> +			*removed = true;
>   	}
>   }
>   
> @@ -7665,10 +7672,10 @@ static void adapter_stop(struct btd_adapter *adapter)
>   		uint8_t addr_type = btd_device_get_bdaddr_type(device);
>   
>   		adapter_remove_connection(adapter, device, BDADDR_BREDR,
> -						MGMT_DEV_DISCONN_UNKNOWN);
> +						MGMT_DEV_DISCONN_UNKNOWN, NULL);
>   		if (addr_type != BDADDR_BREDR)
>   			adapter_remove_connection(adapter, device, addr_type,
> -						MGMT_DEV_DISCONN_UNKNOWN);
> +						MGMT_DEV_DISCONN_UNKNOWN, NULL);
>   	}
>   
>   	g_dbus_emit_property_changed(dbus_conn, adapter->path,
> @@ -8618,7 +8625,17 @@ static void dev_disconnected(struct btd_adapter *adapter,
>   
>   	device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
>   	if (device) {
> -		adapter_remove_connection(adapter, device, addr->type, reason);
> +		bool removed;
> +
> +		adapter_remove_connection(adapter, device, addr->type, reason,
> +						&removed);
> +		/* No need to continue if device was removed from the adapter,
> +		 * as it will be freed and the disconnect notify will be called
> +		 * in the device free callback.
> +		 */
> +		if (removed)
> +			return;
> +
>   		disconnect_notify(device, reason);
>   	}
>   

I tested this and crash is fixed.

Frédéric Danis

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


