Return-Path: <SRS0=nJSa=DB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CC8C2D0E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 07:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2BD206C9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Sep 2020 07:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgIXHKl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:10:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgIXHKl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 03:10:41 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLLOo-0003b6-Ky
        for linux-bluetooth@vger.kernel.org; Thu, 24 Sep 2020 07:10:38 +0000
Received: by mail-pf1-f198.google.com with SMTP id q5so1269315pfl.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nbrq59GvwtLcN9qKevu8+3dfH8r78wKpe+smKwZezME=;
        b=fcxPMeoHyMCaT1UFyUIUgdMmCiNIDouti3QG3r0ZVkandCZTABJrs4SOZCMtPLxodd
         90Tf7/POfDab7QyvFZsoua9pJ2nxXdBx8Hw6+ijSJljcfwtVqvqaztOre7KXBnURVT0Q
         lbegwu7VeSqgM4WrT/mWVGcuVBZCZg3bzZ6p6N2hqb0NX95zcV4vJYeVmF94bPUlASt5
         oZa5cVJCTrKcno8YdZpc0HGnx8TUlQ2zlYq5AHOxbNsGkdRWPJ3IphYN5/9c4fZe4e8W
         X3qnPZqYQ9E6uLTgLH7Eb4CpEmHKgWV26rApGzKD1n/khGQPGTOhelqzG0Qj2544hdPG
         d3+w==
X-Gm-Message-State: AOAM532rOmT2Tz9isJBbKuv7tV2d2bkbQso+XqSOFqBXaUq8qX8mAC4T
        UEK9g7XUB1V3kQVIT6hug47/MS7TpbQTy6kCzNmXphtg3n+sCmw1Qm+GFfVwUFnXrF169t5+JHf
        y/6w7MGtgqGNZDgu+ziIE4ytpHmvlOwxNoFmfcWAsQ/TnwA==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr2601220pjs.195.1600931436188;
        Thu, 24 Sep 2020 00:10:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCk7vzCBN/l74QQtaNp+k0MuChSSLUgg5AfeBO3OsjJTBVY/G00Wpe7vMaVKlvc6su9uo1Ig==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr2601198pjs.195.1600931435690;
        Thu, 24 Sep 2020 00:10:35 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q10sm1351546pja.48.2020.09.24.00.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 00:10:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system
 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CANFp7mV7fC9_EZHd7B0Cu-owgCVdA6CNd2bb7XwFf5+6b7FVpg@mail.gmail.com>
Date:   Thu, 24 Sep 2020 15:10:31 +0800
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Alex Lu <alex_lu@realsil.com.cn>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A6F728DB-A07B-4323-83A5-3DABA8FDC156@canonical.com>
References: <20200923175602.9523-1-kai.heng.feng@canonical.com>
 <CANFp7mV7fC9_EZHd7B0Cu-owgCVdA6CNd2bb7XwFf5+6b7FVpg@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[+Cc linux-usb]

Hi Abhishek,

> On Sep 24, 2020, at 04:41, Abhishek Pandit-Subedi <abhishekpandit@chromium.org> wrote:
> 
> Hi Kai-Heng,
> 
> Which Realtek controller is this on?'

The issue happens on 8821CE.

> 
> Specifically for RTL8822CE, we tested without reset_resume being set
> and that was causing the controller being reset without bluez ever
> learning about it (resulting in devices being unusable without
> toggling the BT power).

The reset is done by the kernel, so how does that affect bluez?

From what you described, it sounds more like runtime resume since bluez is already running.
If we need reset resume for runtime resume, maybe it's another bug which needs to be addressed?

> If the firmware doesn't cut off power during suspend, maybe you
> shouldn't set the BTUSB_WAKEUP_DISABLE flag for that controller.

We don't know beforehand if the platform firmware (BIOS for my case) will cut power off or not.

In general, laptops will cut off the USB power during S3.
When AC is plugged, some laptops cuts USB power off and some don't. This also applies to many desktops. Not to mention there can be BIOS options to control USB power under S3/S4/S5...

So we don't know beforehand.

> 
> I would prefer this doesn't get accepted in its current state.

Of course.
I think we need to find the root cause for your case before applying this one.

Kai-Heng

> 
> Abhishek
> 
> On Wed, Sep 23, 2020 at 10:56 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Realtek bluetooth controller may fail to work after system sleep:
>> [ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
>> [ 1280.835712] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION failed (-110)
>> 
>> If platform firmware doesn't cut power off during suspend, the firmware
>> is considered retained in controller but the driver is still asking USB
>> core to perform a reset-resume. This can make bluetooth controller
>> unusable.
>> 
>> So avoid unnecessary reset to resolve the issue.
>> 
>> For devices that really lose power during suspend, USB core will detect
>> and handle reset-resume correctly.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/bluetooth/btusb.c | 8 +++-----
>> 1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 8d2608ddfd08..de86ef4388f9 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -4255,17 +4255,15 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>                enable_irq(data->oob_wake_irq);
>>        }
>> 
>> -       /* For global suspend, Realtek devices lose the loaded fw
>> -        * in them. But for autosuspend, firmware should remain.
>> -        * Actually, it depends on whether the usb host sends
>> +       /* For global suspend, Realtek devices lose the loaded fw in them if
>> +        * platform firmware cut power off. But for autosuspend, firmware
>> +        * should remain.  Actually, it depends on whether the usb host sends
>>         * set feature (enable wakeup) or not.
>>         */
>>        if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
>>                if (PMSG_IS_AUTO(message) &&
>>                    device_can_wakeup(&data->udev->dev))
>>                        data->udev->do_remote_wakeup = 1;
>> -               else if (!PMSG_IS_AUTO(message))
>> -                       data->udev->reset_resume = 1;
>>        }
>> 
>>        return 0;
>> --
>> 2.17.1
>> 

