Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE07C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F190423602
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLRVXv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:23:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46253 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgLRVXv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 16:23:51 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7D292CED33;
        Fri, 18 Dec 2020 22:30:25 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: Always fallback to alt 1 for WBS
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201210012003.133000-1-tpiepho@gmail.com>
Date:   Fri, 18 Dec 2020 22:23:08 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7ADF39E2-647E-49E2-9C5B-B0BF6A303B95@holtmann.org>
References: <20201210012003.133000-1-tpiepho@gmail.com>
To:     Trent Piepho <tpiepho@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Trent,

> When alt mode 6 is not available, fallback to the kernel <= 5.7 behavior
> of always using alt mode 1.
> 
> Prior to kernel 5.8, btusb would always use alt mode 1 for WBS (Wide
> Band Speech aka mSBC aka transparent SCO).  In commit baac6276c0a9
> ("Bluetooth: btusb: handle mSBC audio over USB Endpoints") this
> was changed to use alt mode 6, which is the recommended mode in the
> Bluetooth spec (Specifications of the Bluetooth System, v5.0, Vol 4.B
> §2.2.1).  However, many if not most BT USB adapters do not support alt
> mode 6.  In fact, I have been unable to find any which do.
> 
> In kernel 5.8, this was changed to use alt mode 6, and if not available,
> use alt mode 0.  But mode 0 has a zero byte max packet length and can
> not possibly work.  It is just there as a zero-bandwidth dummy mode to
> work around a USB flaw that would prevent device enumeration if
> insufficient bandwidth were available for the lowest isoc mode
> supported.
> 
> In effect, WBS was broken for all USB-BT adapters that do not support
> alt 6, which appears to nearly all of them.
> 
> Then in commit 461f95f04f19 ("Bluetooth: btusb: USB alternate setting 1 for
> WBS") the 5.7 behavior was restored, but only for Realtek adapters.
> 
> I've tested a Broadcom BRCM20702A and CSR 8510 adapter, both work with
> the 5.7 behavior and do not with the 5.8.
> 
> So get rid of the Realtek specific flag and use the 5.7 behavior for all
> adapters as a fallback when alt 6 is not available.  This was the
> kernel's behavior prior to 5.8 and I can find no adapters for which it
> is not correct.  And even if there is an adapter for which this does not
> work, the current behavior would be to fall back to alt 0, which can not
> possibly work either, and so is no better.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 20 ++++++--------------
> 1 file changed, 6 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

