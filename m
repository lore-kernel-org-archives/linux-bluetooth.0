Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A36C4727E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 07:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DD22389F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 07:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgIYHOf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:14:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55361 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYHOe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 03:14:34 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLhw6-0005Ls-33
        for linux-bluetooth@vger.kernel.org; Fri, 25 Sep 2020 07:14:30 +0000
Received: by mail-pf1-f198.google.com with SMTP id c197so1419921pfb.23
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 00:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y90EgWWcDzxyCaCQZY4DtmLps0FoOxTkn8TK8k+gYCI=;
        b=BLWwxPsvAvwzCsV25ngiJDNEP/JMjq3sqH7fWslSBLKMwqd9IEJZOMMgwP40sG0TOb
         tVNB4FLBlNM8l2Ki/xbvoJWkEKnQgnBRR8i/+FRTA9k8N0rnbiAPkgrlykDcHi4nxoCN
         fV0WNqxVqHzBoldrvKTJ63rpyJY3NBSIbwRwRf+TOlZED17UoNc5VxnQvcATgQQ3T51y
         a1yTpahYDxE+m6MFyvw/bv/J7j20UQI0X4V8aiGwrpPNqStDkgcrqAE8/6NpP1IqLUmy
         Qr0/qq4YTxDnTQRGiYgL+Ahv+I4FK0GCoA65xzGH2GNjWkSwT/9XBxreoHiPMccIYcx9
         o2mw==
X-Gm-Message-State: AOAM532ASF7v/zEHDgcsawv5GbrWaCSt3knPyJTUEkzNWuzDQohT+Qp+
        ScsuqFbCi/cdSQy1yowJBEsL0VTFRL+UdgoY0sbUo0RV3ftOSpP0xBoMvbjira959tla+EMFZv+
        g7icm5eNMU8SO3CseCkz/BaKviUDESqS1wZtAC7DLji3Zzg==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr1375675pju.207.1601018068073;
        Fri, 25 Sep 2020 00:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvk46AVeIvnXWXVuga0PdEtl2G5HaDcP/B4yNEln86Vawdtf1kz8zpjXrF7G9AqqAvs/+TtQ==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr1375652pju.207.1601018067542;
        Fri, 25 Sep 2020 00:14:27 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z63sm1594672pfz.187.2020.09.25.00.14.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 00:14:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <6b46b6bca9d3486499d0374eb277b00c@realsil.com.cn>
Date:   Fri, 25 Sep 2020 15:14:15 +0800
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <4055CF26-9A1F-42E6-A88A-3726B4532669@canonical.com>
References: <6b46b6bca9d3486499d0374eb277b00c@realsil.com.cn>
To:     =?utf-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

> On Sep 25, 2020, at 15:04, 陆朱伟 <alex_lu@realsil.com.cn> wrote:
> 
> Hi Kai-Heng,
> 
>> On September 25, 2020 14:04, Kai-Heng Feng wrote:
>> 
>> Hi Abhishek,
>>> On Sep 25, 2020, at 11:33, Abhishek Pandit-Subedi
>> <abhishekpandit@chromium.org> wrote:
>>> 
>>> + Alex Lu (who contributed the original change)
>>> 
>>> Hi Kai-Heng,
>>> 
>>> 
>>> On Thu, Sep 24, 2020 at 12:10 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>> 
>>>> [+Cc linux-usb]
>>>> 
>>>> Hi Abhishek,
>>>> 
>>>>> On Sep 24, 2020, at 04:41, Abhishek Pandit-Subedi
>> <abhishekpandit@chromium.org> wrote:
>>>>> 
>>>>> Hi Kai-Heng,
>>>>> 
>>>>> Which Realtek controller is this on?'
>>>> 
>>>> The issue happens on 8821CE.
>>>> 
>>>>> 
>>>>> Specifically for RTL8822CE, we tested without reset_resume being set
>>>>> and that was causing the controller being reset without bluez ever
>>>>> learning about it (resulting in devices being unusable without
>>>>> toggling the BT power).
>>>> 
>>>> The reset is done by the kernel, so how does that affect bluez?
>>>> 
>>>> From what you described, it sounds more like runtime resume since bluez
>> is already running.
>>>> If we need reset resume for runtime resume, maybe it's another bug
>> which needs to be addressed?
>>> 
>>> From btusb.c:
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-
>> next.git/tree/drivers/bluetooth/btusb.c#n4189
>>> /* Realtek devices lose their updated firmware over global
>>> * suspend that means host doesn't send SET_FEATURE
>>> * (DEVICE_REMOTE_WAKEUP)
>>> */
>>> 
>>> Runtime suspend always requires remote wakeup to be set and reset
>>> resume isn't used there.
>> 
>> Thanks for the clarification.
>> 
>>> 
>>> During system suspend, when remote wakeup is not set, RTL8822CE loses
>>> the FW loaded by the driver and any state currently in the controller.
>>> This causes the kernel and the controller state to go out of sync.
>>> One of the issues we observed on the Realtek controller without the
>>> reset resume quirk was that paired or connected devices would just
>>> stop working after resume.
>>> 
>>>> 
>>>>> If the firmware doesn't cut off power during suspend, maybe you
>>>>> shouldn't set the BTUSB_WAKEUP_DISABLE flag for that controller.
>>>> 
>>>> We don't know beforehand if the platform firmware (BIOS for my case)
>> will cut power off or not.
>>>> 
>>>> In general, laptops will cut off the USB power during S3.
>>>> When AC is plugged, some laptops cuts USB power off and some don't.
>> This also applies to many desktops. Not to mention there can be BIOS
>> options to control USB power under S3/S4/S5...
>>>> 
>>>> So we don't know beforehand.
>>>> 
>>> 
>>> I think the confusion here stems from what is actually being turned
>>> off between our two boards and what we're referring to as firmware :)
>> 
>> Yes :)
>> 
>>> 
>>> In your case, the Realtek controller retains firmware unless the
>>> platform cuts of power to USB (which it does during S3).
>> 
>> Not all platform firmware (i.e. BIOS for x86) cut USB power during S3, as I
>> describe in last reply.
>> 
>>> In my case, the Realtek controller loses firmware when Remote Wakeup
>>> isn't set, even if the platform doesn't cut power to USB.
>> 
>> Thanks for the clarification, I believe it's a case that should to be handled
>> separately.
>> 
>>> 
>>> In your case, since you don't need to enforce the 'Remote Wakeup' bit,
>>> if you unset the BTUSB_WAKEUP_DISABLE for that VID:PID, you should get
>>> the desirable behavior (which is actually the default behavior; remote
>>> wake will always be asserted instead of only during Runtime Suspend).
>> 
>> So we have three cases here. Assuming reset_resume isn't flagged by btusb:
>> 
>> 1) Both USB power and BT firmware were lost during suspend.
>> USB core finds out power was lost, try to reset resume the device. Since
>> btusb doesn't have reset_resume callback, USB core calls probe instead.
>> 
>> 2) Both USB power and BT firmware were kept during suspend. This is my
>> case.
>> Regular resume handles everything.
>> 
>> 3) USB power was kept but BT firmware was lost. This is your case.
>> USB core finds out power was kept, use regular resume. However the BT
>> firmware was lost, so resume fails.
>> For this case, maybe we can use btrtl_setup_realtek() in btusb_resume()? It
>> won't re-upload firmware if firmware is retained, and will do proper
>> initializing if firmware was lost.
> 
> In my opinions,
> For the 3), there are two cases, one is that firmware was lost in auto suspend. That should never happen, because the data->intf->needs_remote_wakeup is set in btusb_open() and btusb_close(). The flag means that host will send remote wakeup during autosuspend, and firmware wouldn't drop.
> Another case is firmware loss in global suspend. I think that's no problem, driver sets data->udev->reset_resume in btusb_suspend() and btusb will reprobe after resume.

Apparently for my case, RTL8821CE, firmware was kept without setting remote wakeup.
Is it okay to also set remote wakeup for global suspend to retain the firmware?
If firmware was retained, does USB warm reset affect BT controller in anyway?

Kai-Heng

> 
>> 
>> Kai-Heng
>> 
>>> 
>>> @Alex -- What is the common behavior for Realtek controllers? Should
>>> we set BTUSB_WAKEUP_DISABLE only on RTL8822CE or should we unset it
>>> only on RTL8821CE?
>>> 
>>>>> 
>>>>> I would prefer this doesn't get accepted in its current state.
>>>> 
>>>> Of course.
>>>> I think we need to find the root cause for your case before applying this
>> one.
>>>> 
>>>> Kai-Heng
>>>> 
>>>>> 
>>>>> Abhishek
>>>>> 
>>>>> On Wed, Sep 23, 2020 at 10:56 AM Kai-Heng Feng
>>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>> 
>>>>>> Realtek bluetooth controller may fail to work after system sleep:
>>>>>> [ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
>>>>>> [ 1280.835712] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION
>> failed (-110)
>>>>>> 
>>>>>> If platform firmware doesn't cut power off during suspend, the
>> firmware
>>>>>> is considered retained in controller but the driver is still asking USB
>>>>>> core to perform a reset-resume. This can make bluetooth controller
>>>>>> unusable.
>>>>>> 
>>>>>> So avoid unnecessary reset to resolve the issue.
>>>>>> 
>>>>>> For devices that really lose power during suspend, USB core will detect
>>>>>> and handle reset-resume correctly.
>>>>>> 
>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>> ---
>>>>>> drivers/bluetooth/btusb.c | 8 +++-----
>>>>>> 1 file changed, 3 insertions(+), 5 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>>>> index 8d2608ddfd08..de86ef4388f9 100644
>>>>>> --- a/drivers/bluetooth/btusb.c
>>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>>> @@ -4255,17 +4255,15 @@ static int btusb_suspend(struct
>> usb_interface *intf, pm_message_t message)
>>>>>>              enable_irq(data->oob_wake_irq);
>>>>>>      }
>>>>>> 
>>>>>> -       /* For global suspend, Realtek devices lose the loaded fw
>>>>>> -        * in them. But for autosuspend, firmware should remain.
>>>>>> -        * Actually, it depends on whether the usb host sends
>>>>>> +       /* For global suspend, Realtek devices lose the loaded fw in them
>> if
>>>>>> +        * platform firmware cut power off. But for autosuspend,
>> firmware
>>>>>> +        * should remain.  Actually, it depends on whether the usb host
>> sends
>>>>>>       * set feature (enable wakeup) or not.
>>>>>>       */
>>>>>>      if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
>>>>>>              if (PMSG_IS_AUTO(message) &&
>>>>>>                  device_can_wakeup(&data->udev->dev))
>>>>>>                      data->udev->do_remote_wakeup = 1;
>>>>>> -               else if (!PMSG_IS_AUTO(message))
>>>>>> -                       data->udev->reset_resume = 1;
>>>>>>      }
>>>>>> 
>>>>>>      return 0;
>>>>>> --
>>>>>> 2.17.1
>> 
>> 
>> ------Please consider the environment before printing this e-mail.

