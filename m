Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DBFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9195C64E79
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 17:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBRR2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Feb 2021 12:28:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38267 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhBRPpH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Feb 2021 10:45:07 -0500
Received: from 1.general.hwang4.us.vpn ([10.172.67.16])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1lClTX-0008Pr-8U; Thu, 18 Feb 2021 15:44:20 +0000
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
 <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
 <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <4ac9d25d-c928-60fa-e418-178f546f179b@canonical.com>
Date:   Thu, 18 Feb 2021 23:43:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2/18/21 11:02 PM, Hans de Goede wrote:
> Hi,
>
> On 2/18/21 3:36 PM, Hui Wang wrote:
>> On 2/18/21 8:37 PM, Hans de Goede wrote:
>>> drivers/usb/core/hub.c: usb_new_device() contains the following:
>> [...]
>>>          err = hci_register_dev(hdev);
>>>        if (err < 0)
>>> @@ -4688,9 +4688,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>>>            gpiod_put(data->reset_gpio);
>>>          hci_free_dev(hdev);
>>> -
>>> -    if (!enable_autosuspend)
>>> -        usb_enable_autosuspend(data->udev);
>> Hi Hans,
>>
>> And Do we need to call usb_disable_autosuspend() in the disconnect()? like below:
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 32161dd40ed6..ef831492363c 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -4673,6 +4673,9 @@ static void btusb_disconnect(struct usb_interface *intf)
>>
>>          hci_unregister_dev(hdev);
>>
>> +       if (enable_autosuspend)
>> +               usb_disable_autosuspend(data->udev);
>> +
>>          if (intf == data->intf) {
>>                  if (data->isoc)
>> usb_driver_release_interface(&btusb_driver, data->isoc);
>>
>>
>> Before the btusb_probe() is called, the usb device is autosuspend disabled, suppose users set the btusb.enable_autosuspend=1, the driver btusb will enable the autosuspend on this device. If users remove this driver, the disconnect() will be called, the usb device will keep autosuspend enabled. Next time if users reload this driver by 'sudo modprobe  btusb enalbe_autosuspend=0',  they will find the device is autosuspend enabled instead of disabled.
> The problem with calling usb_disable_autosuspend() is that the auto-suspend setting is a bool,
> rather then a counter, so if a udev-rule or the user manually through e.g. :
>
> echo auto > /sys/bus/usb/devices/1-10/power/control
>
> Has enabled autosuspend then we would be disabling it, which is undesirable.
>
> Most USB drivers which have some way of enabling autosuspend by-default
> (IOW which call usb_enable_autosuspend()) simply enable it at the end
> of a successful probe and leave it as is on remove.
>
> Also keep in mind that remove normally runs on unplug of the device, in
> which case it does not matter as the device is going away.
>
> If a user wants to disable autosuspend after loading the btusb module,
> the correct way to do this is by simply running e.g. :
>
> echo on > /sys/bus/usb/devices/1-10/power/control
>
> Rather then rmmod-ing and insmod-ing the module with a different module-param value.

Got it, thanks for your explanation.

Thanks,

Hui.

>
> Regards,
>
> Hans
>
>
>
>
