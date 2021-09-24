Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F42C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661B860FDC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 09:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbhIXJij (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:38:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33970 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbhIXJii (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 05:38:38 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 59F6ACECF2;
        Fri, 24 Sep 2021 11:37:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 5.15 regression fix] Bluetooth: hci_h5: Fix
 (runtime)suspend issues on RTL8723BS HCIs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210920125739.111846-1-hdegoede@redhat.com>
Date:   Fri, 24 Sep 2021 11:37:03 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <5B663F6D-3856-4CC8-93D7-A16AE3F50C95@holtmann.org>
References: <20210920125739.111846-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> The recently added H5_WAKEUP_DISABLE h5->flags flag gets checked in
> h5_btrtl_open(), but it gets set in h5_serdev_probe() *after*
> calling  hci_uart_register_device() and thus after h5_btrtl_open()
> is called, set this flag earlier.
> 
> Also on devices where suspend/resume involves fully re-probing the HCI,
> runtime-pm suspend should not be used, make the runtime-pm setup
> conditional on the H5_WAKEUP_DISABLE flag too.
> 
> This fixes the HCI being removed and then re-added every 10 seconds
> because it was being reprobed as soon as it was runtime-suspended.
> 
> Cc: Archie Pusaka <apusaka@chromium.org>
> Fixes: 66f077dde749 ("Bluetooth: hci_h5: add WAKEUP_DISABLE flag")
> Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_h5.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

