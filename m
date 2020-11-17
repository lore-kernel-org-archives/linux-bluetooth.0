Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604CC56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5232222E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dt9EhiVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgKQOol (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgKQOok (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 09:44:40 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E80C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 06:44:38 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so30395944lfd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnfKtOiK+KgpTfLdPKDWsiCOL6CsXplNGQmgn9n13po=;
        b=dt9EhiVSHodNpUk+TnsNJciE1ph6q2TIfIm2tniyv9QidFZvp2Zz893EjPlEg+Dfgt
         7y/P27TaWUMZsq/HiWF3X5qm4ON0TTGhMcIaXdsVzklHRRY3s5hbJlRlSo0P852X6HEt
         RkF7Qljz6u2vvVsh5kslJ3VOUKqd/ASnN3YeakczRopYgxhs/oHSBfp8V7xiLtzZn3yg
         /ptswecIJXSAnasyLnt2KdMTwb//nR/YVhAAnqfm2Zy0ZxAi5xtQGwaW10OuC3HhiibO
         bOafHRSQ0vmGes1wyCNZysfGhHylAS8ytqz+QEvkywyhI4yosEfY+mIP6pTFmTxUE9KZ
         ZJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnfKtOiK+KgpTfLdPKDWsiCOL6CsXplNGQmgn9n13po=;
        b=ndoMEaFEhtaSTxspycITUbvoA3b1r6a6voI9lwVGwmu4DcFK8X+z9Qabluyp4ge+bL
         vgdYtzdY71CF49f8QqrjS/TmvFyYCfh1BvZ/egkd5/O3gTDirrBxWFK93V6yFeOg4Ed1
         3hDGQxfvM9vNE1/taipERaIBoSyfMnRedrThhBssA5NM3XlpAR9bgYdpcpyXQKPZSdTB
         sjdyDE/+f3gdNGyAf7IEYsv0xkHAbrmrwFHgMLb2QH818TS/BFoxJHjPTqrEKXUayyuz
         SAA5vRif0k4xQ1+iUJNSIovx4kc44m5IXAFm1MNnJMa5z3gQIwVgrDibmm3l+VSoHcwS
         OVkg==
X-Gm-Message-State: AOAM5329onPALfLHFoHs4UFK9CNTj6LmttdTCAtoYEhYsICjeraOiWrd
        ggZMYer6qEJqCp9d2eKAo/BZZujEL3O6U9jnYVNZnQ==
X-Google-Smtp-Source: ABdhPJxucbMHBar6HKG1mEYtoGv11VKzcKU2oGK5uH009Q7eY5wyLhhBu/VMP4lqM1ddKx/qbbFJCuk676WAoRsm8TE=
X-Received: by 2002:ac2:5083:: with SMTP id f3mr1876412lfm.45.1605624276780;
 Tue, 17 Nov 2020 06:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20201116233910.4128702-1-luiz.dentz@gmail.com>
In-Reply-To: <20201116233910.4128702-1-luiz.dentz@gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 17 Nov 2020 09:44:24 -0500
Message-ID: <CALWDO_Ut1QSJmbVUinekRN5yNvttXcdr87J5O7dEj=PaAfLiLg@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/2] avdtp: Fix connecting using streaming mode with
 signalling channel
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 16, 2020 at 7:22 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Signalling channel shall only use Basic or ERTM modes.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Tested-by: Alain Michaud <alainm@chromium.org>

> ---
>  profiles/audio/avdtp.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 16fa20bba..619b94e29 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -2429,20 +2429,13 @@ uint16_t avdtp_get_version(struct avdtp *session)
>         return session->version;
>  }
>
> -static GIOChannel *l2cap_connect(struct avdtp *session)
> +static GIOChannel *l2cap_connect(struct avdtp *session, BtIOMode mode)
>  {
>         GError *err = NULL;
>         GIOChannel *io;
>         const bdaddr_t *src;
> -       BtIOMode mode;
> -
>         src = btd_adapter_get_address(device_get_adapter(session->device));
>
> -       if (btd_opts.mps == MPS_OFF)
> -               mode = BT_IO_MODE_BASIC;
> -       else
> -               mode = BT_IO_MODE_STREAMING;
> -
>         if (session->phy)
>                 io = bt_io_connect(avdtp_connect_cb, session,
>                                         NULL, &err,
> @@ -2610,7 +2603,14 @@ static int send_req(struct avdtp *session, gboolean priority,
>         int err, timeout;
>
>         if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
> -               session->io = l2cap_connect(session);
> +               BtIOMode mode;
> +
> +               if (btd_opts.mps == MPS_OFF)
> +                       mode = BT_IO_MODE_BASIC;
> +               else
> +                       mode = BT_IO_MODE_ERTM;
> +
> +               session->io = l2cap_connect(session, mode);
>                 if (!session->io) {
>                         /* Report disconnection anyways, as the other layers
>                          * are using this state for cleanup.
> @@ -2807,8 +2807,14 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
>                                 struct seid_rej *resp, int size)
>  {
>         struct avdtp_local_sep *sep = stream->lsep;
> +       BtIOMode mode;
> +
> +       if (btd_opts.mps == MPS_OFF)
> +               mode = BT_IO_MODE_BASIC;
> +       else
> +               mode = BT_IO_MODE_STREAMING;
>
> -       stream->io = l2cap_connect(session);
> +       stream->io = l2cap_connect(session, mode);
>         if (!stream->io) {
>                 avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
>                 return FALSE;
> --
> 2.26.2
>
