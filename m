Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF96EC5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A125A20857
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKYOkY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 09:40:24 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35056 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYOkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 09:40:23 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0153ECED08;
        Wed, 25 Nov 2020 15:47:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: hci_core: Fix attempting to set RPA timeout
 when unsupported
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201027070203.13561-1-edwardvear@gmail.com>
Date:   Wed, 25 Nov 2020 15:40:20 +0100
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EA422B68-A287-430A-9B2C-3A56FC305A31@holtmann.org>
References: <20201027070203.13561-1-edwardvear@gmail.com>
To:     Edward Vear <edwardvear@gmail.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Edward,

> During controller initialization, an LE Set RPA Timeout command is sent
> to the controller if supported. However, the value checked to determine
> if the command is supported is incorrect. Page 1921 of the Bluetooth
> Core Spec v5.2 shows that bit 2 of octet 35 of the Supported_Commands
> field corresponds to the LE Set RPA Timeout command, but currently
> bit 6 of octet 35 is checked. This patch checks the correct value
> instead.
> 
> This issue led to the error seen in the following btmon output during
> initialization of an adapter (rtl8761b) and prevented initialization
> from completing.
> 
> < HCI Command: LE Set Resolvable Private Address Timeout (0x08|0x002e) plen 2
>        Timeout: 900 seconds
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 2
>        Status: Unsupported Remote Feature / Unsupported LMP Feature (0x1a)
> = Close Index: 00:E0:4C:6B:E5:03
> 
> The error did not appear when running with this patch.
> 
> Signed-off-by: Edward Vear <edwardvear@gmail.com>
> ---
> net/bluetooth/hci_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

