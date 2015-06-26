Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
References: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
	<986DE56C-2E79-4CAD-9D32-89DAED9B449A@holtmann.org>
	<CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
Date: Fri, 26 Jun 2015 13:27:23 +0300
Message-ID: <CACVxJT9kTRZC2G3cKsH8ccsP_B8r+7dKXNrz55u6yr9D41QOQA@mail.gmail.com>
Subject: Re: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
From: Alexey Dobriyan <adobriyan@gmail.com>
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	inux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 26, 2015 at 1:03 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> 2015-06-26 11:37 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:

>> --- a/net/bluetooth/hidp/core.c
>> +++ b/net/bluetooth/hidp/core.c
>> @@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_session **ou=
t, const bdaddr_t *bdaddr,
>>         session->conn =3D l2cap_conn_get(conn);
>>         session->user.probe =3D hidp_session_probe;
>>         session->user.remove =3D hidp_session_remove;
>> +       INIT_LIST_HEAD(&session->user.list);

Heh, I checked every list.next/prev instance except init bit.
Sorry for the breakage.

  Alexey
