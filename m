Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984CDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9682177B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJW6cIiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgHTRVV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgHTRVR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 13:21:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0827C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 10:21:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so3415352ejc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdufANzauToKqmwmMwTfQjvv8/deNb/umE9oNAjsLvc=;
        b=KJW6cIiAm80v3j3MztQgrglJPct/M/E9qEUZZaiTyphKmd/gWcPrH6ngEfCdKX8OYa
         tbwkRGUMUB9NfXdGS3XVY7lJu3Zi897CZQn1ij1TrzMCGQ0DkfMSlP9jsJIaFIBFFIi6
         6zlWKTyV9zGaOZa9KCXefSzKSCUw2MmUvZZSdTumfCNiWSO7XuaD8AgwZEeRCSXUc5Tc
         xEvx2Rvvxim3xlLM68T90uvt70Wjhqk/S2u7FPM+vUZwvQU6xdfsyJ6L0E3I4sRVGiLA
         GuQh9QrLe0xkpVioxDd8X45C5xYi2FLSH3kGKAEGU7OFOf9UqNN2FOWmAhrjUleKfv6B
         RBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdufANzauToKqmwmMwTfQjvv8/deNb/umE9oNAjsLvc=;
        b=M/2TGqNZnfBNNhZbWF0Fql9yHntjOgZHe5DLXkg8gFYSxw0FuYWNGGi+IcsifF4f7J
         9QrM8VPJBAHHPfoC6iEXdGTLM4kAJRjOK9788Kz3CgEVqOY3ERI5VHQTHc/Nlk4FezfZ
         cE6z0qGA4+h8yXyi8SYiX9jZxsHnUQMyZzFE12ULAAtm6xPIUnVrhprSLzXm5V9os2na
         QVoEu2UhXWa6bl2fM41P9VhGqllurFEZWYjYnt/Gdq9G0zlF3quM+N4xf6kTuJXw5Epl
         nQHSVTH7FRKPYdPX2fZKwVlnHI7XdOS0WlujAiL2lzZ+TDDK1Sgg8m0MfKLGHVk4OJgl
         +QFw==
X-Gm-Message-State: AOAM530UUKL/NXUAeUgTK9vk8JRGsWk5yp4AZgX/ot+ROHBqlwMHqGi5
        S4F5wY0aHHjp21zsCX5VaqCLEXoQpU2Ex9aKjDp9fA==
X-Google-Smtp-Source: ABdhPJy02Do52250u7VdnW1pqpfL7a/DbB1GUOL3tNTB7Y8cZ36NSbUMGiTNNDDYPl6t5ZaGQhHLjVNM8FrqkLhNr4E=
X-Received: by 2002:a17:906:c2c8:: with SMTP id ch8mr4146656ejb.161.1597944072198;
 Thu, 20 Aug 2020 10:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com> <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
 <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com>
In-Reply-To: <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com>
From:   Yu Liu <yudiliu@google.com>
Date:   Thu, 20 Aug 2020 10:20:36 -0700
Message-ID: <CAHC-ybxshy5zmkAku6suicvjO0Ngofp0+gRyYLX_RXr9YhU94Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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

Friendly ping for comments from Marcel. Thanks.


On Mon, Aug 17, 2020 at 4:17 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marcel,
>
> On Mon, Aug 17, 2020 at 4:07 PM Yu Liu <yudiliu@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Initially this is introduced to query whether WBS is supported by the adapter,
> > the API is generic enough to be extended to support querying others in
> > the future.
> >
> > Reviewed-by: sonnysasaka@chromium.org
> >
> > Signed-off-by: Yu Liu <yudiliu@google.com>
> > ---
> >
> > Changes in v2:
> > - Return an array of strings instead of a dict
> >
> > Changes in v1:
> > - Initial change
> >
> >  doc/adapter-api.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index 1a7255750..8fbcadb54 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -204,6 +204,18 @@ Methods            void StartDiscovery()
> >                                          org.bluez.Error.NotReady
> >                                          org.bluez.Error.Failed
> >
> > +               array{string} GetCapabilities()
> > +
> > +                       This method returns a list of supported
> > +                       capabilities that is populated when the adapter
> > +                       initiated.
> > +
> > +                       Possible values:
> > +                               "wbs" - Wide band speech
>
> Btw, should we stick to use wbs terminology here, or we should
> actually use the HCI feature/command, because wbs has actually to be
> implemented by the HFP afaik this is only indicating that the
> controller is able to notify packets drops, etc, with use of erroneous
> command. Perhaps we should actually use the term PLC (Packet Loss
> Concealment) instead since that seems to be the real capability here,
> afaik WBS does not actually require PLC.
>
> > +
> > +                       Possible errors: org.bluez.Error.NotReady
> > +                                        org.bluez.Error.Failed
> > +
> >  Properties     string Address [readonly]
> >
> >                         The Bluetooth device address.
> > --
> > 2.28.0.220.ged08abb693-goog
> >
>
>
> --
> Luiz Augusto von Dentz
