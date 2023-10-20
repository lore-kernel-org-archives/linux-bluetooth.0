Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE3BCDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 09:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376639AbjJTJod (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376625AbjJTJoc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 05:44:32 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB95C2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 02:44:30 -0700 (PDT)
Received: from [192.168.0.233] (unknown [95.91.242.37])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C50D61E5FE01;
        Fri, 20 Oct 2023 11:44:21 +0200 (CEST)
Message-ID: <4cf2cb28-b334-487b-96d6-6318961035e1@molgen.mpg.de>
Date:   Fri, 20 Oct 2023 11:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/1] gobex/gobex.c : Increase default obex
 timeout from 10 sec to 500 sec
Content-Language: en-US
To:     Purendra Singh <purendra.singh@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, luiz.dentz@gmail.com
References: <20231020093716.9654-1-purendra.singh@nxp.com>
 <20231020093716.9654-2-purendra.singh@nxp.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231020093716.9654-2-purendra.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Purendra,


Thank you for sending version 2. (No space is necessary in the prefix 
before the colon.)


Am 20.10.23 um 11:37 schrieb Purendra Singh:
> This issue is observed when multiple profiles are active from
> multiple connected devices: A2DP + HID + OBex File transfer
> 
> File received status of some reference devices is delayed,
> that causes timeout and file transfer status error (Variation
> of timeout is between ~100 seconds to ~450 seconds).
> 
> We tested with Motorola Edge, Samsung M33, OnePlus 6T.
> 
> Experimentaly we increased the timeout and at 500 seconds no issue was

Experimentally

> observed.

Oh, it’s really seconds. Isn’t greater than 8 minute timeout *not* very 
user friendly?

> ---
>   gobex/gobex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index e9b89cead..f0e1c2c83 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -22,7 +22,7 @@
>   #define G_OBEX_MINIMUM_MTU	255
>   #define G_OBEX_MAXIMUM_MTU	65535
>   
> -#define G_OBEX_DEFAULT_TIMEOUT	10
> +#define G_OBEX_DEFAULT_TIMEOUT	500
>   #define G_OBEX_ABORT_TIMEOUT	5
>   
>   #define G_OBEX_OP_NONE		0xff


Kind regards,

Paul
