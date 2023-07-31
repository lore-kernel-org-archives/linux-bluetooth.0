Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4327CC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 08:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGaIwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjGaIwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 04:52:05 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16319A5
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 01:49:13 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1D27F61E5FE03;
        Mon, 31 Jul 2023 10:48:55 +0200 (CEST)
Message-ID: <698aa5d3-3261-c9d9-d754-d36ae9716eb4@molgen.mpg.de>
Date:   Mon, 31 Jul 2023 10:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1] main: Fix a logical error within parse_config_int()
Content-Language: en-US
To:     Zijun Hu <quic_zijuhu@quicinc.com>
Cc:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
References: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Zijun,


Am 31.07.23 um 09:46 schrieb Zijun Hu:
> Fix a logical error within parse_config_int().

Thank you for spotting and fixing this. I guess this warning was printed 
on the terminal?

Although obvious, instead of duplicating the commit message summary in 
the body, it would be great, if you still wrote a more elaborate commit 
message. Maybe:

Having a config file with the line below

     …

causes the config file to be ignored, and the warning below:

     …

> ---
>   src/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/main.c b/src/main.c
> index 150a5af4cca4..13501440b052 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -458,7 +458,7 @@ static bool parse_config_int(GKeyFile *config, const char *group,
>   		return false;
>   	}
>   
> -	if (tmp < max) {
> +	if (tmp > max) {
>   		warn("%s.%s = %d is out of range (> %d)", group, key, tmp, max);
>   		return false;
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
