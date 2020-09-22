Return-Path: <SRS0=LYTB=C7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A4C4727E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 01:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E7023A6C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 01:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZfwSRRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgIVBoI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 21:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgIVBoI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 21:44:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8170C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 18:44:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w16so19258283oia.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 18:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnystwRGA77c1y/A1dFdil02soJNePvzvHddszLW6VU=;
        b=qZfwSRReRvRujKpNbyaHCuMTuDJ0CNRzkDjPUUCYMpJWROixPiM1isCJg2VZqeJkkq
         cMZv2rPO02+QmRQWLos6dWj/y+UM5HaHLP8IWt2V+/TkC1UnSM9kfUUZDs+HGdY3CZs3
         AAuAjgXALKT8GVlctFPF7pSYuZmougYQivuH/tAKfheA8Z/gMaOKvJzrmPN3BJ7f0FjK
         onTjZij6U3Q6M1ZB4p+/wcAVftAxDqnrTSxdiebCqAecGguDRoHFumyX7qKxePKxNFO3
         6X1y0NKVlzkytJ9qulNFxGX2XCdgQgC9FkUjc8B+i9Ns6R7oLuQMYu8YP6Y7ZmdBgro7
         LDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnystwRGA77c1y/A1dFdil02soJNePvzvHddszLW6VU=;
        b=iVETX2lP7aTH79OmCFZYbwiwnBZCX3iCdyWukvaAhaQRQ0VsAsv2rz9Zaz9aEEUNwA
         L7rhQrfSMlgP74VcPeQzon9f9uRzHGtGRu4btUPsDV0aJkJUPKUoWL2rXwdyVo5V4xZL
         w8QydNLkuYt/nfUHFa9Wskv5MEYZDOK8oa6JiBq2ZjR8UTkn2kf5SYc0tpNx4h48k1tk
         0/XRCt4rvn6Q4yAgcQoCk/FHkMg3Jojg9TingvLXknUTllPmIo4UiG4JT3sauaD8H7kf
         Nh7FT2fo3zlahqx0I0SCdqM0kC8PrMDkCHmMtdxhqkk7ZEjl/3ColGbssX/NILcBfXgQ
         8W4A==
X-Gm-Message-State: AOAM532GJvHRKU2HI/k8XqTAAoCgcdHocLQjgxnSHzW2jDg76Fq6jTaL
        R85C8DybRsXRJ4J8PJwo5B9CXxPatn34/jx3Ai0=
X-Google-Smtp-Source: ABdhPJzdqqKU0DBDzelyGfvn3gCvrPS4rlMxVCI/Vam41KkOrhL7qZ/r2gDKa227/bcgGKRm6l0fcQbsG+VrcEk9E5A=
X-Received: by 2002:aca:3e08:: with SMTP id l8mr1242763oia.152.1600739046443;
 Mon, 21 Sep 2020 18:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <CABmPvSHYi7WeWqgqxSe60omSyVXj_EezMhGi1GMXBBWM-TWeBw@mail.gmail.com>
 <CABBYNZJDbPd83cx0KWLGMpE_KaA9xUbuMCDsuQVTNxV7xrowiw@mail.gmail.com> <CABmPvSEgnWoyijsA=ZsNeJoJdbz5YJTZHtEGWp6JTj3dKxxMrQ@mail.gmail.com>
In-Reply-To: <CABmPvSEgnWoyijsA=ZsNeJoJdbz5YJTZHtEGWp6JTj3dKxxMrQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Sep 2020 18:43:53 -0700
Message-ID: <CABBYNZJKT8mf8RP5ZVt3M2hUNRkzyiwGvpFm7n3WBayt-kbsyA@mail.gmail.com>
Subject: Re: Modifying Makefile.am to facilitate test-adv-monitor and future
 unit tests.
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Mon, Sep 21, 2020 at 12:21 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
> On Fri, Sep 18, 2020 at 3:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Miao,
> >
> > On Fri, Sep 18, 2020 at 12:44 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > >
> > > Hi Luiz and Marcel,
> > >
> > > Unlike the rest of the existing unit tests in BlueZ, the logic blocks
> > > tested in test-adv-monitor require dependencies of not only
> > > src/adv_monitor.c but also all the dependency tree of
> > > src/adv_monitor.c. The current convention in Makefile.am is to add all
> > > the extra dependencies one by one. However, the maintenance cost is
> > > high and not suitable in the case of test-adv-monitor. Therefore, we'd
> > > like to propose changes in Makefile.am to make the source of
> > > bluetoothd as a static library and link it for bluetoothd target and
> > > the unit test target. It would be great if you can provide feedback on
> > > this idea before the implementation. Thanks in advance!
> >
> > Then we should have had the code move to src/shared for unit testing,
> > but how exactly are you planning to do that? For testing the kernel
> > interface it normally done via a dedicated tester, but that again can
> > be done with shared library.
> >
> In series https://patchwork.kernel.org/project/bluetooth/list/?series=351021,
> we introduced some helper functions in adv_monitor.h to perform unit
> testing and test-adv-monitor to facilitate the unit tests of
> adv_monitor. We are encountering an expected build check failure on
> this series.
>
> There are two categories in test-adv-monitor, content filtering and
> RSSI tracking, and content filter is easy to be moved to a standalone
> shared component while RSSI tracking involves the use of timer, D-Bus
> method calls and adv_monitor's internal structures, and that makes it
> strongly coupled with the adv_monitor implementation which require a
> tree of dependencies apart from adv_monitor.
>
> There are two options to resolve the build failures in our case.
> (1) Reorganize Makefile.am
> This option is to make the sources (except src/main.c) into a static
> lib and link this lib in bluetoothd executable target and whichever
> unit test the sources are required.
> (2) Create src/shared/am to facilitate helpers and core logic
> This option is to create a new source under src/shared/ to facilitate
> helper functions and core logic for src/adv_monitor. The interface of
> src/shared/am may have the following functions.
> - Create/destroy functions of struct adv_monitor
> - Create/destroy functions of struct adv_monitor_device
> - Helper function for monitor content matching.
> - Helper function for RSSI tracking
> However, the logic of RSSI tracking is hard to be ripped off and moved
> to src/shared/am. One example would be the use of timer in RSSI
> tracking, and there is currently no previous example of the timer use
> in the shared library.

Not really following regarding the dependency on D-Bus, usually shared
don't have dependency on that because the code would be part of the
deamon and in that case you would be better of  testing that direct
via a tester that does exercise its D-Bus API. Lets be clear here,
except for gbus itself all our tests under unit directory are for C
function testing, if you want to test a D-Bus interface then we need a
tester that would do that over D-Bus.

> Series https://patchwork.kernel.org/project/bluetooth/list/?series=351021
> is up for review. Our next step here would be ripped off the unit test
> for now and submit v5 of the series. Once we reach an conclusion on
> advmon unit test, we can submit a separate series including the
> refactoring and unit tests. Looking forward to any feedbacks. Thanks!

I'd strip the testing for now since it doesn't seem we are on sync to
how we test things apparently.

> Regards,
> Miao



-- 
Luiz Augusto von Dentz
