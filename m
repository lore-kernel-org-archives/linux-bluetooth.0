Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A0C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2924C60230
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhBRR1T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 12:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbhBRPET (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 10:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613660532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cg2pUie7n+Q+Ezf3SrEwB+M1qJkh4j5nEyDi0hYKZ3Q=;
        b=DAN1wuQE4WFLNE6EvEev+wi2JAyGmQLW2RpXIaZnTlFcSGYiXOFu6u+0aEs72N2l0kf+iL
        ZAAqFn5ALkSU+6IgOxAHASkbdXcXNFwo12H/If2LC6Ur+z0ClDygLvK2ykRCYsM5WyWa0O
        EOjbSmxC4Tpkl3YJW9qDhRc78P0W2dU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-c_fBaF34NU29F7I754BNIg-1; Thu, 18 Feb 2021 10:02:10 -0500
X-MC-Unique: c_fBaF34NU29F7I754BNIg-1
Received: by mail-ej1-f71.google.com with SMTP id h24so795208ejl.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 07:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cg2pUie7n+Q+Ezf3SrEwB+M1qJkh4j5nEyDi0hYKZ3Q=;
        b=cg881V3tbvyJu3Cm7EoxeFEU25FMyKltYeNIZU/oJH/71ZcqvKgmlRGDqW678Vh/O5
         ysZxEMH/p8kp49R59dyu7FB4+lQGeSrjSNyTAtj4uUuNEAj/4jFS0GsAo/gblT1DI92g
         J74Gt6oyhbYhmuG78v+KarLpX0TgQkjuy+hVL4f8MgVzApeVrj9mjszDBB/j2ECE1Loq
         ornjzGkP0TLe2M0UHIMwvAmwAR+KG9VQSj2/WuFOOLKBhq2OLc3fCTdOq7Fs8ivo4nt5
         lrnu4NciGkVgDCk2NGAoxZCOGeuJ+j1YY1uDa/lEeeP2Cm5Ijn+VGH2U+477fDTQACNq
         25rA==
X-Gm-Message-State: AOAM531tR9/IR9SpayqX+9FHpSp8rQkqJC/BfHkox8sOZbf/FYSVM9UN
        /pqhGH+kQ7sdDYPzsIq5jBlb68v+MVmO1d5sTtl7HlUo42VQYsx7HKvsCxG146pnbHwXsrj4+dz
        ssXCcIrNfu7sLYIjX2HqyopYL+kpl1p5H1rWZP6ZiRCto4mumKxsM60Fe6K8BtRwOlP6CgApMIN
        7GR3fK
X-Received: by 2002:a17:906:3885:: with SMTP id q5mr4404852ejd.105.1613660528238;
        Thu, 18 Feb 2021 07:02:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxKdwgQNxtPk6xmYgbqObS5kh5MiMjEEpcjtAwXPlfnFLQo4OVyfBQEsLXNA67avglLlD57Q==
X-Received: by 2002:a17:906:3885:: with SMTP id q5mr4404741ejd.105.1613660527136;
        Thu, 18 Feb 2021 07:02:07 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g8sm2921365edr.22.2021.02.18.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 07:02:06 -0800 (PST)
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hui Wang <hui.wang@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
 <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
Date:   Thu, 18 Feb 2021 16:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 2/18/21 3:36 PM, Hui Wang wrote:
> 
> On 2/18/21 8:37 PM, Hans de Goede wrote:
>> drivers/usb/core/hub.c: usb_new_device() contains the following:
> [...]
>>         err = hci_register_dev(hdev);
>>       if (err < 0)
>> @@ -4688,9 +4688,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>>           gpiod_put(data->reset_gpio);
>>         hci_free_dev(hdev);
>> -
>> -    if (!enable_autosuspend)
>> -        usb_enable_autosuspend(data->udev);
> Hi Hans,
> 
> And Do we need to call usb_disable_autosuspend() in the disconnect()? like below:
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 32161dd40ed6..ef831492363c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4673,6 +4673,9 @@ static void btusb_disconnect(struct usb_interface *intf)
> 
>         hci_unregister_dev(hdev);
> 
> +       if (enable_autosuspend)
> +               usb_disable_autosuspend(data->udev);
> +
>         if (intf == data->intf) {
>                 if (data->isoc)
> usb_driver_release_interface(&btusb_driver, data->isoc);
> 
> 
> Before the btusb_probe() is called, the usb device is autosuspend disabled, suppose users set the btusb.enable_autosuspend=1, the driver btusb will enable the autosuspend on this device. If users remove this driver, the disconnect() will be called, the usb device will keep autosuspend enabled. Next time if users reload this driver by 'sudo modprobe  btusb enalbe_autosuspend=0',  they will find the device is autosuspend enabled instead of disabled.

The problem with calling usb_disable_autosuspend() is that the auto-suspend setting is a bool,
rather then a counter, so if a udev-rule or the user manually through e.g. :

echo auto > /sys/bus/usb/devices/1-10/power/control

Has enabled autosuspend then we would be disabling it, which is undesirable.

Most USB drivers which have some way of enabling autosuspend by-default
(IOW which call usb_enable_autosuspend()) simply enable it at the end
of a successful probe and leave it as is on remove.

Also keep in mind that remove normally runs on unplug of the device, in
which case it does not matter as the device is going away.

If a user wants to disable autosuspend after loading the btusb module,
the correct way to do this is by simply running e.g. :

echo on > /sys/bus/usb/devices/1-10/power/control

Rather then rmmod-ing and insmod-ing the module with a different module-param value.

Regards,

Hans




