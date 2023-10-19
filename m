Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE6CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 08:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjJSIHM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSIHL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 04:07:11 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19C124
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 01:07:08 -0700 (PDT)
Received: from [10.0.101.84] (unknown [62.214.191.67])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BC8A261E5FE01;
        Thu, 19 Oct 2023 10:06:56 +0200 (CEST)
Message-ID: <b934f6b3-ebce-4370-9a97-610fc2aa18fc@molgen.mpg.de>
Date:   Thu, 19 Oct 2023 10:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1 1/1] gobex/gobex.c : Changed default obex timeout
Content-Language: en-US
To:     Purendra-Singh <purendra.singh@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, luiz.dentz@gmail.com
References: <20231019071651.4773-1-purendra.singh@nxp.com>
 <20231019071651.4773-2-purendra.singh@nxp.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231019071651.4773-2-purendra.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Purendra-Singh,


Thank you for your patch.

Am 19.10.23 um 09:16 schrieb Purendra-Singh:
> Description: File received status of some reference devices
> is delayed, that causes timeout and file transfer status error.

Some formal issues:

1.  Please remove the redundant *Description* at the beginning.
2.  Do you only have “one” name, or is the transcription(?) spelled 
without a hyphen/minus: Purendra Singh?
3.  Please be more specific in the commit messages summary/title. Maybe:

     > gobex: Increase default obex timeout from 10 ms to 500 ms

Most importantly, why did you pick 500 ms, and what reference device is 
it? (What chipset for example?)

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
