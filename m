Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD22C4708A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A3613C9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhE0PZf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 11:25:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51617 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhE0PYe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 11:24:34 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4AB83CED35;
        Thu, 27 May 2021 17:30:50 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] Bluetooth: hci_h5: Add RTL8822CS capabilities
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210527151951.v2.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
Date:   Thu, 27 May 2021 17:22:53 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E1D8B7BD-2F62-4491-8289-BE925AB2B4D2@holtmann.org>
References: <20210527151951.v2.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> RTL8822 chipset supports WBS, and this information is conveyed in
> btusb.c. However, the UART driver doesn't have this information just
> yet.
> 
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ---
> 
> Changes in v2:
> * Add declaration for the case when CONFIG_BT_RTL is not enabled
> 
> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> drivers/bluetooth/btrtl.h  |  7 +++++++
> drivers/bluetooth/hci_h5.c |  5 +----
> 3 files changed, 24 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree ..

.. however I am not super happy with this. I think it is time that we clean this stuff up. The vendor support for Realtek is getting messy and I don’t like that.

Regards

Marcel

