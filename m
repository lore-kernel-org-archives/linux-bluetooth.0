Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CA9C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E4221571
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E4221571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI0RCJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:02:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35684 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeI0RCJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:02:09 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id ECBD6CF16A;
        Thu, 27 Sep 2018 12:51:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 1/2] Bluetooth: btintel: Add platform device for rfkill
 signal
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E5FA71999F8E8845A748D0B68F0A4BDF966495@BGSMSX103.gar.corp.intel.com>
Date:   Thu, 27 Sep 2018 12:44:27 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        chethan tn <chethantn@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <426A4301-8777-4781-9AEE-32A800BD9C33@holtmann.org>
References: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
 <CF4E3B3B-C3A4-4037-A2F1-ECB4B01FAC6D@holtmann.org>
 <CAMH2TCpppynorUSW7bh6Qq-y3p3q38ppSX2Hj0w851+2OtTXZA@mail.gmail.com>
 <3296D1DD-DC70-4685-BDF9-F27576C09F68@holtmann.org>
 <CAMH2TCpMoQShFcAUrsQ_yzcbM4dE1S+akPvoLgda-HfGyhfE=A@mail.gmail.com>
 <E5FA71999F8E8845A748D0B68F0A4BDF966495@BGSMSX103.gar.corp.intel.com>
To:     "Hegde, Raghuram" <raghuram.hegde@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Raghuram,

>>>>>> Driver to add INTL6205 platform ACPI device to enable out of band 
>>>>>> GPIO signalling to handle rfkill and reset the bluetooth 
>>>>> controller. Expose an interface in kernel to assert GPIO signal.
>>>>>> 
>>>>>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>>>>>> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
>>>>>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>>>>>> ---
>>>>>> drivers/bluetooth/btintel.c | 68 
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>>> drivers/bluetooth/btintel.h |  6 ++++
>>>>>> 2 files changed, 74 insertions(+)
>>>>>> 
>>>>>> diff --git a/drivers/bluetooth/btintel.c 
>>>>>> b/drivers/bluetooth/btintel.c index 5270d5513201..538cd6b6c524 
>>>>>> 100644
>>>>>> --- a/drivers/bluetooth/btintel.c
>>>>>> +++ b/drivers/bluetooth/btintel.c
>>>>>> @@ -24,6 +24,9 @@
>>>>>> #include <linux/module.h>
>>>>>> #include <linux/firmware.h>
>>>>>> #include <linux/regmap.h>
>>>>>> +#include <linux/acpi.h>
>>>>>> +#include <linux/platform_device.h> #include 
>>>>>> +<linux/gpio/consumer.h>
>>>>>> #include <asm/unaligned.h>
>>>>>> 
>>>>>> #include <net/bluetooth/bluetooth.h> @@ -375,6 +378,71 @@ int 
>>>>>> btintel_read_version(struct hci_dev *hdev, struct intel_version 
>>>>>> *ver) } EXPORT_SYMBOL_GPL(btintel_read_version);
>>>>>> 
>>>>>> +static struct gpio_desc *reset_gpio_handler;
>>>>> 
>>>>> this thing is so inherent broken. Please never ever do that. If there are two reset handlers or two Intel USB devices connected things will go horrible wrong.
>>>> Is it fine to keep list of the descriptors handlers for all the 
>>>> Intel devices connected?
>>>>> 
>>>>>> +void btintel_reset_bt(struct hci_dev *hdev, unsigned char code) {
>>>>>> +     if (!reset_gpio_handler)
>>>>>> +             return;
>>>>>> +
>>>>>> +     gpiod_set_value(reset_gpio_handler, 0);
>>>>>> +     mdelay(100);
>>>>>> +     gpiod_set_value(reset_gpio_handler, 1); } 
>>>>>> +EXPORT_SYMBOL_GPL(btintel_reset_bt);
>>>>> 
>>>>> What happens here when you do this? Does the Bluetooth USB device disconnect from the USB bus and gets re-enumerated and the btusb_probe() routine gets called again?
>>>> Yes, USB re-enumeration will be done and btusb_proble() function will be called.
>>> 
>>> As I said, in that case it is fine to implement this an RFKILL switch. It is platform RFKILL switch. The USB device actually gets virtually disconnected.
>>> 
>>>>> 
>>>>> If this is the case, then I have no idea how many times I have to explain. It is a platfrom reset switch and using RFKILL for this is acceptable.
>>>> Thought of make this platform independent by exposing ACPI object 
>>>> "INTL6205", by doing so in case different platforms if the ACPI 
>>>> object is exposed by the platform then this driver would be loaded.
>>>> Kindly please do suggest.
>>> 
>>> See above. I really don't know what else to say. You can not handle this inside hci_dev since the hci_dev will be actually destroyed if you pull the GPIO.
>> Please note that the implementation is similar to the RF kill switch, just that its implemented in btintel.c. Our understanding is hci_dev does exist when GPIO toggle has to be done, only after that will be destroyed.
>> Later again hci_dev would be created and the hdev->hw_reset shall be re-assigned.
>> As you suggest if its not to be included in hci_dev, could you please let us know how to invoke the GPIO toggle without registering the callback(hdev->hw_reset).
>> 
> We have explored registering the 'INTL6205' ACPI object through Rfkill driver and implementing GPIO toggle in the '.set_block' function of Rfkill. But, we are stuck in how to invoke the '.set_block' function from hci_core,
> whenever there is a HCI command timeout. Could you please provide some pointers on how to implement this.

As I said multiple times before, this needs to be a separate driver since it is really an RFKILL driver. It is a RFKILL platform driver like with the old Lenovo/IBM laptops that take the Bluetooth device off the USB bus.

If you additionally want to go the hammer approach and causes the RFKILL to be trigger from hdev->bt_error, then that is another story, but first get an RFKILL driver written and send here for review. Or as proposed, fix the firmware to not crash in the first place ;)

Regards

Marcel

