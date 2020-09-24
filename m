Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B9C4363D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BD82399A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 21:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7XVRX3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIXVSZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXVSZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 17:18:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3597BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 14:18:25 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 60so322997otw.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTUkOp4UAXVn9OxQMUD8QbmtlPiYE5qc3hVmASK3+WI=;
        b=H7XVRX3YNgMT+Qdtj12HxTcqIaJcEwbU6HeBeQgiu27gmVQDNU0TltQ5Kgiicx63XW
         uYC3zM0+qj7Ez73ZWybPWgbtIVpYUNpUasK5BpTmhehKgAVJIRWMkf7wAeXSrABhFBH2
         a7ynywOnIL+SNNWSD81meHFYHBnFeBzs2QAJL7U7yEeg82hbF/nLEM1wsDxUetjRH/CR
         U8U4eZW4y0dSMZRIkkQ42yq+4YyA87l+uW4d8qb4ysI1obTGub1PvlMZp2VAds0VgLFM
         kZccPm0pOVCU17+xA4bBImr3fLpQNtyzRE3M4n3WZsNOqiw4pMUr0r4tLUGACs/J6rlO
         0lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTUkOp4UAXVn9OxQMUD8QbmtlPiYE5qc3hVmASK3+WI=;
        b=FrNG5A/FDlCapijIX5sNKfAWFPi8TmIuVnd7Rx2PYOeWqTcovi2/dbvVgOg+fdIinP
         cybBwkjJ8SpRIMIw2fYF//w7XQOPp6Pps3mCnYPwTWPcFuyFK6PYU3uSHoXzMsXE1uAf
         rWBXTgyuPD481zd0gM0c8VfdUQ+v2zoxM1iFXI0qqh8LKhob9OFAwLRFQEsoRJ9wZe7k
         H2gRJ++UJIC2g+PI1hirD/3MpXHJMAB4Itq8v8gpY//KBa7OPOHvoBQWmZoWLcWo4WZP
         njBw4f7khfzw4cSQW8K3c0WfBcN1ZmEZXZ7pVnb1ty3PELq9+TDm4TNLWAAIZlCTXe5j
         cWVg==
X-Gm-Message-State: AOAM530jBIC9dL5y7HIQ8CCy5KA3a6DPdC7RAM0xJ87Eq5VzPQUHtHtm
        U53Y0qeLTHZqIuW9CZAwtXbssoknB6S2QlFiXpY=
X-Google-Smtp-Source: ABdhPJyVfvgBSC2fcTo9zDAA6kMGU19gieGYC/KgDtCu15ssHV4aS6Tsk1uBm6oNMErkz+MBQLHZTko6Y2pz0THwo+E=
X-Received: by 2002:a05:6830:22e6:: with SMTP id t6mr752631otc.88.1600982304365;
 Thu, 24 Sep 2020 14:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABmPvSHYi7WeWqgqxSe60omSyVXj_EezMhGi1GMXBBWM-TWeBw@mail.gmail.com>
 <CABBYNZJDbPd83cx0KWLGMpE_KaA9xUbuMCDsuQVTNxV7xrowiw@mail.gmail.com>
 <CABmPvSEgnWoyijsA=ZsNeJoJdbz5YJTZHtEGWp6JTj3dKxxMrQ@mail.gmail.com>
 <CABBYNZJKT8mf8RP5ZVt3M2hUNRkzyiwGvpFm7n3WBayt-kbsyA@mail.gmail.com> <CABmPvSHUs-4w3_XNFZJA07+uNeBZxh_qP=24ahr-HxvhULUCNw@mail.gmail.com>
In-Reply-To: <CABmPvSHUs-4w3_XNFZJA07+uNeBZxh_qP=24ahr-HxvhULUCNw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Sep 2020 14:18:12 -0700
Message-ID: <CABBYNZKgUNwJ7scKSq99=nWPqmPuYsTp8fEL+JSAyrKfcK3zkg@mail.gmail.com>
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

On Thu, Sep 24, 2020 at 1:44 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz,
>
>
> On Mon, Sep 21, 2020 at 6:44 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Miao,
> >
> > On Mon, Sep 21, 2020 at 12:21 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Fri, Sep 18, 2020 at 3:12 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Miao,
> > > >
> > > > On Fri, Sep 18, 2020 at 12:44 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > > > >
> > > > > Hi Luiz and Marcel,
> > > > >
> > > > > Unlike the rest of the existing unit tests in BlueZ, the logic blocks
> > > > > tested in test-adv-monitor require dependencies of not only
> > > > > src/adv_monitor.c but also all the dependency tree of
> > > > > src/adv_monitor.c. The current convention in Makefile.am is to add all
> > > > > the extra dependencies one by one. However, the maintenance cost is
> > > > > high and not suitable in the case of test-adv-monitor. Therefore, we'd
> > > > > like to propose changes in Makefile.am to make the source of
> > > > > bluetoothd as a static library and link it for bluetoothd target and
> > > > > the unit test target. It would be great if you can provide feedback on
> > > > > this idea before the implementation. Thanks in advance!
> > > >
> > > > Then we should have had the code move to src/shared for unit testing,
> > > > but how exactly are you planning to do that? For testing the kernel
> > > > interface it normally done via a dedicated tester, but that again can
> > > > be done with shared library.
> > > >
> > > In series https://patchwork.kernel.org/project/bluetooth/list/?series=351021,
> > > we introduced some helper functions in adv_monitor.h to perform unit
> > > testing and test-adv-monitor to facilitate the unit tests of
> > > adv_monitor. We are encountering an expected build check failure on
> > > this series.
> > >
> > > There are two categories in test-adv-monitor, content filtering and
> > > RSSI tracking, and content filter is easy to be moved to a standalone
> > > shared component while RSSI tracking involves the use of timer, D-Bus
> > > method calls and adv_monitor's internal structures, and that makes it
> > > strongly coupled with the adv_monitor implementation which require a
> > > tree of dependencies apart from adv_monitor.
> > >
> > > There are two options to resolve the build failures in our case.
> > > (1) Reorganize Makefile.am
> > > This option is to make the sources (except src/main.c) into a static
> > > lib and link this lib in bluetoothd executable target and whichever
> > > unit test the sources are required.
> > > (2) Create src/shared/am to facilitate helpers and core logic
> > > This option is to create a new source under src/shared/ to facilitate
> > > helper functions and core logic for src/adv_monitor. The interface of
> > > src/shared/am may have the following functions.
> > > - Create/destroy functions of struct adv_monitor
> > > - Create/destroy functions of struct adv_monitor_device
> > > - Helper function for monitor content matching.
> > > - Helper function for RSSI tracking
> > > However, the logic of RSSI tracking is hard to be ripped off and moved
> > > to src/shared/am. One example would be the use of timer in RSSI
> > > tracking, and there is currently no previous example of the timer use
> > > in the shared library.
> >
> > Not really following regarding the dependency on D-Bus, usually shared
> > don't have dependency on that because the code would be part of the
> > deamon and in that case you would be better of  testing that direct
> > via a tester that does exercise its D-Bus API. Lets be clear here,
> > except for gbus itself all our tests under unit directory are for C
> > function testing, if you want to test a D-Bus interface then we need a
> > tester that would do that over D-Bus.
> >
> > > Series https://patchwork.kernel.org/project/bluetooth/list/?series=351021
> > > is up for review. Our next step here would be ripped off the unit test
> > > for now and submit v5 of the series. Once we reach an conclusion on
> > > advmon unit test, we can submit a separate series including the
> > > refactoring and unit tests. Looking forward to any feedbacks. Thanks!
> >
> > I'd strip the testing for now since it doesn't seem we are on sync to
> > how we test things apparently.
> >
> Thanks for your reply. We need to rethink how to perform the testing.
> And agree, we do plan to strip the testing for now from our series.

Btw, I do recall seeing D-Bus level tests in chromium, have you guys
stopped developing them?

> > > Regards,
> > > Miao
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
