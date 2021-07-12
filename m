Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E7C07E99
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A46561245
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGLUnx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhGLUnw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 16:43:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25970C0613DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 13:41:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r135so31231031ybc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6mcThMdQ+3MofnxAx6uoNfHyPruYidEtPFBcQDzWEA=;
        b=Eler6PR6EIL+Um8kuizSr6zz7YXDDTcoc53M4yG4h29+CLz6qq7vvV0+wcAIYs+RNr
         9PC7uDX2GZ76wYiMkOpzCCVsP/100jrHBsyI+0l7PJYvCWjH8+vm5YwslxkqSVPYjI/o
         fRN/PjxsDVm85yyTCgKx8LsANLen0GHa+nJxnJXQxSGn376ZZ9rr8ntimCZCKV6SRpnO
         GsUBMYry3jxfm49szO0J2z2UEgr45c0pCqC2yXAwJFK/BOPS/QSIXoT0OUA3l/QbYNSe
         2JDnCxoEwCF4npnCejNb9MhKe33aWubtYRZHvWwA0f62AfAN/tlso8Vc3Wpd3EVLYDaD
         0tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6mcThMdQ+3MofnxAx6uoNfHyPruYidEtPFBcQDzWEA=;
        b=Y0nckkQqAWeOWaS0GycPIJlPF17aREq2ScZmoh4bjVCXuKlcNzLa3nRp+xHVFG1wQy
         FFVPHbjxrx/Kt4dzqU8gsrjxpgTiWlpJyA4h/Pl7JNVw4TjicvIdXebKQjgnoCb53xdF
         N6x0xNg5/1mUcfY1WRGAyL/nGu1QknBwkO/CeXM3t2Z4luLEWdlv5bIh+NzyyOgMRjlz
         ZxpG5nh+htTBBcXBd4t50cXHpsNSXUM2ies9t6Z2Tnk6PJvSZU6Ob3QYaMNhzVgBHvCy
         iWPLeddvq0xCpkn7xM0tyqaQ1vDFFj0m7uIYYiEsRx4TVamTjf7RNdTQjGuqhIoa6Tm8
         v7bw==
X-Gm-Message-State: AOAM531UbOkwmSEUHmycp85zSLWeC9mvr3cAcIyfTd0Q5e1JHJLEstHm
        4maGow9hJ/3z/pnSI6gVBwtfgqUF2hTYVy/4G1s=
X-Google-Smtp-Source: ABdhPJxDUT66VUlJOcfhxY7I3yreE+EtGdzpe3NfY53GAb39FZC9piqykiQN82BqnEtvPmTYP1VltgxJVguhB50hxxE=
X-Received: by 2002:a25:b741:: with SMTP id e1mr1091716ybm.347.1626122463178;
 Mon, 12 Jul 2021 13:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210712203813.Bluez.v1.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
In-Reply-To: <20210712203813.Bluez.v1.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Jul 2021 13:40:52 -0700
Message-ID: <CABBYNZJ-Oc=H7icDxBVk8iNAfcBjZDL_CgKq7r8k82iwT66pVQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] a2dp: Fix crash in channel_free while waiting
 cmd resp
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Jul 12, 2021 at 5:39 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> When channel_free is called and we are waiting for a command response
> from the peer, bluez NULL the setup->session but would not free its
> setup_cb. Since setup_cb holds a ref of setup, the setup wouldn't be
> freed and if service_removed is called after channel_free, a2dp_cancel
> tries to abort the ongoing avdtp commands, which accesses the
> setup->session and triggers a crash.
>
> This change finalizes all avdtp commands before assigning setup->session
> to NULL in channel_free.
>
> Crash stack trace:
> 0x000059f01943e688      (bluetoothd -avdtp.c:3690)
> avdtp_abort
> 0x000059f01943928a      (bluetoothd -a2dp.c:3069)
> a2dp_cancel
> 0x000059f0194377fa      (bluetoothd -sink.c:324)
> sink_unregister
> 0x000059f01948715a      (bluetoothd -service.c:177)
> service_remove
> 0x000059f01948d77c      (bluetoothd -device.c:5346)
> device_remove
> 0x000059f019476d14      (bluetoothd -adapter.c:7202)
> adapter_remove
> 0x000059f019476c3e      (bluetoothd -adapter.c:10827)
> adapter_cleanup
> 0x000059f01949d8d7      (bluetoothd -main.c:1114)               main
> 0x0000787b36185d74      (libc.so.6 -libc-start.c:308)
> __libc_start_main
> 0x000059f019433e39      (bluetoothd + 0x00026e39)               _start
> 0x00007fff2d2c0127
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> There are two other options to fix this crash.
> 1. add a NULL check in a2dp_cancel before calling avdtp_abort.
> 2. call setup_cb_free to every setup_cb in setup->cb in channel_free.
>
> Since each setup_cb needs setup->session, I think there is no need to
> keep the setup_cb after assigning setup->session to NULL. So the first
> option is not ideal. If the second option is adopted, there would be
> some time that sink/source->connect_id/disconnect_id is not zero, but
> there is no corresponding setup_cb.
>
> Test steps:
> Reproduce the crash with the following steps. Verify the crash is
> no longer observed after this change.
> 1. ignore AVDTP_SET_CONFIGURATION resp by modifying avdtp.c
> 2. turn on a paired headset
> 3. check the bluetooth.log, while bluez is waiting for
>    AVDTP_SET_CONFIGURATION resp, stop bluetoothd immediately.
>    This will trigger:
>    session_cb (I/O error) -> connection_lost
>    -> avdtp_set_state (AVDTP_SESSION_STATE_DISCONNECTED)
>    -> avdtp_state_cb -> channel_remove -> channel_free
>    then:
>    adapter_cleanup -> adapter_remove -> device_remove -> service_remove
>    -> a2dp_sink_remove -> sink_unregister -> sink_free -> a2dp_cancel
> 4. check if bluetoothd crash
> The above steps can trigger the crash 100%.
>
>  profiles/audio/a2dp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index d31ed845cbe7..f201b98c79d0 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1540,9 +1540,14 @@ static void channel_free(void *data)
>         setup = find_setup_by_session(chan->session);
>         if (setup) {
>                 setup->chan = NULL;
> +               /* Finalize pending commands before we NULL setup->session */
> +               finalize_setup_errno(setup, -ENOTCONN, finalize_discover,
> +                                                       finalize_select,
> +                                                       finalize_config,
> +                                                       finalize_resume,
> +                                                       finalize_suspend, NULL);

While the analysis seems correct I wonder if wouldn't be a better idea
to have a finalize_all so we don't have to iterate the callback list
multiple times, other than that the patch looks good and I would
prioritize it to have it included asap.

>                 avdtp_unref(setup->session);
>                 setup->session = NULL;
> -               finalize_setup_errno(setup, -ENOTCONN, NULL);
>         }
>
>         g_free(chan);
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz
