Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50659C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 19:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiASTj5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:39:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55597 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357084AbiASTjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 14:39:47 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id E3BBDCECE1;
        Wed, 19 Jan 2022 20:39:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add the Asus TF103C to the
 bcm_broken_irq_dmi_table
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <dcf0b4bc-1b4c-eeca-42a1-6ac92a0e1275@redhat.com>
Date:   Wed, 19 Jan 2022 20:39:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <723D20F2-2688-4112-9ED4-2F8C3B6BF4DF@holtmann.org>
References: <20211231115055.115988-1-hdegoede@redhat.com>
 <FE6FDB9A-2188-45EE-9605-CF5A5B7E43A1@holtmann.org>
 <dcf0b4bc-1b4c-eeca-42a1-6ac92a0e1275@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

>>> The DSDT for the Asus TF103C specifies a IOAPIC IRQ for the HCI -> host IRQ
>>> but this is not correct. Unlike the previous entries in the table, this
>>> time the correct GPIO to use instead is known; and the TF103C is battery
>>> powered making runtime-pm support more important.
>>> 
>>> Extend the bcm_broken_irq_dmi_table mechanism to allow specifying the right
>>> GPIO instead of just always disabling runtime-pm and add an entry to it for
>>> the Asus TF103C.
>>> 
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> drivers/bluetooth/hci_bcm.c | 44 ++++++++++++++++++++++++++++++-------
>>> 1 file changed, 36 insertions(+), 8 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>> index ef54afa29357..c6ac4aa994af 100644
>>> --- a/drivers/bluetooth/hci_bcm.c
>>> +++ b/drivers/bluetooth/hci_bcm.c
>>> @@ -20,6 +20,7 @@
>>> #include <linux/regulator/consumer.h>
>>> #include <linux/clk.h>
>>> #include <linux/gpio/consumer.h>
>>> +#include <linux/gpio/machine.h>
>>> #include <linux/tty.h>
>>> #include <linux/interrupt.h>
>>> #include <linux/dmi.h>
>>> @@ -870,7 +871,23 @@ static int bcm_resume(struct device *dev)
>>> #endif
>>> 
>>> /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
>>> +static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
>>> +	.dev_id = "serial0-0",
>> 
>> do you need this one? I assume it could be easily enumerated as serial1-0 if you are unlucky.
> 
> Yes there can be multiple global gpiod_lookup_table-s registered
> and the gpiolib code finds the one to use be matching this field
> to the dev_name() for the device passed to gpiod_get().
> 
> I'm not worried about this getting enumerated with another dev_name(),
> this is a tablet with no ways to add extra serial-bus devices and
> there is only the 1 serial-bus device.

is there no other way to match this device?

Regards

Marcel

