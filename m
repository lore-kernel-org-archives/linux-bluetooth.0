Return-Path: <SRS0=LpJm=NT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA4C32789
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F1420827
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F1420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeKHSHl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:07:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59283 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeKHSHl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Nov 2018 13:07:41 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9A992CF2BA;
        Thu,  8 Nov 2018 09:40:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [Patch v1] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKdAkRQsmx_idHCUAVTvPpnEYFdS6a0C_oNdjBQms6cBe6OwBw@mail.gmail.com>
Date:   Thu, 8 Nov 2018 09:33:14 +0100
Cc:     chethan tn <chethantn@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Bag, Amit K" <amit.k.bag@intel.com>, raghuram.hegde@intel.com,
        sukumar.ghorai@intel.com, rajatja@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <261DCD38-D597-404C-92F3-30FB4E40F1FB@holtmann.org>
References: <1540907764-26294-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <CAMH2TCoG80TCheJqPhu3vxQAvgALnSh8g=jbw_QFM9BOTBq1XA@mail.gmail.com>
 <20181107014427.GA1121@dtor-ws>
 <CD6DE466-5E73-473C-8943-684FBAEF337E@holtmann.org>
 <CAKdAkRTfBV67=KGmimsc6obeHcjgo63UpG=Jn+C=NFDQ2cNE=A@mail.gmail.com>
 <4F7A2AA5-2CEC-4F2E-9691-099A6906EF0B@holtmann.org>
 <CAKdAkRQsmx_idHCUAVTvPpnEYFdS6a0C_oNdjBQms6cBe6OwBw@mail.gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dmitry,

>>>>>> We are planning to further implement the followings, kindly please
>>>>>> provide your suggestions.
>>>>>> 1. To handle more than 1 Intel BT controller connected to platform,
>>>>>> will keep list of the objects in "static const struct acpi_device_id
>>>>>> intel_bt_rfkill_acpi_match[] ". And keep a list of "struct
>>>>>> intel_bt_rfkill_dev" for each of the acpi object.
>>>>>> 2.  With this implementation from user space RF kill for the device
>>>>>> object is achieved, however need to map the rfkill object with the
>>>>>> corresponding "hdev" so that on error from the controller kernel can
>>>>>> do the reset through this RF Kill driver.
>>>>> 
>>>>> I am confused, why you model a generic chip reset functionality via
>>>>> RFKill subsystem. As far as I understand, the issue is that you want to
>>>>> be able to reset the chip when it gets confused and not actually disable
>>>>> the chip/stop it from emitting RF signals.
>>>>> 
>>>>> I believe this functionality should be contained in the driver and you
>>>>> simply need to come with a way to tie the adapter instance with data in
>>>>> ACPI, probably based on physical USB connection.
>>>> 
>>>> it is impossible to do that in the driver since what the GPIO is doing is to push the USB device off the bus. So you actually see an USB disconnect and a new re-enumeration when it comes back. Meaning the driver knows nothing during that time.
>>> 
>>> The driver would know that it is in the middle of resetting the
>>> device. The fact that the device disappears from the bus is not a big
>>> deal. You just need to make sure you finish the reset task running
>>> before finishing teardown of the device in disconnect method.
>> 
>> it is a big deal and it is unpredictable. We can not magically assign resources to a device that is about to go away.
> 
> Nor should you. You allocate the resources at bind time.
> 
>> And more importantly you have no idea which device goes away.
> 
> What do you mean? The reset line goes to exactly one controller. You
> just need to find a way to describe it in ACPI. Probably attach to the
> device that describes USB port the controller is attached to?
> 
> This is not the first device hard-wired USB device that needs
> additional info supplied via ACPI or DT, and we already have a way to
> specify bindings in device tree for USB devices:
> Documentation/devicetree/bindings/usb/usb-device.txt and actually
> btusb itself: Documentation/devicetree/bindings/net/btusb.txt
> 
> Can we adopt the above to ACPI?

I have no heard from anybody on how that can be describe nor that it is for this hardware. So for the driver this binding between the GPIO and the USB interface / device does not exist.

>>>> This is a classic soft RFKILL switch like we have seen in the early Thinkpads.
>>> 
>>> It is not RFkill as, as far as I understand, it does not guarantee
>>> that it actually blocks the transmitter. It really is a reset line and
>>> its purpose is to unwedge the chip, not keep it in the off state. I do
>>> not think there is a reason to export this as RFkill switch to
>>> userspace and then build infrastructure to recognize that this is
>>> special kind of RFkill switch that can be used to work around issues
>>> in the controller. Have the driver assert and deassert it to kick
>>> itself off the bus, the USB hotplug will take care of the rest.
>> 
>> It is a RFKILL switch since the device looses power and with also turns RF off. As I said, this is the same as with the old Thinkpads where we have done exactly the same.
> 
> I believe you should not only look at the end result, but also at the
> purpose of the facility. What is being handled here I believe was not
> intended as a switch to turn device off.

It is powering off and powering on the device. It is a classical Bluetooth RFKILL switch. As I said, that is how we have treated this big-hammer approach to RFKILL since the Thinkpads started doing that.

Regards

Marcel

