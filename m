Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3ECC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 22:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiAUWxH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 17:53:07 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40068 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiAUWxH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 17:53:07 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 92673CED1A;
        Fri, 21 Jan 2022 23:53:05 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_sync: unlock on error in
 hci_inquiry_result_with_rssi_evt()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220111072319.GH11243@kili>
Date:   Fri, 21 Jan 2022 23:53:05 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5202DA51-7BA4-41F1-BECA-858B894EC4F0@holtmann.org>
References: <20220111072319.GH11243@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> Add unlocks to two error paths in hci_inquiry_result_with_rssi_evt().
> 
> Fixes: fee645033e2c ("Bluetooth: hci_event: Use skb_pull_data when processing inquiry results")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> net/bluetooth/hci_event.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch doesn’t apply cleanly, please rebase against bluetooth-next tree.

Regards

Marcel

