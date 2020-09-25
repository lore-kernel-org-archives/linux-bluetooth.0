Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0EFC4727F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 06:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA74F235F8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 06:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgIYGrX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:47:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54609 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgIYGrX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 02:47:23 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLhVo-0002NN-R3
        for linux-bluetooth@vger.kernel.org; Fri, 25 Sep 2020 06:47:21 +0000
Received: by mail-pj1-f69.google.com with SMTP id ic18so1182154pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 23:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1xTU2HZT5ZPNiI5Nnwy9xhPoPtId/zzqXSdxC+Cmcjg=;
        b=gnpBN3Cv6fYhIS4z7+/tWSbB1lGurfH4uJw9Jxg5SYtwHB6+g/Wdf2dAizxuWySjsn
         qg9m225SMzPBljWtyeDFViABitUucQtclVA1f+3y8/lezsR3U+A98C0a7xZclKgUn3G6
         ZhOnBFnHaVRMI7LczXnFWJ6+iD6N+K1u6um8ia3eErkuLL9ITina36sw8H5eqOa3V26C
         gLXfJf2RPXkbmtZYSzuwJYYLo90+qsB0+QOhKX6TJ6MfFLMf//5FuBdzrkPQ64JEfL1Z
         PiCJ+qVMkmRy8VLvIBiFxqG6J4CQpCue7KWTZ3ySYRUq5JpNXbgpxuLgOp575Lmde+ep
         AJTQ==
X-Gm-Message-State: AOAM533N7NcUDNIPWs9asHBVcCqv5P8d/gA+bZXgZOgoM0ZqIUpb8OSz
        pozLSX8j8ofAsgPdbmjj2cqcj/C4HucTCtxUYQDxS2gJqPazY4x6XtbCrGQNjXj8fLBfZ815hJ8
        /rrEvKmp1dW5YrwgHJ6f9rIEL6YgX0fvKqAtsZAITDV/3JA==
X-Received: by 2002:a63:546:: with SMTP id 67mr2318261pgf.347.1601016438847;
        Thu, 24 Sep 2020 23:47:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjfwmtj2sXE6v3dl6Fh14Mdhm0zrkN3fRFPdybeheYNQfMQVEIyVo9Gev13sG84NTaS391yg==
X-Received: by 2002:a63:546:: with SMTP id 67mr2318235pgf.347.1601016438288;
        Thu, 24 Sep 2020 23:47:18 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id c185sm1423826pfb.123.2020.09.24.23.47.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:47:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2ce180be1cab4400bb792f5ff2384be7@realsil.com.cn>
Date:   Fri, 25 Sep 2020 14:47:14 +0800
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <73E1E197-21E6-452D-84A0-32B0DCBB8D65@canonical.com>
References: <2ce180be1cab4400bb792f5ff2384be7@realsil.com.cn>
To:     =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On Sep 25, 2020, at 14:40, 陆朱伟 <alex_lu@realsil.com.cn> wrote:
> 
> Hi Abhishek,
> 
>> On September 25, 2020 at 11:34, Abhishek Pandit-Subedi wrote:
>> 
>> + Alex Lu (who contributed the original change)
>> 
>> Hi Kai-Heng,
>> 
>> 
>> On Thu, Sep 24, 2020 at 12:10 AM Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>> 
>>> [+Cc linux-usb]
>>> 
>>> Hi Abhishek,
>>> 
>>>> On Sep 24, 2020, at 04:41, Abhishek Pandit-Subedi
>> <abhishekpandit@chromium.org> wrote:
>>>> 
>>>> Hi Kai-Heng,
>>>> 
>>>> Which Realtek controller is this on?'
>>> 
>>> The issue happens on 8821CE.
>>> 
>>>> 
>>>> Specifically for RTL8822CE, we tested without reset_resume being set
>>>> and that was causing the controller being reset without bluez ever
>>>> learning about it (resulting in devices being unusable without
>>>> toggling the BT power).
>>> 
>>> The reset is done by the kernel, so how does that affect bluez?
>>> 
>>> From what you described, it sounds more like runtime resume since bluez
>> is already running.
>>> If we need reset resume for runtime resume, maybe it's another bug
>> which needs to be addressed?
>> 
>> From btusb.c:
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-
>> next.git/tree/drivers/bluetooth/btusb.c#n4189
>> /* Realtek devices lose their updated firmware over global
>> * suspend that means host doesn't send SET_FEATURE
>> * (DEVICE_REMOTE_WAKEUP)
>> */
>> 
>> Runtime suspend always requires remote wakeup to be set and reset
>> resume isn't used there.
>> 
>> During system suspend, when remote wakeup is not set, RTL8822CE loses
>> the FW loaded by the driver and any state currently in the controller.
>> This causes the kernel and the controller state to go out of sync.
>> One of the issues we observed on the Realtek controller without the
>> reset resume quirk was that paired or connected devices would just
>> stop working after resume.
>> 
>>> 
>>>> If the firmware doesn't cut off power during suspend, maybe you
>>>> shouldn't set the BTUSB_WAKEUP_DISABLE flag for that controller.
>>> 
>>> We don't know beforehand if the platform firmware (BIOS for my case) will
>> cut power off or not.
>>> 
>>> In general, laptops will cut off the USB power during S3.
>>> When AC is plugged, some laptops cuts USB power off and some don't. This
>> also applies to many desktops. Not to mention there can be BIOS options to
>> control USB power under S3/S4/S5...
>>> 
>>> So we don't know beforehand.
>>> 
>> 
>> I think the confusion here stems from what is actually being turned
>> off between our two boards and what we're referring to as firmware :)
>> 
>> In your case, the Realtek controller retains firmware unless the
>> platform cuts of power to USB (which it does during S3).
>> In my case, the Realtek controller loses firmware when Remote Wakeup
>> isn't set, even if the platform doesn't cut power to USB.
>> 
>> In your case, since you don't need to enforce the 'Remote Wakeup' bit,
>> if you unset the BTUSB_WAKEUP_DISABLE for that VID:PID, you should get
>> the desirable behavior (which is actually the default behavior; remote
>> wake will always be asserted instead of only during Runtime Suspend).
>> 
>> @Alex -- What is the common behavior for Realtek controllers? Should
>> we set BTUSB_WAKEUP_DISABLE only on RTL8822CE or should we unset it
>> only on RTL8821CE?
>> 
> 
> According to the feedback from our firmware engineers, all Realtek controllers should have the same behavior on suspend and resume.
> @ Kai-Heng, " Bluetooth: hci0: command 0x1001 tx timeout " is irrelevant to firmware loss or not. The rom code in controller supports this command.

Does USB warm-reset affect the Bluetooth controller?

Kai-Heng

> 
>>>> 
>>>> I would prefer this doesn't get accepted in its current state.
>>> 
>>> Of course.
>>> I think we need to find the root cause for your case before applying this
>> one.
>>> 
>>> Kai-Heng
>>> 
>>>> 
>>>> Abhishek
>>>> 
>>>> On Wed, Sep 23, 2020 at 10:56 AM Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com> wrote:
>>>>> 
>>>>> Realtek bluetooth controller may fail to work after system sleep:
>>>>> [ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
>>>>> [ 1280.835712] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION
>> failed (-110)
>>>>> 
>>>>> If platform firmware doesn't cut power off during suspend, the
>> firmware
>>>>> is considered retained in controller but the driver is still asking USB
>>>>> core to perform a reset-resume. This can make bluetooth controller
>>>>> unusable.
>>>>> 
>>>>> So avoid unnecessary reset to resolve the issue.
>>>>> 
>>>>> For devices that really lose power during suspend, USB core will detect
>>>>> and handle reset-resume correctly.
>>>>> 
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>> drivers/bluetooth/btusb.c | 8 +++-----
>>>>> 1 file changed, 3 insertions(+), 5 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>>> index 8d2608ddfd08..de86ef4388f9 100644
>>>>> --- a/drivers/bluetooth/btusb.c
>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>> @@ -4255,17 +4255,15 @@ static int btusb_suspend(struct
>> usb_interface *intf, pm_message_t message)
>>>>>               enable_irq(data->oob_wake_irq);
>>>>>       }
>>>>> 
>>>>> -       /* For global suspend, Realtek devices lose the loaded fw
>>>>> -        * in them. But for autosuspend, firmware should remain.
>>>>> -        * Actually, it depends on whether the usb host sends
>>>>> +       /* For global suspend, Realtek devices lose the loaded fw in them if
>>>>> +        * platform firmware cut power off. But for autosuspend, firmware
>>>>> +        * should remain.  Actually, it depends on whether the usb host
>> sends
>>>>>        * set feature (enable wakeup) or not.
>>>>>        */
>>>>>       if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
>>>>>               if (PMSG_IS_AUTO(message) &&
>>>>>                   device_can_wakeup(&data->udev->dev))
>>>>>                       data->udev->do_remote_wakeup = 1;
>>>>> -               else if (!PMSG_IS_AUTO(message))
>>>>> -                       data->udev->reset_resume = 1;
>>>>>       }
>>>>> 
>>>>>       return 0;
>>>>> --
>>>>> 2.17.1

