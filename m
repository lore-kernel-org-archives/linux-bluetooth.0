Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF73C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F9F64DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 13:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhA1NYK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhA1NYJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 08:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611840162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei7M7IJPq7I3csOnYXEUqHkhCfwVpAvi0Pxt/eacxtY=;
        b=h9C8fy/6VToV+nYB0nI4+PmWVho5PmPatNNuCz4ifd3yqDSfR7leTqMvoU4q8Ijkk/3W3e
        XIcUMx3/613uweJvqgUdqm/VVUBn9E2w8vc/BgCwL8MuX6PupaUlvDtcZNTok5IIWTHWyH
        WWEX2gxp7/6eo0cSX6Gpuo1Nz7Ng0wY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-9KaIPFQTMeWKedApOTlupw-1; Thu, 28 Jan 2021 08:22:40 -0500
X-MC-Unique: 9KaIPFQTMeWKedApOTlupw-1
Received: by mail-ej1-f70.google.com with SMTP id ar27so1032897ejc.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jan 2021 05:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ei7M7IJPq7I3csOnYXEUqHkhCfwVpAvi0Pxt/eacxtY=;
        b=gZIXtf/srs7w5hhByZb/1zmNMQqCSEIXcRCxiiGWlgoXJo6+r9CpQNsmMTjfkUSlaQ
         +YjZENarxzVyH9Sj4K8BGenUIZDatZ4izzzRwkJYEF8MvjoD9CsSjPqsO3pVVL3CIYt4
         TADaPZhcMzTStLUM/+EP1Y7DqG/emoC6ZANKMHYsphQ9yg1PY4l3yPEN/nVOu8ja0jS9
         o6EyiVTTrhWwlSJlvh3YIEE64BCYVddSF5fFJpbSt4YZuswv6W9uVGSvfobdut/UeTSe
         wLV8Z8m5APWrFNJISazjBKB1yZe73mcs5fuv86tn6jW8R/6ykK4Gw9r9Tnld4I86ZSBP
         ZAxg==
X-Gm-Message-State: AOAM533fq0NJsmev6h1DM+8nXVD8nt2KP1Bso1utjVnpWHuEz0wN7fUs
        9AWk8h+l1s1EEUEvnG+B0CPiIjS9CKxHlkKFgZAVW28uYjFJyQP6dk4ojWNXYWYgErGhPepFWPi
        MhRGPi6o2NsrC3lP5OP3qqFd4jBSl
X-Received: by 2002:a17:906:9497:: with SMTP id t23mr11382038ejx.523.1611840159165;
        Thu, 28 Jan 2021 05:22:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZMJXKvTQRY4Sws7FEl7SFJSg7hsyEb9IA0cxfR99xT10UXlCU+7N236PDL0HELHCRg6GMEQ==
X-Received: by 2002:a17:906:9497:: with SMTP id t23mr11382022ejx.523.1611840158983;
        Thu, 28 Jan 2021 05:22:38 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id k22sm2245979eji.101.2021.01.28.05.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 05:22:38 -0800 (PST)
Subject: Re: [PATCH] Bluetooth: hci_h5: Disable the hci_suspend_notifier for
 btrtl devices
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
References: <20210127215834.9367-1-hdegoede@redhat.com>
 <CANFp7mUK27wSXnBKEyrTTRPCDtSxawYEDVCbqOuJhRKnCFFm9w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <013f5dd0-8b56-5cdf-bba9-651359fa8710@redhat.com>
Date:   Thu, 28 Jan 2021 14:22:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANFp7mUK27wSXnBKEyrTTRPCDtSxawYEDVCbqOuJhRKnCFFm9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 1/28/21 12:58 AM, Abhishek Pandit-Subedi wrote:
> Hi Hans,
> 
> You can also implement hdev->prevent_wake to prevent configure wake
> from running.

Yes I did consider that, but there still is an issue sometimes on
resume too and the BT_SUSPEND_DISCONNECT handling takes 200 ms which
is nice to get rid of too. So I opted to just disable the
hci_suspend_notifier().

> hci_unregister_dev will also clear any tasks during
> resume, unregister the pm notifier and cancel the suspend work so if
> reprobe takes <2s (default suspend work timeout), you shouldn't see a
> delay or any errors.

The RTL8723bs is the cheapest of cheap wifi/bt combo chip and is
often found on cheap/slow devices. I did see this:

[  598.686060] Bluetooth: hci0: Timed out waiting for suspend events
[  598.686124] Bluetooth: hci0: Suspend timeout bit: 5
[  598.686237] Bluetooth: hci0: Suspend notifier action (4) failed: -110

At least once, it might just be that the 2 seconds elapsed before
the reprobe ran (or there might still be a race somewhere).

> I'm not 100% confident that the reprobe worker and the pm notifier
> won't race so I'm ok with this change as well. I would prefer if the> driver only set a quirk and the actual register/unregister was handled
> entirely inside hci_core though.

Ok, I did consider using a quirk for this myself, but I was not sure
if this warranted a core change since this is a somewhat unique
situation.

I'll respin the patch into a patch-set adding a quirk, thank you
for your feedback.

Regards,

Hans





> On Wed, Jan 27, 2021 at 1:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The hci_suspend_notifier which was introduced last year, is causing
>> problems for uart attached btrtl devices. These devices may loose their
>> firmware and their baudrate setting over a suspend/resume.
>>
>> Since we don't even know the baudrate after a suspend/resume recovering
>> from this is tricky. The driver solves this by treating these devices
>> the same as USB BT HCIs which drop of the bus during suspend.
>>
>> Specifically the driver:
>> 1. Simply unconditionally turns the device fully off during
>>    system-suspend to save maximum power.
>> 2. Calls device_reprobe() from a workqueue to fully re-init the device
>>    from scratch on system-resume (unregistering the old HCI and
>>    registering a new HCI).
>>
>> This means that these devices do not benefit from the suspend / resume
>> handling work done by the hci_suspend_notifier. At best this unnecessarily
>> adds some time to the suspend/resume time.
>>
>> But in practice this is actually causing problems:
>>
>> 1. These btrtl devices seem to not like the HCI_OP_WRITE_SCAN_ENABLE(
>> SCAN_DISABLED) request being send to them when entering the
>> BT_SUSPEND_CONFIGURE_WAKE state. The same request send on
>> BT_SUSPEND_DISCONNECT works fine, but the second one send (unnecessarily?)
>> from the BT_SUSPEND_CONFIGURE_WAKE transition causes the device to hang:
>>
>> [  573.497754] PM: suspend entry (s2idle)
>> [  573.554615] Filesystems sync: 0.056 seconds
>> [  575.837753] Bluetooth: hci0: Timed out waiting for suspend events
>> [  575.837801] Bluetooth: hci0: Suspend timeout bit: 4
>> [  575.837925] Bluetooth: hci0: Suspend notifier action (3) failed: -110
>>
>> 2. The PM_POST_SUSPEND / BT_RUNNING transition races with the
>> driver-unbinding done by the device_reprobe() work.
>> If the hci_suspend_notifier wins the race it is talking to a dead
>> device leading to the following errors being logged:
>>
>> [  598.686060] Bluetooth: hci0: Timed out waiting for suspend events
>> [  598.686124] Bluetooth: hci0: Suspend timeout bit: 5
>> [  598.686237] Bluetooth: hci0: Suspend notifier action (4) failed: -110
>>
>> In both cases things still work, but the suspend-notifier is causing
>> these ugly errors getting logged and ut increase both the suspend- and
>> the resume-time by 2 seconds.
>>
>> This commit works around these problems by disabling (unregistering)
>> the hci_suspend_notifier.
>>
>> Note that any eventual hci_unregister_dev() will call
>> unregister_pm_notifier() a second time, this is fine it will
>> simply fail with -ENOENT and hci_unregister_dev() ignores the
>> return value.
>>
>> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
>> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/bluetooth/hci_h5.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>> index 7be16a7f653b..acbcc676d6c2 100644
>> --- a/drivers/bluetooth/hci_h5.c
>> +++ b/drivers/bluetooth/hci_h5.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/of_device.h>
>>  #include <linux/serdev.h>
>>  #include <linux/skbuff.h>
>> +#include <linux/suspend.h>
>>
>>  #include <net/bluetooth/bluetooth.h>
>>  #include <net/bluetooth/hci_core.h>
>> @@ -876,6 +877,13 @@ static int h5_btrtl_setup(struct h5 *h5)
>>         bool flow_control;
>>         int err;
>>
>> +       /*
>> +        * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
>> +        * done by the hci_suspend_notifier is not necessary; it actually causes
>> +        * delays and a bunch of errors to get logged, so disable it.
>> +        */
>> +       unregister_pm_notifier(&h5->hu->hdev->suspend_notifier);
>> +
>>         btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
>>         if (IS_ERR(btrtl_dev))
>>                 return PTR_ERR(btrtl_dev);
>> --
>> 2.29.2
>>
> 

