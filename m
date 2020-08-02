Return-Path: <SRS0=6lUD=BM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A923C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE142075B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHBO6X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:58:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54399 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHBO6V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Aug 2020 10:58:21 -0400
Received: from [192.168.1.151] (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id CC417CED2E;
        Sun,  2 Aug 2020 17:08:22 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a module parameter ignore_id for
 debugging
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200802042138.9149-1-hui.wang@canonical.com>
Date:   Sun, 2 Aug 2020 16:58:19 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <432B3E10-052D-4DCB-84A4-B239D218D4E5@holtmann.org>
References: <20200802042138.9149-1-hui.wang@canonical.com>
To:     Hui Wang <hui.wang@canonical.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hui,

> There is always an on-board usb bluetooth hci on the laptops, if
> the bluetooth function doesn't work well like a bt headset can't work
> with HSP/HFP mode, we often plug an external usb BT hci to verify if
> that headset could work with the exteral BT hci or not, in this
> situation, there will be 2 hcis (hci0 and hci1) in the system, and
> so far, the gnome can't handle the hci1 well so we met lots of
> problems when debugging with hci1 under gnome.
> 
> After adding this new module parameter, we could ban the on-board
> usb hci by putting btusb.ignore_id=idVendor,idProduct to the bootargs,
> then the external usb hci will be hci0 and there is only one hci
> in the system. We could easily debug with the external usb bluetooth
> hci after this change.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

please use this instead.

echo “vvvv pppp 0 08fd 0002" > /sys/bus/usb/drivers/foo/new_id

Regards

Marcel

