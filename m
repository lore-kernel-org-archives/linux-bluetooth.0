Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C7E611BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhESSMA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhESSL7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:11:59 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717FC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:10:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r8so19263733ybb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5zyZvHODyW7wNlmGkZxhl3cucirKpOxo7r8pyIsuAg=;
        b=RePIhNZgnwyAsI602yeGhRgJNCXLSE5u7WcBYSLeftFIRbzW1ti52ZsVoGjnCRgTBx
         24UeKfGV1GwuNRfzACfFlBtq8zDHoamRZe4ONDzioEVFkMkoadD5KYGJ1foxFRjdxISg
         gf0PLy5IVaQZL64JNsP81nVeogMtxl6ZxhlZYfFuVbEoe7xcwjYEXiVlTHZ9p9cZZsn3
         kFwMWEG9Moh4/lsG004WNqNptqE0DIMlEVOVpwUfycUkJsYYd8wds6bo+WG7CJUGkhJa
         4JQglhBDuZRfl5d53/NoDv0o8fO4jfRU8YFQZqcgnjBQLlHNsKF9H4JDC9cXiKj0oRDu
         9Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5zyZvHODyW7wNlmGkZxhl3cucirKpOxo7r8pyIsuAg=;
        b=kiNVatUvXxvjEK3q5JIhcuWUqdyj/4ZcN7U+DRctlrJfWbNND/eEKAekb1V+0JIdg1
         ru6qS24v5aEzioeJG8VEwrxyPaZuq5VLAPJpjqu7ZmPw0zcGCUJs2TEtkVSDuyvruAPD
         YBbZxWN8/+MEIXVgVA3rtkIW5MH+DVcN2OfqfvRo8SNskLYl8rOwNmBkWSoHFYqg42WX
         sIujzDqxHUaxRi6ia6/MMv1mq3FOHkhtvQCkm/F4bAm0OS1V1SsoARNcSTglhHkz2gnA
         WgpcpWskiHHei4VEXac5/E4cbD8Q+adGmNbvGdCf8ycHMBltIpW//nZ7K0Ba47Bd9tpP
         gJNA==
X-Gm-Message-State: AOAM532sdOoGsazbEPg1jJY8xQHMHAP6Do0vc7pAmcvvkE/i00YWUbrb
        iZBCL1/lYgVON8/a/t8MGQMhkZ8JmL9cnJGFkg4=
X-Google-Smtp-Source: ABdhPJw+5zLHDEP8KYEqXcjoxpOzb2vFWKFilwzUruTkYqrmxoAWe1hhgyTbu9Gt8aVg0d9iP4SlVIKiL9e4ih/1fr8=
X-Received: by 2002:a25:b80e:: with SMTP id v14mr1280416ybj.408.1621447837480;
 Wed, 19 May 2021 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
 <625ddaac272571a89451dbff5be28270cd63e15b.camel@gmail.com>
In-Reply-To: <625ddaac272571a89451dbff5be28270cd63e15b.camel@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 May 2021 11:10:26 -0700
Message-ID: <CABBYNZKFN3yRV+RGZKuN4v5=NiYOP0tEX2e-nwYqLYt=sVuLvA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] core: Fix loading AVDTP options
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     Howard Chung <howardchung@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, May 18, 2021 at 9:41 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> Hi Howard,
>
> On Fri, 2021-05-07 at 12:32 +0800, Howard Chung wrote:
> > From: Yun-Hao Chung <howardchung@chromium.org>
> >
> > Fix misassigned AVDTP StreamMode option, which causes StreamMode not
> > being set.
> > Fix AVDTP SessionMode option not freed.
> >
> > Reviewed-by: mmandlik@chromium.org
> > Reviewed-by: apusaka@chromium.org
>
> Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> > ---
> >
> >  src/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/main.c b/src/main.c
> > index c32bda7d407d..7612d6984890 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -774,9 +774,10 @@ static void parse_config(GKeyFile *config)
> >                       DBG("Invalid mode option: %s", str);
> >                       btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
> >               }
> > +             g_free(str);
> >       }
> >
> > -     val = g_key_file_get_integer(config, "AVDTP", "StreamMode", &err);
> > +     str = g_key_file_get_string(config, "AVDTP", "StreamMode", &err);
> >       if (err) {
> >               DBG("%s", err->message);
> >               g_clear_error(&err);
> > @@ -791,6 +792,7 @@ static void parse_config(GKeyFile *config)
> >                       DBG("Invalid mode option: %s", str);
> >                       btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
> >               }
> > +             g_free(str);
> >       }
> >
> >       parse_br_config(config);

Applied, thanks.

-- 
Luiz Augusto von Dentz
