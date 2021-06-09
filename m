Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B05C48BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD9F613F3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhFITZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:25:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60155 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITZA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 15:25:00 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5124BCECD6;
        Wed,  9 Jun 2021 21:31:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] Bluetooth: HCI: Fix Set Extended (Scan Response) Data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210609180927.179265-1-luiz.dentz@gmail.com>
Date:   Wed, 9 Jun 2021 21:23:03 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <74BFE4B6-E0DD-4836-9AE0-20D9D34F0BC2@holtmann.org>
References: <20210609180927.179265-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> These command do have variable length and the length can go up to 251,
> so this changes the struct to not use a fixed size and then when
> creating the PDU only the actual length of the data send to the
> controller.
> 
> Fixes: a0fb3726ba551 ("Bluetooth: Use Set ext adv/scan rsp data if
> controller supports")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h      |  6 ++--
> include/net/bluetooth/hci_core.h |  8 ++---
> net/bluetooth/hci_request.c      | 51 ++++++++++++++++++--------------
> 3 files changed, 37 insertions(+), 28 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

