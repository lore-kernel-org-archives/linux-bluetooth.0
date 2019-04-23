Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F45C10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A798206BA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 15:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfDWP5X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:57:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36340 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWP5X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 11:57:23 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4018BCF2CC;
        Tue, 23 Apr 2019 18:05:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] build: Bump glib dependency to 2.32
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1915942.yPAXW0zZuX@ix>
Date:   Tue, 23 Apr 2019 17:57:21 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <4BF0EB1B-B683-409B-A60F-1D3B6797AC83@holtmann.org>
References: <20190419105146.29272-1-szymon.janc@codecoup.pl>
 <CABBYNZKM4jFa=e=A3PWmvtJpQznW3rLJ172eU7GBW6ekZd2u1Q@mail.gmail.com>
 <1915942.yPAXW0zZuX@ix>
To:     Szymon Janc <szymon.janc@codecoup.pl>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

>>> make --no-print-directory all-am
>>> 
>>>  CC       client/main.o
>>> 
>>> In file included from /usr/include/glib-2.0/glib/gasyncqueue.h:32,
>>> 
>>>                 from /usr/include/glib-2.0/glib.h:32,
>> 
>>>                 from client/main.c:36:
>> Weird it seems to be triggering the use of a deprecated API on its
>> own? That would be a bug in glib, also weird it did not trigger to
>> other tools only for client.
> 
> Yes, this looks like bug in glib but unfortunatelly that is the version 
> shipped with Ubuntu 19.04...
> 
> It triggers for other files too, this is just first in line in case of single 
> thread build.

I am against this change. Can someone fix Ubuntu please. Or we just start aggressively moving towards ELL and get rid of GLib.

Regards

Marcel

