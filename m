Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56226C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 20:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E82206F6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 20:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRYhFNeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGUCf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgGGUCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 16:02:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41653C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 13:02:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so25491916lfc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uTyg3tJMPD5Lk1s77wrHuXbd7OOCmjF9sWfiuTAkIkU=;
        b=tRYhFNeFy/wfHMfDpxn2Xmbs2ez/U4weX/XmaGyjAIGg1gaMoXjOhC3F92+Jt17aP8
         jXnI9r7YCy3A0mAvlRX7FuAZs1WBPbYy4pxlh8PxUG8Kf1nJ6oNcVsSVELTmbQYgJjeg
         yZguJ13CW5zlBjMSmIo6ii/mjEv5EuBtJKVfRUHDOQyISopHsruEEkCAhMioAaiCyQvw
         lQlN7GZOtQCdDtjwP6wjNnwMJoQOlGd4GdhPT0yJb0OJdP5+4tfR5kke5nvYppwRIcc3
         gNP1P+OeDwmnnw8MFU0hHcJmsefSg3UqTgPfGLYeIT8U6ZWUEZaxVPLgmoh0nFxiU0PW
         vwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uTyg3tJMPD5Lk1s77wrHuXbd7OOCmjF9sWfiuTAkIkU=;
        b=Ck99v3jhbmBkG0T4v/59MDnttTNQJwQyTtrOtcMlmVutBJ3MdeR8lT9UH3VQQEDt7w
         XkUGQR02bGArcNFzIY3Ur13k3BLrAnDUbnddAUpdsfPWllAPcJfP5JhMGCiwZhGoB8Va
         mSaUY74iCWEhvodOZHz9h0UFAAVsFljBD7KlDKjTN5x4vjfWp5Hf0IqF1K1vEUPRui1b
         BDzlefJRToGihjI7gHJDi62GQ0F6Laq0DqtrKd6fGk/Z4fOODqiNedLEBFqBp3eUuhHl
         p4RwTdMIyoogE6yPk6dDP3jXrcArQjvDgeD655K+uXgp+zybMYZdd05R10hffLSYxMg8
         TKdg==
X-Gm-Message-State: AOAM530sr0i7FaQW3fCrZPZZvwUpa5WT4smf0dbabjqtwMUoo6nqOxN9
        l9H2fq55vHMwcs1FVSCCmsF8Noh+UN/jiKucYdn6y2f58T4=
X-Google-Smtp-Source: ABdhPJzK7vsWEHYiR8RgkdL0394c6XtLgvT8MN8DPZ6U8DRjwZUEWVc+wcfJ8yme/RQJ7OU6La4gGeP3bHidQDqppcM=
X-Received: by 2002:a19:c78d:: with SMTP id x135mr33854676lff.82.1594152153448;
 Tue, 07 Jul 2020 13:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200707141628.368748-1-alainm@chromium.org> <67268C4E-674E-4DE9-B642-E1CAE8748E28@holtmann.org>
 <CALWDO_UDxA3maSxKr_wc_VKo3bXuT+GtSmSrMAJ5u4640cyKxw@mail.gmail.com>
In-Reply-To: <CALWDO_UDxA3maSxKr_wc_VKo3bXuT+GtSmSrMAJ5u4640cyKxw@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 7 Jul 2020 16:02:21 -0400
Message-ID: <CALWDO_VMohmimfoZdPR4w5heFJLERa7tNHTQD9qPMYpCkoemmg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: create CONFIG_BT_DEBUG_FEATURE_FUNC_NAME
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 7, 2020 at 1:15 PM Alain Michaud <alainmichaud@google.com> wrot=
e:
>
> On Tue, Jul 7, 2020 at 11:53 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Alain,
> >
> > > Creates a CONFIG_BT_DEBUG_FEATURE_FUNC_NAME option to include functio=
n names in
> > > debug statements.
> > >
> > > Unlike other platforms __func__ isn't a string literal so it cannot b=
e
> > > automatically concatenated by the pre-processor.  As a result, the
> > > function name is passed as a parameter to the tracing function.  Sinc=
e
> > > pr_debug is a function like macro, the normal expansion of BT_PREFIX_=
PARAM
> > > does not work as it gets processed within the first parameter as well=
,
> > > for this reason, BT_DBG is split into two versions.
> > >
> > > This patch was built tested with all 4 possible combinations of
> > > CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.
> > >
> > > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Making CONFIG_BT_DEBUG_FEATURE_FUNC_NAME dependent on
> > > CONFIG_BT_DEBUG_FEATURE
> > >
> > > include/net/bluetooth/bluetooth.h | 32 +++++++++++++++++++++++-------=
-
> > > net/bluetooth/Kconfig             | 11 +++++++++++
> > > 2 files changed, 35 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> > > index 7ee8041af803..8506dd268d4b 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -162,22 +162,37 @@ void bt_dbg_set(bool enable);
> > > bool bt_dbg_get(void);
> > > __printf(1, 2)
> > > void bt_dbg(const char *fmt, ...);
> > > +#define BT_DBG_INT   bt_dbg
> > > +#else
> > > +#define BT_DBG_INT   pr_debug
> > > #endif
> > > __printf(1, 2)
> > > void bt_warn_ratelimited(const char *fmt, ...);
> > > __printf(1, 2)
> > > void bt_err_ratelimited(const char *fmt, ...);
> > >
> > > -#define BT_INFO(fmt, ...)    bt_info(fmt "\n", ##__VA_ARGS__)
> > > -#define BT_WARN(fmt, ...)    bt_warn(fmt "\n", ##__VA_ARGS__)
> > > -#define BT_ERR(fmt, ...)     bt_err(fmt "\n", ##__VA_ARGS__)
> > > -
> > > -#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
> > > -#define BT_DBG(fmt, ...)     bt_dbg(fmt "\n", ##__VA_ARGS__)
> > > +#if IS_ENABLED(BT_FEATURE_DEBUG_FUNC_NAMES)
> >
> > are you sure you tested this?
>
> This was tested on chromeos using this patch chain which also sets the
> configuration and revert our original patch:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/2279613
(facepalm) You were right, I introduced this bug in v2's rename.  This
is now fixed in V3.
>
> >
> >
> > And frankly I don=E2=80=99t get the point for the new Kconfig option. I=
t is rather useless in this patch. Tell me one thing, do you prefer that FE=
ATURE_DEBUG prints the function names or not. Because if dynamic debug is u=
sed, we don=E2=80=99t need it since that is all configurable via dynamic de=
bug itself and we don=E2=80=99t need it there (and I also don=E2=80=99t wan=
t it in the dynamic debug case).
> I'd be ok if we unconditionally print function names if
> CONFIG_BT_FEATURE_DEBUG is set.  what I want to avoid is to overly
> complicate the debug macros to have the function names configurable at
> runtime.
>
> >
> > Regards
> >
> > Marcel
> >
