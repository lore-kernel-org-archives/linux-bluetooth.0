Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to the
 serdev driver
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171004184343.7855-9-hdegoede@redhat.com>
 <DFCF661F-6FE0-4449-A169-D71ED9282074@holtmann.org>
 <1389d64c-17aa-c6a1-d56f-6c2fe877f247@redhat.com>
 <17592E57-3A4B-4386-B809-9EA928D38FDD@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <2487535c-18b4-c689-3c67-d1261b21feee@redhat.com>
Date: Thu, 5 Oct 2017 19:53:43 +0200
MIME-Version: 1.0
In-Reply-To: <17592E57-3A4B-4386-B809-9EA928D38FDD@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 05-10-17 17:15, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>> Make the serdev driver use struct bcm_device as its driver data and share
>>>> all the pm / GPIO / IRQ related code paths with the platform driver.
>>>>
>>>> After this commit the 2 drivers are in essence the same and the serdev
>>>> driver interface can be used for all ACPI enumerated HCI UARTs.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> drivers/bluetooth/hci_bcm.c | 118 +++++++++++++++++++++++++-------------------
>>>> 1 file changed, 68 insertions(+), 50 deletions(-)
>>> all 9 patches have been applied to bluetooth-next tree.
>>
>> Excellent, thank you!
>>
>> So I guess this means we can also move forward with getting
>> the 2 patches from Frédéric Danis merged ? There is a bit
>> of a bisect-ability problem there, if the acpi pull-req
>> gets merged first then uart attached bcm bt will stop
>> working until the bluetooth subsys is also merged.
>>
>> But I don't think this will impact a lot of users
>> (also given the need for a manual btattach so far),
>> so I don't think this is a big problem... ?
> 
> I wonder if we should just do this as all-in-one change for 4.15 kernel. We surely can get the ACPI changes into 4.15 and the Bluetooth changes as well. Then it should just work.
> 
> So I am leaning to just adding the revert patch into the bluetooth-next tree and then just add the ACPI PnP ID for the GPD device in the same pull request. And if the ACPI changes make it then nobody will know the difference that we switched from USB to UART.

Yes that should work fine.

Regards,

Hans
