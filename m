Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337202331.5970.269.camel@aeonflux>
References: <1337201737-5983-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1337202331.5970.269.camel@aeonflux>
Date: Wed, 16 May 2012 23:44:51 +0200
Message-ID: <CA+6KyKZ0vrPHoXXfWwJdiVLDR+59azRwWMhJbjndM+Aw_dKSwA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Use hci_conn data to handle failed LE
 Connection Complete
From: Andrzej Kaczmarek <andrzejk@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2012/5/16 Marcel Holtmann <marcel@holtmann.org>:
>> =A0 =A0 =A0 hci_dev_lock(hdev);
>>
>> + =A0 =A0 if (ev->status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 conn =3D hci_conn_hash_lookup_state(hdev, LE_L=
INK, BT_CONNECT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!conn)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mgmt_connect_failed(hdev, &conn->dst, conn->ty=
pe,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->=
dst_type, ev->status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_proto_connect_cfm(conn, ev->status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 conn->state =3D BT_CLOSED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_del(conn);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr)=
;
>> =A0 =A0 =A0 if (!conn) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn =3D hci_conn_add(hdev, LE_LINK, &ev->bd=
addr);
>
> this change is wrong. We are now treating every single adapter as being
> broken. That is not acceptable.

Why do you think these adapters are broken? As I explained in cover
letter for v1, spec does not require peer address to be provided in
Connection Complete which is reasonable since we can only have one
pending connection request. Also as Claudio and Andre noticed such
behaviour could be to simplify whitelist implementation - in case of
connection request using whitelist it does not make sense to include
specific peer address in event.

> We should only add a tweak if the BD_ADDR parameter is BDADDR_ANY and
> not as a general rule. In addition if we do this, we need to print a
> warning to dmesg to make this known.

Perhaps we can just add warning in case BD_ADDR is not BDADDR_ANY and
we cannot find hci_conn for it - in such case most probably something
went wrong.

BR,
Andrzej
