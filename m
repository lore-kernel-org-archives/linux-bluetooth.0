Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5F2206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbhAZFb3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40572 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbhAYPhC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 10:37:02 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 155E1CECC5;
        Mon, 25 Jan 2021 16:10:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY
 for btrtl
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210119114700.3662156-1-tientzu@chromium.org>
Date:   Mon, 25 Jan 2021 16:03:06 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>, Hilda Wu <hildawu@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <880F0A16-7F4C-40C1-924A-2CB7B1094B3D@holtmann.org>
References: <20210119114700.3662156-1-tientzu@chromium.org>
To:     Claire Chang <tientzu@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Claire,

> Realtek Bluetooth controllers can do both LE scan and BR/EDR inquiry
> at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> drivers/bluetooth/hci_h5.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

