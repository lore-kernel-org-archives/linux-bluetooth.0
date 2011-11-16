Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/6] Bluetooth: Add hci_flags to struct hci_dev
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1321479870.15441.549.camel@aeonflux>
Date: Wed, 16 Nov 2011 18:50:24 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B4F38BBD-E95A-452A-A971-8186DD54BD1A@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org> <1321051824-5216-2-git-send-email-andre.guedes@openbossa.org> <1321052996.15441.408.camel@aeonflux> <08179A8B-4B3D-4481-BFBA-571195F9B401@openbossa.org> <1321479870.15441.549.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 16, 2011, at 6:44 PM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>>>> This patch adds the hci_flags field to struct hci_dev. This new
>>>> flags variable should be used to define flags related to BR/EDR
>>>> and/or LE controller itself. It should be used to define flags
>>>> which represents states from the controller. The hci_flags is
>>>> cleared in case the controller sends a Reset Command Complete
>>>> Event to the host.
>>>>=20
>>>> Also, this patch adds the HCI_LE_SCAN flag which was created to
>>>> track if the controller is performing LE scan or not. The flag
>>>> is set/cleared when the controller starts/stops scanning.
>>>>=20
>>>> This is an initial effort to stop using hdev->flags to define
>>>> internal flags since it is exported to userspace by an ioctl.
>>>>=20
>>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>>>> ---
>>>> include/net/bluetooth/hci.h      |    8 ++++++++
>>>> include/net/bluetooth/hci_core.h |    2 ++
>>>> net/bluetooth/hci_core.c         |    1 +
>>>> net/bluetooth/hci_event.c        |    6 ++++++
>>>> 4 files changed, 17 insertions(+), 0 deletions(-)
>>>>=20
>>>> diff --git a/include/net/bluetooth/hci.h =
b/include/net/bluetooth/hci.h
>>>> index 139ce2a..70321a1 100644
>>>> --- a/include/net/bluetooth/hci.h
>>>> +++ b/include/net/bluetooth/hci.h
>>>> @@ -88,6 +88,14 @@ enum {
>>>> 	HCI_RESET,
>>>> };
>>>>=20
>>>> +/*
>>>> + * BR/EDR and/or LE controller flags: the flags defined here =
should represent
>>>> + * states from the controller.
>>>> + */
>>>> +enum {
>>>> +	HCI_LE_SCAN,
>>>> +};
>>>> +
>>>> /* HCI ioctl defines */
>>>> #define HCIDEVUP	_IOW('H', 201, int)
>>>> #define HCIDEVDOWN	_IOW('H', 202, int)
>>>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>>>> index 1795257..f6d5d90 100644
>>>> --- a/include/net/bluetooth/hci_core.h
>>>> +++ b/include/net/bluetooth/hci_core.h
>>>> @@ -250,6 +250,8 @@ struct hci_dev {
>>>>=20
>>>> 	struct module		*owner;
>>>>=20
>>>> +	unsigned long		hci_flags;
>>>> +
>>>=20
>>> so I remember that I said, we call these mgmt_flags and make sure =
that
>>> all the flags are bound the mgmt interface. Why are we calling this
>>> hci_flags now?
>>=20
>> I realized this flags variable is more related to the controller
>> itself than to management interface. For instance, HCI_LE_SCAN,
>> HCI_INQUIRY, HCI_PSCAN, HCI_ISCAN and others flags pretty much
>> related to the _controller_. Additionally, the PINQUIRY flag, which
>> we might add soon, might be defined in hci_flags too, since it is
>> related to the controller.
>>=20
>> About the mgmt_flags, I was thinking in using this flags variable
>> to define management interface related flags. Flags such as
>> HCI_MGMT, HCI_PAIRABLE, HCI_SERVICE_CACHE and HCI_LINK_KEYS could
>> be added to mgmt_flags since they are all related to management
>> interface itself. In a patch in interleaved discovery support series
>> (as I said, I'll send it to ML soon), I create the mgmt_flags =
variable
>> and define the MGMT_DISCOV flags to track if we are carrying out a
>> discovery or not.=20
>>=20
>> So, summarizing we would have two flags variables: hci_flags (which
>> holds flags related to the controller) and mgmt_flags (which holds
>> flags related to management interface).
>>=20
>> Do we keep hci_flags or rename it to mgmt_flags and mix up controller
>> and management interface flags?
>=20
> then just call them dev_flags (like we have dev_type). Prefixing =
things
> with hci_ seems wrong to me.

Ok, I'll rename it.

Andre
