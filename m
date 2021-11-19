Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 19:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B4A61283
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 19:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhKSToC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhKSTnw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 14:43:52 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F05C06173E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 11:40:47 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id j1so6573392vkr.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 11:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmtLGkWgpK9Trsmaw0yWBVoQyG6pJWEIwY4tb8nm798=;
        b=YTlkMips8EN63BUWsnLG6WaYt7p/nso+I+WSTbZ8DZrAkH2Kmr5Q5XBdqi+IHDmLLr
         7UozbXzkavPnh/YnVX8wLX87rsfXsahWR9pjsi+AtAnZYPMnoU0y60Ye7o7VTa+ZxMtD
         MVnO1WMJKJ5QAIekrjudZh4VzmlazXti/21QeeRW3iubSns/8m6gsB9XrPKimJWkPQFh
         KtCsdKDOaUEcz3nosekg+lzBBTrdB7Su/bx0vGngmLWzA/Q7g8quVLySCHGw2fog6uCY
         e0wfG9afHVu8Cq83lj6zaBLLWoad8MkPkd9bpzFbka/Dg5JWwD0mgwQDp+r3zRQF60bI
         G9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmtLGkWgpK9Trsmaw0yWBVoQyG6pJWEIwY4tb8nm798=;
        b=1GtZe/e6H2FucCejeytUZvMQAN841WZJl4zYLUNM/3RkaAaXGyB60sGMxNR22hPW4+
         22LavOP1vrFv+h6Wy2lVYtfPiJ2P31mRjw0hYcxO/rbxIG3ovzfBsEduamaOTtouXP4W
         jbmCW3fldK3FVOLAOfd5LknWO/rFd2mS8jYUQfoh6CyerfZh/F2lI2toVGUOcMAoB1hg
         kRxCRJMq7mcYPiM/El+kY3aYMuVcvw8QtPFeSeuldcXO+ApFNJfm5eTz33S8qH1to5Tn
         AsyUEG70hPfxRx6++W0Di3cGnCqvxz+UKeWij97LyFcnWVZzWeZdLthaB+Jrg2g59Hhp
         iuqQ==
X-Gm-Message-State: AOAM5315YxBNOKju7nx6ol7dEcEr8WO0BThKSODNumQZXuFBeaBrt6d2
        Jxb4eFwQZp9bJB1QsGHNI4h4cREW5vcYMosU2ow=
X-Google-Smtp-Source: ABdhPJwxDAAeGlBQ+0gpHnSiOnZWHXGcfUtcqrP3vQ4fKvGZR/ZMi3WUfJDZXT51tTLh9PhQCpliJ65dvNpMQIGISfQ=
X-Received: by 2002:a05:6122:d05:: with SMTP id az5mr122353682vkb.9.1637350846152;
 Fri, 19 Nov 2021 11:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <20211117110627.BlueZ.v5.6.I363090b80e59a3cda134c9bd2df0b3bca2cb527b@changeid>
 <CABBYNZL994EW-=6xrknc3LK0sRv4pv7OReKiWzC3eF54MBK0xw@mail.gmail.com> <CAGPPCLB9KSDG1LFYeeKnPjtD001Q00PXgkRnh8Xz_9N=zB+mqg@mail.gmail.com>
In-Reply-To: <CAGPPCLB9KSDG1LFYeeKnPjtD001Q00PXgkRnh8Xz_9N=zB+mqg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Nov 2021 11:40:35 -0800
Message-ID: <CABBYNZJrV6w5=-FP7WPE9CytgNs+4sbTwV+iOF04N2u+CxYiuQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 6/6] core: Update default advmon Sampling_Period
 to 0xFF
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Fri, Nov 19, 2021 at 11:06 AM Manish Mandlik <mmandlik@google.com> wrote:
>
> Hi Luiz,
>
>
> On Wed, Nov 17, 2021 at 4:09 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Manish,
>>
>> On Wed, Nov 17, 2021 at 11:15 AM Manish Mandlik <mmandlik@google.com> wrote:
>> >
>> > Update default Advertisemet Monitor Sampling_Period to 0xFF. It
>> > indicates that controller will report only one advertisement per
>> > monitoring period for a device. This will help reduce the power
>> > consumption drastically.
>> >
>> > Reviewed-by: Miao-chen Chou <mcchou@google.com>
>> > ---
>> >
>> > Changes in v5:
>> > - New patch in the series. Update default Sampling_Period to 0xFF.
>> >
>> >  src/main.c    | 2 +-
>> >  src/main.conf | 2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/src/main.c b/src/main.c
>> > index 5ca8d5644..1f852fdf6 100644
>> > --- a/src/main.c
>> > +++ b/src/main.c
>> > @@ -932,7 +932,7 @@ static void init_defaults(void)
>> >         btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
>> >         btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
>> >
>> > -       btd_opts.advmon.rssi_sampling_period = 0;
>> > +       btd_opts.advmon.rssi_sampling_period = 0xFF;
>> >  }
>> >
>> >  static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
>> > diff --git a/src/main.conf b/src/main.conf
>> > index e05291d8e..e49259453 100644
>> > --- a/src/main.conf
>> > +++ b/src/main.conf
>> > @@ -260,5 +260,5 @@
>> >  [AdvMon]
>> >  # Default RSSI Sampling Period. This is used when a client registers an
>> >  # advertisement monitor and leaves the RSSISamplingPeriod unset.
>> > -# Default: 0
>> > +# Default: 0xFF (Report only one Adv per device during the monitoring period)
>> >  #RSSISamplingPeriod=0
>>
>> While at it it would be good to explain what is the unit used here,
>> also it is common practice to have the default on the commented entry.
>
> Ack. I'll update this in the next revision.
>
>>
>>
>> > --
>> > 2.34.0.rc1.387.gb447b232ab-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> Can you please review the other patches as well and let me know if they look good? I'll send all the required changes in the next revision together.

Other patches look good.


-- 
Luiz Augusto von Dentz
