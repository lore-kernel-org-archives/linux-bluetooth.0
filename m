Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79719C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 22:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5165F20C56
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDwiAsVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436963AbgE1WbQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 18:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436803AbgE1WbP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 18:31:15 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873FC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 15:31:15 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id g22so86244oop.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygMGdSPW2a6G+W3D6/dXKHgrqatfcTprCi/d3AI44KQ=;
        b=hDwiAsVi5gjL6BO4gw2f3g+vjRTXfIVmkRf8p5bg5eG87K+LUK9WfIHnmW1u+T1nPU
         0OEpWiM1EmAkIPh55vC1HPan8sQV3RheBIutHi4llqQq2SONzvEMhcMUMJYBJ3Zv1B8g
         wLRpe4/CcyMrhiehrn8cQot/PzgeWgd3+aXIMtza8AnCpUrIPXbMqb7CVIZBKscChI3b
         x8xjA4o+yODSg6vDRBKTAriNK1ImdiE1+w0M82NhNz8eCUUG7MgiUkTvmNK58nSZuxrL
         DJ3HPCc9EVqn0dM/VDy5483MaSzImOt1FLwLZPPrVrd1fHFrWYkws6QI7cry+JlHhsp9
         oFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygMGdSPW2a6G+W3D6/dXKHgrqatfcTprCi/d3AI44KQ=;
        b=qyXnlAhtFPDXM2FnqJkCxfOIl+CBIjxIFN9AgNdglToet7amJomjD0oYSva385/Fm3
         iYSpjU/Eb6vLSRBg+71+RUn8h9OUJa5jTrGUB7B1jBcWjUh8iSAWjjK0BkbnulSvnB1v
         WcP5ZRP2Bwq1ejrvDPYlctu2fE7tFBjeFgyOOlvefvoLquDD1TCpP715UDJHDp3atLIf
         x5aswaBi34+M9oJkADa48nO8Z7c10EvLsi9He11oDx1dsWAr/JG1E9k1UpjDJgr3Yxh+
         hT9Sr6T7TGrqJIxH2UPEB2ebCZZwXSmXXOIdrgOXSkVYLVAII6L0KhilzKlDxvgssbxE
         IRhg==
X-Gm-Message-State: AOAM530szQEwuPcf6tN6X91lxiqMy/4mhqa8nNxYDHeQQ12eAZ//1c+x
        CO642O6NpHMpDpo41rzhZ/RLYCt3Exp37QLPExc=
X-Google-Smtp-Source: ABdhPJy49q+xL2O9qU6G6wZIgNU8cidR0FOHpJToHhM6A+zGY5QnUJUwwROv8pZVgNjlh/fA1ai4b2upFxYQah7MjBk=
X-Received: by 2002:a4a:e795:: with SMTP id x21mr4129135oov.91.1590705074376;
 Thu, 28 May 2020 15:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200528172525.216354-1-luiz.dentz@gmail.com> <20200528172525.216354-2-luiz.dentz@gmail.com>
 <0eb5cec7-a79a-a513-8303-a23b1bd7a0ce@gmail.com>
In-Reply-To: <0eb5cec7-a79a-a513-8303-a23b1bd7a0ce@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 28 May 2020 15:31:02 -0700
Message-ID: <CABBYNZLieGyLBWREu1E5D3W+bh-S48S0S5OY2KfQfs270+oniA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] avrcp: Don't attempt to load settings if on volume
 changed is supported
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Thu, May 28, 2020 at 11:56 AM Andrey Semashev
<andrey.semashev@gmail.com> wrote:
>
> On 2020-05-28 20:25, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > If only volume changed is supported that means the player cannot really
> > indicate track/metadata changes so don't attempt to read them.
> > ---
> >   profiles/audio/avrcp.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 75811bf98..d46ac0ab7 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -3814,6 +3814,10 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
> >       if (!session->controller || !session->controller->player)
> >               return FALSE;
> >
> > +     /* Skip if player status/metadata if only volume changes is supported */
> > +     if (events == AVRCP_EVENT_VOLUME_CHANGED)
> > +             return FALSE;
> > +
> >       if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
> >                       !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
> >               avrcp_list_player_attributes(session);
> >
>
> The result is still the same with this patch - MTW2 reboots after
> GetPlayStatus.

Looks like the test was wrong, Ive send a v3 fixing that.

-- 
Luiz Augusto von Dentz
