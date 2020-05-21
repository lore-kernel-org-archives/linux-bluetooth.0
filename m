Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C80C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FFE20759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 16:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeo+ll3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEUQWi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgEUQWi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 12:22:38 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012AEC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 09:22:38 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x23so6703503oic.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5pnOfy9l28HKaYyqe7DEu48PKag2pJnfvdBT2LWvfU4=;
        b=oeo+ll3JRss8B9Z3NVcScl7U4qpbV/ZZNEF2N0TkeLsnh6rBWxzSMwYXCBA2qjI76x
         UnuCUma4q8YVgXoVOAjBRfhN16AVUsWz/X8bDB6JfBt2lTA/eUoecJDLhRkBJ5XufoOG
         tmk7qqCVep42+FNiUxcYCFVS4iJQ55UfepCI3yifX2XAKqg0w84axP9S4nMlBV7Pj8dd
         FPXuAP+3hE2KxRL3gpZ7pppQREE6V2jdr7+tER+dGZv0K+O3Y/0/3Tu5IIZ/j4KvhrOp
         vqf+qnT07F9Zzt3082/uP89ZjdSnBL5eN9GjplvgVgW1TMPANaSLyFTt6BGcTdpnQFsd
         0xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5pnOfy9l28HKaYyqe7DEu48PKag2pJnfvdBT2LWvfU4=;
        b=Dzu14i/cq7bWy+CLiSfmf70Ao8w/NwrqzGp06NNY4sbGU+7Cyq2g/QnTygTb+CPLb2
         2Uc39KqgrULVaZPxhd9O5S57oO18rSYRLtbPnvpudzbK52OlXWok1URGWF5+DfZzIdsM
         CxUQNbeAgOIGYDAnPJKqtHsG/0uTn05mMD39w65w+a4qabDleYfJMr4t2T9YsgkZ053C
         G9QbhCCrjnAJPZWS2agGU9gPUu1B4HWZ2wSYuTgxmoksQrxAZ+D1XXzIioopgYlZtaC1
         ntJuwrwjkn1mTBBk80FyTbdnlYBQLIkJqdJrMHUFwv78Aut3pIqwepS7iIKqV5EI+6qr
         05bg==
X-Gm-Message-State: AOAM531VgqzhYJ+7OGRd1hLIazgXMNNJEpvG2tywz+E+z5qt3deNeKzT
        yttDCpdhSbHCEDupCovYmy+wfm+okfWX5xHLwpiB8A==
X-Google-Smtp-Source: ABdhPJyJ0OfD526ecKMqdAEe3YpmYDjyChGdTaE7L0Xo56ZqUJSZ9bx7MTPy7TOJ0dF2qYeM3N0B/NmsaCPsnkpPmd0=
X-Received: by 2002:aca:6747:: with SMTP id b7mr5259147oiy.110.1590078156862;
 Thu, 21 May 2020 09:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200519200345.217345-1-luiz.dentz@gmail.com>
In-Reply-To: <20200519200345.217345-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 May 2020 09:22:22 -0700
Message-ID: <CABBYNZ+MwrFW8jkwP09YAdc_iph9B0+MMgm_GD-JCS7DjrCYPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] a2dp: Fix caching endpoints for unknown version
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, May 19, 2020 at 1:03 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Don't cache the capabilities of endpoints which the version is unknown
> since so capabilities may not be available in such case.
> ---
>  profiles/audio/a2dp.c  | 11 +++++++++--
>  profiles/audio/avdtp.c |  7 ++++++-
>  profiles/audio/avdtp.h |  1 +
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index a2ce3204d..15e211b95 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2667,15 +2667,22 @@ static void discover_cb(struct avdtp *session, GSList *seps,
>                                 struct avdtp_error *err, void *user_data)
>  {
>         struct a2dp_setup *setup = user_data;
> +       uint16_t version = avdtp_get_version(session);
>
> -       DBG("err %p", err);
> +       DBG("version 0x%04x err %p", version, err);
>
>         setup->seps = seps;
>         setup->err = err;
>
>         if (!err) {
>                 g_slist_foreach(seps, register_remote_sep, setup->chan);
> -               store_remote_seps(setup->chan);
> +
> +               /* Only store version has been initialized as features like
> +                * Delay Reporting may not be queried if the version in
> +                * unknown.
> +                */
> +               if (version)
> +                       store_remote_seps(setup->chan);
>         }
>
>         finalize_discover(setup);
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index b632e41c5..1fd2be051 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -2256,7 +2256,7 @@ static uint16_t get_version(struct avdtp *session)
>         const sdp_record_t *rec;
>         sdp_list_t *protos;
>         sdp_data_t *proto_desc;
> -       uint16_t ver = 0x0100;
> +       uint16_t ver = 0x0000;
>
>         rec = btd_device_get_record(session->device, A2DP_SINK_UUID);
>         if (!rec)
> @@ -2396,6 +2396,11 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
>         return session;
>  }
>
> +uint16_t avdtp_get_version(struct avdtp *session)
> +{
> +       return session->version;
> +}
> +
>  static GIOChannel *l2cap_connect(struct avdtp *session)
>  {
>         GError *err = NULL;
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index ad2cb9bcb..f1e51d4e3 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -310,3 +310,4 @@ struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
>
>  struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
>                                                         struct queue *lseps);
> +uint16_t avdtp_get_version(struct avdtp *session);
> --
> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz
