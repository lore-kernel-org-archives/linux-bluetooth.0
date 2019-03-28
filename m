Return-Path: <SRS0=kuyC=R7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE9DC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Mar 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877A1217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Mar 2019 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="NUVj/k7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfC1Nqy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:46:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41911 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Nqx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Mar 2019 09:46:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so17683121lja.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2019 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+1mh3DmCm2IZV3Em5Ot/UVI5vyIeFAMzMiv0CnYZ+c=;
        b=NUVj/k7xpqMld73bIioFoQqFxML01X41bufQCuKWfLz8bDcZVFHh2FTLMfcoIGG4t2
         Abx4OKZKdic7VF0lgvmQwl5UygUDJqD8gjx76VFHlhgOB0lNnTOFwPIEXxfUCt3iwDCh
         40vb1FE1hZLPpaBNqbHwJj7P2xz13h7wPyy3UyMnzZD2ONzfPjBBT/OO/2MXq/xpVfX3
         1zw0Szn/X6F9LzkSsgFGjAzmuRo0x4LG64LYx2RKUnf9XccNS6n2LzORmSQeuDPocMOQ
         BWrEIDM8jmrTIOPNDr2qPN74xlxJrlxqGaXqrn74UwqYYAvuR2gPyFseD12rbrSieKvH
         uQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3+1mh3DmCm2IZV3Em5Ot/UVI5vyIeFAMzMiv0CnYZ+c=;
        b=HZwgkf41OU84h7S6WOifMax7v4lMFF06kIEJJ23qSNCYYv7EEEIBmmN8GQT9Uhl85D
         EXjTTL1NkxY6HMYPdQogdhrY1mZLv4Z5bMwTAUKZ5bC0nrN7D0jWTr9k5iGNOZguQDjB
         3f4QDz44y/4zabL/7+dzLv+k7qpx1Et8JeV/FksMeeBnYyUwn73x3mq1biFRseeSzQLe
         4tUw3ER6CUKaSd0YLU19iJjWbWiFV4Ta43qRMw+6lKY/AmSdi/jBBN+EptQD7KzCBuwY
         UcwLfhDbXpD1R1vGOoGBosOriSnEXdRKJwZqJZNBIAIdcPSyCiGaxCfDTV8CsodY/Zaa
         hnnQ==
X-Gm-Message-State: APjAAAWCVq2/xX9eWuSqAUPNdqro3OBjhJ3y3kYDk44mSP+qOk2ssX9v
        QlKvKR8STaJjWwInejpFmxZsfpZO9M0=
X-Google-Smtp-Source: APXvYqyFFAmmKL66RmOrrwsxKeMj2a1GOBk2rrZ6qsWmor38uSzHz/jdRu907rknWoViyW1irgQulg==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr23647586ljd.8.1553780810889;
        Thu, 28 Mar 2019 06:46:50 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id d1sm2464026lfa.15.2019.03.28.06.46.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:46:49 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] emulator: Fix handling of Set Event Mask Page 2 Command
Date:   Thu, 28 Mar 2019 14:46:48 +0100
Message-ID: <3199979.ZHmQMNjpqu@ix>
Organization: CODECOUP
In-Reply-To: <20190327100031.32062-1-szymon.janc@codecoup.pl>
References: <20190327100031.32062-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday, 27 March 2019 11:00:31 CET Szymon Janc wrote:
> This command is also valid for BR/EDR only (was introduced in 3.0)
> and for LE only controllers (Authenticated Payload Timeout Expired
> Event).
> ---
>  emulator/btdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 4d34aee1a..f4c79c2d0 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -3206,8 +3206,8 @@ static void default_cmd(struct btdev *btdev, uint16_t
> opcode, break;
> 
>  	case BT_HCI_CMD_SET_EVENT_MASK_PAGE2:
> -		if (btdev->type != BTDEV_TYPE_BREDRLE &&
> -				btdev->type != BTDEV_TYPE_BREDRLE50)
> +		if (btdev->type == BTDEV_TYPE_BREDR20 ||
> +				btdev->type == BTDEV_TYPE_AMP)
>  			goto unsupported;
>  		semp2 = data;
>  		memcpy(btdev->event_mask_page2, semp2->mask, 8);

Applied.

-- 
pozdrawiam
Szymon Janc


