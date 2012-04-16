Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAA37ikYUoy4K16CtX2Jw41bqsoH_QmXOjr19C7eZGmtXY6vQ3Q@mail.gmail.com>
References: <1334596114-2263-1-git-send-email-ulisses@profusion.mobi>
	<f8f94a7b-ec38-43e1-91f7-1e39864b376a@email.android.com>
	<CAA37ikYUoy4K16CtX2Jw41bqsoH_QmXOjr19C7eZGmtXY6vQ3Q@mail.gmail.com>
Date: Mon, 16 Apr 2012 19:51:22 -0300
Message-ID: <CAA37ika5v0CkESAL75aWxu7TmZr-_xUOW=e7X30-x+OBmvukUw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix registering hci with duplicate name
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Apr 16, 2012 at 7:07 PM, Ulisses Furquim <ulisses@profusion.mobi> w=
rote:
> Hi Andrei,
>
> On Mon, Apr 16, 2012 at 6:44 PM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
>> Hi Ulisses,
>>
>> Ulisses Furquim <ulisses@profusion.mobi> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BB(=D0=B0):
>>
>>>When adding HCI devices hci_register_dev assigns the same name
>>>hci1 for subsequently added AMP devices.
>>>
>>>...
>>>[ 6958.381886] sysfs: cannot create duplicate filename
>>> =C2=A0 =C2=A0 =C2=A0 '/devices/virtual/bluetooth/hci1
>>>...
>>>
>>>We assume id starts with the number we'll try to add the new device
>>>and keep iterating until we find the proper place. The only difference
>>>is we start with 0 for BR/EDR device and 1 for AMP devices (thus AMP
>>>devices will never receive register as index 0). Then every hdev->id in
>>>the _ordered_ list <=3D to the id we want we increment id and move the
>>>variable head. In the end we'll have id as the first available one and
>>>head is where you need to add hdev after to keep the list ordered.
>>>
>>>Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>>Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>>>---
>>>
>>>Andrei, it'd be good if you could test it with AMP and add a tested-by
>>>as well, please.
>>>
>>>Thanks.
>>>
>>>---
>>> net/bluetooth/hci_core.c | =C2=A0 =C2=A02 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>index c4dc263..f24d3d8 100644
>>>--- a/net/bluetooth/hci_core.c
>>>+++ b/net/bluetooth/hci_core.c
>>>@@ -1754,7 +1754,7 @@ int hci_register_dev(struct hci_dev *hdev)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 /* Find first available device id */
>>> =C2=A0 =C2=A0 =C2=A0 list_for_each(p, &hci_dev_list) {
>>>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (list_entry(p, stru=
ct hci_dev, list)->id !=3D id)
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (list_entry(p, stru=
ct hci_dev, list)->id > id)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D p; id++;
>>
>> Without testing I feel that it would not work. If you register first AMP=
 then bredr it would have the same id.
>
> Hmm. First AMP will receive id 1, right? The first bredr will be tried
> with id 0 and find the id 1 already there and break the loop and
> insert hci0 before hci1 in the list, right? I still think it'll work.

Now that I think, I see a problem, but different than you said. It's
easily fixed, though.

 =C2=A0 =C2=A0 =C2=A0 list_for_each(p, &hci_dev_list) {
              int nid =3D list_entry(p, struct hci_dev, list)->id;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nid > id)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
              if (nid =3D=3D id)
                       id++;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D p;
       }

Now we solve the problem of adding first bredr and then an AMP device
which had to result in hci0 and then hci1, but with the previous code
was resulting in hci0 and hci2. Please, if you could test it'd be
great.

Thanks,
Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
