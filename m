Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B68EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 23:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4971D20709
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 23:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMyMxx3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHQXRL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHQXRI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 19:17:08 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD60C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 16:17:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v6so14769281ota.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBN+7DVSoGmRYZdaF0Xc2Fr0jnFu0vtmzUtOMztMCvY=;
        b=JMyMxx3SP14VqB41O7Upjcma9ejQjvya7OeyvIPEczgYi1SS7ObRGpgxXtbD/7hh6U
         3SDbCejRF2mPXNkjvn17ogxEKjzGp9o2/eUTZLRjS+QCXdewe7ytHq8+Fr85epKrA8NV
         jmw5JDcrrIyzVHnoRcIVHePaACGd5RbXtm2larBXbzs1lCpH96bOmz62YSCRLgDBRvkT
         hp4/1QAHQBN7Re9imjXDv2NzigrnIzq2WQyZ78IDArW3nej0StaJCEq6Lj0MdMZh1MQR
         62+JmSNI1Egyfhv9FHd9Im2x9KkPyYg06OKHNlbpyOYTK/eUl8eHl+Z3aXtXkxeV3Viq
         aWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBN+7DVSoGmRYZdaF0Xc2Fr0jnFu0vtmzUtOMztMCvY=;
        b=iYacYCoTqLA5r9acikzoGEgwyaDHLk60XmeKAmeKF98oc42I8gvvr1F2q3jtz/MWSk
         wyzQCckI7aNCiSxcVY41tmloz0+Ptmx6zfd2IJ7nXimlBacOxw9d7OWpiRr17s9uBZly
         2vY6cz38H3E62wDP8VXWskF4c1KUkyw9m9Br93dvSD6PreoFsXI++K0N2fM3RXyiXb7H
         m4Je0O2V6Lul4igqJc7MCjzUY3FllLG3LWxeQqV5eNwYvAU2OqI8B3H9Rrl4IWSb8PcB
         adcKnL3ymfSqyzuZoWotyzUfPyA18IIpJVD8numRR1SnVC6SorVD+kgQlLdz1DIDiaCy
         QB3A==
X-Gm-Message-State: AOAM531Q4ju6qNuR1BVMtl7XaRCyl9SdTBBmetx/bEMmUwA+DGwShnfz
        rbSFyTWM0iE+8uSDwVGOD4DBi6rY8CGigMaK37p+XCAM
X-Google-Smtp-Source: ABdhPJxuMnoYx4/tmAqcX1dOUrvBo2AOFjcKcnIr/RBAbf+LSjNAnf0CRuW3EGnV0m/19C/Hj5xcctpV5+ujKS0NfPY=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr12568844otj.362.1597706224803;
 Mon, 17 Aug 2020 16:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com> <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
In-Reply-To: <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 16:16:54 -0700
Message-ID: <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Aug 17, 2020 at 4:07 PM Yu Liu <yudiliu@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Initially this is introduced to query whether WBS is supported by the adapter,
> the API is generic enough to be extended to support querying others in
> the future.
>
> Reviewed-by: sonnysasaka@chromium.org
>
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
>
> Changes in v2:
> - Return an array of strings instead of a dict
>
> Changes in v1:
> - Initial change
>
>  doc/adapter-api.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 1a7255750..8fbcadb54 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -204,6 +204,18 @@ Methods            void StartDiscovery()
>                                          org.bluez.Error.NotReady
>                                          org.bluez.Error.Failed
>
> +               array{string} GetCapabilities()
> +
> +                       This method returns a list of supported
> +                       capabilities that is populated when the adapter
> +                       initiated.
> +
> +                       Possible values:
> +                               "wbs" - Wide band speech

Btw, should we stick to use wbs terminology here, or we should
actually use the HCI feature/command, because wbs has actually to be
implemented by the HFP afaik this is only indicating that the
controller is able to notify packets drops, etc, with use of erroneous
command. Perhaps we should actually use the term PLC (Packet Loss
Concealment) instead since that seems to be the real capability here,
afaik WBS does not actually require PLC.

> +
> +                       Possible errors: org.bluez.Error.NotReady
> +                                        org.bluez.Error.Failed
> +
>  Properties     string Address [readonly]
>
>                         The Bluetooth device address.
> --
> 2.28.0.220.ged08abb693-goog
>


-- 
Luiz Augusto von Dentz
