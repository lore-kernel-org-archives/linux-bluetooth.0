Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99860C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiAMPWt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230217AbiAMPWt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 10:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642087368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2/2Zyrzv4bPm7GE5ckuTwpZEERJ7ZtSCBetJN2C5LA=;
        b=B4BPcCvF/FLqcfa4t759wlMDxfXRLWuW1fSIb2+EBiVP0AJ8sYHY3BBl5ciO97UsAttss4
        fsJpvKAJOtcYESJf6b2qwrMSR/AnRyI5VsfyQeI9XT102PclX0QTieuNyDC8l4dYynvwEs
        UbNdAKNNDgku7VFpGkHS2oEvYn1h78Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-c4F1lT76Osuw7jDexRKrBg-1; Thu, 13 Jan 2022 10:22:47 -0500
X-MC-Unique: c4F1lT76Osuw7jDexRKrBg-1
Received: by mail-ed1-f69.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so5647153edc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jan 2022 07:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L2/2Zyrzv4bPm7GE5ckuTwpZEERJ7ZtSCBetJN2C5LA=;
        b=uB9FuRUkloLo1Mmf4g9E3iiaoKqe2XoyHEzxP0+NWFkFIHCUEwqb1Xwgb2hG1hc/6t
         uEduXy7ux4KWgKIh3c0biwQB1Z9q7294BqBWYuqhceO4tgNvQ1hHB1UcpfGsEDbJ34xT
         6B6s28cT4vFr0q2mJtQb7IOKV/CgVmhzP4cEx7TPN1ctyEb2eUcMKWLno6Y/egkjyhxq
         NXUh52lAUK1e6jhaHVbQtQjSYBC+KJlcVINJzKb+TmAQ2b2DvlTpDUtS/5Rw+owJSsUR
         s8sXTB5jtmjE335bhJ5As6EMk1htfYV0KsKRclYerz8sVoyStorQqKE9yphd2UqdOK+I
         e7/g==
X-Gm-Message-State: AOAM530eIjoXaaQxwkY5+cw6+2tsyGPvSmfa/jS+NhttzoLYf3YVBPBA
        9aHMl4vRKVopCYSeeZv72GmwP2LmKxhWe4EZeOca0j8f5fnSiDMwsj4sqVYxksa1DlXz5P4zoqZ
        4AD01pF3dahBmkmbrsBt5+QX84+EU
X-Received: by 2002:a50:a6d4:: with SMTP id f20mr4685044edc.303.1642087366437;
        Thu, 13 Jan 2022 07:22:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFbmAGaFs3Z0P9SDuy98BQa8kfxYCVZG5irkVdAY8ROX9XdLq15HuXoIVomfk9g7OtliwPAg==
X-Received: by 2002:a50:a6d4:: with SMTP id f20mr4685030edc.303.1642087366288;
        Thu, 13 Jan 2022 07:22:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q14sm1376028edd.40.2022.01.13.07.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 07:22:45 -0800 (PST)
Message-ID: <dcf0b4bc-1b4c-eeca-42a1-6ac92a0e1275@redhat.com>
Date:   Thu, 13 Jan 2022 16:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add the Asus TF103C to the
 bcm_broken_irq_dmi_table
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20211231115055.115988-1-hdegoede@redhat.com>
 <FE6FDB9A-2188-45EE-9605-CF5A5B7E43A1@holtmann.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <FE6FDB9A-2188-45EE-9605-CF5A5B7E43A1@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thank you for the review.

On 1/6/22 21:27, Marcel Holtmann wrote:
> Hi Hans,
> 
>> The DSDT for the Asus TF103C specifies a IOAPIC IRQ for the HCI -> host IRQ
>> but this is not correct. Unlike the previous entries in the table, this
>> time the correct GPIO to use instead is known; and the TF103C is battery
>> powered making runtime-pm support more important.
>>
>> Extend the bcm_broken_irq_dmi_table mechanism to allow specifying the right
>> GPIO instead of just always disabling runtime-pm and add an entry to it for
>> the Asus TF103C.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 44 ++++++++++++++++++++++++++++++-------
>> 1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index ef54afa29357..c6ac4aa994af 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -20,6 +20,7 @@
>> #include <linux/regulator/consumer.h>
>> #include <linux/clk.h>
>> #include <linux/gpio/consumer.h>
>> +#include <linux/gpio/machine.h>
>> #include <linux/tty.h>
>> #include <linux/interrupt.h>
>> #include <linux/dmi.h>
>> @@ -870,7 +871,23 @@ static int bcm_resume(struct device *dev)
>> #endif
>>
>> /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
>> +static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
>> +	.dev_id = "serial0-0",
> 
> do you need this one? I assume it could be easily enumerated as serial1-0 if you are unlucky.

Yes there can be multiple global gpiod_lookup_table-s registered
and the gpiolib code finds the one to use be matching this field
to the dev_name() for the device passed to gpiod_get().

I'm not worried about this getting enumerated with another dev_name(),
this is a tablet with no ways to add extra serial-bus devices and
there is only the 1 serial-bus device.

Regards,

Hans



> 
>> +	.table = {
>> +		GPIO_LOOKUP("INT33FC:02", 17, "host-wakeup-alt", GPIO_ACTIVE_HIGH),
>> +		{ }
>> +	},
>> +};
>> +
>> static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
>> +	{
>> +		.ident = "Asus TF103C",
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
>> +		},
>> +		.driver_data = &asus_tf103c_irq_gpios,
>> +	},
>> 	{
>> 		.ident = "Meegopad T08",
>> 		.matches = {
> 
> Regards
> 
> Marcel
> 

