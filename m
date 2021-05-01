Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064EBC433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 03:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8EF6140C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 03:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhEADXY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhEADXY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 23:23:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0085C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 20:22:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t22so15424021pgu.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rM10aFpE/1ge7sndkWqbRhH3zQ7107GojcG00vkfB6I=;
        b=uCNlwdBiloiDyKVLlt98YMOUZRpM2rMGZAvaYaXwa4/lqGGlsF5KkxTp3xo9XSEu65
         lQFW1JrTogbdttwGJYAiY8UndC3DSVziaf3vb/Bz7m9Y3w9chQUS6emptDvDrriyb6pv
         uRHPP5qFtUpoZ3ai55bSptXihDgFXaSzYP+gI2ntoXm2i4gwK3+TVrShqAh918Y0k84/
         pw77HRhw/ShsF3V2D770vx9VKHJEUdvXWdDnzNM3Y6xNjKAs8NXZTG9fLwMX351qtc0P
         BJYb6ug0K8RPmJZa/t1VXUgbH2X9QWJSY4hBPhDywAwJ5KSyyvNU5qFRMUR4Sx7P0+A5
         fA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rM10aFpE/1ge7sndkWqbRhH3zQ7107GojcG00vkfB6I=;
        b=kEkuoL1Xcgat/e7zdcTPWKd8jOTq6FS/dqBs9hpu/Mpjnrdy4DF57VyYz1oHi0lCH1
         pS9HotF7OQdYc2e4b6QvckBXxUACjwnwgEetpGMCc2xHcCrRmWMThgDezqZ2ZqKbM964
         cZ7aTmHEeINzsFoJOFTU7ZIHCodfhVaJxpxjkhxuLi5fBc3ihZCnHquBEnkWqYAH0AaA
         Z3NWPr527JRfAHuxO2Jvch45pN8m9sBKBZdZ3I7MuojMgTe7I0VsCpM+06M/cyfmWMzQ
         +U7e4+JamIRxTEgf+7F5mwwuP2kEVZqFjzrGA9zZKaiRdiCHw50NOE6uXJo/16Tl48mG
         DmKA==
X-Gm-Message-State: AOAM5314ChbMbN80jG1+VQJKvcTwXwPjKtdgUg/v6Yg3jWtR+gnCx2Ti
        veO7SurMT9wG3SC/7A2M3So=
X-Google-Smtp-Source: ABdhPJxCQMhw3dNRVzioHUt5kfe2IeEPr/e6cI5txTnabhZGhG4KbnNdLg0rEaFBKiD5ZGiKSIv3TA==
X-Received: by 2002:a63:5322:: with SMTP id h34mr7798247pgb.182.1619839352277;
        Fri, 30 Apr 2021 20:22:32 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id n8sm3231856pfu.111.2021.04.30.20.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 20:22:31 -0700 (PDT)
Message-ID: <4b0030d99fd6698fd8d5a4e17b0df658a02e6788.camel@gmail.com>
Subject: Re: [BlueZ v2] monitor: Update manpage
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 30 Apr 2021 20:22:30 -0700
In-Reply-To: <BA960BC0-D602-4B59-BFF4-6ADF1B487081@holtmann.org>
References: <20210428062214.335567-1-hj.tedd.an@gmail.com>
         <CABBYNZJJHLZdhOFHrTHV7XN7++t4XKq3yHxS2wsi2bJ2AkRnVw@mail.gmail.com>
         <87c5b74558d3062f301dbfa28b93cdbfbe310dd2.camel@gmail.com>
         <CABBYNZKYDBQFqf8uVeXZNg-OVBks96fqRMk+8S+029Y26dSiow@mail.gmail.com>
         <BA960BC0-D602-4B59-BFF4-6ADF1B487081@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, 2021-05-01 at 03:59 +0200, Marcel Holtmann wrote:
> Hi Luiz,
> 
> > > > > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > > > > 
> > > > > This patch updates the manpage for btmon written in rst format.
> > > > > ---
> > > > > Makefile.am       |  26 ++++---
> > > > > Makefile.tools    |   4 ++
> > > > > configure.ac      |   4 ++
> > > > > doc/btmon.txt     |  35 ----------
> > > > > monitor/btmon.rst | 172 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > 
> > > > I do wonder why you change the location from doc to monitor, I think
> > > > we actually should keep all the documentation under doc and perhaps
> > > > even have a dedicated make target for those since we would likely want
> > > > to generate all the manpages from rst which may be time consuming so
> > > > people not interested on it can just skip it.
> > > 
> > > I converted all manpages in the tree to .rst and ready to submit.
> > > Can I combine all in this series or wait for this to merge first?
> > 
> > Have you added a make target for those? I really don't mind having the
> > manpages generated within the same location of the binary, although I
> > think it would be more organized to have it in one place, but a make
> > target would probably be a good practice.
> 
> the way how this works is that in a git tree they are always generated unless disabled or rst2man is not available. And in a tarball, the generated manual pages are shipped, which means they are not
> needed to be generated. So no specific make target required. Lets just copy what iwd repository doing since that is working fine.
> 
To align with iwd way, I suggest to make some changes in Makefile as well.
For example, disabling manpages are not working because the manpages are
added to dist_man_MANS without checking MANPAGES flags.

I converted all existing manpages to .rst format and ready to submit.
I will add them in this patch set.

> Regards
> 
> Marcel
> 

Regards,

Tedd

