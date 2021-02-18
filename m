Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F27C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1064E2E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBRRZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 12:25:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36140 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhBROhZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 09:37:25 -0500
Received: from [123.112.65.49] (helo=[192.168.2.108])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1lCkPu-0002mS-Db; Thu, 18 Feb 2021 14:36:30 +0000
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
Date:   Thu, 18 Feb 2021 22:36:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210218123728.17067-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2/18/21 8:37 PM, Hans de Goede wrote:
> drivers/usb/core/hub.c: usb_new_device() contains the following:
[...]
>   
>   	err = hci_register_dev(hdev);
>   	if (err < 0)
> @@ -4688,9 +4688,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>   		gpiod_put(data->reset_gpio);
>   
>   	hci_free_dev(hdev);
> -
> -	if (!enable_autosuspend)
> -		usb_enable_autosuspend(data->udev);
Hi Hans,

And Do we need to call usb_disable_autosuspend() in the disconnect()? 
like below:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 32161dd40ed6..ef831492363c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4673,6 +4673,9 @@ static void btusb_disconnect(struct usb_interface 
*intf)

         hci_unregister_dev(hdev);

+       if (enable_autosuspend)
+               usb_disable_autosuspend(data->udev);
+
         if (intf == data->intf) {
                 if (data->isoc)
usb_driver_release_interface(&btusb_driver, data->isoc);


Before the btusb_probe() is called, the usb device is autosuspend 
disabled, suppose users set the btusb.enable_autosuspend=1, the driver 
btusb will enable the autosuspend on this device. If users remove this 
driver, the disconnect() will be called, the usb device will keep 
autosuspend enabled. Next time if users reload this driver by 'sudo 
modprobe  btusb enalbe_autosuspend=0',  they will find the device is 
autosuspend enabled instead of disabled.

Thanks.


>   }
>   
>   #ifdef CONFIG_PM
