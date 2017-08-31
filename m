Return-Path: <frederic.danis.oss@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add
 broadcom-bluetooth
To: Marcel Holtmann <marcel@holtmann.org>,
 Loic Poulain <loic.poulain@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 f.fainelli@gmail.com, Johan Hedberg <johan.hedberg@gmail.com>,
 linux-rpi-kernel@lists.infradead.org,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 devicetree@vger.kernel.org
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <20170822074726.e424lflqxn6mb4xd@flea.lan>
 <f2fcf522-cd1e-e748-0ee7-ad28bbf8ae5d@i2se.com>
 <4c23bcb6-1b90-c41e-6e47-7d8315e760ae@gmail.com>
 <9BD5C644-6B89-496C-B442-F276D7A99102@holtmann.org>
From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Message-ID: <cbd8f439-0575-593e-80d7-8c5d74188236@gmail.com>
Date: Thu, 31 Aug 2017 21:32:56 +0200
MIME-Version: 1.0
In-Reply-To: <9BD5C644-6B89-496C-B442-F276D7A99102@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Loïc,

Le 23/08/2017 à 16:19, Marcel Holtmann a écrit :
>> This is already partially supported in the hci_bcm driver.
>> Today this driver registers a platform_driver(legacy/ACPI) and a
>> serdev_device_driver (new/DT).
>>
>> The platform driver retrieves the gpios and mainly uses them in pm ops.
>> Once the ACPI for serdev will be supported, this plat driver should be
>> removed.
>>
>> The serdev driver does no support this yet because I used the RPi3
>> as dev platform. But this is something we want to have as well.
> Making ACPI serdev aware and turning BTH0 into serdev nodes is really the next step. That would allow us to simplify the drivers and remove duplicate code. Do you still have access to ACPI based tablets with Broadcom chips? It would be great if you can take a stab at this.

I have access to an Asus T100TA with Broadcom chipset and I recently 
started to work on the ACPI part of SerDev.
I hope to send patches for it soon.

Regards,

Frédéric Danis
