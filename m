Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DEC43457
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 21:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E2B223BF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 21:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSvw3cb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbgJSVh5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733246AbgJSVh5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 17:37:57 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834F5C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 14:37:57 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id f15so326140uaq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBOWxB2321K0nviHMosmjzEKA9rYfYXfMrodT0hpf7A=;
        b=DSvw3cb/VokO0aHUeNw3leP/1Ajp6UPkFWHOZmkt7PkJmlaOQq75XG0CmzehL7Ir3b
         3fnO9XoEQ/d5zVW+ucrBTZDBw0H6yoBqF08Lvheyk2VrUgvCWYj1EN+u0CUiP0rZ7NK7
         UJu1zuQy/Vixd+KRWgq3tnhuRv/QA1LAa5YFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBOWxB2321K0nviHMosmjzEKA9rYfYXfMrodT0hpf7A=;
        b=igGrRpmaZNW0qI/lVgOU8uLwVOTqQEMYes0o1CZAG1qaVaEtALd0ENUcNS9c8Oo/7r
         UC6/IDbqS3elunuagjFWUjJrtdTXzuQ2PfN4qfUbF6tvLz6oeF8g1bLoQSv6dyjC7HWF
         g55CBYMHBRC7CSbvayvdSPBsMEGdZ/HWRyIMbnH4LD0LRuoESRbOMEBp0dvZ37dAoQv2
         9z1LB9c1wEi01w+FaovlPTxqlOWOM2y12GbwhJYaQ2WtCQ0KnhEXaUSA+R/uCZinJlt0
         b3G7D5rCbEdjyuSpDeKeJ7h2obV5vedwF+aMUMuRcb+TZqzK7UZHyo+9UtWD+dpcwRt4
         mGrA==
X-Gm-Message-State: AOAM533dgYvHOLopG3kHGcEhhqpru6W2gBSy7dWvlr3adVw0zOnTdb8n
        K/MHRzvcbT+it46mjzQ1zL+oD93t+q90B7SykIU4Sg==
X-Google-Smtp-Source: ABdhPJxOSKFLv6FUdXvwo9Kzlug/3CyRyn12FMtJvyIOznMU9zUml0fNKS/R9+hCxpT/QIBkONVN6WCtnRSRfNkvGrg=
X-Received: by 2002:ab0:907:: with SMTP id w7mr967440uag.100.1603143476645;
 Mon, 19 Oct 2020 14:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <b74ea9cb201bb98691ecbfb3893d2a49@codeaurora.org>
In-Reply-To: <b74ea9cb201bb98691ecbfb3893d2a49@codeaurora.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 19 Oct 2020 14:37:44 -0700
Message-ID: <CANFp7mXMfvHrAcaJhY7q2oZk3MtqOMxLGOEpNc-hnzVSyA+LZA@mail.gmail.com>
Subject: Re: Update WCN3991 FW file
To:     asitshah@codeaurora.org
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org, jwboyer@kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Hemantg <hemantg@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Nack.

This resulted in a boot loop on ChromeOS. It looks like only
'crbtfw32.tlv' was changed and not 'crnv32.bin'.

Abhishek

On Sat, Oct 17, 2020 at 8:33 AM <asitshah@codeaurora.org> wrote:
>
>
> Hi Team,
>
> Please include updated firmware bin for WCN3991.
>
> Snapshot of pull request is as below, let me know if anything is
> missing.
>
> >>>>>
>
> The following changes since commit
> 58d41d0facca2478d3e45f6321224361519aee96:
>
>    ice: Add comms package file for Intel E800 series driver (2020-10-05
> 08:09:03 -0400)
>
> are available in the git repository at:
>
>    https://github.com/shahasit/bt-linux-firmware/tree/master
>
> for you to fetch changes up to 8877322c1254f327f47c86ec02c46013b68b9a47:
>
>    QCA : Updated firmware file for WCN3991 (2020-10-17 20:53:36 +0530)
>
> ----------------------------------------------------------------
> Asit Shah (1):
>        QCA : Updated firmware file for WCN3991
>
>   qca/crbtfw32.tlv | Bin 126300 -> 126832 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)
>
> <<<<<<
>
> Regards,
> Asit
