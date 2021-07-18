Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F2C636CB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D6661166
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jul 2021 16:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhGRQyb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jul 2021 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGRQya (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jul 2021 12:54:30 -0400
X-Greylist: delayed 2311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jul 2021 09:51:32 PDT
Received: from authenticated.a-painless.mh.aa.net.uk (painless-a.thn.aa.net.uk [IPv6:2001:8b0:0:62::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92674C061762;
        Sun, 18 Jul 2021 09:51:32 -0700 (PDT)
Received: from cartman.offog.org ([2001:8b0:83b:b53f::a])
        by painless-a.thn.aa.net.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ats@offog.org>)
        id 1m59Pf-0005OO-RQ; Sun, 18 Jul 2021 17:13:07 +0100
Received: from ats by cartman.offog.org with local (Exim 4.94.2)
        (envelope-from <ats@offog.org>)
        id 1m59PT-0003ss-W7; Sun, 18 Jul 2021 17:12:55 +0100
From:   Adam Sampson <ats@offog.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drivers/bluetooth: Remove all strcpy() uses
References: <20210718153626.18382-1-len.baker@gmx.com>
Date:   Sun, 18 Jul 2021 17:12:55 +0100
In-Reply-To: <20210718153626.18382-1-len.baker@gmx.com> (Len Baker's message
        of "Sun, 18 Jul 2021 17:36:26 +0200")
Message-ID: <y2awnpnfvnc.fsf@offog.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Len Baker <len.baker@gmx.com> writes:

> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy() but in
> this case it is better to use the scnprintf to simplify the arithmetic.
>
> This is a previous step in the path to remove the strcpy() function
> entirely from the kernel.
>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index cddd350beba3..d6674b367e05 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -1350,6 +1350,7 @@ static void btmrvl_sdio_coredump(struct device *dev)
>  	u8 *dbg_ptr, *end_ptr, *fw_dump_data, *fw_dump_ptr;
[...]
> +			size += scnprintf(fw_dump_ptr + size,
> +					  sizeof(fw_dump_ptr) - size,
[...]
> +			size += scnprintf(fw_dump_ptr + size,
> +					  sizeof(fw_dump_ptr) - size,

sizeof(fw_dump_ptr) there looks wrong -- you want the size of the buffer
it points to (fw_dump_len + 1)?

Thanks,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
