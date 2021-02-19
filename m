Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99ABC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Feb 2021 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D1964EAF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Feb 2021 09:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBSJZz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Feb 2021 04:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBSJZs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Feb 2021 04:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613726660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7WBxiYwJNyICmXp4vU0jM+OyXrzPTJXtEFMwAqP2nw=;
        b=hmQAF275aeZjIB3H6pY3sdzQVXRQrSX/f156O/B2F9nUke2vGJUQV/Ki4S+a5T3jinjztM
        bxUR3AsTPSEy9Jgm/e2xisl6GRiFDq88ngLS8sGSufdLc9nMu2yzb9obL568TID35TvWTt
        JQQYfhVc1zPtOzmB+JFzQdED4OIqdKE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-_3J2nQ4-MnmmfZ6dQNJcjA-1; Fri, 19 Feb 2021 04:24:19 -0500
X-MC-Unique: _3J2nQ4-MnmmfZ6dQNJcjA-1
Received: by mail-ej1-f71.google.com with SMTP id f3so25338eje.20
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 01:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7WBxiYwJNyICmXp4vU0jM+OyXrzPTJXtEFMwAqP2nw=;
        b=kOMv3RJdpy9xXPTT1PV458I2QST3JMb3ouaOp03bx9KqQarNRHQ86vb0NbIuUlwYUf
         aAyx5k04f/OYoXFc5O2uk9eHxm5V8ZhPpKTQBb2OFMPfUFL+WvtI5udtu9PND28aniUs
         /+fCtBXX9HocR7amVpPsyJ2KzH5//GuqoPHWA6ISiq6jkDi6nyqfUUdr/Q8Atug8bOgt
         4uTFvWtE9dE2JIArMaeLYQdWg/s6ifGlziT5V/HnBfRlBS5JvZaAtgOWXt3fG0rew/7/
         uJGF79XDqB+cBnCBUUW8Yav56Dhep35BREZEYfm1QxgCbgc9UWbB86SXOndTdgOn3YeR
         F5AQ==
X-Gm-Message-State: AOAM532Lth/W9QahWEbDSNqTDONT6LZBfPq9MlM8bGRSVjkGbxWH9oJ9
        qL5WARr1rKwvi9dRDRHH2lTzDnTkC2IHS4JzI3MWI1r5C37UyLZSL6afiXFr3l9XTumcsn7n1ds
        LK+wgbSPfBJsTCyFqOa9KowySAZeV1B5Gqympn4zOIpBpYeM2gxce2bAKj53XRwjpobJChiseTk
        APXSHp
X-Received: by 2002:a50:fa91:: with SMTP id w17mr8101267edr.195.1613726657371;
        Fri, 19 Feb 2021 01:24:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRO3Wh32NIQagKshB/MpFGjJLN61+Wb6aYM6TGR78ddl4OcPF+6GmOKSOHMaOyywKcRgr6PQ==
X-Received: by 2002:a50:fa91:: with SMTP id w17mr8101249edr.195.1613726657131;
        Fri, 19 Feb 2021 01:24:17 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cf25sm4258460ejb.71.2021.02.19.01.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:24:16 -0800 (PST)
Subject: Re: [PATCH 5.12 regression fix] Bluetooth: btusb: Revert Fix the
 autosuspend enable and disable
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Hui Wang <hui.wang@canonical.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20210218123728.17067-1-hdegoede@redhat.com>
 <20210218123728.17067-2-hdegoede@redhat.com>
 <90d8996d-a376-2e9c-37ce-ce50b8660fd1@canonical.com>
 <4510935f-a30b-445d-a048-683619f2855b@redhat.com>
 <6CE927B6-449A-472C-9196-AF98895AA5E1@holtmann.org>
 <2bf12891-eeae-e55f-ab46-7434dffbad76@redhat.com>
 <CABBYNZ+euV5rwx=LeLKOGSL0AwnPfE7paEHhNhMiUpXGYixgBw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2fc373c2-0255-63b6-3e4a-9aa83f6986e1@redhat.com>
Date:   Fri, 19 Feb 2021 10:24:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+euV5rwx=LeLKOGSL0AwnPfE7paEHhNhMiUpXGYixgBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 2/19/21 12:41 AM, Luiz Augusto von Dentz wrote:
> Hi Hans,
> 
> On Thu, Feb 18, 2021 at 2:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Marcel,
>>
>> On 2/18/21 9:01 PM, Marcel Holtmann wrote:
>>> Hi Hans,
>>>
>>>>>> drivers/usb/core/hub.c: usb_new_device() contains the following:
>>>>> [...]
>>>>>>         err = hci_register_dev(hdev);
>>>>>>       if (err < 0)
>>>>>> @@ -4688,9 +4688,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>>>>>>           gpiod_put(data->reset_gpio);
>>>>>>         hci_free_dev(hdev);
>>>>>> -
>>>>>> -    if (!enable_autosuspend)
>>>>>> -        usb_enable_autosuspend(data->udev);
>>>>> Hi Hans,
>>>>>
>>>>> And Do we need to call usb_disable_autosuspend() in the disconnect()? like below:
>>>>>
>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>>> index 32161dd40ed6..ef831492363c 100644
>>>>> --- a/drivers/bluetooth/btusb.c
>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>> @@ -4673,6 +4673,9 @@ static void btusb_disconnect(struct usb_interface *intf)
>>>>>
>>>>>         hci_unregister_dev(hdev);
>>>>>
>>>>> +       if (enable_autosuspend)
>>>>> +               usb_disable_autosuspend(data->udev);
>>>>> +
>>>>>         if (intf == data->intf) {
>>>>>                 if (data->isoc)
>>>>> usb_driver_release_interface(&btusb_driver, data->isoc);
>>>>>
>>>>>
>>>>> Before the btusb_probe() is called, the usb device is autosuspend disabled, suppose users set the btusb.enable_autosuspend=1, the driver btusb will enable the autosuspend on this device. If users remove this driver, the disconnect() will be called, the usb device will keep autosuspend enabled. Next time if users reload this driver by 'sudo modprobe  btusb enalbe_autosuspend=0',  they will find the device is autosuspend enabled instead of disabled.
>>>>
>>>> The problem with calling usb_disable_autosuspend() is that the auto-suspend setting is a bool,
>>>> rather then a counter, so if a udev-rule or the user manually through e.g. :
>>>>
>>>> echo auto > /sys/bus/usb/devices/1-10/power/control
>>>>
>>>> Has enabled autosuspend then we would be disabling it, which is undesirable.
>>>>
>>>> Most USB drivers which have some way of enabling autosuspend by-default
>>>> (IOW which call usb_enable_autosuspend()) simply enable it at the end
>>>> of a successful probe and leave it as is on remove.
>>>>
>>>> Also keep in mind that remove normally runs on unplug of the device, in
>>>> which case it does not matter as the device is going away.
>>>>
>>>> If a user wants to disable autosuspend after loading the btusb module,
>>>> the correct way to do this is by simply running e.g. :
>>>>
>>>> echo on > /sys/bus/usb/devices/1-10/power/control
>>>>
>>>> Rather then rmmod-ing and insmod-ing the module with a different module-param value.
>>>
>>> then lets remove the module parameter from btusb.ko.
>>
>> The module parameter is useful to make sure runtime-suspend never gets
>> enabled starting from boot onwards, either through the kernel cmdline
>> or through modprobe.conf settings.
>>
>> Also the module parameter is used to implement CONFIG_BT_HCIBTUSB_AUTOSUSPEND
>> Kconfig option which sets the default value for the module param;
>> and most distros enable that option since it having autosuspend enabled
>> is the right thing to do in almost all cases.
> 
> Actually in case we are connected we should probably disable
> autosuspend as some BT controllers don't seem to be able to transmit
> any data back to the host if the connection stays idle long enough to
> trigger auto suspend.

Do those controller accept connection requests from previously paired
devices, without them having to be woken from userspace first?

In my experience if controllers have this issue then these controller
falsely advertise USB remote wake-up support / has broken USB remote
wake-up support and devices will also not automatically (re)connect
without first going to the bluetooth control-panel in the desktop
which wakes-up the controller from the PC side.

The fix for these controllers would be to explicitly disable
remote-wakeup on these controllers by making a call like this:

	device_set_wakeup_capable(&data->udev->dev, false);

But only on controllers where we know the remote-wakeup is broken.

This will still allow the device to be runtime/auto-suspended when
bluetooth is disabled by the user, while disabling it when bluetooth
is enabled. This works this way because of the following btusb.c code:

static int btusb_open(struct hci_dev *hdev)
{
	...
	data->intf->needs_remote_wakeup = 1;
	...
}

static int btusb_close(struct hci_dev *hdev)
{
	...
	data->intf->needs_remote_wakeup = 0;
	...
}

Regards,

Hans

