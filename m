Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
References: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
	<986DE56C-2E79-4CAD-9D32-89DAED9B449A@holtmann.org>
	<CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
Date: Fri, 26 Jun 2015 16:28:24 +0200
Message-ID: <CADDKRnDchGURbrxt=herCnLiLfcqrRt=s_wMoBpuG25Ae32WYg@mail.gmail.com>
Subject: Re: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	inux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2015-06-26 12:03 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> 2015-06-26 11:37 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:
>> Hi Joerg,
>>
>>> Bluetooth is inoperable in current Linus tree and the
>>> first bad commit is:
>>>
>>> 835a6a2f8603237a3e6cded5a6765090ecb06ea5 is the first bad commit
>>> commit 835a6a2f8603237a3e6cded5a6765090ecb06ea5
>>> Author: Alexey Dobriyan <adobriyan@gmail.com>
>>> Date:   Wed Jun 10 20:28:33 2015 +0300
>>>
>>>    Bluetooth: Stop sabotaging list poisoning
>>>
>>>    list_del() poisons pointers with special values, no need to overwrit=
e them.
>>>
>>>    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>>    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>>
>>> My BT adapter is an intel 8087:07da
>>> I reverted that commit and this fixed the problem for me.
>>
>> today we had a patch from Tedd fixing the list initialization in the HID=
P code.
>>
>> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
>> index 9070dfd6b4ad..f1a117f8cad2 100644
>> --- a/net/bluetooth/hidp/core.c
>> +++ b/net/bluetooth/hidp/core.c
>> @@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_session **ou=
t, const bdaddr_t *bdaddr,
>>         session->conn =3D l2cap_conn_get(conn);
>>         session->user.probe =3D hidp_session_probe;
>>         session->user.remove =3D hidp_session_remove;
>> +       INIT_LIST_HEAD(&session->user.list);
>>         session->ctrl_sock =3D ctrl_sock;
>>         session->intr_sock =3D intr_sock;
>>         skb_queue_head_init(&session->ctrl_transmit);
>>
>> Could this be fixing it for you as well?
>>
> I will check this when I am at home in the
> afternoon.
>

The patch works for me too.

Thanks, J=C3=B6rg
