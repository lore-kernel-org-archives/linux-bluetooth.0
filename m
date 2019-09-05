Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBCDC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F027206B8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 15:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbfIEP3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:29:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52552 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfIEP3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 11:29:11 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9692CCECD1;
        Thu,  5 Sep 2019 17:37:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Fix an issue that failing to
 download the FW which size is over 32K bytes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190905052157.2052-1-max.chou@realtek.com>
Date:   Thu, 5 Sep 2019 17:29:09 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, alex_lu@realsil.com.cn
Content-Transfer-Encoding: 7bit
Message-Id: <49091C5B-1211-45DC-8249-715340CD6314@holtmann.org>
References: <20190905052157.2052-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> Fix the issue that when the FW size is 32K+, it will fail for the download
> process because of the incorrect index.
> 
> When firmware patch length is over 32K, "dl_cmd->index" may >= 0x80. It
> will be thought as "data end" that download process will not complete.
> However, driver should recount the index from 1.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> Changes in v2:
> - Added the comment for commit message
> - Remove the extra variable
> 
> drivers/bluetooth/btrtl.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

