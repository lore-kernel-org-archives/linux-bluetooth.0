Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A86FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7BB2073B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 20:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Du8oCqtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407309AbgE1Um4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407240AbgE1Umz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 16:42:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA9FC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 13:42:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so996880pje.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zdyzLimXPKb8loA9eaNOpZUzWfyNaM5PR6IwlYxpXo4=;
        b=Du8oCqtJwgbtosFY4o395cLSrMzX/msg37UKQjYvLS6QQ7YLGyN638DSsEQsaeeY2f
         bqbrcEjJlSpY6oGKOTay+04QHpGFV1ORhJ2E99xg625at5WwGQU/jk9eV7vTuwMOTN6p
         1mVDkyGnQ7Q/uF/evtjPW1Vaf4PbR95+GWbNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdyzLimXPKb8loA9eaNOpZUzWfyNaM5PR6IwlYxpXo4=;
        b=WUVp1coiyVYTucUL67FmaYxFssQMHo/z6K3FDC4JIlLM0MkXKjBLekkoZa2fzeEH0X
         hpF2c8tHiCpOth73L9L+TicmlY2UjpOpwRArgi2YxYuJXA5o5FrhoGUOzKSwzsxFvOyJ
         Df/cxqXCXrq2iRIS2oYukeS8WAqDD1+FEK4xkCo9Tlwj4EljVmu2KXEZMFA2otVLHPrp
         p3mtAWJ10VytqhNRpkLE661xozyA81CjUPw3WMwtB1SiIEZwbUtbBflgIyfoevjCDu6n
         L4/q/SziXOTBMZCd7X+AZ2LxYcCuto1ujUQUi3FjgNRuz1bB5qbVafJJbz16aO7GCWTe
         jIMg==
X-Gm-Message-State: AOAM533wYIaR98nTmaMMpbZNvjSyKlxIa1pdJGvQFp9kBGDqf9FLUUDR
        lAzAexFlPOKCu2Wr08u7oVTENA==
X-Google-Smtp-Source: ABdhPJyc5Y33yZEJNPHkyz6Y9xrbOnyBsYt39W75M0ByokE/SZClzan4j2p7o8JcmfA/bBrPWvSJPw==
X-Received: by 2002:a17:90a:23e7:: with SMTP id g94mr6003805pje.210.1590698573489;
        Thu, 28 May 2020 13:42:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id m12sm5860434pjf.44.2020.05.28.13.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 13:42:52 -0700 (PDT)
Date:   Thu, 28 May 2020 13:42:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, stable@kernel.org, tientzu@chromium.org
Subject: Re: [PATCH v2] bluetooth: hci_qca: Fix suspend/resume functionality
 failure
Message-ID: <20200528204251.GM4525@google.com>
References: <1590697867-7618-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590697867-7618-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 29, 2020 at 04:31:07AM +0800, Zijun Hu wrote:
> @dev parameter of qca_suspend()/qca_resume() represents
> serdev_device, but it is mistook for hci_dev and causes
> succedent unexpected memory access.
> 
> Fix by taking @dev as serdev_device.
> 
> Fixes: 41d5b25fed0 ("Bluetooth: hci_qca: add PM support")
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
