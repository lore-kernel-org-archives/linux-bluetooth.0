Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC232C07E9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 16:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9127C6100C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 16:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhGTP0M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbhGTPKw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 11:10:52 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B5C0617AB;
        Tue, 20 Jul 2021 08:47:07 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b13so33362989ybk.4;
        Tue, 20 Jul 2021 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tn5GQG1impN/UmGoIUcAsteqIcWCQ+O6KpXk/KRYhHI=;
        b=lNe/NW7lWDfERaztukADH3t7mRVDXv2pDELtmVvc07xZv0ICbm05BMThqPQSSUv9E/
         ttK+/Sh+Ik06l3uIOR3N+963yTIAC4Jr540RdewFXARtj3ZPH3mx83ZF0PfmxpUIzAEO
         f+K3h1ST0eiURDX0/B7REINx2adZcqjmEPH8MhKvj2qKm4+Qce7TFcpNo9+G1b10vLD7
         ZgjNONkjZ12ykLi2WnADh5sjwt0frPhPXO3szciv99P9o7NJScVrPwzzfoeRUrAVJle0
         rFTz0GvanUoQ/TiEUbktBBCFOmLWKHwuPYWHNfKSiQw4hC3zzF6BeqXmHXUvP7NryZDJ
         BA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tn5GQG1impN/UmGoIUcAsteqIcWCQ+O6KpXk/KRYhHI=;
        b=cxB1m470RYO4WcLZ2xTfZtuPt+5f1MXPfo8AaZShdc3j5F9eSV0noX+lE8J+ITSWMl
         y331qmKNoKSDnPR/NY8aPHgwXrDgniFqwEU7iyvH+C4f5hvMktZFrU8gw9rVrTv6pq6V
         MOPu7KLQLlv3lR2EEXaLDCLaxab10FS7iegmxLQ4hetdCYb6caICCOTo0LYLonQ5+qlJ
         01j9xTKnRNGakuOJb5UTnFy5ngn9cZTcSDhWiCXMDcJAs1QoRb4XhUMFrRgUCvbOxZQs
         9YsGjnIdAK9ax0X5CdN+UJDA14YAJ+2CEsJLKSxox+bTq3Gyusa8A3X/1aP9+9yJcJxE
         DBDQ==
X-Gm-Message-State: AOAM533QTvDTyu/qPdXGCLlsAPaBSnKV2MR3hgLU5mPQGYWcXJCVSRsH
        x9MD16iXQVEiDFHOTIy1S9IzxHM2OU33vwoy5Tk=
X-Google-Smtp-Source: ABdhPJwH+vPpHV3/iIL524Q2gUMiQvMFEi+ZeqvPtEb3SDgb0PiJRlrOt6Cqrtwu2GlZu4x42p3ivQ1b4BnSYyVDafM=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr40586981ybu.282.1626796027029;
 Tue, 20 Jul 2021 08:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210719024937.9542-1-bobo.shaobowang@huawei.com>
 <20210719074829.2554-1-hdanton@sina.com> <97b64908-45d3-f074-bd9c-0bb04624bad1@huawei.com>
 <20210720021619.621-1-hdanton@sina.com> <CABBYNZLfFs86Hiej6C2EMVutf4ygyamifBJrXdQK97JpTLBqKg@mail.gmail.com>
 <20210720062100.819-1-hdanton@sina.com>
In-Reply-To: <20210720062100.819-1-hdanton@sina.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Jul 2021 08:46:55 -0700
Message-ID: <CABBYNZKaNM=koHZ1X=D1_jD9NvEdYN4Be5mH5hAghHG2tkgCHA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free error in lock_sock_nested()
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, Wei Yongjun <weiyongjun1@huawei.com>,
        yuehaibing@huawei.com, huawei.libin@huawei.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+664818c59309176d03ee@syzkaller.appspotmail.com>,
        syzbot <syzbot+9a0875bc1b2ca466b484@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hillf,

On Mon, Jul 19, 2021 at 11:21 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 19 Jul 2021 21:24:30 -0700 Luiz Augusto von Dentz wrote:
> >
> >While Im fine adding a destroy callback the kfree shall be still in
> >l2cap_chan_destroy:
>
> Then feel free to send a tiny patchset to linux-bluetooth@vger.

What do you mean, we haven't applied your changes yet.


-- 
Luiz Augusto von Dentz
