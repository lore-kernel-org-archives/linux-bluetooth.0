Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA202067D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 21:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FWpXMeRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgERVwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgERVwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 17:52:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D66C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:52:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so9433070lfb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlKH/Wjvc3w0iL9zZFNrq2WkVLgnrPO/wMFvDVg/k9E=;
        b=FWpXMeRvY0570ukx1lWK9KKIJbK9MyN31W/ZA4Iah5+8ADS1ZJ41ouhyNQcPIVjmVy
         JWOETmtKZx6ZcNvVuVw7ctG3Q+YLXU9TdpwyhlUiGH9Tu7VIC7ISts4RTTTYcFtfcK0D
         HIOUoj3dA/U6bV14CKGglXRiQO5AI0Sphn5+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlKH/Wjvc3w0iL9zZFNrq2WkVLgnrPO/wMFvDVg/k9E=;
        b=lRWEmIqAc8n9vRDut7RIFM4rXvK4elqMNJNHdcUxL0m/2Rgt85GlaPdvPQNTtZCxgD
         X6770B5WFUO6TkY8kGGFYhzjIQgDPSzkP6pH6i8Pq5SUFCH2T0J5AeWxBOCl4YdpzoPj
         hm+OJiF3cI8Dev7BW2G5sH2TnIDowdL1blpus1kQDQ+hJkFhGpAvfkMpm/urcGfO7GCI
         pzAoH3ZGwa+0z7QDYHaTcp7D5/xGoF5rQsp79TY4eH2EQRKT/MW3WSQCd7RHf2uNJcs/
         wmtSf5XKd9V+FdAodwNpRt6uxfPess4lYlbkrnuNBwRlc1v1lickuyzo6hFIFJbPltVd
         f6fQ==
X-Gm-Message-State: AOAM532+Tmx6v004xB7byHr2/NnMpeo8TsbP3o+FCjCZkx3KgCC2Xhi3
        8BwxrzEzU14722pNvBPrtrNac7xc7LorpEt1bTs0Og==
X-Google-Smtp-Source: ABdhPJwQYHGXf8N1ImkGUa3t6JUhNpj4tEtw4ik8HOXqvlg1IlTCdiKOfLRi+jvHT1VdRzvTP1s7/Do0MzUQEZ47gPw=
X-Received: by 2002:ac2:59c3:: with SMTP id x3mr6571958lfn.117.1589838723113;
 Mon, 18 May 2020 14:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200505175338.BlueZ.v1.1.Ibb4c8b00abb07d20022768dfc8b9479b35e1d9a3@changeid>
 <CABmPvSG8_qqAA8M0hHi-3XqdqrkGBzpRypngPenzrODDDn4fbQ@mail.gmail.com> <CACumGOJ37axfhtog6EO=23XeQxdb6ziuYMZK5ueX4etnf-ePog@mail.gmail.com>
In-Reply-To: <CACumGOJ37axfhtog6EO=23XeQxdb6ziuYMZK5ueX4etnf-ePog@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 18 May 2020 14:51:51 -0700
Message-ID: <CABmPvSEa1dRzrhRjGWo0FBqs3CQLjbwSMjz+Huk2Ocnm8K+QJw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] doc/advertisement-monitor-api: Rename methods
 and shorten the preset strings
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Awesome! Thanks for reviewing.

On Mon, May 18, 2020 at 2:30 PM Von Dentz, Luiz
<luiz.von.dentz@intel.com> wrote:
>
> Hi Miao,
>
> On Mon, May 18, 2020 at 2:21 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>>
>> Hi Marcel and Luiz,
>>
>> Per Marcel's suggestion, I renamed the functions and refined the
>> string values of  features and monitor types. Can you help with
>> reviewing this?
>>
>> Thanks,
>> Miao
>>
>> On Tue, May 5, 2020 at 5:54 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>> >
>> > This renames RegisterApplication/UnregisterApplication to
>> > RegisterMonitor/UnregisterMonitor and shortens the strings used in some
>> > properties.
>> > ---
>> > Hi Maintainers,
>> >
>> > This patch updates the experimental API for advertisement monitoring.
>> >
>> > Thanks,
>> > Miao
>> >
>> >  doc/advertisement-monitor-api.txt | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
>> > index 604448f56..74adbfae9 100644
>> > --- a/doc/advertisement-monitor-api.txt
>> > +++ b/doc/advertisement-monitor-api.txt
>> > @@ -89,7 +89,7 @@ Service               org.bluez
>> >  Interface      org.bluez.AdvertisementMonitorManager1 [experimental]
>> >  Object path    /org/bluez/{hci0,hci1,...}
>> >
>> > -Methods                void RegisterApplication(object application)
>> > +Methods                void RegisterMonitor(object application)
>> >
>> >                         This registers a hierarchy of advertisement monitors.
>> >                         The application object path together with the D-Bus
>> > @@ -99,7 +99,7 @@ Methods               void RegisterApplication(object application)
>> >                         Possible errors: org.bluez.Error.InvalidArguments
>> >                                          org.bluez.Error.AlreadyExists
>> >
>> > -               void UnregisterApplication(object application)
>> > +               void UnregisterMonitor(object application)
>> >
>> >                         This unregisters advertisement monitors that have been
>> >                         previously registered. The object path parameter must
>> > @@ -118,7 +118,7 @@ Properties  array{string} SupportedMonitorTypes [read-only]
>> >
>> >                         Possible values for monitor types:
>> >
>> > -                       "patterns_with_logic_or"
>> > +                       "or_patterns"
>> >                                 Patterns with logic OR applied. With this type,
>> >                                 property "Patterns" must exist and has at least
>> >                                 one pattern.
>> > @@ -130,7 +130,7 @@ Properties  array{string} SupportedMonitorTypes [read-only]
>> >
>> >                         Possible values for features:
>> >
>> > -                       "controller-based-monitor-by-patterns"
>> > +                       "controller-patterns"
>> >                                 If the controller is capable of performing
>> >                                 advertisement monitoring by patterns, BlueZ
>> >                                 would offload the patterns to the controller to
>> > --
>> > 2.24.1
>> >
>
>
> Sorry for the delay, it is now applied, thanks.
