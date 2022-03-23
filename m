Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F04C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 06:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiCWGvT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242019AbiCWGvS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 02:51:18 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32C546A5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 23:49:47 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5ae903.dynamic.kabel-deutschland.de [95.90.233.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0013461EA1928;
        Wed, 23 Mar 2022 07:49:44 +0100 (CET)
Message-ID: <8ff37c48-4e71-1c40-53bb-5bb99d7a1a88@molgen.mpg.de>
Date:   Wed, 23 Mar 2022 07:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] obexd: Fix can't receive small files sent by windows
Content-Language: en-US
To:     Xinpeng Wang <wangxinpeng@uniontech.com>
References: <20220323052149.28674-1-wangxinpeng@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220323052149.28674-1-wangxinpeng@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Xinpeng,


Thank you for the patch.

You can use `git format-patch`’s switch `--reroll-count` to denote that 
it’s replacing an earlier sent in patch. It’s also good practice to 
write the changes between the version below the `---` line, so it’s 
clear for the reviewer, what changed. For example:

v2: Fix typo in commit message summary

Am 23.03.22 um 06:21 schrieb xinpeng wang:
> Windows devices use streaming mode to send files. If a small file is

What do you mean by Windows devices exactly? Windows phone or any computer?

> sent,the first time processing data will be completed successfully,

Please add a space after the comma.

> and the transfer_complete function will be called before the end to
> clear os->path.At this time, the dbus signal is still pending, and

Please add a space after the dot/period.

> the dbus method call requesting the file path has not been processed;
> in this way, the upper-level program will not be able to obtain the
> file path, resulting in failure to receive the file.
> Therefore, the signal of Filename is generated, and it is forced to
> be sent when status=active.

I’d also add a blank line between paragraphs.

How can your issue be reproduced, and the fix verified?

> Signed-off-by: xinpeng wang <wangxinpeng@uniontech.com>
> ---
>   obexd/src/manager.c | 6 +++++-
>   obexd/src/obex.c    | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 01741fe62..2c180dc44 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -533,8 +533,12 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
>   void manager_emit_transfer_started(struct obex_transfer *transfer)
>   {
>   	transfer->status = TRANSFER_STATUS_ACTIVE;
> +	if (!transfer->path)
> +		return;
>   
> -	manager_emit_transfer_property(transfer, "Status");
> +	g_dbus_emit_property_changed_full(connection, transfer->path,
> +					TRANSFER_INTERFACE, "Status",
> +					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
>   }
>   
>   static void emit_transfer_completed(struct obex_transfer *transfer,
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 3a68fd66c..c0d9e160a 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -720,6 +720,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
>   		manager_emit_transfer_property(os->service_data, "Size");
>   
>   	os->path = g_strdup(filename);
> +	manager_emit_transfer_property(os->service_data, "Filename");
>   
>   	return 0;
>   }
