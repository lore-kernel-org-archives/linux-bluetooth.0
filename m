Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC61C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 02:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4530617C9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 02:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELCYP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 22:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhELCYP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 22:24:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5322C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 19:23:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so1162394edt.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oJ8BSy2TIsBbi5FIl3mJEoaa0aPFkHwEL2Wyh8P8G0=;
        b=VS6RN4qBOxbluO2QWol6GCo4daCDaItudgLsB+OEANLMyIt1uybqai74e6oR0dxNuc
         FS80JG2/mzZjrZURSUWh74uA7Ti0mwzrQ16JAqEsOtwD4oTcb/cp3YGdUTB82gTF0umO
         ZSIGD6BA9LIV4zE6UnN79R8HFXuu8ABQUAvven039qpZ34kzVggJ+GD0d5Zx+coHvCh+
         dk2YlHJml/OuO3BGQk7LlCiPxVFaZvtUX6JOPXRGfbluoPlETfLedkjiri4r5Us4YirS
         o2E+h4OadntOnLbAFuX5/pAjjB1QyH4T/alYwgJdyRWwY2iz1TIAT6atdDPC26zReVcx
         vMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oJ8BSy2TIsBbi5FIl3mJEoaa0aPFkHwEL2Wyh8P8G0=;
        b=aytU2ClmeefCvudC+LLu2ym+YAruefZE/mx2jrkFBhmXUcbpbZo4CYgo9IOhESe8D+
         Lu0Gk8IFhxwRrpqe3xJm0nirNKwhochXtk3o5zx3ItTpZB7DAlEi6kEQROU6qTNszXeJ
         c2LvvWKTa2aerolcg7KQU7t0P0YJnhh3Jo59Zv7OcKrQ5a3f+okakgTvT9Lpd0wdSNez
         ErNVQdwe8ApG01SDdNXdxCfB7lPWfk+Tqw5au0lEXfcyZmAUE8Q/lUiNCjakIIC7NQvj
         qIzYkzJdD0rA3z2a7lYsGjsi6MmqD8pZa3z9if+CjmDi/9WWU7ijcPKWEHV9IKAMiyr+
         EeRg==
X-Gm-Message-State: AOAM5323XdPwWNAxiIMVIFVaGDC0gj19f9ln6wWptJST55XeZ7eQ4iob
        tcw/FJhc3VvgTr21xw9w4boFVePWP4i7qw6q3mtNiu7IpsVgMg==
X-Google-Smtp-Source: ABdhPJxPRSzVHM1vN7BzkqgxUfDe+9rMRNDBBec36/0cYNKt3l48nSY7TXB0QEU/YsKr9q0+RpH+ydxxES5M99lkFqk=
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr39334411edd.167.1620786185159;
 Tue, 11 May 2021 19:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210511152807.Bluez.v1.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
 <CABBYNZ+JiqjRR0p6LSFr8MZ6i2pojDDjmh5X5n8MCRih06WEUQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+JiqjRR0p6LSFr8MZ6i2pojDDjmh5X5n8MCRih06WEUQ@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Wed, 12 May 2021 10:22:54 +0800
Message-ID: <CAPHZWUdfWV3PnTWzYVeSbSR6qZesyn7PJuEMNFUsg+Qv07Ngpw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] monitor: Fix possible crash of rfcomm packet
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, May 12, 2021 at 2:04 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Tue, May 11, 2021 at 12:28 AM Howard Chung <howardchung@google.com> wrote:
> >
> > From: Yun-Hao Chung <howardchung@chromium.org>
> >
> > When RFCOMM_TEST_EA returns false, btmon assumes packet data has at
> > least 5 bytes long. If that assumption fails, btmon could crash when
> > trying to read the next byte.
> > This patch fix it by checking the remaining size before reading the last
> > byte.
> >
> > Reviewed-by: apusaka@chromium.org
> > ---
> >
> >  monitor/rfcomm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> > index 9b88a3440e31..76b1123bb23d 100644
> > --- a/monitor/rfcomm.c
> > +++ b/monitor/rfcomm.c
> > @@ -452,6 +452,9 @@ void rfcomm_packet(const struct l2cap_frame *frame)
> >                 hdr.length = GET_LEN16(hdr.length);
> >         }
> >
> > +       if (l2cap_frame->size == 0)
> > +               goto fail;
> > +
>
> if (!l2cap_frame->size)

will do.
>
>
>
> >         l2cap_frame_pull(&tmp_frame, l2cap_frame, l2cap_frame->size-1);
>
> Or perhaps we can make l2cap_frame_pull check if it can really pull
> the frame and return false if it doesn't just as get_*.

IMO, this might not be the best solution. Since |len|l in
2cap_frame_pull is uint16_t, when l2cap_frame->size-1 overflows it
might confuse people.

>
>
>
> >         if (!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
>
>
> --
> Luiz Augusto von Dentz
