Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73425C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596E120760
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFJIHv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:07:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47231 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJIHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 04:07:51 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id A4B03CECE0;
        Wed, 10 Jun 2020 10:17:39 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/2] Bluetooth: Add support to read Intel debug feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200608122747.10714-1-kiran.k@intel.com>
Date:   Wed, 10 Jun 2020 10:07:49 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        kiraank@gmail.com, Chethan T N <chethan.tumkur.narayan@intel.com>,
        Ps AyappadasX <AyappadasX.Ps@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <42972942-78E2-4CE2-A8F4-085131A9B843@holtmann.org>
References: <20200608122747.10714-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> The command shall read the Intel controller supported
> debug feature. Based on the supported features additional debug
> configuration shall be enabled.
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Ps AyappadasX <AyappadasX.Ps@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> drivers/bluetooth/btintel.c | 33 +++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h | 15 +++++++++++++++
> drivers/bluetooth/btusb.c   |  7 ++++++-
> 3 files changed, 54 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

