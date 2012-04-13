Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAA37ikaFf+=9yR_qa6_QFNjOxAf3DZ5D_R7kZ28ZycjuVaLSsg@mail.gmail.com>
References: <1334311590-1135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1334316099-18492-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikaFf+=9yR_qa6_QFNjOxAf3DZ5D_R7kZ28ZycjuVaLSsg@mail.gmail.com>
Date: Fri, 13 Apr 2012 21:39:21 +0300
Message-ID: <CAMXE1-o8oPdPF6Ry1nFUcnHFUMXs8U_ghysKN3nhCeTsFFx7Mw@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] Bluetooth: Fix registering hci with duplicate name
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Fri, Apr 13, 2012 at 7:25 PM, Ulisses Furquim <ulisses@profusion.mobi> wrote:

> On Fri, Apr 13, 2012 at 8:21 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
>>
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> When adding HCI devices hci_register_dev may assigns the same name
>> hciX for subsequently added HCI devices. Use bitmask to find free
>> device ID the same way as it is done in other subsystems.
>>
>> ...
>> [ 6958.381886] sysfs: cannot create duplicate filename
>>        '/devices/virtual/bluetooth/hci1
> Well, I don't like this bitmask approach, really. We used to have this
> list ordered and the code was doing that before we added the
> restriction of index 0 for AMP devices, I think.

I think it just was not tested enough.

> Using a bitmask looks
> overkill to me when we can probably modify the loop to find the first

This approach is used in many places when choosing device id, specifically
in network device code, so I just took it as I do not like to reinvent
the wheel.

> available ID. Marcel even suggested an approach with a pseudo code
> that seems to be the best way to go. Something along the lines of:
>
>        list_for_each(p, &hci_dev_list) {
>                if (list_entry(p, struct hci_dev, list)->id > id)
> /* just replacing != with > */
>                        break;
>                head = p; id++;
>        }
>
> We assume id starts with the number we'll try to add the new device
> and keep iterating until we find the proper place. The only difference
> is we start with 0 for BR/EDR and 1 for AMP devices. Then every
> hdev->id in the _ordered_ list <= to the id we want we increment id
> and move head. In the end we'll have id as the first available one and
> head is where you need to add hdev (before head) to the list to keep
> it ordered. Right? Does that work for you? Am I missing anything here?

Please better send a patch ;) Either way is OK for me.

Regards,
Andrei
