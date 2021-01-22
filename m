Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5808FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27A022D50
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbhAVAwk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbhAVAwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 19:52:40 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666BC061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:51:59 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ox12so5323909ejb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCP0VJStTzPj9G2IsY14W0aFRvVkpeiVaW3fq1R6f4E=;
        b=RZUF6zIllbmIQ2P+V0dIsxqHn+lIJAndn8catulIKXNeQVBnIXUomB7iqFA4zMbkZ0
         A8plKuFVR2GUhlVvv5lVtiNwYJZWnFiJmQMdXi1uRI+MpBqBeysCByaI+UUx9lclDEbq
         plxy38xd3dyhKWl9NtlAzseQKwfdqyMamzXmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCP0VJStTzPj9G2IsY14W0aFRvVkpeiVaW3fq1R6f4E=;
        b=Wmg493w2PBT6+MSCoytQxvovwfUIYhbcV6g/7+MmACyENcHz3achu7rJ9GmGzAsZ9a
         tpadS7kgbnaJ3kcfE44T3GoutTgsh5tyOwTG76D/M+Xk48fxVbl6VilpTtbqfGr/FFFI
         rHV/9ullbnFqw5t9PZmGTDnGdL7oRGDtVqd+Fjm8J7GiRyrooaxlxQK+xtsjWv2Z/Twb
         DCE03K3nyAiMbmNikWYT2FsHKAJSqq9d6oSOUFpXXDuxAP0iqzbxyxUwN61M09cNODSx
         KXhxHY4TzfXvNRKpUuZwJQ8aVXNXMPL6BJYMAsCmCTvAWcwbfbM1lexvCkUrSmHnh0vt
         Ilsg==
X-Gm-Message-State: AOAM532tpFnhBW4L6oupkzlMgqKGe01PKS6DNmNKSjpRpNuugYSy/V5Y
        a/yWV3sTauYzcieIxoOCmxf86IWNyLSFlQ==
X-Google-Smtp-Source: ABdhPJxsr3iibw3ucF6cbyoy1gw0JUcbNuksgkx3Btm1qkxVNa6OmvsLaIqYcV3xXZOmDUJnETPyUQ==
X-Received: by 2002:a17:906:478a:: with SMTP id cw10mr1295891ejc.533.1611276718314;
        Thu, 21 Jan 2021 16:51:58 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id h16sm3885736eds.21.2021.01.21.16.51.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 16:51:57 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id g10so3526377wrx.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:51:57 -0800 (PST)
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr1870321wru.215.1611276717462;
 Thu, 21 Jan 2021 16:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20210122001326.14263-1-sonnysasaka@chromium.org> <CABBYNZ+OPd_QnHnuhtf0eCx_Vvqy7BSanwjG4ifYVGGEUduHdg@mail.gmail.com>
In-Reply-To: <CABBYNZ+OPd_QnHnuhtf0eCx_Vvqy7BSanwjG4ifYVGGEUduHdg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 21 Jan 2021 16:51:45 -0800
X-Gmail-Original-Message-ID: <CAO271mnuZcvX2CTKGrQgCQoJ3DtCZGVyyCTGEVdLhVEYgqAFdA@mail.gmail.com>
Message-ID: <CAO271mnuZcvX2CTKGrQgCQoJ3DtCZGVyyCTGEVdLhVEYgqAFdA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] input/hog: Fix double registering report
 value callbacks
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Sorry I missed your reply before. I think it's a good idea using
notifyid, let me give it a try.

On Thu, Jan 21, 2021 at 4:39 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Jan 21, 2021 at 4:19 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > In commit 23b69ab3e484 ("input/hog: Cache the HID report map"), we
> > optimized HOG reconnection by registering report value callbacks early,
> > but there was a bug where we also re-register the same report value
> > callbacks after at CCC write callback. We should handle this case by
> > avoiding the second callback register if we know we have done it
> > earlier.
> >
> > ---
> >  profiles/input/hog-lib.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > index 1f132aa4c..089f42826 100644
> > --- a/profiles/input/hog-lib.c
> > +++ b/profiles/input/hog-lib.c
> > @@ -80,6 +80,7 @@ struct bt_hog {
> >         struct bt_uhid          *uhid;
> >         int                     uhid_fd;
> >         bool                    uhid_created;
> > +       bool                    report_value_cb_registered;
> >         gboolean                has_report_id;
> >         uint16_t                bcdhid;
> >         uint8_t                 bcountrycode;
> > @@ -336,6 +337,13 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
> >                 return;
> >         }
> >
> > +       /* If we already had the report map cache, we must have registered UHID
> > +        * and the report value callbacks. In that case, don't re-register the
> > +        * report value callbacks here.
> > +        */
> > +       if (hog->report_value_cb_registered)
> > +               return;
> > +
>
> Didn't I comment on this problem before? I do recall suggesting using
> notifyid instead of adding yet another flag.
>
> >         report->notifyid = g_attrib_register(hog->attrib,
> >                                         ATT_OP_HANDLE_NOTIFY,
> >                                         report->value_handle,
> > @@ -1703,6 +1711,8 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
> >                                         report_value_cb, r, NULL);
> >         }
> >
> > +       hog->report_value_cb_registered = true;
> > +
> >         return true;
> >  }
> >
> > @@ -1753,6 +1763,8 @@ void bt_hog_detach(struct bt_hog *hog)
> >                 }
> >         }
> >
> > +       hog->report_value_cb_registered = false;
> > +
> >         if (hog->scpp)
> >                 bt_scpp_detach(hog->scpp);
> >
> > --
> > 2.29.2
> >
>
>
> --
> Luiz Augusto von Dentz
