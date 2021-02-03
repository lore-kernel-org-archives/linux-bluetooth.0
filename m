Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A81C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB2C64F60
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 13:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhBCNgC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 08:36:02 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59774 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhBCNf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 08:35:29 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 92482CECFC;
        Wed,  3 Feb 2021 14:42:09 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix the autosuspend enable and disable
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210203080245.5168-1-hui.wang@canonical.com>
Date:   Wed, 3 Feb 2021 14:34:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <15090265-7150-479D-8BC2-1D5CA83E5956@holtmann.org>
References: <20210203080245.5168-1-hui.wang@canonical.com>
To:     Hui Wang <hui.wang@canonical.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hui,

> I tried to disable the autosuspend on btusb through the module
> parameter enable_autosuspend, this parameter is set to N, but the usb
> bluetooth device is still runtime suspended.
> $ cat /sys/module/btusb/parameters/enable_autosuspend
> N
> $ cat /sys/bus/usb/devices/3-10/power/runtime_status
> suspended
> $ cat /sys/bus/usb/devices/3-10/power/runtime_suspended_time
> 65187
> 
> We already set ".supports_autosuspend = 1" in the usb_driver, this
> device will be set autosuspend enabled by usb core, we don't need
> to call usb_enable_autosuspend() in the btusb_probe(). Instead if
> users set the parameter enable_autosuspend to N, we need to call
> usb_disable_autosuspend() in the btusb_probe(). After this change
> and set the parameter to N, we could see the device is not runtime
> suspended anymore.
> $ cat /sys/module/btusb/parameters/enable_autosuspend
> N
> $ cat /sys/bus/usb/devices/3-10/power/runtime_status
> active
> $ cat /sys/bus/usb/devices/3-10/power/runtime_suspended_time
> 0
> 
> And if we disable the autosuspend in the btusb_probe(), we need to
> enable the autosuspend in the disconnect(), this could guarantee
> that the device could be runtime suspended after we rmmod the btusb.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

