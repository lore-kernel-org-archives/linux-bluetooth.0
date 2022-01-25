Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C97EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 21:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiAYVn2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:43:28 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40745 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiAYVn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 16:43:28 -0500
Received: from smtpclient.apple (p5b3d24e1.dip0.t-ipconnect.de [91.61.36.225])
        by mail.holtmann.org (Postfix) with ESMTPSA id 73E31CECF6;
        Tue, 25 Jan 2022 22:43:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220125185305.2419774-1-luiz.dentz@gmail.com>
Date:   Tue, 25 Jan 2022 22:43:27 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7251E650-FC10-4B60-8F04-6CE59E8140E8@holtmann.org>
References: <20220125185305.2419774-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> HCI_EV_VENDOR is in fact variable length since it acts as metaevent
> where a vendor can implement their own event sets.
> 
> In addition to it this makes use of bt_dev_warn_ratelimited to supress
> the amount of logging in case the event has more data than expected.
> 
> Fixes: 3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI event")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_event.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

