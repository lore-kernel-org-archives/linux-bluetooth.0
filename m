Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120419070846.GC16002@aemeltch-MOBL1>
References: <1334761984-5400-1-git-send-email-ulisses@profusion.mobi>
	<20120419070846.GC16002@aemeltch-MOBL1>
Date: Thu, 19 Apr 2012 16:40:27 -0300
Message-ID: <CAA37ikYC+4s69RPksnUH6N4jDe=4bgSAvhX-vqK6kDr4G3x4Sg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Fix registering hci with duplicate name
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Apr 19, 2012 at 4:08 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Wed, Apr 18, 2012 at 12:13:04PM -0300, Ulisses Furquim wrote:
>> When adding HCI devices hci_register_dev assigns the same name
>> hci1 for subsequently added AMP devices.
>>
>> ...
>> [ 6958.381886] sysfs: cannot create duplicate filename
>> =A0 =A0 =A0 =A0'/devices/virtual/bluetooth/hci1
>> ...
>>
>> We assume id starts with the number we'll try to add the new device
>> and keep iterating until we find the proper place. The only difference
>> is we start with 0 for BR/EDR device and 1 for AMP devices (thus AMP
>> devices will never receive register as index 0). Then every hdev->id in
>> the _ordered_ list <=3D to the id we want we increment id and move the
>> variable head. In the end we'll have id as the first available one and
>> head is where you need to add hdev after to keep the list ordered.
>>
>> Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>> ---
>>
>> v3 - really add new hdev after head to keep the list ordered.
>> v2 - only increment id when we find it's already there in the list.
>>
>> ---
>> =A0net/bluetooth/hci_core.c | =A0 16 ++++++++++------
>> =A01 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index c4dc263..2b98c33 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1739,24 +1739,28 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u=
16 interval, u16 window,
>> =A0/* Register HCI device */
>> =A0int hci_register_dev(struct hci_dev *hdev)
>> =A0{
>> - =A0 =A0 struct list_head *head =3D &hci_dev_list, *p;
>> + =A0 =A0 struct list_head *head, *p;
>> =A0 =A0 =A0 int i, id, error;
>>
>> =A0 =A0 =A0 if (!hdev->open || !hdev->close)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> + =A0 =A0 write_lock(&hci_dev_list_lock);
>> +
>> =A0 =A0 =A0 /* Do not allow HCI_AMP devices to register at index 0,
>> =A0 =A0 =A0 =A0* so the index can be used as the AMP controller ID.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 id =3D (hdev->dev_type =3D=3D HCI_BREDR) ? 0 : 1;
>> -
>> - =A0 =A0 write_lock(&hci_dev_list_lock);
>> + =A0 =A0 head =3D &hci_dev_list;
>>
>> =A0 =A0 =A0 /* Find first available device id */
>> =A0 =A0 =A0 list_for_each(p, &hci_dev_list) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (list_entry(p, struct hci_dev, list)->id !=
=3D id)
>> + =A0 =A0 =A0 =A0 =A0 =A0 int nid =3D list_entry(p, struct hci_dev, list=
)->id;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (nid > id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 head =3D p; id++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (nid =3D=3D id)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 head =3D p;
>> =A0 =A0 =A0 }
>
> This looks to be working but I still prefer bitmask approach as it result=
s
> in simpler code like shown below:
>
> <------8<------------------------------------------
> | =A0list_for_each_entry(d, &hci_dev_list, list)
> | =A0 =A0 =A0 =A0 =A0set_bit(d->id, inuse);
> |
> | =A0id =3D find_first_zero_bit(inuse, PAGE_SIZE * 8);
> |
> <------8<------------------------------------------
>
> Anyway I leave it to maintainers to decide.
>
> Tested-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Well, it's certainly up to them. Thanks for checking anyway. :-) I
just don't think allocating a page, marking the bits and finding the
first available is better than the other solution (which was already
there too). However, we need any fix merged soon as 3.3 seems to be
affected by this bug. Just plugging two USB dongles on my machine
gives me the duplicate name error from sysfs. :-/

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
