Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7E64EAD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBFP5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Feb 2021 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBFP5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Feb 2021 10:57:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB2C06174A;
        Sat,  6 Feb 2021 07:56:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sjoerd)
        with ESMTPSA id D0E811F40E84
Received: by dawn.luon.net (Postfix, from userid 1000)
        id 084DEC62B06; Sat,  6 Feb 2021 16:56:54 +0100 (CET)
Date:   Sat, 6 Feb 2021 16:56:53 +0100
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        kernel@collabora.com
Subject: Re: [PATCH] Bluetooth: btusb: Always fallback to alt 1 for WBS
Message-ID: <YB68RUVLRGQKS+yH@dawn.lan>
References: <20201210012003.133000-1-tpiepho@gmail.com>
 <7ADF39E2-647E-49E2-9C5B-B0BF6A303B95@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ADF39E2-647E-49E2-9C5B-B0BF6A303B95@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Dec 18, 2020 at 10:23:08PM +0100, Marcel Holtmann wrote:
> Hi Trent,
> 
> > When alt mode 6 is not available, fallback to the kernel <= 5.7 behavior
> > of always using alt mode 1.
> > 
> > Prior to kernel 5.8, btusb would always use alt mode 1 for WBS (Wide
> > Band Speech aka mSBC aka transparent SCO).  In commit baac6276c0a9
> > ("Bluetooth: btusb: handle mSBC audio over USB Endpoints") this
> > was changed to use alt mode 6, which is the recommended mode in the
> > Bluetooth spec (Specifications of the Bluetooth System, v5.0, Vol 4.B
> > §2.2.1).  However, many if not most BT USB adapters do not support alt
> > mode 6.  In fact, I have been unable to find any which do.

> patch has been applied to bluetooth-next tree.

For easier application to the stable tree(s) this should probably get:
  Fixes: baac6276c0a9 ("Bluetooth: btusb: handle mSBC audio over USB Endpoints")

In my testing this indeed fixes mSBC audio with both a Belkin (Broadcom
BCM20702A, 050d:065a) and an Intel Bluetooth (8087:0a2b) adapters.

  Tested-By: Sjoerd Simons <sjoerd@collabora.com>

Regards,
  Sjoerd
