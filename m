Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D3C47247
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 04:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571A0206FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 04:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0jw96NN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgEEEh3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgEEEh3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 00:37:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C459C061A0F
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 21:37:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so690265wma.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 21:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjr2p6Sky7HNtYLzkWBxt3sGdstFR5ZkvsJrYAroa3M=;
        b=C0jw96NN/EMfE2lRHLNXBA6hSqwbhH0MQuN9kndKd/wijLh5i9g3kFihS2EMZThNWH
         xxULYFgEJZSyElKKNBR884mAm/xfTxULg6+tQXuOYcXhXF+4LxZ07K8JrwK5soFtn9fh
         GbXS30g5q5v4iq4wm/uIMhv6Bd93unOLTSLTOJVWtC2nt9NAJeOW1+0HpUh/slwy/xTz
         Oh2sZS6eTwjA//Bj28Fpyc+UrDvNdtUg5qr2Af5g8tf1iumB65Q1upPa/CXdyC1Vxqme
         gXHsPYyqFxMmjwIPvNCTaZOGKh6txjIlp1QdzU0u3qFuh8HLF9rGvgPgDVLPmhv6Fb6J
         IcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjr2p6Sky7HNtYLzkWBxt3sGdstFR5ZkvsJrYAroa3M=;
        b=mFOWyDVCy8xSsTmrqTZjeMQ/JG3vAFQElCbHQp5IokFASyd2DRHIWMDYHx2RISXBIj
         DwJFsfQN9Tf/5d/WLBX7MjBGeCD6q38LmMi/82mhMiM0flHX1Bd9MkD9h5EfNpTF8o13
         tl+jj+6VRhUmPuSpXClZAhSrlMnKZZjjIXdW5B3/lcvr6fKWkq4Y+UIZK/aYDMhFJbMz
         jL+tP5RG/1N5uL40pA0sq8hNg6E1vJ5Uw8ACyLBnp3YfRSmMWQrU2/TYsImna7fyMJ0k
         cIxTFuhEwLCbUk7k0NFQEchx2qbGdit6sW+BIFNJLILjjSs6ZH+CzaP53QRz97nKCZ4z
         NRlg==
X-Gm-Message-State: AGi0PuZQlln7yTdZb9BwAa5TbQWPdsemKXhKBrq5SF6CVnv+JvEmNYVE
        YQ2x3ZBJoRI9Ior556nWQsO13PgsjBzq2Lku5w9AdEdb
X-Google-Smtp-Source: APiQypLmEubvGZYcs0L+UkLNepONNVP01TEtK5arouWhoulZ7JYIkTvRTiH8Shx1GmBSm+jhMaTrBmp4Kzifao7uCU0=
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr1088225wmb.61.1588653446116;
 Mon, 04 May 2020 21:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200430145105.Bluez.v1.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
 <CABBYNZL_rOVYs-3W8DZn_ugh-c23r+H4qjmBi55t3Rd-iZCW-Q@mail.gmail.com>
In-Reply-To: <CABBYNZL_rOVYs-3W8DZn_ugh-c23r+H4qjmBi55t3Rd-iZCW-Q@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 5 May 2020 12:37:15 +0800
Message-ID: <CAJQfnxEjQzLZVOG5nWnSdK_gxgat7BCdywoz1gNsocNRNHSOxg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] tools/l2cap-tester: Add test for waiting
 disconnection response
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Id make the test abort if cannot be disconnected properly, but it
> looks like we don't have any means to detect if the kernel has support
> for it or not, but perhaps it is fine since this is trying to test the
> right behavior.
>
Yeah, currently we have no way of knowing whether the kernel supports
this behavior or not. If we really want to, perhaps we can add
something to query that, but I doubt that is worth the hassle.
