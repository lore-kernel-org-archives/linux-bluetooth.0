Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04666C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FEC60EE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhJLP4f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:56:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41950 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhJLP4f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 11:56:35 -0400
Received: from smtpclient.apple (p4fefcb73.dip0.t-ipconnect.de [79.239.203.115])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9DA0ACECE1;
        Tue, 12 Oct 2021 17:54:32 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: Fix memory leak of hci device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211012075634.8041-1-weiyongjun1@huawei.com>
Date:   Tue, 12 Oct 2021 17:54:32 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3EC78E44-6E60-4B99-B880-2F5CC468C424@holtmann.org>
References: <20211012075634.8041-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Wei,

> Fault injection test reported memory leak of hci device as follows:
> 
> unreferenced object 0xffff88800b858000 (size 8192):
>  comm "kworker/0:2", pid 167, jiffies 4294955747 (age 557.148s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
>  backtrace:
>    [<0000000070eb1059>] kmem_cache_alloc_trace mm/slub.c:3208
>    [<00000000015eb521>] hci_alloc_dev_priv include/linux/slab.h:591
>    [<00000000dcfc1e21>] bpa10x_probe include/net/bluetooth/hci_core.h:1240
>    [<000000005d3028c7>] usb_probe_interface drivers/usb/core/driver.c:397
>    [<00000000cbac9243>] really_probe drivers/base/dd.c:517
>    [<0000000024cab3f0>] __driver_probe_device drivers/base/dd.c:751
>    [<00000000202135cb>] driver_probe_device drivers/base/dd.c:782
>    [<000000000761f2bc>] __device_attach_driver drivers/base/dd.c:899
>    [<00000000f7d63134>] bus_for_each_drv drivers/base/bus.c:427
>    [<00000000c9551f0b>] __device_attach drivers/base/dd.c:971
>    [<000000007f79bd16>] bus_probe_device drivers/base/bus.c:487
>    [<000000007bb8b95a>] device_add drivers/base/core.c:3364
>    [<000000009564d9ea>] usb_set_configuration drivers/usb/core/message.c:2171
>    [<00000000e4657087>] usb_generic_driver_probe drivers/usb/core/generic.c:239
>    [<0000000071ede518>] usb_probe_device drivers/usb/core/driver.c:294
>    [<00000000cbac9243>] really_probe drivers/base/dd.c:517
> 
> hci_alloc_dev() do not init the device's flag. And hci_free_dev()
> using put_device() to free the memory allocated for this device,
> but it calls just kfree(dev) only in case of HCI_UNREGISTER flag
> is set. So any error handing before hci_register_dev() success
> will cause memory leak.
> 
> To avoid this behaviour we need to set hdev HCI_UNREGISTER flag
> in hci_alloc_dev_priv().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8a47a3017d61..42410f568e90 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3876,6 +3876,11 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
> 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
> 	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
> 
> +	/* We need to set HCI_UNREGISTER flag to correctly release
> +	 * the device in hci_free_dev()
> +	 */
> +	hci_dev_set_flag(hdev, HCI_UNREGISTER);
> +

I can see the point in the bug report, but I don’t see that the fix is correct. Can you prove that this fix is correct when hci_register_dev is actually called.

Regards

Marcel

