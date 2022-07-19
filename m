Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jul 2022 19:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiGST2S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiGST2S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jul 2022 15:28:18 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADE52DD7
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 12:28:16 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb74.dynamic.kabel-deutschland.de [95.90.235.116])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1197E61EA1929;
        Tue, 19 Jul 2022 21:28:13 +0200 (CEST)
Message-ID: <72a1d366-ce9f-c8f2-1ca1-f2b191d36ba9@molgen.mpg.de>
Date:   Tue, 19 Jul 2022 21:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] Bluetooth:btrtl:Fix typo in comment
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
References: <20220719154148.16769-1-dengshaomin@cdjrlc.com>
Content-Language: en-US
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220719154148.16769-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Shaomin,


Am 19.07.22 um 17:41 schrieb shaomin Deng:
> Delete the repeated word "that" in comments.

Maybe start your first name with a capital letter?

     git config --global user.name "Shaomin Deng"

In the commit message summary, please add a space after the colons, and 
maybe use:

Bluetooth: btrtl: Remove duplicate *that* in comment

> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>   drivers/bluetooth/btrtl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 47c28fd8f006..fb52313a1d45 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -330,7 +330,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
>   	/* Loop from the end of the firmware parsing instructions, until
>   	 * we find an instruction that identifies the "project ID" for the
>   	 * hardware supported by this firwmare file.

firmware

It’d be great if you fixed that in a separate commit.

> -	 * Once we have that, we double-check that that project_id is suitable
> +	 * Once we have that, we double-check that project_id is suitable

It’s a lot of “that”, but it’s actually correct.

>   	 * for the hardware we are working with.
>   	 */
>   	while (fwptr >= btrtl_dev->fw_data + (sizeof(*epatch_info) + 3)) {


Kind regards,

Paul
