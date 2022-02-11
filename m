Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E790C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 07:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiBKHiB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:38:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiBKHh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 02:37:58 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CE9B
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 23:37:41 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebe1.dynamic.kabel-deutschland.de [95.90.235.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6423E61EA1926;
        Fri, 11 Feb 2022 08:37:38 +0100 (CET)
Message-ID: <fdaaf4ca-934f-c0ff-63f8-2feda6a106ef@molgen.mpg.de>
Date:   Fri, 11 Feb 2022 08:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [BlueZ PATCH 1/4] adapter: Fix the reusing gerror without
 re-initialization
Content-Language: en-US
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
References: <20220211001840.22566-1-hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220211001840.22566-1-hj.tedd.an@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Tedd,


Am 11.02.22 um 01:18 schrieb Tedd Ho-Jeong An:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>

I had a hard time to understand, what the git commit message summary 
meant. Maybe:

> adapter: Use g_clear_error() to set gerr to NULL to fix segfault


> When the GError variable is freeed with g_error_free(), it is not set to
> NULL and reusing the same variable again can cause the seg_fault because
> it is still pointing the old memory address which is freed.

Could you please include an example stack-/backtrace?

> This patch relaces the g_error_free() to g_clear_error() which frees the
> variable and set it to NULL if the variable is used in the function

set*s*

> again.
> 
> Fixes: 2287c517ca1bd ("adapter: Fix unchecked return value")
> Fixes: https://github.com/bluez/bluez/issues/276

To make the tags unambiguous, at least in the Linux kernel world, 
*Resolves* or *Closes* are used to refer to issues.


Kind regards,

Paul


> ---
>   src/adapter.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 3ee98431d..eef50f67a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4676,7 +4676,7 @@ static void load_devices(struct btd_adapter *adapter)
>   		if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   			error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -			g_error_free(gerr);
> +			g_clear_error(&gerr);
>   		}
>   
>   		key_info = get_key_info(key_file, entry->d_name);
> @@ -5662,7 +5662,7 @@ static void convert_names_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   	g_key_file_set_string(key_file, "General", "Name", value);
>   
> @@ -5895,7 +5895,7 @@ static void convert_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	set_device_type(key_file, type);
> @@ -6001,7 +6001,7 @@ static void store_sdp_record(char *local, char *peer, int handle, char *value)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	sprintf(handle_str, "0x%8.8X", handle);
> @@ -6085,7 +6085,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	store_attribute_uuid(key_file, start, end, prim_uuid, uuid);
> @@ -6145,7 +6145,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	for (service = services; *service; service++) {
> @@ -6170,7 +6170,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
>   	if (!g_file_set_contents(filename, data, length, &gerr)) {
>   		error("Unable set contents for %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	if (device_type < 0)
> @@ -6185,7 +6185,7 @@ static void convert_primaries_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   	set_device_type(key_file, device_type);
>   
> @@ -6241,7 +6241,7 @@ static void convert_ccc_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	sprintf(group, "%hu", handle);
> @@ -6297,7 +6297,7 @@ static void convert_gatt_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	sprintf(group, "%hu", handle);
> @@ -6352,7 +6352,7 @@ static void convert_proximity_entry(char *key, char *value, void *user_data)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	g_key_file_set_string(key_file, alert, "Level", value);
> @@ -6556,7 +6556,7 @@ static void load_config(struct btd_adapter *adapter)
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	/* Get alias */
> @@ -8313,7 +8313,7 @@ static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	for (i = 0; i < 16; i++)
> @@ -8479,7 +8479,7 @@ static void store_csrk(struct btd_adapter *adapter, const bdaddr_t *peer,
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	for (i = 0; i < 16; i++)
> @@ -8657,7 +8657,7 @@ static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	g_key_file_set_integer(key_file, "ConnectionParameters",
> @@ -9316,7 +9316,7 @@ static void remove_keys(struct btd_adapter *adapter,
>   	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
>   		error("Unable to load key file from %s: (%s)", filename,
>   								gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   
>   	if (type == BDADDR_BREDR) {
> @@ -9418,7 +9418,7 @@ static bool get_static_addr(struct btd_adapter *adapter)
>   								&gerr)) {
>   		error("Unable to load key file from %s: (%s)",
>   					STORAGEDIR "/addresses", gerr->message);
> -		g_error_free(gerr);
> +		g_clear_error(&gerr);
>   	}
>   	addrs = g_key_file_get_string_list(file, "Static", mfg, &len, NULL);
>   	if (addrs) {
