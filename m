Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 06:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiBRG3F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 01:29:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiBRG3E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 01:29:04 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E88B1B7186
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 22:28:46 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebcf.dynamic.kabel-deutschland.de [95.90.235.207])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D1E5E61E6478B;
        Fri, 18 Feb 2022 07:28:43 +0100 (CET)
Message-ID: <d2c865b1-bfbd-4667-2398-967b612f6c8d@molgen.mpg.de>
Date:   Fri, 18 Feb 2022 07:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH BlueZ] main.conf: Fix parsing of mode options
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220218021605.3126182-1-luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220218021605.3126182-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Am 18.02.22 um 03:16 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This replace the of g_key_file_get_integer which is limited to only

Do you mean “This replaces the use of”? Maybe just:

Replace g_key_file_get_integer, limited to only decimal values, with …

> decimal values to g_key_file_get_string and then use strtol to convert
> the string value to integer.

Maybe give an example config file line with a hex assignment:

     X=0x…
> Fixes: https://github.com/bluez/bluez/issues/293
> ---
>   src/main.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/src/main.c b/src/main.c
> index bf9d398e4..a448320c1 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -354,13 +354,22 @@ static void parse_mode_config(GKeyFile *config, const char *group,
>   
>   	for (i = 0; i < params_len; ++i) {
>   		GError *err = NULL;
> -		int val = g_key_file_get_integer(config, group,
> -						params[i].val_name, &err);
> +		char *str;
> +
> +		str = g_key_file_get_string(config, group, params[i].val_name,
> +									&err);
>   		if (err) {
>   			DBG("%s", err->message);
>   			g_clear_error(&err);
>   		} else {
> -			info("%s=%d", params[i].val_name, val);
> +			char *endptr = NULL;
> +			int val;
> +
> +			val = strtol(str, &endptr, 0);
> +			if (!endptr || *endptr != '\0')
> +				continue;
> +
> +			info("%s=%s(%d)", params[i].val_name, str, val);
>   
>   			val = MAX(val, params[i].min);
>   			val = MIN(val, params[i].max);


Kind regards,

Paul
