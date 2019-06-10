Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A7C28CC5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 03:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A41720859
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 03:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vayc/Y3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfFJD4L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Jun 2019 23:56:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbfFJD4L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Jun 2019 23:56:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id u22so4459840pfm.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Jun 2019 20:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NXq7+5TLKvAkQ8XL+jNtNPrlKW2Do4NcJRGZ+dP5KsQ=;
        b=Vayc/Y3G0FTfIUOeKVLrMawJZXo0PZDM0yVgttDFkF8a1YYOP5Wft9gEXMu2UrVvvS
         QkLNnf3txosc64G5eGurPtpsrb7Bf65fIuazuWiuM/GxeZIcQUcVlRmfU9Ab/Tqh6XMV
         IdFKn2Ohn4rOtjPchhAqycy04KKPH/1myc/zyvwxV7GNfRXli6iDTFUiV0XgG9MWgQLp
         dPOsRvmIVpb+IqypmFYmU5nt4nmGQdKHMp+P34EV6ahXHN241WKpaX52k2685Ory4prx
         /O4X9UBiRnp6RavLAxGnj8of4UFebYvRf1gE6nUwVyZyUu94CEOJQMZQ01JL0DFRRf2U
         7MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NXq7+5TLKvAkQ8XL+jNtNPrlKW2Do4NcJRGZ+dP5KsQ=;
        b=sFEAZV6AFyrAEXQ1wbimiXjLXLfutrntutBMgPbu7WvqodRCt6o3sDZ+AFhGRlJDff
         wKwnfUw1Sv0EaNADQ+GJPBz6kRfGaczNkjG9bbIhT/A4geooR9+oZe7Dr0o+FLeZUnX7
         cF7FyTeeB6pMg8UTmTDGsm0RUyEHRBj9/EY7QGIm8VgwDpsjHeHuEi2QI+z1oALoY5qS
         pax+1g6QM0vP/1B2/FGpRNueIW/RcYFRqQeaUGjhsKRd2Xr+BfsXZncP78HChQ780yIL
         PfJQOdeTHp9yimMy8uZ/olroE4DdIkIADvuu32ILSp7U7i8P6c1TIfS8ktYar7G9P/mU
         UsHw==
X-Gm-Message-State: APjAAAXxpu+9+aRt6KJsr+8rFcCop3rxrIeRnTESZkCUXwCgicooyjWK
        Jp1383lpNp8M9K4PiTiTz+myC33W
X-Google-Smtp-Source: APXvYqyPJmpoVMULyuorglg1NSHeoeaAyeOKRemWMqpq/pqSwgD9rcKob9kb0p/EHxgQ6Ft7idvwjA==
X-Received: by 2002:a63:d70b:: with SMTP id d11mr13961822pgg.178.1560138969819;
        Sun, 09 Jun 2019 20:56:09 -0700 (PDT)
Received: from [192.168.1.13] ([172.103.152.101])
        by smtp.gmail.com with ESMTPSA id x25sm9196866pfm.48.2019.06.09.20.56.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 20:56:08 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   David Frey <dpfrey@gmail.com>
Subject: Interacting with a TI SensorTag CC2650
Message-ID: <40541478-bb40-b6ae-5b3d-22adb41588f0@gmail.com>
Date:   Sun, 9 Jun 2019 20:56:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I have a Texas Instruments SensorTag (model CC2650) that acts as a BLE
device.  I'm trying to interact with it from a PC running Bluez.
Specifically, I'm trying to read the IR temperature sensor.

Assumptions:
- The PC is running Bluez 5.50 on top of a recent Linux kernel
- There is a LE capable adapter (hci0) which is powered on
- Discovery has not yet been activated, so no devices are currently known

Here is what I *think* I need to do to make this work.  Please correct
me if I'm wrong or if there is a better way to do the same thing.

- Register a handler for the "InterfacesAdded" signal on the Bluez
object manager
- Call the StartDiscovery() method on the Adapter1 interface of hci0
- In the "InterfaceAdded" handler, check if any of the interfaces being
added are org.bluez.Device1.  If it is, then check that the path
contains "hci0" because we don't want to pick up objects on other adapters.
- For devices found, check if the "Name" property is set to "CC2650
SensorTag".  Ideally, the device would advertise it's service UUIDs and
then you could register a profile object via org.bluez.GattManager1's
RegisterApplication(), but this is not possible because the SensorTag
doesn't seem to include the service UUIDs in it's advertising payload.
- When a matching device is found according to the search above, call
the Connect() method on the Device1 interface.  This will cause all of
the services, characteristics and descriptors to be populated into the
object manager
- Wait for the IR temperature service UUID to appear in my
"InterfacesAdded" callback
- Wait for all of the relevant characteristics and descriptors to be
reported in my "InterfacesAdded" callback
- Use the ReadValue() method on the org.bluez.GattCharacteristic1
interface to read from the appropriate object


The above describes the steps that I think are necessary for a simple
read of the value.  Once I want to enable notifications, I think it gets
slightly more complicated because there are multiple characteristics in
play.

Things that seem strange to me:
- I find it surprising that the way to watch for a newly scanned device
on a specific adapter is to monitor every interface that is added to
bluez and then manually filter to see if it's a device on hci0.  Is
there no better way to do this?
- Do I need to track all of the characteristics and descriptors that
pass through the "InterfacesAdded" handler so that I ensure that I wait
long enough before trying to access the characteristics of a service?

Thanks,
David

