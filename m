Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C2C001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 05:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGaFnY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 01:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGaFnX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 01:43:23 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EF6E6C
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 22:43:21 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5ae862.dynamic.kabel-deutschland.de [95.90.232.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AC33161E5FE01;
        Mon, 31 Jul 2023 07:43:06 +0200 (CEST)
Message-ID: <b91708a1-8dd5-f587-03f0-302ee9a85570@molgen.mpg.de>
Date:   Mon, 31 Jul 2023 07:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH BlueZ 1/2] adapter: Be able to use ConnectDevice for
 discovered devices
Content-Language: en-US
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
References: <CABBYNZKtfk4O=1VLoh0nb_PtR8hzJsPg53P+_q3+kAUAO+cWxg@mail.gmail.com>
 <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Szymon Janc <szymon.janc@codecoup.pl>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Cc: +Szymon]

Dear Simon,


Thank you for your patch. In the commit summary, an alternative to “Be 
able” could be “Allow”.

Am 31.07.23 um 06:12 schrieb Simon Mikuda:
> This can be useful when you want to specify trasport type for already

tra*n*sport

> paired device (e.g. use LE transport for dual mode device).

Could you please elaborate a little more? Maybe even give an example, 
how this can be tested?

> ---
>   src/adapter.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 2679d4302..17f4a637d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3763,9 +3763,6 @@ static DBusMessage *connect_device(DBusConnection *conn,
>   	if (!bacmp(&addr, BDADDR_ANY))
>   		return btd_error_invalid_args(msg);
>   
> -	if (btd_adapter_find_device(adapter, &addr, addr_type))
> -		return btd_error_already_exists(msg);
> -
>   	device_connect(adapter, &addr, addr_type, msg);
>   	return NULL;
>   }
