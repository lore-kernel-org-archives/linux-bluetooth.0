Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E51C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 01:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8AC64F24
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 01:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBZBGH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:06:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhBZBFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Feb 2021 20:05:53 -0500
Received: from [123.112.65.122] (helo=[192.168.0.106])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1lFRZ9-0000gF-P2; Fri, 26 Feb 2021 01:05:12 +0000
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <9e4478ca-aa70-8b93-3068-f11b5a2107a0@canonical.com>
Date:   Fri, 26 Feb 2021 09:05:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210218123728.17067-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Acked-by: Hui Wang <hui.wang@canonical.com>

On 2/18/21 8:37 PM, Hans de Goede wrote:
> drivers/usb/core/hub.c: usb_new_device() contains the following:
>
>          /* By default, forbid autosuspend for all devices.  It will be
>           * allowed for hubs during binding.
>           */
>          usb_disable_autosuspend(udev);
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
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/bluetooth/btusb.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 54a4f86f32e2..03b83aa91277 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4627,8 +4627,8 @@ static int btusb_probe(struct usb_interface *intf,
>   			data->diag = NULL;
>   	}
>   
> -	if (!enable_autosuspend)
> -		usb_disable_autosuspend(data->udev);
> +	if (enable_autosuspend)
> +		usb_enable_autosuspend(data->udev);
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
>   }
>   
>   #ifdef CONFIG_PM
