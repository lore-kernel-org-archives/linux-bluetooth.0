Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1B11CA0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638161; cv=none; b=aEIMG0ohSqu9etsf4C9Le9OcSODhdnpZWzGN4+uqbb8hZEBzi1dCSLZmIzH/984dgnUeyYBOXyXldo5L8FyjnuZ2J0vL+4ZlyW4fHl159wOXdH2SakgbMtdkyzBMZD4OCrRMYuFhZjoKOZE65MEV/s3rTYfTHY8Z/z2bkxjd6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638161; c=relaxed/simple;
	bh=9xelEXPI7mEeYo5KxRnlZjYbp2sy2YQGDayWlpjEYDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmn9lIEIsl4K2qOhKLCTFqqrGMCvPnfV/VmHgj54wkxg1nCOwLd8kq3fRt8h/1OkqIuw1UxEyYIqCBCopP3NSk3qzMfu6LIIoIUTujx+Oq13jL7VUA16efSUOuHxMh5GdKcSUxcQcYnKM3WHeGxHcOPk4bytBMwbN26NVOBSs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5ae9a6.dynamic.kabel-deutschland.de [95.90.233.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CB46461E5FE06;
	Mon, 22 Jul 2024 10:48:44 +0200 (CEST)
Message-ID: <cbdeef3c-081d-4b45-8350-d4edde1287ff@molgen.mpg.de>
Date: Mon, 22 Jul 2024 10:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving
 List" command fail
To: Clancy Shang <clancy_shang@163.com>
Cc: linux-bluetooth@vger.kernel.org, Clancy Shang <clancy.shang@quectel.com>
References: <20240722075626.3050334-1-clancy_shang@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240722075626.3050334-1-clancy_shang@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Clancy,


Thank you for your patch. Some minor comments.

Am 22.07.24 um 09:56 schrieb clancy_shang@163.com:
> From: Clancy Shang <clancy.shang@quectel.com>
> 
> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E,

I’d spell it *Bluetooth Core Specification* [1].

> 7.8.38, If there is an existing entry in the resolving list with the same

I’d spell *If* lowercase.

> non-zero Peer_IRK, the Controller should return the error code Invalid
> HCI Command Parameters (0x12), so fix it.

You could describe the current situation, so what is returned right now.

Also, it’d be great if you documented the test environment how to 
reproduce the issue.

[1]: https://www.bluetooth.com/specifications/specs/core54-html/

> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>   src/adapter.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 85ddfc165..495c9f631 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8901,6 +8901,76 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
>   	g_key_file_free(key_file);
>   }
>   
> +static void delete_exist_irk_from_directory(
> +						struct btd_adapter *adapter,
> +						const unsigned char *key)
> +{
> +	char dirname[PATH_MAX];
> +	GError *gerr = NULL;
> +	DIR *dir;
> +	struct dirent *entry;
> +
> +	create_filename(dirname, PATH_MAX, "/%s",
> +				btd_adapter_get_storage_dir(adapter));
> +
> +	dir = opendir(dirname);
> +	if (!dir) {
> +		btd_error(adapter->dev_id,
> +				"Unable to open adapter storage directory: %s",
> +								dirname);
> +		return;
> +	}
> +
> +	while ((entry = readdir(dir)) != NULL) {
> +		struct btd_device *device;
> +		char filename[PATH_MAX];
> +		GKeyFile *key_file;
> +		struct irk_info *irk_info;
> +		uint8_t bdaddr_type;
> +
> +		if (entry->d_type == DT_UNKNOWN)
> +			entry->d_type = util_get_dt(dirname, entry->d_name);
> +
> +		if (entry->d_type != DT_DIR || bachk(entry->d_name) < 0)
> +			continue;
> +
> +		create_filename(filename, PATH_MAX, "/%s/%s/info",
> +					btd_adapter_get_storage_dir(adapter),
> +					entry->d_name);
> +
> +		key_file = g_key_file_new();
> +		if (!g_key_file_load_from_file(
> +								key_file,
> +								filename,
> +								0,
> +								&gerr)) {

No idea, if it’s my mailer, but the parameters look too much intended.


> +			error("Unable to load key file from %s: (%s)",
> +					filename, gerr->message);
> +			g_clear_error(&gerr);
> +		}
> +
> +		bdaddr_type = get_le_addr_type(key_file);
> +
> +		irk_info = get_irk_info(key_file, entry->d_name, bdaddr_type);
> +
> +		if (irk_info) {
> +			if (!memcmp(irk_info->val, key, 16)) {
> +				DBG("Has same irk,delete it");

Please add a space after the comma, and maybe also print the value.

> +				device = btd_adapter_find_device(adapter,
> +							&irk_info->bdaddr,
> +							irk_info->bdaddr_type);
> +				if (device)
> +					btd_adapter_remove_device(adapter,
> +									device);
> +			}
> +		}
> +		g_key_file_free(key_file);
> +	}
> +
> +	closedir(dir);
> +
> +}
> +
>   static void new_irk_callback(uint16_t index, uint16_t length,
>   					const void *param, void *user_data)
>   {
> @@ -8950,6 +9020,8 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>   	if (!persistent)
>   		return;
>   
> +	delete_exist_irk_from_directory(adapter, irk->val);

exist*ing*?

> +
>   	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
>   
>   	btd_device_set_temporary(device, false);


Kind regards,

Paul
