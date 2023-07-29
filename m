Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C75C001DC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 04:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjG2Emz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jul 2023 00:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2Emx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jul 2023 00:42:53 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566A1984
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 21:42:52 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5ae835.dynamic.kabel-deutschland.de [95.90.232.53])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5996B61E5FE01;
        Sat, 29 Jul 2023 06:42:44 +0200 (CEST)
Message-ID: <907983cc-4175-1130-cb1c-ca42baa40dfa@molgen.mpg.de>
Date:   Sat, 29 Jul 2023 06:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH BlueZ 5/5] monitor: Add parsing Service Data of UUID 128
To:     =?UTF-8?Q?=c5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
 <20230729004552.1422547-6-lukasz.rymanowski@codecoup.pl>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230729004552.1422547-6-lukasz.rymanowski@codecoup.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Łukasz,


Thank you for your patch.

Am 29.07.23 um 02:45 schrieb Łukasz Rymanowski:
> In the advertising report, instead of deciding EIR 0x21 into this:

Do you mean deciphering?

> 
> 	Unknown EIR field 0x21: 3a048f2ba97ea6ae1b49c619e973a4a701480d130d
> 
> We can do bit better
> 
>          Service Data UUID 128: Vendor specific
>            Data: 01480d130d
> ---
>   monitor/packet.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 3031b028f..21e08ccef 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -3997,6 +3997,18 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
>   			print_service_data(data, data_len);
>   			break;
>   
> +		case BT_EIR_SERVICE_DATA128:
> +			if (data_len <= 16)
> +				break;
> +
> +			print_field("Service Data UUID 128: %s ",
> +						bt_uuid128_to_str(&data[0]));
> +
> +			if (data_len > 16)
> +				print_hex_field("  Data", &data[16],
> +								data_len - 16);
> +
> +			break;
>   		case BT_EIR_RANDOM_ADDRESS:
>   			if (data_len < 6)
>   				break;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
