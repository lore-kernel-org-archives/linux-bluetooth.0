Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07758C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 14:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B511761382
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 14:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhDFOR1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhDFOR0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 10:17:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE322C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Apr 2021 07:17:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b14so22991729lfv.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Apr 2021 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoTJO5FbKGG+5sESqcpryB9OmFJ7UA3g0HUQSw+vzOE=;
        b=P9oKSee/7qkq3grn4jpN3xiXHtgwqQTXA0dCYL7e2iQS6h625OxPs1lwCVcABCMVmP
         uQ/uNEV6TfPdEjSis0bDBEzPGvhCNqCueecJN5AkD5W+7hK7RDocxKsM4aZYQigUxrP1
         fGXb1b/tOfBfILg0S4c9CvWo+M/BDRIOKoHlPpb4UI5kkQQpx8vdiy0c8s7gO2Mxh/5/
         qul591CnScAXEX386FFLjVlER1DZfCzImxd8KWE3iJPImzrc/NDNHvdTdZRYobyDMfzf
         GjiKoKhVKWrrDXz0BiDoeF8ZQda/zKcws+gliILJzYWlu2YOPEz6OQrQXVn6dFKzLC4J
         cKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EoTJO5FbKGG+5sESqcpryB9OmFJ7UA3g0HUQSw+vzOE=;
        b=dM8293RVfNhrrifO5VtkOcilMYhj7VdIeacd/wpdqHKGAjNBVCCXXQ51ayRh6P/KY0
         maZ5CTU7Zu1Y2IonNHd5yUxHk88s3ySlDtnFH7FmWilaB/ZgkwPuWbUfEeB1lz5+KfrE
         /sTssj/lfIEwKvDFX4Ws1IPEYjZIQBprclbFo2lsyQ6pDlpZH7g7IDI7+tWhHYDrH/v7
         ko4AoB74RCBQHjq+uhFkSYkzEWzBGgf1AQ55lvT9d0A1l5BE1Hsm+euuXc4OkoEho72d
         jsX7Q61oGKgXsNgVHPU2PUjDedDPSWfECdEBcar4BL9f1HoI2XeC4y68ESvntUZBKIgL
         ivwg==
X-Gm-Message-State: AOAM531ncMD3kLJ7Z87uSMkhLhQjUQz361Hv4bBuDQv11DCV1WO1Iu43
        W2X/oAs1TB+t9mHo/Yz7uIMUIyFDObz7nQQY
X-Google-Smtp-Source: ABdhPJxSZiLCzRU+Vql9eyZKHNy2KSlxo4DrNtS5G+vSn3srKM6v30HIW14gLNdkoI7NOLR7U8uMrg==
X-Received: by 2002:ac2:5e8e:: with SMTP id b14mr20433032lfq.626.1617718636277;
        Tue, 06 Apr 2021 07:17:16 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id c14sm2172993lfp.269.2021.04.06.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:17:15 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: Re: [PATCH 2/2] Bluetooth: LL privacy allow RPA
Date:   Tue, 06 Apr 2021 16:17:13 +0200
Message-ID: <5698706.lOV4Wx5bFT@ix>
Organization: CODECOUP
In-Reply-To: <20210405143041.16168-1-sathish.narasimman@intel.com>
References: <20210405143041.16168-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Monday, 5 April 2021 16:30:41 CEST Sathish Narasimman wrote:
> allow RPA to add bd address to whitelist
> 
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  net/bluetooth/hci_request.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 0d78122342d5..560b74d421a8 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -847,6 +847,10 @@ static u8 update_white_list(struct hci_request *req)
>  	 */
>  	bool allow_rpa = hdev->suspended;
> 
> +	if (use_ll_privacy(hdev) &&
> +	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
> +		allow_rpa = true;
> +
>  	/* Go through the current white list programmed into the
>  	 * controller one by one and check if that address is still
>  	 * in the list of pending connections or list of devices to

I'm bit confused by this patch. Why add RPA to whitelist if LL privacy is in 
use?

-- 
pozdrawiam
Szymon Janc


