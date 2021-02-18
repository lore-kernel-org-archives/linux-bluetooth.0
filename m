Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A19DC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D819264EB6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBRWGY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBRWGX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 17:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613685896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+U6B/xWVZLn93Gyql2CCv6bDVOtEzXPJ1zRqxRggkk=;
        b=AHRQPzEK5LivWRmaX8AARagihp/7F7UF+7Y48QtIQ4KELWSkyLA2jFrfX1vXbOVOz92hFU
        0BGbXAGpEOlDhQDCQ+Zf/l9Lw9bKQFaHLSQ14Pxyeq27yYTluvNciSobVVZHnI1nNaNSza
        TK0lDkkb6TZtWWBoReznawXppFz13BQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-UzDTji66MoKQQHmsxs0QzQ-1; Thu, 18 Feb 2021 17:04:54 -0500
X-MC-Unique: UzDTji66MoKQQHmsxs0QzQ-1
Received: by mail-wr1-f71.google.com with SMTP id w11so1559844wrp.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Feb 2021 14:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6+U6B/xWVZLn93Gyql2CCv6bDVOtEzXPJ1zRqxRggkk=;
        b=tAH5ow/4DU+QqejBtBRCCQjm89dEaBwGhIZVvOg0y5T3P+l6HGqx2Zi1z6FLvEBtsj
         +NwkuSkLUoPMdKHgJYlv7v7gfTbTVA+UzDI0zccqoroLqdscwb3kyCJik2tg6f22/tMU
         SIIKZ3HdaDgx+GwqkkTho5gYabxNF8Y9o8Kbkg3/JG52rXM98eo0KPp8pQQS8rx4jkgD
         Ky7BjJoSojm8uUEJoBoEGkFMkJxOImiCMAUG/uKrWcQhv70XGCeO4hnCi4jikDErRu1v
         WC0UKL5pGnlaSNhfS+reahYN5Axo5kkiDyl4PrKH3ma9T/LqtVt9606OTD7WRUanuAUu
         ed7w==
X-Gm-Message-State: AOAM530FpKexxDkbdLmmkgN0eYmME8gjdwVYfwnZtchSSCsSiluLWocU
        eXExgQhdrnNZigZddPs8ErE6Upl8DImAaNG0O3N/bO2tBOhihLm10D5RFpnE/PWyF9ZQF47GEjU
        rhe/TETeq6D4MzviAi05L7yL4OmVxuCng9S8g0ox5XMW+Tqd9iH5S4snSR19QrxGANCh806oWBm
        fZvIGz
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr5992684edt.160.1613685892195;
        Thu, 18 Feb 2021 14:04:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDpwnuig1oK5r6UnQ+964mKqhXJ6p8I/f/npk0172GtIa/YMdXjHw53hO+qExoubXL9T9rUw==
X-Received: by 2002:aa7:c9c9:: with SMTP id i9mr5992659edt.160.1613685891943;
        Thu, 18 Feb 2021 14:04:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id de33sm2923055ejc.37.2021.02.18.14.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 14:04:51 -0800 (PST)
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Hui Wang <hui.wang@canonical.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
 <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
 <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
 <6CE927B6-449A-472C-9196-AF98895AA5E1@holtmann.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2bf12891-eeae-e55f-ab46-7434dffbad76@redhat.com>
Date:   Thu, 18 Feb 2021 23:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6CE927B6-449A-472C-9196-AF98895AA5E1@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 2/18/21 9:01 PM, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>> drivers/usb/core/hub.c: usb_new_device() contains the following:
>>> [...]
>>>>         err = hci_register_dev(hdev);
>>>>       if (err < 0)
>>>> @@ -4688,9 +4688,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>>>>           gpiod_put(data->reset_gpio);
>>>>         hci_free_dev(hdev);
>>>> -
>>>> -    if (!enable_autosuspend)
>>>> -        usb_enable_autosuspend(data->udev);
>>> Hi Hans,
>>>
>>> And Do we need to call usb_disable_autosuspend() in the disconnect()? like below:
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 32161dd40ed6..ef831492363c 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -4673,6 +4673,9 @@ static void btusb_disconnect(struct usb_interface *intf)
>>>
>>>         hci_unregister_dev(hdev);
>>>
>>> +       if (enable_autosuspend)
>>> +               usb_disable_autosuspend(data->udev);
>>> +
>>>         if (intf == data->intf) {
>>>                 if (data->isoc)
>>> usb_driver_release_interface(&btusb_driver, data->isoc);
>>>
>>>
>>> Before the btusb_probe() is called, the usb device is autosuspend disabled, suppose users set the btusb.enable_autosuspend=1, the driver btusb will enable the autosuspend on this device. If users remove this driver, the disconnect() will be called, the usb device will keep autosuspend enabled. Next time if users reload this driver by 'sudo modprobe  btusb enalbe_autosuspend=0',  they will find the device is autosuspend enabled instead of disabled.
>>
>> The problem with calling usb_disable_autosuspend() is that the auto-suspend setting is a bool,
>> rather then a counter, so if a udev-rule or the user manually through e.g. :
>>
>> echo auto > /sys/bus/usb/devices/1-10/power/control
>>
>> Has enabled autosuspend then we would be disabling it, which is undesirable.
>>
>> Most USB drivers which have some way of enabling autosuspend by-default
>> (IOW which call usb_enable_autosuspend()) simply enable it at the end
>> of a successful probe and leave it as is on remove.
>>
>> Also keep in mind that remove normally runs on unplug of the device, in
>> which case it does not matter as the device is going away.
>>
>> If a user wants to disable autosuspend after loading the btusb module,
>> the correct way to do this is by simply running e.g. :
>>
>> echo on > /sys/bus/usb/devices/1-10/power/control
>>
>> Rather then rmmod-ing and insmod-ing the module with a different module-param value.
> 
> then lets remove the module parameter from btusb.ko.

The module parameter is useful to make sure runtime-suspend never gets
enabled starting from boot onwards, either through the kernel cmdline
or through modprobe.conf settings.

Also the module parameter is used to implement CONFIG_BT_HCIBTUSB_AUTOSUSPEND
Kconfig option which sets the default value for the module param;
and most distros enable that option since it having autosuspend enabled
is the right thing to do in almost all cases.

Regards,

Hans

