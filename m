Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add support for BCM2E7E
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <aed714df-ec91-cda6-c8fc-f45e40c4a6cb@redhat.com>
Date: Wed, 4 Oct 2017 21:07:40 +0200
Cc: Sebastian Reichel <sre@kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <C0704E2C-0EA2-41B4-A7CB-0E5D0A624C19@holtmann.org>
References: <20170907202551.26796-1-hdegoede@redhat.com>
 <20170907202551.26796-2-hdegoede@redhat.com>
 <aab461af-601b-70c3-f79e-95ce0bdbbc9d@redhat.com>
 <20171001103509.4jqlt6kuqgxlm5m5@earth>
 <aed714df-ec91-cda6-c8fc-f45e40c4a6cb@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

>>> This will happen automatically with this patch series,
>>> but with the current 4.14 bluetooth stack it will work in
>>> USB mode, and if we then merge this series post 4.14
>>> bluetooth will stop working without users doing a btattach
>>> command from userspace and we will have a regression on
>>> our hands.
>> Once the series from Frédéric Danis lands, you can get
>> serial based broadcom bluetooth without btattach:
>> https://www.spinics.net/lists/linux-bluetooth/msg71856.html
> 
> Oh, cool. Thank you for pointing this out to me. I still
> believe reverting the workaround for the 0000:0000
> usb-id device is the right thing to do though.
> 
> I've tested Frédéric Danis' series and it needed quite
> some work on one of my devices. I've just submitted
> a 9 patch series to add all the features the platform
> code paths of hci_bcm.c have and which were missing from
> the serdev code paths.

can you send a revert patch with a proper commit message explaining why we are reverting it and then I take it in with your other patch series.

Regards

Marcel

