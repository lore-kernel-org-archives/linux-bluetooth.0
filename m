Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F0CC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32BD6134F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhFNUYr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:24:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43777 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhFNUYj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 16:24:39 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 748C4CECDF;
        Mon, 14 Jun 2021 22:30:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] Bluetooth: SMP: Fix crash when receiving new
 connection when debug is enabled
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210614174644.1259909-1-luiz.dentz@gmail.com>
Date:   Mon, 14 Jun 2021 22:22:30 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <87DEADEE-2B40-4AA2-A071-97BB49DCFEA2@holtmann.org>
References: <20210614174644.1259909-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> When receiving a new connection pchan->conn won't be initialized so the
> code cannot use bt_dev_dbg as the pointer to hci_dev won't be
> accessible.
> 
> Fixes: 2e1614f7d61e4 ("Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/smp.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

