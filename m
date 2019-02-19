Return-Path: <SRS0=iCSy=Q2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4454C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A573421905
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="oPHxYQCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBSORb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:17:31 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45138 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBSORa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Feb 2019 09:17:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so14801730lfc.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Feb 2019 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeGseOaYkPneeKVSa5Saeo2Y0cNSbB08ClwJ6mcAFGM=;
        b=oPHxYQCuG9O1K9RbjRyY9qbKWzA3LGrmsUMXLgvQ5iZkCGEGimERBiRq9F2ihbYJM7
         QTKzh2C9sMdUGh825h8TMkXIdLt5Oq5f0gSELyIakKK6nJm5G8cD6sZRgOOP/wxHAjSf
         8vK33KuMg8bJssRHBXLOWMynqJ3c9Ljb6k1usto31HISCWDdZ3d+WMew8aiGdb0clB4o
         4tgP70TrsJ3nfwxzYK3ZO4hzHBtbvhzGtS9u9ycuo0gcjh9DwgJVAzdCLfgaOS+4TcYG
         tEOHgvZikBzRNZTCW5oCpW72hLpUOzzk8aCeM9GeYrTS7QZF6EV/0Usu3LGl7cZCy3/R
         vITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JeGseOaYkPneeKVSa5Saeo2Y0cNSbB08ClwJ6mcAFGM=;
        b=KCEM+GSmIQaOAkIeLbvEwVu9JLT/HMp1rb6cGbLsFdqx6PZQ3DkBir6SZrEqsqx3hG
         v+TMPgk5f5EduJhUrwOaTfRn9wFOENr+2lBXm8cD6G0CScs7Fb00KQCjeO98mYyMpWZ9
         n73Ol22Pk5Aa88BCyJ+Mn/WSFnvju6immMbr3xEehVlBME5YR2nS6zmJixAm7cKJYcC5
         okx3/5qvrY/AT6yk0lQiXgWICwBl0f9vVE9EX/jUkJN+LuoeUGQEwuWaeDEkUt3/pWC0
         KEIIGtl1VWPZSpqO7UyMb69pmTrk5nVfHWKOBTsZg0G50fQSWsVjhIvHXWJslrnK9zaZ
         XElQ==
X-Gm-Message-State: AHQUAuYMLWFnFbAkEhKHqopapZ3CxT0SgJ9fyR9vNL65YA+pJeFRNgbA
        Hqe35PkwB7tApC4NmIj/QiVkdhrvEos=
X-Google-Smtp-Source: AHgI3Ia2D/lS0MJhsBTgw3swDjiuPbsiJ/8f4XMyqUivcezL21/8hKs9qWtOwAHzc/aZ4Gf/FaiRYA==
X-Received: by 2002:ac2:510e:: with SMTP id q14mr15498329lfb.106.1550585848425;
        Tue, 19 Feb 2019 06:17:28 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id i15sm4223722ljb.48.2019.02.19.06.17.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 06:17:27 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix LE Read Transmit Power Command deconding
Date:   Tue, 19 Feb 2019 15:17:24 +0100
Message-ID: <5520196.lJkKZ16GmH@ix>
Organization: CODECOUP
In-Reply-To: <20190215125828.20410-1-szymon.janc@codecoup.pl>
References: <20190215125828.20410-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday, 15 February 2019 13:58:28 CET Szymon Janc wrote:
> Min and max TX power are signed intergers.
> ---
>  monitor/bt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor/bt.h b/monitor/bt.h
> index ec62864d6..1fbb40efc 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -2359,8 +2359,8 @@ struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
> #define BT_HCI_CMD_LE_READ_TX_POWER		0x204b
>  struct bt_hci_rsp_le_read_tx_power {
>  	uint8_t  status;
> -	uint8_t  min_tx_power;
> -	uint8_t  max_tx_power;
> +	int8_t  min_tx_power;
> +	int8_t  max_tx_power;
>  } __attribute__ ((packed));
> 
>  #define BT_HCI_CMD_LE_READ_RF_PATH_COMPENSATION		0x204c

Applied.

-- 
pozdrawiam
Szymon Janc


