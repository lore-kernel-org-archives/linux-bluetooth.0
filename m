Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CBC11F90
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27BC60FE7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 08:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353812AbhGLIcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358378AbhGLIZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 04:25:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8FC09CE7A
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 01:17:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so13437342eds.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxHpiYfDuncik6i5FwRpbNUnKMGIA/9+EY+s+sQQfMA=;
        b=CGypMf/PuT/GG5nredzePwHjCCdYQd2+769x+EJWPBa+/JiSMa++TYKlpZdoyyUENA
         ZdAUeg8+rzYQZHSUkJM17exv38C/ToG2CU9mTk+cBatA8U+h/Wn79tFyqc7SY5w7aJnA
         kwP9j4YgCmZSbNeRmg1NMol0xrKJuwnBHU34uSsOU6rQrmrnkOuLp3KpNRSQf6+5D3lW
         v8Mufq/KV49cf9Iy9lUGJmeqzBYDv9x0AjeO2IMaW/djCEMm39BA4B8PXUnpa+aD3Qyj
         F1DEfDSpF/9X53L65Od4InQ5lByJdPHkuv80Kq28vI6i9ZN+YklvnDZJgxgCjcvkBiMk
         Igtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxHpiYfDuncik6i5FwRpbNUnKMGIA/9+EY+s+sQQfMA=;
        b=iYpEWL5vWMSWsx5/dDkVRsKTuJJy4/sqhJ1gJcWkLSJGe037oiO4R27GXKzIROXSKW
         dZl9gGqXtrilMmq6Tm6wbQ/M/ZgQN/E7cArkUgMISQr+0NKXfSgyKXH9bXlwoNQ7lZ1B
         p8CJ8RERwi8GDsRpLYFRCrQ/FWOj/JJy9ozBoZeWbnBRcbr/Kma5MFwziuG4igJh8u8H
         TgYzKnge/4Zj4+7+em7BZ5bCtC0CVXM9B2Rn5FeHfjbSzUFvNH5s1fvF/X2s3MoaeQjs
         MeCqlYuzdgjkXrKSCwERtSGLkZbgFiLUQ4RCypo5/NawvSzOnUFsjAVVTCCilMQZ41FW
         L6mA==
X-Gm-Message-State: AOAM530ESdtAvaAoXS7NaP4aVf6BdVZWNyqOzAU9Ce2wKEKcg21yUuvH
        oaXbpwyP0rBOEcossP09yDqSdhsO3TVRLeuv5ajfvg==
X-Google-Smtp-Source: ABdhPJyRoWzqPHKS7BjtIKnElyqlBBkIXBFVCGub63ybxrL2pVVsCG9hHvjuRToxcmMSSQdFsgQvIDKlxmBy/EGAdaU=
X-Received: by 2002:aa7:dd0d:: with SMTP id i13mr50853521edv.97.1626077826901;
 Mon, 12 Jul 2021 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
 <20210708142059.Bluez.v1.6.I123189fa93aad2c2d1be645d38dbc494aa15563c@changeid>
 <CABBYNZ+_hYCZX=QMbrYALK6QwVnxcT4-XM-aaFvNHxC06fR2vQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+_hYCZX=QMbrYALK6QwVnxcT4-XM-aaFvNHxC06fR2vQ@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Mon, 12 Jul 2021 16:16:55 +0800
Message-ID: <CAPHZWUfQSECsHDB4AB2OfhTeRra9JoiwK_gqxysD1nrqtknyyw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 06/14] audio: Remove Media1 interface when a2dp
 source disallowed
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I agree this is a trick for CrOS and probably not suitable for
upstreaming. If we want to allow/disallow profiles without
reprobing/removing them, here is what we need to do:
For each profile in profiles/, reject the connection if its UUID is
not allowed. Note that checking the UUID in btd_request_authorization
is not enough since some profiles like profiles/health/mcap.c don't
call btd_request_authorization.
The same check will need to be added in src/profiles.c as well so that
we can also manage external profiles.
Does that make sense?

On Fri, Jul 9, 2021 at 1:49 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
> >
> > When A2DP source profile is removed from adapter, a2dp_server and
> > everything inside the object will be removed, which also releases all
> > MediaEndpoints and MediaPlayer. When A2DP source profile is re-added,
> > although a2dp_server will be created, clients are not able to know they
> > can register their endpoints and player by then.
> >
> > This patch handles this case by unregistering Media1 interface
> > when we remove a2dp_server, and register it back when a2dp_source is
> > allowed.
>
> This sounds more like a bug fix for a regression introduced by the
> very set, so Id recommend fixup the original patch that introduced the
> problem, also Im afraid there could other instances like this perhaps
> it would have been better to propagate the allow/block to the profiles
> that way they don't have to be reprobed, I also have my doubts clients
> would react properly to Media1 disappearing and appearing again so Id
> leave it up if there is any endpoint/player registered to avoid having
> them to re-register.
>
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> > perform following steps
> > 1. SetServiceAllowList to empty list
> > 2. pair with an LE headset, then turn off the headset
> > 3. SetServiceAllowList to "0x1234"
> > 4. SetServiceAllowList to empty list
> > 5. turn on the headset and check if it is reconnected.
> >
> >  profiles/audio/a2dp.c  | 2 ++
> >  profiles/audio/avrcp.c | 3 +++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index d31ed845cbe7..26d4f365207e 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -3275,6 +3275,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
> >  {
> >         struct a2dp_server *server;
> >
> > +       media_register(adapter);
> >         DBG("path %s", adapter_get_path(adapter));
> >
> >         server = find_server(servers, adapter);
> > @@ -3315,6 +3316,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
> >                 return;
> >
> >         a2dp_server_unregister(server);
> > +       media_unregister(adapter);
> >  }
> >
> >  static int a2dp_sink_server_probe(struct btd_profile *p,
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index ccf34b2207a9..997a5be9a0f4 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -4751,6 +4751,8 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
> >
> >         if (server->tg_record_id == 0)
> >                 avrcp_server_unregister(server);
> > +
> > +       media_unregister(adapter);
> >  }
> >
> >  static int avrcp_controller_server_probe(struct btd_profile *p,
> > @@ -4761,6 +4763,7 @@ static int avrcp_controller_server_probe(struct btd_profile *p,
> >
> >         DBG("path %s", adapter_get_path(adapter));
> >
> > +       media_register(adapter);
> >         server = find_server(servers, adapter);
> >         if (server != NULL)
> >                 goto done;
> > --
> > 2.32.0.93.g670b81a890-goog
> >
>
>
> --
> Luiz Augusto von Dentz
