Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add support for BCM2E7E
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20170907202551.26796-1-hdegoede@redhat.com>
 <20170907202551.26796-2-hdegoede@redhat.com>
 <aab461af-601b-70c3-f79e-95ce0bdbbc9d@redhat.com>
 <20171001103509.4jqlt6kuqgxlm5m5@earth>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <aed714df-ec91-cda6-c8fc-f45e40c4a6cb@redhat.com>
Date: Mon, 2 Oct 2017 17:29:10 +0200
MIME-Version: 1.0
In-Reply-To: <20171001103509.4jqlt6kuqgxlm5m5@earth>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 01-10-17 12:35, Sebastian Reichel wrote:
> Hi Hans,
> 
> On Sun, Oct 01, 2017 at 11:27:45AM +0200, Hans de Goede wrote:
>> This will happen automatically with this patch series,
>> but with the current 4.14 bluetooth stack it will work in
>> USB mode, and if we then merge this series post 4.14
>> bluetooth will stop working without users doing a btattach
>> command from userspace and we will have a regression on
>> our hands.
> 
> Once the series from Frédéric Danis lands, you can get
> serial based broadcom bluetooth without btattach:
> 
> https://www.spinics.net/lists/linux-bluetooth/msg71856.html

Oh, cool. Thank you for pointing this out to me. I still
believe reverting the workaround for the 0000:0000
usb-id device is the right thing to do though.

I've tested Frédéric Danis' series and it needed quite
some work on one of my devices. I've just submitted
a 9 patch series to add all the features the platform
code paths of hci_bcm.c have and which were missing from
the serdev code paths.

Regards,

Hans
