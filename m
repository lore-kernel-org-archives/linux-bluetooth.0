Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328CBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DD22072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 07:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgHCH7b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:59:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56657 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHCH7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 03:59:31 -0400
Received: from [114.252.213.24] (helo=[192.168.0.104])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1k2VNY-0007Hb-Ae; Mon, 03 Aug 2020 07:59:28 +0000
Subject: Re: [PATCH] Bluetooth: btusb: Add a module parameter ignore_id for
 debugging
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
References: <20200802042138.9149-1-hui.wang@canonical.com>
 <432B3E10-052D-4DCB-84A4-B239D218D4E5@holtmann.org>
 <8c625767-7211-2b41-7673-33e641c2924e@canonical.com>
 <636EB5CB-7A63-4C3B-A053-D59EA73FF1F2@holtmann.org>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <301c3ace-fa24-85af-8913-c692d2dcd071@canonical.com>
Date:   Mon, 3 Aug 2020 15:59:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <636EB5CB-7A63-4C3B-A053-D59EA73FF1F2@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2020/8/3 下午2:45, Marcel Holtmann wrote:
> Hi Hui,
>
>>>> There is always an on-board usb bluetooth hci on the laptops, if
>>>> the bluetooth function doesn't work well like a bt headset can't work
>>>> with HSP/HFP mode, we often plug an external usb BT hci to verify if
>>>> that headset could work with the exteral BT hci or not, in this
>>>> situation, there will be 2 hcis (hci0 and hci1) in the system, and
>>>> so far, the gnome can't handle the hci1 well so we met lots of
>>>> problems when debugging with hci1 under gnome.
>>>>
>>>> After adding this new module parameter, we could ban the on-board
>>>> usb hci by putting btusb.ignore_id=idVendor,idProduct to the bootargs,
>>>> then the external usb hci will be hci0 and there is only one hci
>>>> in the system. We could easily debug with the external usb bluetooth
>>>> hci after this change.
>>>>
>>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 11 +++++++++++
>>>> 1 file changed, 11 insertions(+)
>>> please use this instead.
>>>
>>> echo “vvvv pppp 0 08fd 0002" > /sys/bus/usb/drivers/foo/new_id
>> Thanks,  but to run the command above,  the system should boot up first.  After the system boot up, the btusb is already loaded and and the on-board hci is already driven by btusb. looks like it is too late to run that command for on-board hci.
> then unload the module first or blacklist the module.

Sorry,  still don't understand.  After unload/blacklist the module, 
there will be no /sys/bus/usb/drivers/foo/new_id. Once we load the 
module, the on-board hci will be driven by the module immediately. Looks 
like setting new_id is only useful for USB dongles, for on-board usb 
devices,  I have no idea how to use the new_id.

Thanks,

Hui.

>
> Regards
>
> Marcel
>
