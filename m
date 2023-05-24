Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DBC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 06:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbjEXGwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 02:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbjEXGvm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 02:51:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792CE66
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 23:50:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30a4ebbda56so360519f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 23:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684911053; x=1687503053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aFwfj9W3H4hXf1ZMZipSHttpXbIUAquQbCC2E/57Oag=;
        b=t8VcDIf7j/Ki3Q+S0ldfMjka0bFiBeHP68FU/VXdHjVecvRObubQUWg3B3yL6hafTx
         QlaV48HR+sUr7mk3TsHBXlUJv7qCBorRYn2c2jMyqJMDgvCYFOGpTTrOvHc/rGLiXbbT
         sUs/d+I4Gqh0vTbT8MjZrccQPP1UZjZVFjc7yXfiIpYQC+cewPKpAs0s7F5VJv0+WqOn
         kaoxplMfUx2k3ZswdkzJvg6BA6jnCBDukDHzGNLge1JAC9CWd9rXyEl6p49saVtCado7
         iWrV1pH5kroG1Clijj5qDQquIkPtJa9uBK0TekODzeA1xp7nfkQhCL0ulRBO+0SU/whI
         ehbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911053; x=1687503053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFwfj9W3H4hXf1ZMZipSHttpXbIUAquQbCC2E/57Oag=;
        b=WanwAEcFAgleCxUjL/q6+wQo1BjOHhcY4Ip/SwawuHu1apFwX6OGSjS4m82tlZKo09
         QvufyJ9GWTGfC7z58WBeaNrVXDBkqWLnQLHwPawE1DCa3/HZrXQsP+U0IJfDfUcVFPCf
         ZBmy9znRQgLhP8M09ppRCdktYp8aR2xCgsdPqTBvF20e7whCRW/+UvDNwcTKaxB4f+lV
         WloH8d6RaqCl3WWOekgR/DBxk/gg7d4DrjMTVYQQXvLznhv3X7iRuzxehsdGVxP24qfT
         AdAM3Sc7JTcmjhPjdb6j2OjYPugX8Cg0HCdumow4bRLwsVuqWTsbdBuK20HgiYpiPh5H
         9g+g==
X-Gm-Message-State: AC+VfDw1MLQ40PiNQlxtswx2fUCyKfEPUiNdRgd0042zOgXHDVk3I/S4
        3F4AGiBMVsLxvOMXKGEm+hAF1AOqg+dbmYJDcVo=
X-Google-Smtp-Source: ACHHUZ4qK8vBqoy+kHIphqcDkMUVItf9GX/AL8Y6muxl4g1W9GUpBUF9Z4d8hTD6FgV1mj2d9ftZLw==
X-Received: by 2002:adf:ffce:0:b0:2ef:b4a9:202f with SMTP id x14-20020adfffce000000b002efb4a9202fmr12683860wrs.69.1684911053279;
        Tue, 23 May 2023 23:50:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdcc2000000b003077f3dfcc8sm13210748wrm.32.2023.05.23.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:50:51 -0700 (PDT)
Date:   Wed, 24 May 2023 09:50:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: Add initial implementation of BIS
 connections
Message-ID: <744fd69a-c5a3-4e0f-8c47-33096a1cd374@kili.mountain>
References: <e52365b8-f5ee-48d9-ba86-34c4b350c8e3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52365b8-f5ee-48d9-ba86-34c4b350c8e3@kili.mountain>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, May 24, 2023 at 09:38:34AM +0300, Dan Carpenter wrote:
> Hello Luiz Augusto von Dentz,
> 
> The patch eca0ae4aea66: "Bluetooth: Add initial implementation of BIS
> connections" from Mar 9, 2022, leads to the following Smatch static
> checker warning:
> 
> 	net/bluetooth/hci_conn.c:943 hci_le_remove_cig()
> 	warn: passing zero to 'ERR_PTR'
> 
> net/bluetooth/hci_conn.c
>     939 static int hci_le_remove_cig(struct hci_dev *hdev, u8 handle)
>                                                            ^^^^^^^^^^
> 
>     940 {
>     941         bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
>     942 
> --> 943         return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PTR(handle), NULL);
>                                                                          ^^^^^^
> handle is a u8.  It can hold error codes.

s/can/cannot/.

regards,
dan carpenter

