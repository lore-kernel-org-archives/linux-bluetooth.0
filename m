Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE7C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672B2206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5TtFytd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgF2ViM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbgF2ViH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 17:38:07 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76205C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 14:38:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so14806330oty.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DxrQSJgRWZhZIu+kcajfBCwUzlLVUL7fFgiTLJrLQQ=;
        b=F5TtFytdWFhWn8yqtqkAPKB21EtwsdJPpieCYk8hL0y9bXt360IV903rvGJP0CLTt9
         jq+IwXOID/40JRIMGUmSjRp35pWKXiC1h1RZACLAdOr9ax3x26A2snLzl3n/9/30m9M9
         MinecbOxpc3JRxWgTxQIsut5gGZii26XZgbyFEf554pSFvHYCCIQJP0tWZWgwS0H4kqq
         /0PXG8MWBlH5y2UNBdEJuRhrjC8nbnDc+Eir/ERQ/xyx7Sgvlzu/IMC6h1tvbnHF+brX
         8bfxNyuZHVKcXw8inUc6cVkPdHeqeFIVtOFkI1hPP/snji/ok7Xgq6j4DFEculihYWKS
         O1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DxrQSJgRWZhZIu+kcajfBCwUzlLVUL7fFgiTLJrLQQ=;
        b=f/Ug7icAdYffacxrieEJytuD/BN0oKmrcZ0mM4a5HWJQGxBokOXC24pS1ll5/CK/jN
         wUjqaDVWGdsqYMHyrc9cXE1inoTS02R4sKHQXhzDfZ+um0oC7zsdP5f316Q67xQMqxPZ
         SH8dwCLQE2dtxJf0r/v0U3EkrgaQhylZVz7/emoXS7LkLBqQUnF7HSJIMik5Cp7fKCXz
         o/sIuGV4riy8cJ1Y4HCvzJkHlXjqs54WdHUQDVJTjilvql8r/sl01FuDWNRUf2EzVPda
         KJ3V5J+jkkAdWsKs4eMyczx0Sk5Oiz1VXZq3GDw6aw1LwZ/9k67b/XZKyR6NBmSz+afL
         2dhQ==
X-Gm-Message-State: AOAM532/0c9J8WyNVIeUqTJEb8QfgKCDXQ1RRVoakGGxqdsQTCpgCZl4
        irjQZr7a7K/T8PHcjDkCHgZ1g0z326EUd7PuPgo=
X-Google-Smtp-Source: ABdhPJyefF4V5RM/u6TSk8oFQ2QMfMTC64YYeYXRq1DAIq3PdbvWm5LligD/JGNd8uk7Pyo7aEUsrpT9ATeejXLS9e0=
X-Received: by 2002:a05:6830:1e85:: with SMTP id n5mr14770351otr.362.1593466685764;
 Mon, 29 Jun 2020 14:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200601155858.156798-1-alainm@chromium.org> <CALWDO_WDhOZigHU8SWtkTV1TcUeDRae910fiiHJmiyo8NPp6pg@mail.gmail.com>
In-Reply-To: <CALWDO_WDhOZigHU8SWtkTV1TcUeDRae910fiiHJmiyo8NPp6pg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Jun 2020 14:37:54 -0700
Message-ID: <CABBYNZKSAj7V7u7YYuv2eRv+OGJ7rc45HyAV2mh6jG-br4OADQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH] a2dp:fixing typo in endpoint_setconf_ind
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Jun 29, 2020 at 12:43 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Luiz,
>
> Just a friendly nudge, this is an easy one :)
>
> Thanks,
> Alain
>
>
> On Mon, Jun 1, 2020 at 11:59 AM Alain Michaud <alainm@chromium.org> wrote:
> >
> > This patch simply fixes a typo in endpoint_setconf_ind.
> >
> > ---
> >
> >  profiles/audio/a2dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index 6f46c92bf..e3d6cfc9e 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -654,7 +654,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
> >                                                 endpoint_setconf_cb,
> >                                                 a2dp_sep->user_data);
> >                 if (ret == 0) {
> > -                       /* Attempt to reverve discover if there are no remote
> > +                       /* Attempt to reverse discover if there are no remote
> >                          * SEPs.
> >                          */
> >                         if (queue_isempty(setup->chan->seps))
> > --
> > 2.27.0.rc2.251.g90737beb825-goog
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
