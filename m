Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A1C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 14:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B3861165
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhDIOCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhDIOCa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 10:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLu9lX4p8Ytwg69oXKtyDY10OxMmzylLl2zGtsnC6gs=;
        b=hlqMxmLvrGiCY7CT3Z5dyl5wtkw+O3UhVfw4X7HJ9QxOOa/+624R1AMHNVI3IRh8zkTjFb
        eUd/jAmq98FzyvpPpc50PWCG6+G1nM0WBH830ucYHEnHGewUlMT5ZgoutvEdSotP9HNabN
        zllbEompd6D830Oy6M4RMlEwVU/tl70=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-4FSdz7iTPpSzNJ71YcfSoA-1; Fri, 09 Apr 2021 10:02:15 -0400
X-MC-Unique: 4FSdz7iTPpSzNJ71YcfSoA-1
Received: by mail-ed1-f72.google.com with SMTP id dj13so2695413edb.14
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 07:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLu9lX4p8Ytwg69oXKtyDY10OxMmzylLl2zGtsnC6gs=;
        b=ejvL583ykdWBoJVHLlgt6+8v1dHDYKHz0cS20sCNk7tdDYjMmSz2Wtbk0p1BC525aK
         dQqGdnstZQmNKAvqlLORNnyjJoeh5Ob5NenJ3O6ZxaVYkvomqXmfCP8wUh8hwWhetCIk
         dHwnxON5BO+ZuPmA5nZnANY5aTAa7kYfkvp0oGkKgnW6+07nA3ubzH9KMDL+cYeda8wB
         c7PDnOUdgr8FxrcgsWwmcvYudeBniUv+UkEH2MJYurOBdpUw/bJI4Ar451aHJMyDxNU9
         QeYeWwcoS6U+JkQlSNuO96Mtc/Gz32x3Q2bGwgiCG3yOFURcam+X2bGA7adN0QGHr+c5
         ZyHA==
X-Gm-Message-State: AOAM531THb+XTM9UioRvqjaEwnPkOtYDAmSgiydvUOLgQ3asT+4OL3ff
        upS1/7Qc21CWNcs4oFgWWxFB3HS8kagomKLVuORvdfMtegPaECWyBGmLGSDt8VGERsprU5cqdTa
        1ukBsIzGBZ2SKJ9gS1dJkOr4JfpDo
X-Received: by 2002:a17:906:f953:: with SMTP id ld19mr15796282ejb.164.1617976934289;
        Fri, 09 Apr 2021 07:02:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhtclA0A6FeVEc/IAi4E86GIMV4fw00Evs5UGBP7oUvZpijwy7ylGhiRjf0rnC1iG9pj/XOQ==
X-Received: by 2002:a17:906:f953:: with SMTP id ld19mr15796254ejb.164.1617976934081;
        Fri, 09 Apr 2021 07:02:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s17sm1282996ejx.10.2021.04.09.07.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:02:13 -0700 (PDT)
Subject: Re: [PATCH resend] Bluetooth: hci_h5: Disable the
 hci_suspend_notifier for btrtl devices
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
References: <20210405203602.17151-1-hdegoede@redhat.com>
 <97C75BD6-0F0F-4030-8202-388BF4D8BA5F@holtmann.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2cbdf685-adf3-2577-fe8f-adea26df6df3@redhat.com>
Date:   Fri, 9 Apr 2021 16:02:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <97C75BD6-0F0F-4030-8202-388BF4D8BA5F@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 4/9/21 3:42 PM, Marcel Holtmann wrote:
> Hi Hans,
> 
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
>>   system-suspend to save maximum power.
>> 2. Calls device_reprobe() from a workqueue to fully re-init the device
>>   from scratch on system-resume (unregistering the old HCI and
>>   registering a new HCI).
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
>> This commit avoids these problems by disabling the hci_suspend_notifier.
>>
>> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
>> Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Use the new HCI_QUIRK_NO_SUSPEND_NOTIFIER quirk, instead of directly
>>  unregistering the notifier from hci_h5.c
>> ---
>> drivers/bluetooth/hci_h5.c     |  7 +++++++
>> drivers/bluetooth/hci_serdev.c |  3 +++
>> drivers/bluetooth/hci_uart.h   | 13 +++++++------
>> 3 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>> index 27e96681d583..d79b7bbe6d94 100644
>> --- a/drivers/bluetooth/hci_h5.c
>> +++ b/drivers/bluetooth/hci_h5.c
>> @@ -919,6 +919,13 @@ static int h5_btrtl_setup(struct h5 *h5)
>>
>> static void h5_btrtl_open(struct h5 *h5)
>> {
>> +	/*
>> +	 * Since h5_btrtl_resume() does a device_reprobe() the suspend handling
>> +	 * done by the hci_suspend_notifier is not necessary; it actually causes
>> +	 * delays and a bunch of errors to get logged, so disable it.
>> +	 */
>> +	set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->hdev_flags);
>> +
>> 	/* Devices always start with these fixed parameters */
>> 	serdev_device_set_flow_control(h5->hu->serdev, false);
>> 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
>> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
>> index 9e03402ef1b3..113045e98c19 100644
>> --- a/drivers/bluetooth/hci_serdev.c
>> +++ b/drivers/bluetooth/hci_serdev.c
>> @@ -349,6 +349,9 @@ int hci_uart_register_device(struct hci_uart *hu,
>> 	if (test_bit(HCI_UART_EXT_CONFIG, &hu->hdev_flags))
>> 		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
>>
>> +	if (test_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &hu->hdev_flags))
>> +		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
>> +
>> 	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
>> 		hdev->dev_type = HCI_AMP;
>> 	else
>> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
>> index 4e039d7a16f8..4df2330ac103 100644
>> --- a/drivers/bluetooth/hci_uart.h
>> +++ b/drivers/bluetooth/hci_uart.h
>> @@ -35,12 +35,13 @@
>> #define HCI_UART_NOKIA	10
>> #define HCI_UART_MRVL	11
>>
>> -#define HCI_UART_RAW_DEVICE	0
>> -#define HCI_UART_RESET_ON_INIT	1
>> -#define HCI_UART_CREATE_AMP	2
>> -#define HCI_UART_INIT_PENDING	3
>> -#define HCI_UART_EXT_CONFIG	4
>> -#define HCI_UART_VND_DETECT	5
>> +#define HCI_UART_RAW_DEVICE		0
>> +#define HCI_UART_RESET_ON_INIT		1
>> +#define HCI_UART_CREATE_AMP		2
>> +#define HCI_UART_INIT_PENDING		3
>> +#define HCI_UART_EXT_CONFIG		4
>> +#define HCI_UART_VND_DETECT		5
>> +#define HCI_UART_NO_SUSPEND_NOTIFIER	6
> 
> not really happy using these values here. They are for the ioctl API. Any chance you can just use hu->flags for this?

I see no reason why that would not work. I'll prepare (and test) a v2 with this change.

Regards,

Hans

