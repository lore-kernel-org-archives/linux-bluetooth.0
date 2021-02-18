Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A21264EAD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 14:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhBROAu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 09:00:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhBRNd4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 08:33:56 -0500
Received: from [123.112.65.49] (helo=[192.168.2.108])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1lCjQI-0007Mq-EE; Thu, 18 Feb 2021 13:32:50 +0000
Subject: Re: [PATCH 5.12 regression fix 0/1] Bluetooth: btusb: Revert "Fix the
 autosuspend enable and disable"
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210218123728.17067-1-hdegoede@redhat.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <4762ccc8-457b-ae35-29ad-39a4e7e4d80e@canonical.com>
Date:   Thu, 18 Feb 2021 21:32:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210218123728.17067-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2/18/21 8:37 PM, Hans de Goede wrote:
> Hi All,
>
> >From the commit msg:
>
> """
> drivers/usb/core/hub.c: usb_new_device() contains the following:
>
>          /* By default, forbid autosuspend for all devices.  It will be
>           * allowed for hubs during binding.
>           */
>          usb_disable_autosuspend(udev);
>
> So for anything which is not a hub, such as btusb devices, autosuspend is
> disabled by default and we MUST call usb_enable_autosuspend(udev) to
> enable it.
>
> This means that the "Fix the autosuspend enable and disable" commit,
> which drops the usb_enable_autosuspend() call when the enable_autosuspend
> module option is true, is completely wrong, revert it.
> """
>
> Hui, I guess that what you were seeing is caused by:
> /lib/udev/hwdb.d/60-autosuspend-chromiumos.hwdb

Hi Hans,

You are right, the VID:PID of the BT adapter on my machine is in that 
file, the autosuspend is enabled by udev instead of kernel. I tested on 
another machine whose BT adapter's ID is not in that file, the 
autosuspend is controlled by btusb.enable_autosuspend=0.

Your reverting patch is correct.

> Which enables autosuspend on a bunch of USB devices based on VID:PID,
> overruling the kernel defaults. This is done to get better power-consumption
> with devices where it is known that it is safe to do this.
>   
> I guess that that the device you were testing this with is on that list.
> So the proper fix would be to edit that file and remove your VID:PID from it.
>
> Hui, also next time please try to Cc the original author of the code you
> are modifying. A simple "git blame drivers/bluetooth/btusb.c" would have
> found you commit eff2d68ca738 ("Bluetooth: btusb: Add a Kconfig option to
> enable USB autosuspend by default") and then you could have added me to
> the Cc and I could have nacked the patch before it got merged.
OK, got it. will be careful and will Cc to the original author next time.
> I happen to spot this this time since I was looking into some other
> btusb issue. But if I had not spotted this, this would have caused
> a significant power-consumption regression on many laptops.
>
> Btusb might not look like a big consumer, but if it does not autosuspend
> it often is the only USB device not autosuspending, keeping the XHCI
> controller awake, which in turn is keeping a whole power-plane awake on
> what once used to be the southbridge. At least on Skylake era hw this
> could lead to an extra idle powerconsumption of 1W. So a small change
> can cause a big impact.
>
> Regards,
>
> Hans
>     
>
