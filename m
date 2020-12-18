Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA6C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458A923B7B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgLRV0w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:26:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48464 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgLRV0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 16:26:51 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id 22A9CCED33;
        Fri, 18 Dec 2020 22:33:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix a race for write_work scheduling
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201214072921.3402608-1-tientzu@chromium.org>
Date:   Fri, 18 Dec 2020 22:26:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        robh@kernel.org, sre@kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5E7BFFAA-B248-4C94-87FB-0E824D04C1BC@holtmann.org>
References: <20201214072921.3402608-1-tientzu@chromium.org>
To:     Claire Chang <tientzu@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claire,

> In hci_uart_write_work, there is a loop/goto checking the value of
> HCI_UART_TX_WAKEUP. If HCI_UART_TX_WAKEUP is set again, it keeps trying
> hci_uart_dequeue; otherwise, it clears HCI_UART_SENDING and returns.
> 
> In hci_uart_tx_wakeup, if HCI_UART_SENDING is already set, it sets
> HCI_UART_TX_WAKEUP, skips schedule_work and assumes the running/pending
> hci_uart_write_work worker will do hci_uart_dequeue properly.
> 
> However, if the HCI_UART_SENDING check in hci_uart_tx_wakeup is done after
> the loop breaks, but before HCI_UART_SENDING is cleared in
> hci_uart_write_work, the schedule_work is skipped incorrectly.
> 
> Fix this race by changing the order of HCI_UART_SENDING and
> HCI_UART_TX_WAKEUP modification.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 82f5169bf3d3 ("Bluetooth: hci_uart: add serdev driver support library")
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> drivers/bluetooth/hci_ldisc.c  | 7 +++----
> drivers/bluetooth/hci_serdev.c | 4 ++--
> 2 files changed, 5 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

