Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AB3C4346E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BB5216C4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 19:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bGt4t/Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIUTVI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUTVI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 15:21:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4BC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 12:21:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z19so15331684lfr.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1PaecozHR4M5eRnCxHIbVVrIPnLcorg/Z74qyJThlI=;
        b=bGt4t/Uqsgw1OIj0LPjhocd+TK25QWC2VDpeLdDGa5QZ/alI/Fcm41FivflnSS/EQR
         FJJDzx7XRLHMLvVBU1mHyMpt6X6B0IplukuGNhvzwnLYO3meYDtfka9tDZX6/J86Fp0y
         x5be2rnLGsBIvrqvHogKxErUR5LK0WSU9IW4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1PaecozHR4M5eRnCxHIbVVrIPnLcorg/Z74qyJThlI=;
        b=WGJP5zLptVHKvUHv8PYgrGQOnJdLs2gn+sR0nI/yDiB30IBNC/tPvTSgpQnbiKpDlf
         WZpZNf/YChUgO2W1nt/BvC41btodn7Af8wzL70V/mlgtoWbJplZM4QoU/yB9h8hURtjj
         vC6qLOS/BsRbcXIo1DoQ5PaY+J0wPOxIDi7+HQJjYK1+9wVR+KguoWJJEd5CR4lNLpDP
         Alw1lz3nwwx4eY0IrSG2ly5+OU4IMcu4y4kcWHBx5ivSKK9q5XGtm6Q1bohfY9MGTbhJ
         CUix5DM8Zdm18TV1Vt7P3ogS/ypXntUSIVrV2FojoXe3ASsgIh1vjopG3MmMgwdsSdPN
         wmdw==
X-Gm-Message-State: AOAM530vnF/35gJf9eA/ObDoyLAzYRC1Hwuv0LAoKQFEWwieJV5DTkOU
        83jdOTy/7+3kE70HS3dPsLwxU1kaQhMkeRuEBoFj1A==
X-Google-Smtp-Source: ABdhPJx9iNwHUD4jQ7sy8ksPDVIRjrKYGykQqN7IrMIfj609rOhgwARaVe3Vtab90/Lzy9R5xQCjlRSjklElcE5fhys=
X-Received: by 2002:a19:5619:: with SMTP id k25mr445034lfb.324.1600716065399;
 Mon, 21 Sep 2020 12:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABmPvSHYi7WeWqgqxSe60omSyVXj_EezMhGi1GMXBBWM-TWeBw@mail.gmail.com>
 <CABBYNZJDbPd83cx0KWLGMpE_KaA9xUbuMCDsuQVTNxV7xrowiw@mail.gmail.com>
In-Reply-To: <CABBYNZJDbPd83cx0KWLGMpE_KaA9xUbuMCDsuQVTNxV7xrowiw@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 21 Sep 2020 12:20:54 -0700
Message-ID: <CABmPvSEgnWoyijsA=ZsNeJoJdbz5YJTZHtEGWp6JTj3dKxxMrQ@mail.gmail.com>
Subject: Re: Modifying Makefile.am to facilitate test-adv-monitor and future
 unit tests.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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

Hi Luiz,

On Fri, Sep 18, 2020 at 3:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Fri, Sep 18, 2020 at 12:44 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > Hi Luiz and Marcel,
> >
> > Unlike the rest of the existing unit tests in BlueZ, the logic blocks
> > tested in test-adv-monitor require dependencies of not only
> > src/adv_monitor.c but also all the dependency tree of
> > src/adv_monitor.c. The current convention in Makefile.am is to add all
> > the extra dependencies one by one. However, the maintenance cost is
> > high and not suitable in the case of test-adv-monitor. Therefore, we'd
> > like to propose changes in Makefile.am to make the source of
> > bluetoothd as a static library and link it for bluetoothd target and
> > the unit test target. It would be great if you can provide feedback on
> > this idea before the implementation. Thanks in advance!
>
> Then we should have had the code move to src/shared for unit testing,
> but how exactly are you planning to do that? For testing the kernel
> interface it normally done via a dedicated tester, but that again can
> be done with shared library.
>
In series https://patchwork.kernel.org/project/bluetooth/list/?series=351021,
we introduced some helper functions in adv_monitor.h to perform unit
testing and test-adv-monitor to facilitate the unit tests of
adv_monitor. We are encountering an expected build check failure on
this series.

There are two categories in test-adv-monitor, content filtering and
RSSI tracking, and content filter is easy to be moved to a standalone
shared component while RSSI tracking involves the use of timer, D-Bus
method calls and adv_monitor's internal structures, and that makes it
strongly coupled with the adv_monitor implementation which require a
tree of dependencies apart from adv_monitor.

There are two options to resolve the build failures in our case.
(1) Reorganize Makefile.am
This option is to make the sources (except src/main.c) into a static
lib and link this lib in bluetoothd executable target and whichever
unit test the sources are required.
(2) Create src/shared/am to facilitate helpers and core logic
This option is to create a new source under src/shared/ to facilitate
helper functions and core logic for src/adv_monitor. The interface of
src/shared/am may have the following functions.
- Create/destroy functions of struct adv_monitor
- Create/destroy functions of struct adv_monitor_device
- Helper function for monitor content matching.
- Helper function for RSSI tracking
However, the logic of RSSI tracking is hard to be ripped off and moved
to src/shared/am. One example would be the use of timer in RSSI
tracking, and there is currently no previous example of the timer use
in the shared library.

Series https://patchwork.kernel.org/project/bluetooth/list/?series=351021
is up for review. Our next step here would be ripped off the unit test
for now and submit v5 of the series. Once we reach an conclusion on
advmon unit test, we can submit a separate series including the
refactoring and unit tests. Looking forward to any feedbacks. Thanks!

Regards,
Miao
