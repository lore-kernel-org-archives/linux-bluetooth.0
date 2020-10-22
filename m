Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A3C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 20:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EB424248
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="icUmV87M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368061AbgJVUQq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S367981AbgJVUQp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 16:16:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE145C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:16:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ce10so4194016ejc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDLJnDFI5+2hJixggp+hQ+Cexb1z+zdD3F/VB0WCxGY=;
        b=icUmV87Mlo8IRuLWlWX0Q8a0BJZD76oadQnkj3WhLnjyHJVzIWe+VLbJxlGT/WkIch
         xK1dIF/XekCkRzBq29KEBmN35NdA1D1MutgcvORahweASuDqQTvaSneLw3gHfVzkezmO
         hS/E5GoRMNHLic2sTH4JupR6h61mIVAdzzoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDLJnDFI5+2hJixggp+hQ+Cexb1z+zdD3F/VB0WCxGY=;
        b=ekKx7fYBceWSgJbx2i3ZX2g/23ipawA/nJELICGxZotjYW21Y8VDl5h49cCqsgj4tx
         ECxXwALVntN6OXsWPCUtjR6hnfQmx0yMqNJyLAkVW0MU6+hi3tHBvUPYQu/OZ3Pu/JRj
         gm2zshC6N5sH2P49yzq9bks3DoiEFiOZZKp9S4bu77VC0GhbLEXMaSANR8swarB+ZbhL
         2Hy1PG6LANspqqmttK2RGyX9K0uGxM8MOic/6+tiMvCbSa2byDHLDm+PUpLhymL3gnVH
         12VVpNgWrBy6H/49eVOtsXdHkZN+aOrZIEZHVPnawRUNGhm0cI9Yu4J+QE4L3r2MJZGO
         eGWw==
X-Gm-Message-State: AOAM532jpKgw5Fe+Mb3eNjmMJtE7NwyjxJp3yyeFvpYvKy/A3B4kpQ2Z
        bzYrNFDUXfAMkOiAxqUjrDqRyYawxAy07A==
X-Google-Smtp-Source: ABdhPJwe4YMxaLqpxv8KhTL41z9yu8ZYF95sXWUqIRK/8YMtPpl320DJMjeD1JdCM5xIPeAN1mQTLg==
X-Received: by 2002:a17:906:742:: with SMTP id z2mr1690851ejb.57.1603397802098;
        Thu, 22 Oct 2020 13:16:42 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id k10sm1389472ejh.32.2020.10.22.13.16.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 13:16:40 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id e2so4792049wme.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:16:40 -0700 (PDT)
X-Received: by 2002:a1c:b7c6:: with SMTP id h189mr4379380wmf.154.1603397800227;
 Thu, 22 Oct 2020 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200916232924.129991-1-sonnysasaka@chromium.org> <ED6A96A4-A97A-423B-9E62-80BDA3A07164@holtmann.org>
In-Reply-To: <ED6A96A4-A97A-423B-9E62-80BDA3A07164@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 22 Oct 2020 13:16:29 -0700
X-Gmail-Original-Message-ID: <CAO271mkmWKLssFeohZhBQvyiJL6TJxeJjkr4f5tycS2kLqACeg@mail.gmail.com>
Message-ID: <CAO271mkmWKLssFeohZhBQvyiJL6TJxeJjkr4f5tycS2kLqACeg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/coding-style: Allow spaces after tabs for
 indenting wrapped lines
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Ping and resending in plain text]

Hi Marcel,

Could you share the reason behind the "only tab for indentation" rule
for userspace code? I find that it is hard to format the code and it'd
be good if we adopt the kernel space style indentation as well which
increases readability and ease of code formatting.


On Thu, Oct 1, 2020 at 12:16 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > The "only tabs for indentation" rule was enforced long ago to align with
> > Linux kernel net coding style. This is no longer the case today so we
> > are relaxing the coding style to allow spaces after tabs if it can
> > increase readability.
> >
> > ---
> > doc/coding-style.txt | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/doc/coding-style.txt b/doc/coding-style.txt
> > index f0bf880e3..6a7415847 100644
> > --- a/doc/coding-style.txt
> > +++ b/doc/coding-style.txt
> > @@ -104,9 +104,16 @@ void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> > void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> >                                                       btd_adapter_pin_cb_t cb)
> >
> > +5)
> > +void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
> > +                              btd_adapter_pin_cb_t cb)
> > +
> > The referred style for line wrapping is to indent as far as possible to the
> > right without hitting the 80 columns limit.
> >
> > +It is acceptable to add padding with spaces after tabs to increase
> > +readability, for example to indent function arguments at the parenthesis.
> > +
>
> NAK. The userspace style is a bit different than the kernel one.
>
> Regards
>
> Marcel
>
