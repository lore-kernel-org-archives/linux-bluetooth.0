Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04BC4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9789206B7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 06:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfI0G0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:26:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60387 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfI0G0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 02:26:53 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF4D7CECE9;
        Fri, 27 Sep 2019 08:35:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: btusb: print FW version after FW download
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1569552714-16091-2-git-send-email-amit.k.bag@intel.com>
Date:   Fri, 27 Sep 2019 08:26:51 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        Yoni Shavit <yshavit@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1E6570CE-3F3D-4B8A-B0A2-FAD4DE54EE31@holtmann.org>
References: <1569552714-16091-1-git-send-email-amit.k.bag@intel.com>
 <1569552714-16091-2-git-send-email-amit.k.bag@intel.com>
To:     Amit K Bag <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

> After FW download there is no print to confirm the current
> FW version. Add print to check FW version incase of FW download.
> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Yoni Shavit <yshavit@chromium.org>
> Signed-off-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

