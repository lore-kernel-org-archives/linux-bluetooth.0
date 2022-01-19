Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D22C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 20:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbiASUc4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 15:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231809AbiASUct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 15:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642624368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiP2qdUeRbGmyqt/ABT+kp8asUGAQz3zJ9nD3pBpt6o=;
        b=djTAgoIY8x0lk6qJuJdHLo5IxI/b1mdNxYRuNWE0+j8rTj7V+FPmjsqiR+492xKldOEB5+
        yNu40NAJ5EPUdwu3BDg2RupmaJKG/BlPsjQcBBVU9WcD/DPDfVJmd8oRfrfF92GzmIA2yH
        q5gbJO6qV4QMTGUm9MmL+3i0+T6OFbk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-eIwcCew8P1y0zUWQJHq0-A-1; Wed, 19 Jan 2022 15:32:47 -0500
X-MC-Unique: eIwcCew8P1y0zUWQJHq0-A-1
Received: by mail-ed1-f70.google.com with SMTP id n16-20020aa7c690000000b00404cfbb888dso407630edq.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jan 2022 12:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yiP2qdUeRbGmyqt/ABT+kp8asUGAQz3zJ9nD3pBpt6o=;
        b=jR2rLR5yXex398MEuBseAwAEyjGqP2GqI43o8eGyEo7uO+ZB+oQvXX5bNkt3bzPqUa
         HtgOEnnjlegaHQvXNB5SoKlNXAqhzP/VBbBKTjzwZeUqMMGj2ZBttOeyH4JNd0ihyyUv
         Y7dDO/fjux1iw+Gkd69QrGwyuK2DV0MNHHmVXmKqmAvo8TAiEIUTTRLFo/cjFeQzmrCH
         z4c8jPiqs9/ZUGiLrj4zc7Z2Nm/lSpFMzN9gvX3lvrVQmRZdsk9rL05vVmi4BCgNkxxy
         yAFYRZCPu3Qytu3CoRcK4r52Cg04RbiCqjCJQrD6rymBUutI1DXnMVAI4an2Z/p7zdm+
         1kUg==
X-Gm-Message-State: AOAM532owUlOaH0A8FTMSp7YknlFyjvVgOUJMEseujDdLco5N0U1O8ZU
        bmOVR81vJ/hX5oWA9UEqujiCESqq0GDQePJM3OEAG4YF3hXc1ETUvFcOTCZdrNUnQ4SUfrFU9QM
        7idVWIRn59dpJTQjLOuP3zKfY2fOp
X-Received: by 2002:a05:6402:26c8:: with SMTP id x8mr32273718edd.305.1642624365958;
        Wed, 19 Jan 2022 12:32:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1zt+Dnu9lz7NafeWrxe/jxKu3n6XeETQ4q2czohA0va6S3dGTObhNI2EbnY3qmkn9+sLc6A==
X-Received: by 2002:a05:6402:26c8:: with SMTP id x8mr32273697edd.305.1642624365654;
        Wed, 19 Jan 2022 12:32:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q23sm285829edw.53.2022.01.19.12.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:32:45 -0800 (PST)
Message-ID: <2fbdd560-79e3-82b2-11c3-bf043ec166e4@redhat.com>
Date:   Wed, 19 Jan 2022 21:32:44 +0100
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
 <dcf0b4bc-1b4c-eeca-42a1-6ac92a0e1275@redhat.com>
 <723D20F2-2688-4112-9ED4-2F8C3B6BF4DF@holtmann.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <723D20F2-2688-4112-9ED4-2F8C3B6BF4DF@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 1/19/22 20:39, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>> The DSDT for the Asus TF103C specifies a IOAPIC IRQ for the HCI -> host IRQ
>>>> but this is not correct. Unlike the previous entries in the table, this
>>>> time the correct GPIO to use instead is known; and the TF103C is battery
>>>> powered making runtime-pm support more important.
>>>>
>>>> Extend the bcm_broken_irq_dmi_table mechanism to allow specifying the right
>>>> GPIO instead of just always disabling runtime-pm and add an entry to it for
>>>> the Asus TF103C.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> drivers/bluetooth/hci_bcm.c | 44 ++++++++++++++++++++++++++++++-------
>>>> 1 file changed, 36 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>>> index ef54afa29357..c6ac4aa994af 100644
>>>> --- a/drivers/bluetooth/hci_bcm.c
>>>> +++ b/drivers/bluetooth/hci_bcm.c
>>>> @@ -20,6 +20,7 @@
>>>> #include <linux/regulator/consumer.h>
>>>> #include <linux/clk.h>
>>>> #include <linux/gpio/consumer.h>
>>>> +#include <linux/gpio/machine.h>
>>>> #include <linux/tty.h>
>>>> #include <linux/interrupt.h>
>>>> #include <linux/dmi.h>
>>>> @@ -870,7 +871,23 @@ static int bcm_resume(struct device *dev)
>>>> #endif
>>>>
>>>> /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
>>>> +static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
>>>> +	.dev_id = "serial0-0",
>>>
>>> do you need this one? I assume it could be easily enumerated as serial1-0 if you are unlucky.
>>
>> Yes there can be multiple global gpiod_lookup_table-s registered
>> and the gpiolib code finds the one to use be matching this field
>> to the dev_name() for the device passed to gpiod_get().
>>
>> I'm not worried about this getting enumerated with another dev_name(),
>> this is a tablet with no ways to add extra serial-bus devices and
>> there is only the 1 serial-bus device.
> 
> is there no other way to match this device?

I'm not sure what you mean ny "matching this device" ?  Since the ACPI
tables on this tablet contain the wrong GPIO, we need a gpio-lookup
table override and the gpio cores checks for a lookup table to use with
a specific struct device * based on dev_name() and only based on that,
there are no other matching options in the gpio-lookup mechanism.

Regards,

Hans

