Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add support for BCM2E7E
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sebastian Reichel <sre@kernel.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <20170907202551.26796-1-hdegoede@redhat.com>
 <20170907202551.26796-2-hdegoede@redhat.com>
 <aab461af-601b-70c3-f79e-95ce0bdbbc9d@redhat.com>
 <20171001103509.4jqlt6kuqgxlm5m5@earth>
 <aed714df-ec91-cda6-c8fc-f45e40c4a6cb@redhat.com>
 <C0704E2C-0EA2-41B4-A7CB-0E5D0A624C19@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <78322c1c-5c71-75b5-00bb-7afa78cf2bbe@redhat.com>
Date: Thu, 5 Oct 2017 09:46:27 +0200
MIME-Version: 1.0
In-Reply-To: <C0704E2C-0EA2-41B4-A7CB-0E5D0A624C19@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 04-10-17 21:07, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>> This will happen automatically with this patch series,
>>>> but with the current 4.14 bluetooth stack it will work in
>>>> USB mode, and if we then merge this series post 4.14
>>>> bluetooth will stop working without users doing a btattach
>>>> command from userspace and we will have a regression on
>>>> our hands.
>>> Once the series from Frédéric Danis lands, you can get
>>> serial based broadcom bluetooth without btattach:
>>> https://www.spinics.net/lists/linux-bluetooth/msg71856.html
>>
>> Oh, cool. Thank you for pointing this out to me. I still
>> believe reverting the workaround for the 0000:0000
>> usb-id device is the right thing to do though.
>>
>> I've tested Frédéric Danis' series and it needed quite
>> some work on one of my devices. I've just submitted
>> a 9 patch series to add all the features the platform
>> code paths of hci_bcm.c have and which were missing from
>> the serdev code paths.
> 
> can you send a revert patch with a proper commit message explaining why we are reverting it and then I take it in with your other patch series.

Hmm, I thought I had already send that? But I cannot find it
in the archives, so it looks like I prepared it but never
send it...

I've send it out now, it would be nice to get the revert
into 4.14 so that we don't end up with one kernel release
where we do support the 0000:0000 usb-id.

Regards,

Hans
