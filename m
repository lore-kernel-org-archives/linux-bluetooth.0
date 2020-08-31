Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A1C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29472083E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 21:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBeUb92u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgHaVou (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgHaVot (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 17:44:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36139C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 14:44:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so6880170edk.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP7bcfk6+/3Yopc1eHI5vQIWajE9xbJMncMajv2F6lE=;
        b=pBeUb92uX4HJyuGbdNLPfSKC/8278cJCl/zEEeMABU/YDHDsIMbiseU7b/Q1bUPmU3
         4Q0v7j1N3pQXM1b0TPoYL5pwn++q+OyKe9eJVoPA114Pagq7tR9qRPb5MHieSVJNf5Zt
         n4GUiqlY+4Nd+ag4uSKSqGyVo84EWMRXKuEJw27k1mwUSARJZvc7kRhr24BrILkgZipJ
         dRNcsC5YxM0y0zrHKuKIRAAOVh1H86SoywkdT7gckZy+T0zmmMwqoG0phG0oKdEZgnua
         fPe6trAvFJOMulOwgG4/+N31uWIc3ZhVv01ezMCo0rU55KgfKBx/wnMLIOhKJJyXtgs0
         ALxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP7bcfk6+/3Yopc1eHI5vQIWajE9xbJMncMajv2F6lE=;
        b=nIlsrTxbZMwRepO1Gv9wl977KA8/E8dPM346g3K0dOG+m/caT7RDQwR7w2ZFJV+Iww
         IzaQBrfKqbAUJvDSeGfLMx8WpecouNGbMfpSGpN3bGeF5bbedm/eARQvk4Ism8E2l2St
         uGUnO4pePR9fPY0ZIrLM/8kFpIJrlWd369wfIfqgqTukl99kQgDCTaHh9bc3k6dZ80Uz
         8C6/Jnu6hULNIdUXJf7xvuRYgkucfHQFS3kUBeKbuDZkuj/lqoZji46L2U/zgUAa5KK6
         4k2WnvOt6luc4cKMDRL2OnCWnS55zmadBxqjKSnsh/M2pnZc1matvNrTKTULCIrfcgtK
         A3qw==
X-Gm-Message-State: AOAM530O/DmCD5Y21bd0/x0xfdLJKQGDtlGmTckmf6ZET6d8iLsRYO1H
        Oq6zRidBmyC9feRMxf6WgLlTH1XTLhNJyE8YTT/X6A==
X-Google-Smtp-Source: ABdhPJxFBpU3g3yHnPBLVGd3qkkrW7OXzVNHhMwGCPvrtayFNXkdt1G/PyIzKjMXKbB3J3aS1/FwZfjWJi7InoNO29E=
X-Received: by 2002:a05:6402:6d6:: with SMTP id n22mr2912538edy.79.1598910287550;
 Mon, 31 Aug 2020 14:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200817212554.3844965-1-yudiliu@google.com> <20200817142545.RFC.v2.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
 <CABBYNZLRqhB6d5Hm7_RqvUqCJo11D4+pgYLCeWj0j=8dZk0Bcg@mail.gmail.com> <CAHC-ybxshy5zmkAku6suicvjO0Ngofp0+gRyYLX_RXr9YhU94Q@mail.gmail.com>
In-Reply-To: <CAHC-ybxshy5zmkAku6suicvjO0Ngofp0+gRyYLX_RXr9YhU94Q@mail.gmail.com>
From:   Yu Liu <yudiliu@google.com>
Date:   Mon, 31 Aug 2020 14:44:11 -0700
Message-ID: <CAHC-ybxFY_3HWrvnwF5DS-i-YJtYpUuR9K3-MSWJWo=C-CKQHA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] adapter - D-Bus API for querying the adapter's capabilities
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainmichaud@google.com>
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

+Alain Michaud

Hi Marcel,

Can you please comment on the cl as well as Luiz's suggestion? Thanks.

On Thu, Aug 20, 2020 at 10:20 AM Yu Liu <yudiliu@google.com> wrote:
>
> Friendly ping for comments from Marcel. Thanks.
>
>
> On Mon, Aug 17, 2020 at 4:17 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Marcel,
> >
> > On Mon, Aug 17, 2020 at 4:07 PM Yu Liu <yudiliu@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > Initially this is introduced to query whether WBS is supported by the adapter,
> > > the API is generic enough to be extended to support querying others in
> > > the future.
> > >
> > > Reviewed-by: sonnysasaka@chromium.org
> > >
> > > Signed-off-by: Yu Liu <yudiliu@google.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Return an array of strings instead of a dict
> > >
> > > Changes in v1:
> > > - Initial change
> > >
> > >  doc/adapter-api.txt | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > > index 1a7255750..8fbcadb54 100644
> > > --- a/doc/adapter-api.txt
> > > +++ b/doc/adapter-api.txt
> > > @@ -204,6 +204,18 @@ Methods            void StartDiscovery()
> > >                                          org.bluez.Error.NotReady
> > >                                          org.bluez.Error.Failed
> > >
> > > +               array{string} GetCapabilities()
> > > +
> > > +                       This method returns a list of supported
> > > +                       capabilities that is populated when the adapter
> > > +                       initiated.
> > > +
> > > +                       Possible values:
> > > +                               "wbs" - Wide band speech
> >
> > Btw, should we stick to use wbs terminology here, or we should
> > actually use the HCI feature/command, because wbs has actually to be
> > implemented by the HFP afaik this is only indicating that the
> > controller is able to notify packets drops, etc, with use of erroneous
> > command. Perhaps we should actually use the term PLC (Packet Loss
> > Concealment) instead since that seems to be the real capability here,
> > afaik WBS does not actually require PLC.
> >
> > > +
> > > +                       Possible errors: org.bluez.Error.NotReady
> > > +                                        org.bluez.Error.Failed
> > > +
> > >  Properties     string Address [readonly]
> > >
> > >                         The Bluetooth device address.
> > > --
> > > 2.28.0.220.ged08abb693-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
