Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBAFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 07:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353692AbiCYHfX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353698AbiCYHfW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 03:35:22 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F984DF75
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 00:33:47 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef76.dynamic.kabel-deutschland.de [95.90.239.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8BB4D61E64846;
        Fri, 25 Mar 2022 08:33:46 +0100 (CET)
Message-ID: <c9c39f53-86cb-c4d3-5a6b-15852a765d79@molgen.mpg.de>
Date:   Fri, 25 Mar 2022 08:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] obexd: Fix can't receive small files sent by windows
Content-Language: en-US
To:     Xinpeng Wang <wangxinpeng@uniontech.com>
References: <20220325071350.26668-1-wangxinpeng@uniontech.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220325071350.26668-1-wangxinpeng@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Xinpeng,


Am 25.03.22 um 08:13 schrieb xinpeng wang:
> When obexd receives a file, it parses the filename and other parameters
> when processing the packet for the first time, store filename in
> obex_session and emit the dbus signal, The signal will be pending first.
> then when this file is received, transfer_complete reset obex_session
> is called.
> 
> When using a computer with Windows 10 installed to send a file to bluez,
> obexd will read the data through read_stream; if it is a small file, the
> data processed for the first time is marked as final, and transfer_complete
> reset obex_session will be called when the data is processed for the first
> time. At this point, the dbus signal is still pending, and the dbus method
> that requests the file path has not been processed. This will cause the upper
> application to not be able to transfer files from the cache directory to the
> directory specified by the user.
> 
> To solve this problem, emit Filename's dbus signal and force it when
> status=active.
> 
> Ways to reproduce the problem:
> 1. Use the computer with windows 10 installed to send a small file to the
> computer with ubuntu installed;
> 2. file size < 10k;
> 3. After sending, in most cases, the file is located in the ~/.cache/obexd/
> directory. Normally, the file should be located in the ~/Download directory.
> 
> To fix this, after applying this commit, it also needs to be modified by
> the upper-level application. Modified to read Filename from dbus signal if
> there is Filename in dbus signal. Otherwise, use the dbus method to request
> Filename.
> 
> Signed-off-by: xinpeng wang <wangxinpeng@uniontech.com>
> ---
> v2: Add the steps to reproduce the bug in the submission information.
> 
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

Awesome. Thank you.

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
