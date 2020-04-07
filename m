Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B89C2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB70820678
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WibKiUXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGXRb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:17:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36930 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGXRb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 19:17:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so5002410otq.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCadkit8bpUVLc5OWrG/jj37kMu+iRkXQkS0nkK0458=;
        b=WibKiUXawBCGiko0DvE2nsdbluT3dD8t/Tbh0DhOZUGl0wzB+U7yarvSielncR5pom
         RSvZXFZcxKloi1qtn5A2v6dEV5J2pvuCrfdPF4iq76P0sXlbrhH4KnFVS1iYotOPoCWx
         u8y8TFNP9IlxhEJxl2kogUV9Onla8zdC8zTuHUe1VH20oXUbNDlRLg2NetPCJp+JRSY9
         0GXXUqFTKGxKq4QfS0knyX2pza2G/PGYRiiXasp3BF7JkgxMRGCSkiyfLS1N9xi+NeOM
         cYOfE4xZqwZm3djb0l5c00KFLGfrfzpDztNyo6RwxTFaSR5N/DI5B4gtFoA9mhg3soKk
         S98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCadkit8bpUVLc5OWrG/jj37kMu+iRkXQkS0nkK0458=;
        b=DUfzjX5GUANqI5OVruK8/i3oSwmXDuhjGiq++aMM86LwpXTNn3tre/DrVsqa8CyVzp
         LLxTuINWmztGdJiI2l17aU++ztCOJQ4LWdM4+YjnkT6NQDza83fNTuIWZ64BSMiWKdY+
         y8sIBEHOwUCO7+xI+Hf1Y++1oZSwwRGk6XH37LxSWpisnkU92MddhyTmqxVesPuLZjqY
         2KlY2fb74NXLfGToTPs2iQz+B17BXfX2u9NYahl8IuBqm57OeX/xez39UmnKcr31QDtj
         3tqk6tpntr6gPpq+11TU0av9U+nE//JHzkeCKRTxvyRfttHUwicPGKbENF6ZNMcHcWSA
         jy6A==
X-Gm-Message-State: AGi0PubCOMisTr9AiLkgJb1Wwm3EoLzcYM9OOt880o7k1JbGMrVySziN
        ML9hvZJ1ruq1elRJX4y4xvkVQsmmII1xbFUFpA8=
X-Google-Smtp-Source: APiQypI1jJI/7bTZohpqtGhGGjlN9Kyo7/CZgxxk0D7l0w8pmRFXrgaickNgDTIlkXmRRx1q7bTrpOx/UCY/mFioYLo=
X-Received: by 2002:a9d:67c6:: with SMTP id c6mr3615646otn.11.1586301450169;
 Tue, 07 Apr 2020 16:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
 <20200330160343.Bluez.v2.3.Ia74c1ab0a71d90f46f10b4e32743cab722a97bbb@changeid>
 <528530767.EP9f1MIPRH@ix>
In-Reply-To: <528530767.EP9f1MIPRH@ix>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Apr 2020 16:17:19 -0700
Message-ID: <CABBYNZ+KvVoP_OMrzzUHFofJmDUiX2xCytbbv5FP2irWCp1tBg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 3/6] doc: Add documentation for LE Set
 Advertising Interval
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     Howard Chung <howardchung@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon, Howard,

On Mon, Mar 30, 2020 at 2:27 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Monday, 30 March 2020 10:03:54 CEST Howard Chung wrote:
> > Signed-off-by: Howard Chung <howardchung@google.com>
> > ---
> >
> > Changes in v2: None
> >
> >  doc/advertising-api.txt | 13 +++++++++++++
> >  doc/mgmt-api.txt        | 25 +++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> > index b0565eab2..9264cdb27 100644
> > --- a/doc/advertising-api.txt
> > +++ b/doc/advertising-api.txt
> > @@ -209,3 +209,16 @@ Properties       byte ActiveInstances
> >                       Possible values: "1M"
> >                                        "2M"
> >                                        "Coded"
> > +
> > +             void SetAdvertisingIntervals(uint16 min_interval_ms,
> > +                                          uint16 max_interval_ms)
> > +
> > +                     This method sets the advertising intervals.
> > +
> > +                     The parameters min_interval_ms and
> max_interval_ms
> > +                     are specified in milli-seconds. Valid values of
> > +                     the intervals must fall between 20 ms and 10,240
> ms.
> > +
> > +                     Possible errors: org.bluez.Error.Failed
> > +                                      org.bluez.Error.InProgress
> > +
> org.bluez.Error.InvalidArguments
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 27a41f334..5eff87e24 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -2925,6 +2925,31 @@ Read Extended Controller Information Command
> >                               Invalid Index
> >
> >
> > +Set Advertising Intervals Command
> > +=================================
> > +
> > +     Command Code:           0x0101
> > +     Controller Index:       <controller id>
> > +     Command Parameters:     Min_Interval     (2 Octets)
> > +                             Max_Interval     (2 Octets)
> > +     Return Parameters:      Current_Settings (4 Octets)
> > +
> > +     This command is used to set advertising intervals. The intervals
> > +     are expressed in multiples of 0.625 ms. The default values of
> > +     both intervals are 0x0800. Valid Min_Interval and Max_Interval
> > +     values must fall between 0x0020 and 0x4000.
> > +
> > +     The advertising intervals are first kept in hdev struct. The values
> > +     would be sent to the controller and take effect when advertising is
> > +     actually enabled. If the advertising intervals are set when
> > +     advertising is already on, the advertising would be disabled and
> > +     re-enabled to make the intervals take effect.
> > +
> > +     Possible errors:        Busy
> > +                             Rejected
> > +                             Invalid Parameters
> > +
> > +
> >  Set Appearance Command
> >  ======================
>
>
> I feel this should be per instance settings, and if we want this level of
> finetuning we would probably need to have new command for adding advertising
> sets (where we could fix more, eg not limit data to 255 bytes).
>
> Other option would be to maybe have new flags in current Add Advertising that
> would allow to choose from low,med,hi (eg based on GAP recommended values)
> intervals, and then allow to finetune those via extra command or sysfs?
>
> Just my two cents.

+1, since we need to accomodate for the case of having multiple
application having their own instances having some presets might be
easier to manage.

-- 
Luiz Augusto von Dentz
