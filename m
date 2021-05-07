Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE4C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 08:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6A26143C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 08:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhEGIay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 04:30:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46367 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhEGIax (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 04:30:53 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF206CECDB;
        Fri,  7 May 2021 10:37:41 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix failing to init controllers with
 operation firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210430230501.603111-1-luiz.dentz@gmail.com>
Date:   Fri, 7 May 2021 10:29:50 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <118B8A65-D113-4DB9-8B62-0C15CAFC8138@holtmann.org>
References: <20210430230501.603111-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Some firmware when operation don't may have broken versions leading to
> error like the following:
> 
> [    6.176482] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7
> 2021
> [    6.177906] bluetooth hci0: Direct firmware load for
> intel/ibt-20-0-0.sfi failed with error -2
> [    6.177910] Bluetooth: hci0: Failed to load Intel firmware file
> intel/ibt-20-0-0.sfi (-2)
> 
> Since we load the firmware file just to check if its version had changed
> comparing to the one already loaded we can just skip since the firmware
> is already operation.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

