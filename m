Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD5C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 07:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D79D20862
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 07:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D79D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeKGQ5Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:57:16 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46868 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeKGQ5Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 11:57:16 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id CF8B8CF2AC;
        Wed,  7 Nov 2018 08:35:35 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [Patch v1] Bluetooth: Add Rfkill driver for Intel Bluetooth
 controller
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181107014427.GA1121@dtor-ws>
Date:   Wed, 7 Nov 2018 08:28:07 +0100
Cc:     chethan tn <chethantn@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        amit.k.bag@intel.com, Raghuram Hegde <raghuram.hegde@intel.com>,
        sukumar.ghorai@intel.com, Rajat Jain <rajatja@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CD6DE466-5E73-473C-8943-684FBAEF337E@holtmann.org>
References: <1540907764-26294-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <CAMH2TCoG80TCheJqPhu3vxQAvgALnSh8g=jbw_QFM9BOTBq1XA@mail.gmail.com>
 <20181107014427.GA1121@dtor-ws>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dmitry,

>> We are planning to further implement the followings, kindly please
>> provide your suggestions.
>> 1. To handle more than 1 Intel BT controller connected to platform,
>> will keep list of the objects in "static const struct acpi_device_id
>> intel_bt_rfkill_acpi_match[] ". And keep a list of "struct
>> intel_bt_rfkill_dev" for each of the acpi object.
>> 2.  With this implementation from user space RF kill for the device
>> object is achieved, however need to map the rfkill object with the
>> corresponding "hdev" so that on error from the controller kernel can
>> do the reset through this RF Kill driver.
> 
> I am confused, why you model a generic chip reset functionality via
> RFKill subsystem. As far as I understand, the issue is that you want to
> be able to reset the chip when it gets confused and not actually disable
> the chip/stop it from emitting RF signals.
> 
> I believe this functionality should be contained in the driver and you
> simply need to come with a way to tie the adapter instance with data in
> ACPI, probably based on physical USB connection.

it is impossible to do that in the driver since what the GPIO is doing is to push the USB device off the bus. So you actually see an USB disconnect and a new re-enumeration when it comes back. Meaning the driver knows nothing during that time. This is a classic soft RFKILL switch like we have seen in the early Thinkpads.

Yes, this could be done all nicely with proper integration into the driver, but not with this hardware setup. They took the big hammer approach and killed the power to the device. A proper defined Reset GPIO would have been better and then we could have done this nicely within the driver. However if the device disappears, there is nothing for the driver to do.

Regards

Marcel

