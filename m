Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5EAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 10:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiBOKHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:07:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOKHe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 05:07:34 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D727E5B5
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 02:07:23 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee0e.dynamic.kabel-deutschland.de [95.90.238.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C918461EA1928;
        Tue, 15 Feb 2022 11:07:21 +0100 (CET)
Message-ID: <232b507b-65bd-3857-78f9-4df888620823@molgen.mpg.de>
Date:   Tue, 15 Feb 2022 11:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] Bluetooth: Fix bt_skb_sendmmsg not allocating partial
 chunks
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20220215015938.1950978-1-luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220215015938.1950978-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Am 15.02.22 um 02:59 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Since bt_skb_sendmmsg can be used with the likes of SOCK_STREAM it
> shall return the partial chunks it could allocate instead of freeing
> everything as otherwise it can cause problems like bellow.

Thank you for fixing the bug I found.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> (Nokia N9 (MeeGo/Harmattan)

> Link: https://lore.kernel.org/linux-bluetooth/aa3ee7ac-6c52-3861-1798-3cc1a37f6ebf@molgen.mpg.de/T/#m1f9673e4ab0d55a7dccf87905337ab2e67d689f1

The Linux kernel regression status, when expanding the bug entry: asks 
to add:

Fixes: 81be03e026dc ("Bluetooth: RFCOMM: Replace use of memcpy_from_msg 
with bt_skb_sendmmsg")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: 
https://lore.kernel.org/r/d7206e12-1b99-c3be-84f4-df22af427ef5@molgen.mpg.de

> Fixes: 81be03e026dc ("Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Maybe also add:

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215594

> ---
>   include/net/bluetooth/bluetooth.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 4b3d0b16c185..a647e5fabdbd 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -506,8 +506,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
>   
>   		tmp = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
>   		if (IS_ERR(tmp)) {
> -			kfree_skb(skb);
> -			return tmp;
> +			return skb;
>   		}
>   
>   		len -= tmp->len;


Kind regards,

Paul


[1]: https://linux-regtracking.leemhuis.info/regzbot/mainline/
