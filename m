Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD84C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Feb 2022 15:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiBGPtg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386125AbiBGPqI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Feb 2022 10:46:08 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6433C0401CC
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 07:46:06 -0800 (PST)
Received: from smtpclient.apple (p4ff9f3e5.dip0.t-ipconnect.de [79.249.243.229])
        by mail.holtmann.org (Postfix) with ESMTPSA id 36A06CECF2;
        Mon,  7 Feb 2022 16:40:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] bluetooth: Add support for EP-B3536 USB Bluetooth adapter
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
Date:   Mon, 7 Feb 2022 16:40:36 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <850EDEB4-7C93-4F8E-AC41-701766BBE801@holtmann.org>
References: <a96af59d-089f-1018-74fc-355e96fcf0c3@c0rporation.com>
To:     Jack Murray <kernel@c0rporation.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jack,

> This patch adds support for the EP-B3536 USB bluetooth 5.1 adapter based
> on the 8761B chipset. The existing driver and firmware work fine for this
> device from what I can tell, so this patch just adds the vendor/product IDs
> for it to the supported device list.
> 
> Signed-off-by: Jack Murray <kernel@c0rporation.com>
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)

please send an updated version addressing the comments and include /sys/kernel/debug/usb/devices.

Regards

Marcel

