Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D8C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF4020818
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 19:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF1EJRWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF4020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeKHEsC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:48:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40357 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKHEsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 23:48:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so7324608lfe.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Nov 2018 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5mw2NMyTkg5vB1uVRjZQzDZqYor6TOS2U5fjIkWeCs=;
        b=kF1EJRWhVp8/UvnecnKYeIkqyRxvlmN19mjPmIwdww6zYeoXjhebMnnhVwxF4zh8i+
         KzXziQmeUkDwvnBvFqf9n49sPIUbQVphvzosTWUtAXYo+fpqCy2txzpdr15CUk99uePM
         7ykwwhOnn6izzJD/VWG98fn/7TKfOrtt3FE49pW1H7L3rCwxKodxqgN++22NM3wj1UBP
         uu/TFJKKRZ9xDqHpv4FBhUfegBKtALtSYGiegP7IfdXMBt91EzhQI73FwSkXqLUnXBM5
         XQAj5tWBO994pzBPSY13xOgl1/M3oMJ0JIWlwizPBx3H9K7Wx6TOrNnM7wDO8OtS9paK
         MEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5mw2NMyTkg5vB1uVRjZQzDZqYor6TOS2U5fjIkWeCs=;
        b=BndoE4BPwSaqWJZyfA4GyumFtV8tKFR9CKZ6fapjyjknTIAgM/p4I5mPzVUy/fjoUH
         iZsHYYuDhS5TVJFK9pIlfqPtm4JVqQFTHiTxupcBChA73Ft5bX13asIh1yMDN9akOLoP
         u11tKjplkzpnSLKJ4HGbaRGnFWF6wcyifVXrYYNqSUHQKgMktZtNgYzElXlq7N4E71Q/
         a3vPiiOQttkaUeuAynp/mLcZy2MRPMU0jvtsplHyBa6C/pQvsit+jdrb5OFb9BJv2rUd
         dEAE52EgV4A5NmgV3AGKegEFYyiMm3OkJc4t5unstOlYSbN/ljWayU9kG7kN4fhEjMjy
         TxNg==
X-Gm-Message-State: AGRZ1gIKycbLDkZ74At2TtMFTOZE8eSHSWTXOLwnl6D0JgyNAZnUMWyN
        tcmL/f15a/FKBP8WXUtMYi3v/brw2WnJOPzW3xE=
X-Google-Smtp-Source: AJdET5eeMxn9fn0YbJ2ckiOudwBV3yBz6hZtSCr5z9AYATjRAO3jv1ppgrugGKM+oSnRSX2F/NAzv5IoNSz1JpzvBo0=
X-Received: by 2002:a19:f813:: with SMTP id a19mr856207lff.67.1541618177840;
 Wed, 07 Nov 2018 11:16:17 -0800 (PST)
MIME-Version: 1.0
References: <1540907764-26294-1-git-send-email-chethan.tumkur.narayan@intel.com>
 <CAMH2TCoG80TCheJqPhu3vxQAvgALnSh8g=jbw_QFM9BOTBq1XA@mail.gmail.com>
 <20181107014427.GA1121@dtor-ws> <CD6DE466-5E73-473C-8943-684FBAEF337E@holtmann.org>
 <CAKdAkRTfBV67=KGmimsc6obeHcjgo63UpG=Jn+C=NFDQ2cNE=A@mail.gmail.com> <4F7A2AA5-2CEC-4F2E-9691-099A6906EF0B@holtmann.org>
In-Reply-To: <4F7A2AA5-2CEC-4F2E-9691-099A6906EF0B@holtmann.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 7 Nov 2018 11:16:06 -0800
Message-ID: <CAKdAkRQsmx_idHCUAVTvPpnEYFdS6a0C_oNdjBQms6cBe6OwBw@mail.gmail.com>
Subject: Re: [Patch v1] Bluetooth: Add Rfkill driver for Intel Bluetooth controller
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     chethantn@gmail.com, chethan.tumkur.narayan@intel.com,
        linux-bluetooth@vger.kernel.org, amit.k.bag@intel.com,
        raghuram.hegde@intel.com, sukumar.ghorai@intel.com,
        rajatja@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 7, 2018 at 10:48 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Dmitry,
>
> >>>> We are planning to further implement the followings, kindly please
> >>>> provide your suggestions.
> >>>> 1. To handle more than 1 Intel BT controller connected to platform,
> >>>> will keep list of the objects in "static const struct acpi_device_id
> >>>> intel_bt_rfkill_acpi_match[] ". And keep a list of "struct
> >>>> intel_bt_rfkill_dev" for each of the acpi object.
> >>>> 2.  With this implementation from user space RF kill for the device
> >>>> object is achieved, however need to map the rfkill object with the
> >>>> corresponding "hdev" so that on error from the controller kernel can
> >>>> do the reset through this RF Kill driver.
> >>>
> >>> I am confused, why you model a generic chip reset functionality via
> >>> RFKill subsystem. As far as I understand, the issue is that you want to
> >>> be able to reset the chip when it gets confused and not actually disable
> >>> the chip/stop it from emitting RF signals.
> >>>
> >>> I believe this functionality should be contained in the driver and you
> >>> simply need to come with a way to tie the adapter instance with data in
> >>> ACPI, probably based on physical USB connection.
> >>
> >> it is impossible to do that in the driver since what the GPIO is doing is to push the USB device off the bus. So you actually see an USB disconnect and a new re-enumeration when it comes back. Meaning the driver knows nothing during that time.
> >
> > The driver would know that it is in the middle of resetting the
> > device. The fact that the device disappears from the bus is not a big
> > deal. You just need to make sure you finish the reset task running
> > before finishing teardown of the device in disconnect method.
>
> it is a big deal and it is unpredictable. We can not magically assign resources to a device that is about to go away.

Nor should you. You allocate the resources at bind time.

> And more importantly you have no idea which device goes away.

What do you mean? The reset line goes to exactly one controller. You
just need to find a way to describe it in ACPI. Probably attach to the
device that describes USB port the controller is attached to?

This is not the first device hard-wired USB device that needs
additional info supplied via ACPI or DT, and we already have a way to
specify bindings in device tree for USB devices:
Documentation/devicetree/bindings/usb/usb-device.txt and actually
btusb itself: Documentation/devicetree/bindings/net/btusb.txt

Can we adopt the above to ACPI?

>
> >> This is a classic soft RFKILL switch like we have seen in the early Thinkpads.
> >
> > It is not RFkill as, as far as I understand, it does not guarantee
> > that it actually blocks the transmitter. It really is a reset line and
> > its purpose is to unwedge the chip, not keep it in the off state. I do
> > not think there is a reason to export this as RFkill switch to
> > userspace and then build infrastructure to recognize that this is
> > special kind of RFkill switch that can be used to work around issues
> > in the controller. Have the driver assert and deassert it to kick
> > itself off the bus, the USB hotplug will take care of the rest.
>
> It is a RFKILL switch since the device looses power and with also turns RF off. As I said, this is the same as with the old Thinkpads where we have done exactly the same.

I believe you should not only look at the end result, but also at the
purpose of the facility. What is being handled here I believe was not
intended as a switch to turn device off.

Thanks.

-- 
Dmitry
