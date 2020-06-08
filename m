Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7780FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBFA206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWY59Drm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFHNks (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgFHNks (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 09:40:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68AEC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 06:40:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k8so13461470edq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:git:git:git:git:content-transfer-encoding;
        bh=SUXb6kOmxmNyiArAaDnJO46nhgGvn6KQ8agSb1uC6QU=;
        b=iWY59DrmB3/Rshsw1UATQQ3QnEoWwL6kSwTfSLswCaGKlpVb5SLTESC1+7MLl8Om6i
         qwJ+hAnQXLGtICcjECJY+R8xczWjs3lUk1V92udN6thj1cBwg3H4c7mocy//jzj+oDN2
         DJGmWUyLYyDDWggSmyW6wr04wqw6RUfTEQDls4FZWqnD1Zxna9BF2xF/+B6JM9E4oB9k
         FBsKrI5cpUlZlFOtrYZNDMASUO+YHgzWWPo12hzzAQXPJ56eWoC4wJRj+Fc10auhSYtj
         CFI4bUvlgQKR7JBMvEtvgDQLnxaGqWovTTOLo9jKUrD+WEWL9nIjjyyiufTgSZkP94Td
         AXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:git:git:git:git:content-transfer-encoding;
        bh=SUXb6kOmxmNyiArAaDnJO46nhgGvn6KQ8agSb1uC6QU=;
        b=eCCBwJ1HhgfU25ribBJoYkB9z3o1LOLbBkroPKJqonPtRXJ3EgV4wItFkeR2RcOh1A
         qjiFO9iocrVbbzBYIZWm3gsIW78tmX6kM7Zn89NyNkrBtC/mNn7swydxdem7uq4sfBWK
         4Qnw6fwkQJyasynLwDxKdAn3oqXJzrjWkhQYeaXzZpVRWa32Gt7X6hynEPJ5U7KqBdSz
         1IMmiwhrylccD6IiZatRVkX2U2LFzSMWU5vTaQH3Flbma2YYBFjQH4o3w4K6RaoO1jCD
         UXx4ZuPX3MoJz998dHmqjNzXvaqnGNzFuxtxYF+hSmt38eeT7HGHKef/t/1uj0bgMKYm
         nKNw==
X-Gm-Message-State: AOAM531VaZAg3yN4/Afq3wM2x/La45sQ9m8RyCe7DjOOTb6vX9afVFKs
        XF1mDMSs8ZEBTy5/nTC6mfY2/y6J1lM=
X-Google-Smtp-Source: ABdhPJyAQZJM7mSu5kn6OBkCJNKnAXNimyNKRHKyv+ebXE2+4UVOas33PYNSrgQan0pKSRRjCJEIgQ==
X-Received: by 2002:a50:af25:: with SMTP id g34mr10759279edd.85.1591623645606;
        Mon, 08 Jun 2020 06:40:45 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id b14sm10770202ejq.105.2020.06.08.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 06:40:45 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Marijn Suijten <marijns95@gmail.com>
Subject: Re: [PATCH BlueZ] btio: Fix not translation mode to L2CAP mode
Date:   Mon,  8 Jun 2020 15:40:36 +0200
Message-Id: <20200608134036.3242711-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: CABBYNZJ=RirU3of1pCUjgBwKTP0Rmv5g0uGP-CKJnYLvdDUwOQ@mail.gmail.com
References: <CABBYNZJ=RirU3of1pCUjgBwKTP0Rmv5g0uGP-CKJnYLvdDUwOQ@mail.gmail.com>
MIME-Version: 1.0
GIT:    Lines beginning in "GIT:" will be removed.
GIT:    Consider including an overall diffstat or table of contents
GIT:    for the patch you are writing.
GIT:    Clear the body content if you don't wish to send a summary.
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Hi,
>
> On Fri, Jun 5, 2020 at 10:59 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > When using L2CAP_OPTIONS legacy modes need to be used since they are
> > not compatible with BT_MODE.
> > ---
> >  btio/btio.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/btio/btio.c b/btio/btio.c
> > index 13c731062..844d6007f 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -597,6 +597,20 @@ static gboolean get_key_size(int sock, int *size, GError **err)
> >         return FALSE;
> >  }
> >
> > +static uint8_t mode_l2mode(uint8_t mode)
> > +{
> > +       switch (mode) {
> > +       case BT_IO_MODE_BASIC:
> > +               return L2CAP_MODE_BASIC;
> > +       case BT_IO_MODE_ERTM:
> > +               return L2CAP_MODE_ERTM;
> > +       case BT_IO_MODE_STREAMING:
> > +               return L2CAP_MODE_STREAMING;
> > +       default:
> > +               return UINT8_MAX;
> > +       }
> > +}
> > +
> >  static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
> >                                                 uint8_t mode, GError **err)
> >  {
> > @@ -614,8 +628,14 @@ static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
> >                 l2o.imtu = imtu;
> >         if (omtu)
> >                 l2o.omtu = omtu;
> > -       if (mode)
> > -               l2o.mode = mode;
> > +
> > +       if (mode) {
> > +               l2o.mode = mode_l2mode(mode);
> > +               if (l2o.mode == UINT8_MAX) {
> > +                       ERROR_FAILED(err, "Unsupported mode", errno);
> > +                       return FALSE;
> > +               }
> > +       }
> >
> >         if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o)) < 0) {
> >                 ERROR_FAILED(err, "setsockopt(L2CAP_OPTIONS)", errno);
> > --
> > 2.25.3
>
> Pushed.
>
> --
> Luiz Augusto von Dentz

This patch seems to break avctp browsing. The creation of browsing_io in
avctp_register already uses L2CAP_MODE_ERTM which is not in the
switch-case hence results in "Unsupported mode". What is the desired way
to fix this? Should all those calls use BT_IO_MODE_* instead? Not to
mention the uses of these functions should be checked for their enum
usage as well.

- Marijn Suijten
