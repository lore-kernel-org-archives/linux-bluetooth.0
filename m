Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A59C83012
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579312073C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 17:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgK3RD4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:03:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36888 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgK3RDz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 12:03:55 -0500
Received: from [172.20.10.2] (tmo-111-84.customers.d1-online.com [80.187.111.84])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3FCBCCED17;
        Mon, 30 Nov 2020 18:10:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] MTK mt7921 driver upstream
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201130071655.31515-1-peter.tsao@mediatek.com>
Date:   Mon, 30 Nov 2020 18:03:12 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, mark-yw.chen@mediatek.com,
        justin.tsai@mediatek.com, can.chen@mediatek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BCEF6F87-2B01-49F6-9494-A08E75C9F1AD@holtmann.org>
References: <20201130071655.31515-1-peter.tsao@mediatek.com>
To:     peter.tsao@mediatek.com
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

every patch needs a proper commit message.

> Signed-off-by: Peter Tsao <peter.tsao@mediatek.com>
> ---
> drivers/bluetooth/btmtk_buffer_mode.c         |  263 +
> drivers/bluetooth/btmtk_main.c                | 5517 +++++++++++++++++
> drivers/bluetooth/include/btmtk_buffer_mode.h |   78 +
> drivers/bluetooth/include/btmtk_chip_if.h     |   30 +
> drivers/bluetooth/include/btmtk_define.h      |  304 +
> drivers/bluetooth/include/btmtk_drv.h         |  157 +
> drivers/bluetooth/include/btmtk_main.h        |  587 ++
> drivers/bluetooth/include/sdio/btmtk_sdio.h   |  147 +
> drivers/bluetooth/include/uart/btmtk_uart.h   |   86 +
> drivers/bluetooth/include/usb/btmtk_usb.h     |  100 +
> drivers/bluetooth/sdio/btmtksdio.c            | 2004 ++++++
> drivers/bluetooth/usb/btmtkusb.c              | 3218 ++++++++++
> 12 files changed, 12491 insertions(+)

The drivers/bluetooth/ is not your playground. Keep the structure flat.

> create mode 100644 drivers/bluetooth/btmtk_buffer_mode.c
> create mode 100644 drivers/bluetooth/btmtk_main.c
> create mode 100644 drivers/bluetooth/include/btmtk_buffer_mode.h
> create mode 100644 drivers/bluetooth/include/btmtk_chip_if.h
> create mode 100644 drivers/bluetooth/include/btmtk_define.h
> create mode 100644 drivers/bluetooth/include/btmtk_drv.h
> create mode 100644 drivers/bluetooth/include/btmtk_main.h
> create mode 100644 drivers/bluetooth/include/sdio/btmtk_sdio.h
> create mode 100644 drivers/bluetooth/include/uart/btmtk_uart.h
> create mode 100644 drivers/bluetooth/include/usb/btmtk_usb.h
> create mode 100644 drivers/bluetooth/sdio/btmtksdio.c
> create mode 100644 drivers/bluetooth/usb/btmtkusb.c

And this is too much in a single patch. Split this up.

This patch is not acceptable upstream in this form. Strip all your home grown debugging and duplicates out of the patch. And I am no longer accepting any line discipline drivers. So scrap that as well. Also any kind of snooping stuff is not needed since we have btmon.

In addition, what is wrong with the existing drivers?

Regards

Marcel

