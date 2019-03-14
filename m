Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11010C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FBB20811
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCNRt1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:49:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53927 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfCNRtS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 13:49:18 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2E08CCEE92;
        Thu, 14 Mar 2019 18:57:16 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix not initializing tx_credits
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190314134337.26647-1-luiz.dentz@gmail.com>
Date:   Thu, 14 Mar 2019 18:49:16 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <15333712-63E1-4D74-A18C-AE6AF5313377@holtmann.org>
References: <20190314134337.26647-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> l2cap_le_flowctl_init was reseting the tx_credits which works only for
> outgoing connection since that set the tx_credits on the response, for
> incoming connections that was not the case which leaves the channel
> without any credits causing it to be suspended.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

