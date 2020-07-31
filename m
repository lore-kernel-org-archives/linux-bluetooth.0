Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B62C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B696208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu7CBdOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgGaNnY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaNnY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 09:43:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AD9C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2020 06:43:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so19547721ljk.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2020 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=y8PXeEt0L8JsJtZtNq1ErYk/sYqqK5LKuJSlIGvyQuM=;
        b=Qu7CBdOCzcT8826VDP3PCS8bE3b88CLSDRpfyq47AME0PVm+nIIt34JR/EmX5gqO9r
         +mf6XNlsaTAQnhXMikrc0tMAAxs7au0vFUf8XmYAa7okPHgZKZ/FnMqa7iQW0H+WQf4Q
         2nQkzU+XAPwF3S/qDFfNRfgzBIiyIEFE3Eb2H2gcLBwEifdMNMyP8DcsegGZsG9lccJf
         +H8BiE+l7PpmJNcW5+ATaqeKCEKNYr2rf5ED8mGULBp7dDCEPRQYrMnaf6W0i8Bce7if
         WCJxs8hzas9hC6DFSNeC2j+kBLp3Dk3X9enkveoWyD1/DU5pgAAFDCvf6wXY/juKqI/g
         5TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=y8PXeEt0L8JsJtZtNq1ErYk/sYqqK5LKuJSlIGvyQuM=;
        b=ZgU+WjgsH1ggJjcgjEBKKnODdeWWryFg4cm+woiM43XIFQkZBKShwp0rprj62Lupt0
         J072krJ8rZECPRPvGnGwZsGSrFxU0px27XTOW3uTVgx7iuaR2/5sdZst06Qrp4+k2StT
         wiqLxwMyVYNcIsQSC9YcWfiq54YTm1Pnit5GaH5rlZSRt8NYQetovskMaCBgVH4YPcQy
         ay/7TM063EoOhVSrPSr13r4GDg+7+B6Pxo+HNR5H2odXhic9HDNbGXmqzzhWY8Qpulor
         NLDTc6GNCkLMM7m5V8pGcgu9pSqr7JlIS8t9bYDAqledCt1/VepCdDfH8A9MExMyUQyf
         AXHw==
X-Gm-Message-State: AOAM531YtCOcZ7xqhLaIySkIMNQs+OQ6aJ+Nopxrrwv2ZT6OAAMNzgrc
        HAi81h48aa08DEoLEaRAQRqMyeoA
X-Google-Smtp-Source: ABdhPJzxXid1KIJmsdyajf+mvtdX5ZxnyeYkvVrfOeCBUIl2P6OZTKB2ooBXp20o87GfirLG2Obh0A==
X-Received: by 2002:a2e:7f1a:: with SMTP id a26mr1158099ljd.123.1596203002107;
        Fri, 31 Jul 2020 06:43:22 -0700 (PDT)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id n205sm1939590lfd.59.2020.07.31.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 06:43:21 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:43:19 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increment management interface revision
Message-ID: <20200731134319.GA77314@jhedberg-mac01.home>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200730174011.71784-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730174011.71784-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Jul 30, 2020, Marcel Holtmann wrote:
> Increment the mgmt revision due to the recently added new commands.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
