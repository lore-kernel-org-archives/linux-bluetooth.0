Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B033C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA3A20738
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 06:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHCGpw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:45:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55431 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCGpw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 02:45:52 -0400
Received: from marcel-macpro.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9AFA7CED39;
        Mon,  3 Aug 2020 08:55:53 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a module parameter ignore_id for
 debugging
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <8c625767-7211-2b41-7673-33e641c2924e@canonical.com>
Date:   Mon, 3 Aug 2020 08:45:50 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <636EB5CB-7A63-4C3B-A053-D59EA73FF1F2@holtmann.org>
References: <20200802042138.9149-1-hui.wang@canonical.com>
 <432B3E10-052D-4DCB-84A4-B239D218D4E5@holtmann.org>
 <8c625767-7211-2b41-7673-33e641c2924e@canonical.com>
To:     Hui Wang <hui.wang@canonical.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hui,

>>> There is always an on-board usb bluetooth hci on the laptops, if
>>> the bluetooth function doesn't work well like a bt headset can't work
>>> with HSP/HFP mode, we often plug an external usb BT hci to verify if
>>> that headset could work with the exteral BT hci or not, in this
>>> situation, there will be 2 hcis (hci0 and hci1) in the system, and
>>> so far, the gnome can't handle the hci1 well so we met lots of
>>> problems when debugging with hci1 under gnome.
>>> 
>>> After adding this new module parameter, we could ban the on-board
>>> usb hci by putting btusb.ignore_id=idVendor,idProduct to the bootargs,
>>> then the external usb hci will be hci0 and there is only one hci
>>> in the system. We could easily debug with the external usb bluetooth
>>> hci after this change.
>>> 
>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>> please use this instead.
>> 
>> echo “vvvv pppp 0 08fd 0002" > /sys/bus/usb/drivers/foo/new_id
> 
> Thanks,  but to run the command above,  the system should boot up first.  After the system boot up, the btusb is already loaded and and the on-board hci is already driven by btusb. looks like it is too late to run that command for on-board hci.

then unload the module first or blacklist the module.

Regards

Marcel

