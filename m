Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F77C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD82078E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw+Fn54a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgIOTxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgIOTxd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 15:53:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3141C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 12:53:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so4465381otl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Id/8pc9vmGXdJuxDyR0dvGreEIK/xqFKlzD5b57ynwI=;
        b=Hw+Fn54adGj3qBWwfLTpymSdDyMbJpl0HfrOac25KTx2Os0wwI0a+EZwnQQKzvqwWs
         liYlKE1Ax6ElQ+m29e154goj84Qv3TxbrrA3tMOAd3HsZA6HFQwtR7wHJwg/O7YSOoOx
         Ggq2dOPr+vXcPigG0AcuRbclPiIoB1kwLkvRgKZZQXmu7/zUsJcJgqdlfc8WrbnGmiz5
         5TfhrzpGeUN317RXJoRA0nW9hs6Py3Rbp4qMUMrFrxQos5W8MsOroCpBVtPS7pgqu6vy
         YKfF9/N2QKmL8P+hh6pm/jIf25miKTccZEBz8yNY4Mb8Td4C1orlgm+KdpL+DmeSGMUt
         H5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Id/8pc9vmGXdJuxDyR0dvGreEIK/xqFKlzD5b57ynwI=;
        b=slXwrUdo48gV/i1ej/tm0RpFhGugXq8GsLz8JFtpGxGoHMaf4QH9tpaoXS6SZD1ZaS
         0y+eqzlnvJ2D6XnA9sZ1ebzYGVjXbgdss8oXu7lUP1ED5Q+YWRJZ8WDA6+EDdHlWeVG2
         cLXJiXQgTFKfvuZlz124Q7i11EMoaL34v8ytS5tRlnKtremGmpCkuHbbLTtW5RytU30W
         gu24GtJea/+lzR5+O6Z+bs3+uNGBDRu2U7hTTwhGMRPMvxXFUixZWnY8WVMXJCiGwvIS
         99iap/G41g/RWdaW0qaheTrEiAICCIP0/G17KCpUBXXYffPxNJxTSwbt53WsXnyUF6wZ
         peHg==
X-Gm-Message-State: AOAM531B+uO5XAqVyNPwiWsN2OnGfMmzwXTMM+mqxt4AN/MWcQGBHtXJ
        NOy/2Qg07wSifaDPmOteLeWVwmGw3J4FptuXzyM=
X-Google-Smtp-Source: ABdhPJyfpV352hk3wFvjH2p0YgEZO79l1IBI+MDkuJZGYlQMG2vzZH1cQkv00uQXcA6j8jPoo4c55wbc62i1lU1l2GA=
X-Received: by 2002:a05:6830:22e6:: with SMTP id t6mr7913295otc.88.1600199612065;
 Tue, 15 Sep 2020 12:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
 <CABBYNZJeXkqmx1h85bxFBqJ4eDVfaPQJ9P1m_HApbJj48zT+_A@mail.gmail.com> <CABmPvSEZoYCSE_421Qu2b=z91NxajNxWNahA5xcOMqgPmV-ivA@mail.gmail.com>
In-Reply-To: <CABmPvSEZoYCSE_421Qu2b=z91NxajNxWNahA5xcOMqgPmV-ivA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Sep 2020 12:53:20 -0700
Message-ID: <CABBYNZ+VT9JMMsSh4AysjqJJzuLn5jY=NSsXEKKyAzAdjMDwcw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 1/8] adapter: Remove indirect dependency of headers
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Tue, Sep 15, 2020 at 12:29 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> Thanks for the extra fix to get this series through! We're waiting for
> further comments on
> https://patchwork.kernel.org/project/bluetooth/list/?series=348071.

Weird, I don't seem to have received this series.

> Regards,
> Miao
>
> On Mon, Sep 14, 2020 at 12:48 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Miao,
> >
> > On Fri, Sep 11, 2020 at 11:53 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > >
> > > Given that adapter.h refers symbols from lib/bluetooth.h and lib/sdp.h,
> > > these two headers should be included directly in adapter.h.
> > >
> > > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  src/adapter.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/src/adapter.h b/src/adapter.h
> > > index f8ac20261..c70a7b0da 100644
> > > --- a/src/adapter.h
> > > +++ b/src/adapter.h
> > > @@ -26,6 +26,9 @@
> > >  #include <dbus/dbus.h>
> > >  #include <glib.h>
> > >
> > > +#include <lib/bluetooth.h>
> > > +#include <lib/sdp.h>
> > > +
> > >  #define MAX_NAME_LENGTH                248
> > >
> > >  /* Invalid SSP passkey value used to indicate negative replies */
> > > --
> > > 2.26.2
> >
> > Applied, thanks. Note that I did introduce a path to fix the build
> > problem with  g_dbus_proxy_get_path.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
