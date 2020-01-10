Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6459BC282DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4494C20838
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgAJVFQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:05:16 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:52242 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgAJVFP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 16:05:15 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1iq1Sy-0002du-00; Fri, 10 Jan 2020 21:05:12 +0000
Date:   Fri, 10 Jan 2020 16:05:12 -0500
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Guy Harris <guy@alum.mit.edu>
Subject: Re: [PATCH] hcidump: add support for time64 based libc
Message-ID: <20200110210512.GB30412@brightrain.aerifal.cx>
References: <20200110204903.3495832-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110204903.3495832-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 10, 2020 at 09:49:03PM +0100, Arnd Bergmann wrote:
> musl is moving to a default of 64-bit time_t on all architectures,
> glibc will follow later. This breaks reading timestamps through cmsg
> data with the HCI_TIME_STAMP socket option.
> 
> Change both copies of hcidump to work on all architectures.  This also
> fixes x32, which has never worked, and carefully avoids breaking sparc64,
> which is another special case.

Won't it be broken on rv32 though? Based on my (albeit perhaps
incomplete) reading of the thread, I think use of HCI_TIME_STAMP
should just be dropped entirely in favor of using SO_TIMESTAMPNS -- my
understanding was that it works with bluetooth sockets too.

Rich
