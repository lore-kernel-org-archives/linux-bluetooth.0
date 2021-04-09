Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22411C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05476115B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhDINp1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:45:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46857 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDINp0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 09:45:26 -0400
Received: from marcel-macbook.holtmann.net (p5b3d235a.dip0.t-ipconnect.de [91.61.35.90])
        by mail.holtmann.org (Postfix) with ESMTPSA id 57B1FCECC3;
        Fri,  9 Apr 2021 15:52:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH 5.12 regression fix resend 1/1] Bluetooth: btusb: Revert
 Fix the autosuspend enable and disable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210405203533.17091-2-hdegoede@redhat.com>
Date:   Fri, 9 Apr 2021 15:45:12 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C8344B39-AED4-4F18-99F8-C822EA500FEC@holtmann.org>
References: <20210405203533.17091-1-hdegoede@redhat.com>
 <20210405203533.17091-2-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> drivers/usb/core/hub.c: usb_new_device() contains the following:
> 
>        /* By default, forbid autosuspend for all devices.  It will be
>         * allowed for hubs during binding.
>         */
>        usb_disable_autosuspend(udev);
> 
> So for anything which is not a hub, such as btusb devices, autosuspend is
> disabled by default and we must call usb_enable_autosuspend(udev) to
> enable it.
> 
> This means that the "Fix the autosuspend enable and disable" commit,
> which drops the usb_enable_autosuspend() call when the enable_autosuspend
> module option is true, is completely wrong, revert it.
> 
> This reverts commit 7bd9fb058d77213130e4b3e594115c028b708e7e.
> 
> Cc: Hui Wang <hui.wang@canonical.com>
> Fixes: 7bd9fb058d77 ("Bluetooth: btusb: Fix the autosuspend enable and disable")
> Acked-by: Hui Wang <hui.wang@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)

since we are already at -rc6, I think it makes more sense that you send it directly to Linus for inclusion.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

