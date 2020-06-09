Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6172078C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 15:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBdkFn7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgFIPDf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIPDf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 11:03:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE08C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 08:03:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id e125so12697505lfd.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9HsWt9S/rusQElrF+5Y2uerysSUnKrvasCTBcPfQY0A=;
        b=qBdkFn7vuK7jX3I/as4LBdu6IW/Rp80yNtpLrgaskyDbzP6JDgOnK0Oz/PjtReOI3Q
         X73vadBSyKgNq5EKORUd+bE5ER0c7XEVSh1ziWGbMLUu6OJisTCcBN6G0Oz6GACAGuuh
         Y6eyMawTR3AyZgWW2i+9K/nJ4KselOrh59o8hxpbNBdsShLperSoEmM5VUitaR2la1ww
         E9AfAhRdKkoJBhq9O6L28UlIz+3l64iQcf9hAhknVSyitEi3YS1hXWXj7RZmG2jx3Uul
         /Fdhqamh7/8A3As83sEyKYBevhVKpNsoPjgJ+s9eBXBsqy3bzXCcFpzCI5nFUMRVffCM
         UZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9HsWt9S/rusQElrF+5Y2uerysSUnKrvasCTBcPfQY0A=;
        b=svP6WSHyie9ru7Dx1RBDSLz7mQHfz3qLoE45bE9KOeqlOVFJE44x+1Q75fxeQ6eOJU
         H8hDJ5lSWXByg94gSV2gCTpLLEBZdF7Ib8/Dxr9jxmSzWYfyWhsYs4CkMzzBNAqSrA+R
         ecgnCrY+lTX3nAvuI2vzfCDsSMgaHUKxWlcgt3aod2eqgDFBj4t8zpUY8DeOGwXEDv5c
         JIyr8TXkDWGI3chu/f/G3GdyecHzpcVMqZHiwAkf9NAEvwp+RdiF7ZclZ17IigneB1aE
         QAFQjby17BIolmVr6uSc2rhynEYtXgwF+BLMAEDMESHSgcXbkPocCWLnwSvKAEX3M01a
         8PxA==
X-Gm-Message-State: AOAM533DXVjmItdlScjy3/wrjtoklkcMpZLvnNfiOzr6fDPm61rW3C3L
        Tyhtp84K6bYgstaYo6wV/pCJ7eSg1Vsfs4O7HBP1SOU7
X-Google-Smtp-Source: ABdhPJzcRavb8IAGr8H0HEW3/YbERciYWzyZgOnSASknuf5ZnP7ZPWWpXJuZ1AbVTwgbeZ8jEl9bGaJE/ktmzh8O+sE=
X-Received: by 2002:ac2:54a8:: with SMTP id w8mr15529498lfk.53.1591715010919;
 Tue, 09 Jun 2020 08:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200609225813.Bluez.v2.1.I1952bb847ed07631095daf37fe281a49ccf864d0@changeid>
In-Reply-To: <20200609225813.Bluez.v2.1.I1952bb847ed07631095daf37fe281a49ccf864d0@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 9 Jun 2020 23:03:19 +0800
Message-ID: <CAJQfnxGAAFY0j1GQcOLvWuoYmLmmBSyimMz-hn7-Lh25A6fOtg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] input: disconnect intr channel before ctrl channel
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Sorry, I didn't realize sooner that the version which I sent earlier
as v1 is different than the one in my local repo. This is the correct
version.

Thanks,
Archie


On Tue, 9 Jun 2020 at 22:58, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth HID Profile spec Ver 1.0, section 7.2.2, A
> host or device shall always complete the disconnection of the
> interrupt channel before disconnecting the control channel.
> However, the current implementation disconnects them both
> simultaneously.
>
> This patch postpone the disconnection of control channel to the
> callback of interrupt watch, which shall be called upon receiving
> interrupt channel disconnection response.
> ---
>
> Changes in v2:
> -change socket shut mode to SHUT_WR
>
>  profiles/input/device.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index d89da2d7c..e2ea459fe 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1026,14 +1026,19 @@ static bool is_connected(struct input_device *idev)
>
>  static int connection_disconnect(struct input_device *idev, uint32_t flags)
>  {
> +       int sock;
> +
>         if (!is_connected(idev))
>                 return -ENOTCONN;
>
> -       /* Standard HID disconnect */
> -       if (idev->intr_io)
> -               g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
> -       if (idev->ctrl_io)
> -               g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
> +       /* Standard HID disconnect
> +        * Intr channel must be disconnected before ctrl channel, so only
> +        * disconnect intr here, ctrl is disconnected in intr_watch_cb.
> +        */
> +       if (idev->intr_io) {
> +               sock = g_io_channel_unix_get_fd(idev->intr_io);
> +               shutdown(sock, SHUT_WR);
> +       }
>
>         if (idev->uhid)
>                 return 0;
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
