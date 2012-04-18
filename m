Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120418071620.GB19228@aemeltch-MOBL1>
References: <1334670087-2622-1-git-send-email-ulisses@profusion.mobi>
	<20120418071620.GB19228@aemeltch-MOBL1>
Date: Wed, 18 Apr 2012 11:56:37 -0300
Message-ID: <CAA37ikZiUAt2mmSLW6BpPY-CredSbTb_wckP18nO2Mh33nYBkQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix registering hci with duplicate name
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Apr 18, 2012 at 4:16 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Tue, Apr 17, 2012 at 10:41:27AM -0300, Ulisses Furquim wrote:
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
>> v2 - only increment id when we find it's already there in the list.
>>
>> ---
>> =A0net/bluetooth/hci_core.c | =A0 =A07 +++++--
>> =A01 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index c4dc263..e2202a1 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1754,9 +1754,12 @@ int hci_register_dev(struct hci_dev *hdev)
>>
>> =A0 =A0 =A0 /* Find first available device id */
>> =A0 =A0 =A0 list_for_each(p, &hci_dev_list) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (list_entry(p, struct hci_dev, list)->id !=
=3D id)
>> + =A0 =A0 =A0 =A0 =A0 =A0 int nid =3D list_entry(p, struct hci_dev, list=
)->id;
>
> this looks bad IMO, better use hdev =3D list_entry

Why? I only need to use the id field, after all.

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (nid > id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 head =3D p; id++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (nid =3D=3D id)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 head =3D p;
>> =A0 =A0 =A0 }
>
> This does not work when creating 3rd AMP device:
>
> [ =A0121.925367] Bluetooth: Chosen id 1
> [ =A0121.958056] Created virtual AMP device hci1
>
> [ =A0131.588553] Bluetooth: =A0 =A0 =A0 list: hdev->id 1 id 1
> [ =A0131.661149] Bluetooth: Chosen id 2
>
> [ =A0131.681159] Created virtual AMP device hci2
> [ =A0139.904674] Bluetooth: =A0 =A0 =A0 list: hdev->id 2 id 1
> [ =A0139.943904] Bluetooth: Chosen id 1
> [ =A0139.944780] ------------[ cut here ]------------
> [ =A0139.957882] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
> ...
>
> I suspect that you have to handle 2 cases when you add new device after o=
r
> before head otherwise list gets un-ordered.

Thanks a lot for testing, Andrei. This bug is because I must be
sleeping really bad. :-/ I even say in the commit message we should
add hdev _after_ head and keep using list_add_tail()?! Fixed version
of the patch coming in a few minutes.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
