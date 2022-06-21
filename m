Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BAEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353270AbiFUTXc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353561AbiFUTVb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:21:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86332C10E
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:21:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z17so8022024wmi.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JPNzM25jsQ4hfn+OQR7rzKZ3G1th9F8AT22AF3Eao58=;
        b=JyqZt1W7bQcQJxxtZgwpDRYXSRvwnoxpk0ziWMD5QdLWE9vl3xKGHyYi+8rsk5hwyv
         1YN7wXWk6Wp8KcAV4y41pcieFm8bLpasYaa6+HIz1bBU1dUR6IBU/yNwNV++8+4L8FxW
         GLYnx+v3n1gBIAN+zhrP1XIZm9c0M/E+IX6IIeVgAsI7W4RfzzaKBc9Uq45eYob5ACz2
         O+397jIUCqffx17pdpJsTnvZ6WOaRrVusd3TjH46p757LtK1MLiPeAqsuwtwH5a932+7
         fm6NL1qgFZcxf0rkg/ILRt/O6Yo9+IbwcI1tQJNhxkJVNLj7FInczB3Y2Yi5Dulz7/pf
         lVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JPNzM25jsQ4hfn+OQR7rzKZ3G1th9F8AT22AF3Eao58=;
        b=JnA8KjXi2RK4tRHJVGMwMCEo/g91QUBlyD0/wyYmwqX2gXhEE94SEAvzDn1tvT68Sg
         nezUKk0C9iCKybvetQOuZCkVyAIm+HQqGK1ZGClqw69bfaHoqf8nFpoowdV3X2Xz1ynT
         Iccfa7AyA5Ddyo3rUxA80+M9f8e3HTEuSdjYFbfQOhOAk5ZUgybJ5m/Rjib8bK8rssFL
         Vki9F99IHiZ9vpxhHJ5RsepnTTMdmzCZTML0Jt7v+TAw/Cef/g4pDwHHrTqjO9nveS7m
         0GOmz3ayOtr7Hl0d5Q2OK9IUHGiYBliS/e43bbdWJXgfx5aedA2F5gN8b5h5TALTE8B0
         xvkw==
X-Gm-Message-State: AOAM532AUZHcQFpNn+oWOJiCu9rzGOuxH2Zvxkrg4aHHCa7fVpx+RNqk
        0MAxdLi84wlwU28xHqFVS1US0g==
X-Google-Smtp-Source: ABdhPJxlFjL4nTATY0WIrWK4xIyXEj+pluEEndV3lf1g2D/FOI/iUixUB6Y6UPXYJK5DnCeP/4YMEA==
X-Received: by 2002:a7b:c346:0:b0:397:626d:d2c4 with SMTP id l6-20020a7bc346000000b00397626dd2c4mr42076181wmj.172.1655839287317;
        Tue, 21 Jun 2022 12:21:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c4f4f00b0039748be12dbsm25113528wmq.47.2022.06.21.12.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:21:26 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:21:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/1] Bluetooth: Use chan_list_lock to protect the whole
 put/destroy invokation
Message-ID: <YrIaNPfHozsAplR+@google.com>
References: <20220607134709.373344-1-lee.jones@linaro.org>
 <YrHX9pj/f0tkqJis@google.com>
 <CABBYNZKniL5Y8r0ztFC0s2PEx3GA5YtKeG7of_vMRvqArjeMpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKniL5Y8r0ztFC0s2PEx3GA5YtKeG7of_vMRvqArjeMpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 21 Jun 2022, Luiz Augusto von Dentz wrote:

> Hi Lee,
> 
> On Tue, Jun 21, 2022 at 7:38 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 07 Jun 2022, Lee Jones wrote:
> >
> > > This change prevents a use-after-free caused by one of the worker
> > > threads starting up (see below) *after* the final channel reference
> > > has been put() during sock_close() but *before* the references to the
> > > channel have been destroyed.
> > >
> > >   refcount_t: increment on 0; use-after-free.
> > >   BUG: KASAN: use-after-free in refcount_dec_and_test+0x20/0xd0
> > >   Read of size 4 at addr ffffffc114f5bf18 by task kworker/u17:14/705
> > >
> > >   CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W       4.14.234-00003-g1fb6d0bd49a4-dirty #28
> > >   Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 Google Inc. MSM sm8150 Flame DVT (DT)
> > >   Workqueue: hci0 hci_rx_work
> > >   Call trace:
> > >    dump_backtrace+0x0/0x378
> > >    show_stack+0x20/0x2c
> > >    dump_stack+0x124/0x148
> > >    print_address_description+0x80/0x2e8
> > >    __kasan_report+0x168/0x188
> > >    kasan_report+0x10/0x18
> > >    __asan_load4+0x84/0x8c
> > >    refcount_dec_and_test+0x20/0xd0
> > >    l2cap_chan_put+0x48/0x12c
> > >    l2cap_recv_frame+0x4770/0x6550
> > >    l2cap_recv_acldata+0x44c/0x7a4
> > >    hci_acldata_packet+0x100/0x188
> > >    hci_rx_work+0x178/0x23c
> > >    process_one_work+0x35c/0x95c
> > >    worker_thread+0x4cc/0x960
> > >    kthread+0x1a8/0x1c4
> > >    ret_from_fork+0x10/0x18
> > >
> > > Cc: stable@kernel.org
> > > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > > Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > Cc: linux-bluetooth@vger.kernel.org
> > > Cc: netdev@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  net/bluetooth/l2cap_core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > No reply for 2 weeks.
> >
> > Is this patch being considered at all?
> >
> > Can I help in any way?
> 
> Could you please resend to trigger CI, looks like CI missed this one
> for some reason.

Should I submit it as I did before?  Or did I miss a mailing address?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
