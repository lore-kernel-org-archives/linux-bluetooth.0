Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E7AC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C62619A9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhF1IKM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhF1IKL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 04:10:11 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE0C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:07:45 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c20so6628254uar.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vOEcp0yzFS62fPpzEQDP1h946F/gt+Z8CXA4RgKtoE=;
        b=k+SQdtULoHyIlpN1daemobUVKceuxep6kMwFD8gvR/dPYjx1xKN6/1Do8xbyofv4HG
         /ltCEPoebLv5WhI7EIkQjQo29Pe2GOsGq7RgKRkH7mGEtYRPn9C7SOeQrwUlFextBTdh
         VK5ME1jIyPZU34O847ObOb65HuEqsX35pu5vPPckQfl4ckjEWItqQJHwpVej6Pt+NAfC
         1upAkeg6FhS45YM1uPnmm7jV13/osDdYx1ta05b69uP+/k029ywr+MG1sFV9rAnshJX3
         H2uwqL6Mqw7rjabKrZBlpMbtrBPa0ouXt703Oc9U7MjAzcfhXOZjC4s3AqFkayQjrY19
         EViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vOEcp0yzFS62fPpzEQDP1h946F/gt+Z8CXA4RgKtoE=;
        b=bO6DTcWSFNyZUqMnQERpQCxr9hCLji4isysQTKfiTVvY1IHV6V1p5P7lryPJjTb5TT
         KqbkT5wkSolkKajHWjfZpXlrWhRQyoQQklu3scSkW1fhbiqG7rzvupZQxw6X8G2bxefN
         aVeFVQ0UsDKuHLeO9Hj99TJ23cGmDHe9mcBANbBwKz3wfXWueiEdWwRFWORI5HJ3/q+v
         1PzXG6hB4ogFYPyISSfNI9rNk3eVRjUmEGWxKBIjHho175K5fK4NW9obEjMuZc0ffhfo
         RXThpK+w2eLnRLyQVbJpFdvMYfpfKkfVUSEMq9deTTfHhqtrbE6A66sBbL+kdkQcbgb0
         Ga0A==
X-Gm-Message-State: AOAM53163m12WP07gwtNGv3fzxIActWotp07Ba5cvGYt8G1TCWFBW0LK
        CQev8+ac669t3AowSx6jCdCJfNe3wPIlsKdKSSGl5g==
X-Google-Smtp-Source: ABdhPJzLRMpQoOBj/sIjZ2pILL/50YA2opkidZfHEJD3h0R+YEI9quCmlFMfQ+JNJoYIFnLDSyj9KAAD6P3UOX5D9tc=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr19332675uao.9.1624867664519;
 Mon, 28 Jun 2021 01:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
 <20210621182149.BlueZ.v2.3.I5b72c623fb8b002a5e1f000149b362af3c01ab98@changeid>
 <CABBYNZL3sWvzC9je7_MnuxftJyo9iUOshsXHBtaNAKgAar7XHA@mail.gmail.com>
In-Reply-To: <CABBYNZL3sWvzC9je7_MnuxftJyo9iUOshsXHBtaNAKgAar7XHA@mail.gmail.com>
From:   Joseph Hwang <josephsih@google.com>
Date:   Mon, 28 Jun 2021 16:07:33 +0800
Message-ID: <CAHFy41_xStESoyY6-3+Tb64biBNuPhwPw5OyuJs1rKnouZ=dmg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 3/3] adapter: set quality report feature
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please read the replies in the lines below.

Thanks!

On Tue, Jun 22, 2021 at 2:25 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Joseph,
>
> On Mon, Jun 21, 2021 at 3:23 AM Joseph Hwang <josephsih@chromium.org> wrote:
> >
> > This patch adds the function to enable/disable the quality report
> > experimental feature in the controller through MGMT_OP_SET_EXP_FEATURE.
> >
> > A user space process can enable/disable the quality report feature
> > by sending a property changed signal to the bluetoothd. The bluetoothd
> > can set up the signal handlers to handle the signal in a file under
> > plugins/ to call this function.
> >
> > Note that the bluetoothd calls the experimental feature only when
> > the quality_report_supported flag is true.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  src/adapter.c | 36 ++++++++++++++++++++++++++++++++++++
> >  src/adapter.h |  2 ++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index e2873de46..829d9806b 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -9332,6 +9332,42 @@ static const struct exp_feat {
> >         EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
> >  };
> >
> > +/* A user space process can enable/disable the quality report feature
> > + * by sending a property changed signal to the bluetoothd. The bluetoothd
> > + * can set up the signal handlers in a file under plugins/ to call
> > + * this function.
> > + */
> > +void btd_adapter_update_kernel_quality_report(uint8_t action)
> > +{
> > +       struct mgmt_cp_set_exp_feature cp;
> > +       struct btd_adapter *adapter;
> > +
> > +       adapter = btd_adapter_get_default();
> > +       if (!adapter) {
> > +               info("No default adapter. Skip enabling quality report.");
> > +               return;
> > +       }
> > +
> > +       if (!adapter->quality_report_supported) {
> > +               info("quality report feature not supported.");
> > +               return;
> > +       }
> > +
> > +       memset(&cp, 0, sizeof(cp));
> > +       memcpy(cp.uuid, quality_report_uuid, 16);
> > +
> > +       cp.action = action;
> > +       if (cp.action > 1) {
> > +               error("Unexpected quality report action %u", cp.action);
> > +               return;
> > +       }
> > +
> > +       mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE, adapter->dev_id,
> > +                       sizeof(cp), &cp, NULL, NULL, NULL);
> > +       info("update kernel quality report default adapter %d enable %d",
> > +               adapter->dev_id, cp.action);
> > +}
> > +
> >  static void read_exp_features_complete(uint8_t status, uint16_t length,
> >                                         const void *param, void *user_data)
> >  {
> > diff --git a/src/adapter.h b/src/adapter.h
> > index 60b5e3bcc..001f784e4 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -240,3 +240,5 @@ enum kernel_features {
> >  };
> >
> >  bool btd_has_kernel_features(uint32_t feature);
> > +
> > +void btd_adapter_update_kernel_quality_report(uint8_t action);
>
> It doesn't seem this is being used anywhere, in the patch description

  It is not used elsewhere except in plugins/chromium.c. The function
is placed here so that
other user processes in the Linux community can use it very easily.
Please refer to how it is invoked
in chrome os

https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/bluez/current/plugins/chromium.c;l=748?q=btd_adapter_update_kernel_quality_report&ss=chromiumos

  This quality report experimental feature
(CONFIG_BT_FEATURE_QUALITY_REPORT) follows what was implemented for
the debug log experimental feature (CONFIG_BT_FEATURE_DEBUG).

> it mentions a plugin is handling this via a signal but we could
> actually make the core do that directly, in fact having a plugin
> handling posix signals might be a bad idea. If this is something we
> don't need to change at runtime I would expect it to be configurable

In chrome os, this quality report experimental feature, just like the
other debug log experimental feature, is required to change at run
time. Both experimental features are enabled/disabled at run time with
the same mechanism -- a user space process sends the dbus signals to
enable/disable the features.

> over main.conf, or are there legitimate reasons to not have the
> controller generating these events all the time?

Another reason not to generate the events all the time is to avoid the
overhead on the BT controller and the stack if the feature is not
required.

>
> > --
> > 2.32.0.288.g62a8d224e6-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
