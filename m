Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE3AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 May 2022 07:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiE1Hir (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 May 2022 03:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiE1Hip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 May 2022 03:38:45 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F72DF9
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 May 2022 00:38:42 -0700 (PDT)
Received: from [192.168.0.21] (ip5f5af60f.dynamic.kabel-deutschland.de [95.90.246.15])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A0FB161EA192D;
        Sat, 28 May 2022 09:38:39 +0200 (CEST)
Message-ID: <7c90bc97-555f-8dc5-5e27-cfb6cdb0e428@molgen.mpg.de>
Date:   Sat, 28 May 2022 09:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH-stable v2] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220528003528.571351-1-luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220528003528.571351-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Thank you for your patch.

Am 28.05.22 um 02:35 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Both dev_name and short_name are not guaranteed to be NULL terminated so
> this instead use strnlen and then attempt to determine if the resulting

The *this* does not seem to belong into the sentence.

> string needs to be truncated or not.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216018
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Should this be tagged for the stable series?


Kind regards,

Paul


> ---
>   net/bluetooth/eir.c  | 41 ++++++++++++++++++++++++++---------------
>   net/bluetooth/mgmt.c |  4 ++--
>   2 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
> index 7d77fb00c2bf..776d27f7e18d 100644
> --- a/net/bluetooth/eir.c
> +++ b/net/bluetooth/eir.c
> @@ -13,6 +13,20 @@
>   
>   #define PNP_INFO_SVCLASS_ID		0x1200
>   
> +static u8 eir_append_name(u8 *eir, u16 eir_len, u8 type, u8 *data, u8 data_len)
> +{
> +	u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
> +
> +	/* If data is already NULL terminated just pass it directly */
> +	if (data[data_len - 1] == '\0')
> +		return eir_append_data(eir, eir_len, type, data, data_len);
> +
> +	memcpy(name, data, HCI_MAX_SHORT_NAME_LENGTH);
> +	name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
> +
> +	return eir_append_data(eir, eir_len, type, name, sizeof(name));
> +}
> +
>   u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
>   {
>   	size_t short_len;
> @@ -23,29 +37,26 @@ u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
>   		return ad_len;
>   
>   	/* use complete name if present and fits */
> -	complete_len = strlen(hdev->dev_name);
> +	complete_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
>   	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
> -		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
> +		return eir_append_name(ptr, ad_len, EIR_NAME_COMPLETE,
>   				       hdev->dev_name, complete_len + 1);
>   
>   	/* use short name if present */
> -	short_len = strlen(hdev->short_name);
> +	short_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
>   	if (short_len)
> -		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
> -				       hdev->short_name, short_len + 1);
> +		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
> +				       hdev->short_name,
> +				       short_len == HCI_MAX_SHORT_NAME_LENGTH ?
> +				       short_len : short_len + 1);
>   
>   	/* use shortened full name if present, we already know that name
>   	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
>   	 */
> -	if (complete_len) {
> -		u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
> -
> -		memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
> -		name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
> -
> -		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
> -				       sizeof(name));
> -	}
> +	if (complete_len)
> +		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
> +				       hdev->dev_name,
> +				       HCI_MAX_SHORT_NAME_LENGTH);
>   
>   	return ad_len;
>   }
> @@ -181,7 +192,7 @@ void eir_create(struct hci_dev *hdev, u8 *data)
>   	u8 *ptr = data;
>   	size_t name_len;
>   
> -	name_len = strlen(hdev->dev_name);
> +	name_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
>   
>   	if (name_len > 0) {
>   		/* EIR Data type */
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index cd1b300b9be7..82cc645193f2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1082,11 +1082,11 @@ static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
>   		eir_len = eir_append_le16(eir, eir_len, EIR_APPEARANCE,
>   					  hdev->appearance);
>   
> -	name_len = strlen(hdev->dev_name);
> +	name_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
>   	eir_len = eir_append_data(eir, eir_len, EIR_NAME_COMPLETE,
>   				  hdev->dev_name, name_len);
>   
> -	name_len = strlen(hdev->short_name);
> +	name_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
>   	eir_len = eir_append_data(eir, eir_len, EIR_NAME_SHORT,
>   				  hdev->short_name, name_len);
>   
