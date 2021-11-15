Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7D461AAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbhKOVBj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349280AbhKOUGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 15:06:17 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A853C061714
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 11:42:35 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id v3so37166518uam.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+0tsttkGV0uilUD6xDbAQbeYtk9R3rM/lkrC8t8420=;
        b=UmDB1vTn+pgbfjxEkMG3Ygy6Lz2CUBTUHcPHfSlusPq3ejSfBaAmjON8uZOf8ZKUym
         2DwHDw+h3t29/Imjm5HAaAbMWfjcvrSpsJzEiXl626VzrWwVzAakHQGMqbfGkjrshXxB
         ofR0l1gsUuhvy0SponBHYaMjr/LJ7JI3QedtNQe1ten9Wu+4opKX4prfRNTf51qIQSRK
         SstYfJ8K9JzeEGkLcqYPhFsSBP5rkyEUi9qcKUGDNdTuumR5jOHgpOHiK8xaJYQdwE12
         mzH0CUi+eJC+kYeGoRDakxHY5+QQ860609TqRfSrRsLsJck2+ht6j19ywtYnbnpg7/As
         9xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+0tsttkGV0uilUD6xDbAQbeYtk9R3rM/lkrC8t8420=;
        b=DfltJrh5wKIddNkc1Pr2VytHTHnnbRIOggCSXFjk6hiX6cu6S6FpBRK7YwPqhDCX+F
         mc3MrHhdQdj4K4YHdlWbZByA3qh+LAqyBqcgrlSq1+vjyTTQIwb6miroqfJJO2cVGng9
         fwrQNBaF6bwd6vFZ6zF433ZLPSIRP2FVXVDuDUhD6K8wtINNcelRzGp2bzwRGuzeLjDH
         F3Uvmsq8ZhZ5RoZsMqmDnS5z8myJcKHgWa4eG2cvxZRXc98c35Wt+ma/f7sZRoSSkdmL
         yduoc6WM8notGIxO/ZO4ZLQueoMX6TgkNB6EIgqfBe+HnhdzC/VNt0pY22cNmdI388Ss
         wB7g==
X-Gm-Message-State: AOAM533FWws4t2d+sKmVh3FDbpJS6Mlr1WbbVrjNe14opZLgfmK5ghnz
        0qhaoMCq7zd/YV1Hyc13xycR/jUMM6DbGmbpD+4opUAl/Qc=
X-Google-Smtp-Source: ABdhPJxVYuuor5XbgHOCgec8M1WWGz/zO7mr/hBxM5gpoZxeXsPTy7iYHwBHCj0fKTiQLpxNUXDitgIjinnervcytwg=
X-Received: by 2002:ab0:67d7:: with SMTP id w23mr1999675uar.3.1637005354147;
 Mon, 15 Nov 2021 11:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20211115094108.24331-1-kiran.k@intel.com>
In-Reply-To: <20211115094108.24331-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Nov 2021 11:42:23 -0800
Message-ID: <CABBYNZ+rFbfe1joiLmJBGB_twX4_kNu3Nsr=TSs1SyfMvAes8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] avdtp: Add a flag in struct avdtp to control a2dp offload
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Mon, Nov 15, 2021 at 1:36 AM Kiran K <kiran.k@intel.com> wrote:
>
> Define a flag in struct avdtp and set it based on
> the definition of env variable USE_OFFLOAD
> ---
>  profiles/audio/avdtp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index d3dfbf96dda3..b6feac0ba4d5 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -409,6 +409,9 @@ struct avdtp {
>
>         /* Attempt stream setup instead of disconnecting */
>         gboolean stream_setup;
> +
> +       /* use offload for transport */
> +       gboolean use_offload;
>  };
>
>  static GSList *state_callbacks = NULL;
> @@ -2425,6 +2428,7 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
>                                                         struct queue *lseps)
>  {
>         struct avdtp *session;
> +       char *use_offload;
>
>         session = g_new0(struct avdtp, 1);
>
> @@ -2436,6 +2440,10 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
>
>         session->version = get_version(session);
>
> +       use_offload = getenv("USE_OFFLOAD");
> +       if (use_offload && !strncmp(use_offload, "1", 1))
> +               session->use_offload = TRUE;
> +

We already have a configuration for experimental flags:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n118

So you just have to check if experimental is enabled, or the offload
UUID, in adapter.c, also perhaps we should have something like
btd_adapter_experimental_is_enabled(adapter, uuid) so it would take
care of doing all the checking if that had been enabled in the kernel
or not.

>         if (!chan)
>                 return session;
>
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
