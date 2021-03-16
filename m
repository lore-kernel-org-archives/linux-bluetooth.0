Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6974DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C165068
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCPOAi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:00:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53134 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhCPOAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:00:25 -0400
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5EA56CECFB;
        Tue, 16 Mar 2021 15:08:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3] Bluetooth: SMP: Convert BT_ERR/BT_DBG to
 bt_dev_err/bt_dev_dbg
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210315213929.1828052-1-luiz.dentz@gmail.com>
Date:   Tue, 16 Mar 2021 15:00:22 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <69CD33E1-AAEE-4151-A46E-FEA3FED19A30@holtmann.org>
References: <20210315213929.1828052-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This converts instances of BT_ERR and BT_DBG to bt_dev_err and
> bt_dev_dbg which can be enabled at runtime when BT_FEATURE_DEBUG is
> enabled.
> 
> Note: Not all instances could be converted as some are exercised by
> selftest.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fix issues found by CI
> v3: Remove instances of hdev->name since that is already printed by the likes
> of bt_dev_dbg.
> 
> net/bluetooth/smp.c | 98 ++++++++++++++++++++++++---------------------
> 1 file changed, 52 insertions(+), 46 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

