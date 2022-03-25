Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B87C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359428AbiCYO6l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355920AbiCYO6k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 10:58:40 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADF5852E4C
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 07:57:06 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id C50D8CECDE;
        Fri, 25 Mar 2022 15:57:05 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ v4 1/9] log: Don't log __FILE__ and __func__ with
 DBG_IDX
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220323224003.3736525-2-luiz.dentz@gmail.com>
Date:   Fri, 25 Mar 2022 15:57:05 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <19D73FF4-059E-46D5-9FFA-570DEF6E960A@holtmann.org>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
 <20220323224003.3736525-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This removes __FILE__ and __func__ from DBG_IDX since users of it may
> already contain such information embedded in the format.
> ---
> src/log.h | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/log.h b/src/log.h
> index 74941beb2..1ed742a0d 100644
> --- a/src/log.h
> +++ b/src/log.h
> @@ -9,6 +9,7 @@
>  */
> 
> #include <stdint.h>
> +#include <stdbool.h>

seems to have nothing to do with the change here.

> void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
> 
> @@ -52,10 +53,11 @@ void __btd_enable_debug(struct btd_debug_desc *start,
> 		.file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
> 	}; \
> 	if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
> -		btd_debug(idx, "%s:%s() " fmt, __FILE__, __func__ , ## arg); \
> +		btd_debug(idx, fmt, ## arg); \
> } while (0)
> 
> -#define DBG(fmt, arg...) DBG_IDX(0xffff, fmt, ## arg)
> +#define DBG(fmt, arg...) \
> +	DBG_IDX(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> #define error(fmt, arg...) \
> 	btd_error(0xffff, "%s:%s() " fmt, __FILE__, __func__, ## arg)
> #define warn(fmt, arg...) \

I am still failing to see why this is better.

Regards

Marcel


