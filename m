Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333643105.16897.12.camel@aeonflux>
References: <1333624699-7922-1-git-send-email-vishal.agarwal@stericsson.com>
	<1333643105.16897.12.camel@aeonflux>
Date: Wed, 11 Apr 2012 09:13:19 +0530
Message-ID: <CA+_sZW_hNAMvxKzUXcvBYDEQTtzK=q0VSyKgWJkLiU5RpZTvuw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Temporary keys should be retained during connection
From: vishal agarwal <vishal.bluez@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vishal Agarwal <vishal.agarwal@stericsson.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 5, 2012 at 9:55 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Vishal,
>
>> If a key is non persistent then it should not be used in future
>> connections but it should be kept for current connection. And
>> it should be removed when connecion is removed.
>> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 11 +++++++----
>> =A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| =A0 =A02 ++
>> =A03 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index c0b232c..ce7a415 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -318,6 +318,7 @@ struct hci_conn {
>>
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0remote_cap;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0remote_auth;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0temp_link_key;
>
> I would actually rename this into an action. So something like
> flush_key.
>
>> =A0 =A0 =A0 unsigned int =A0 =A0sent;
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 286f3fc..fddd0ac 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1330,10 +1330,13 @@ int hci_add_link_key(struct hci_dev *hdev, struc=
t hci_conn *conn, int new_key,
>>
>> =A0 =A0 =A0 mgmt_new_link_key(hdev, key, persistent);
>>
>> - =A0 =A0 if (!persistent) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 list_del(&key->list);
>> - =A0 =A0 =A0 =A0 =A0 =A0 kfree(key);
>> - =A0 =A0 }
>> + =A0 =A0 if (!conn)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (persistent)
>> + =A0 =A0 =A0 =A0 =A0 =A0 conn->temp_link_key =3D false;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 conn->temp_link_key =3D true;
>
> So I would actually prefer a cleanup patch first that changes
> hci_persistent_key() function into a bool return value.
>
> After that it could become just like this
>
> =A0 =A0 =A0 =A0conn->temp_link_key =3D !persistent;
>

As this persistent variable is also used in function mgmt_new_link_key,
which sends this value to bluez as store_hint and bluez stores the key
on the basis of this value. So this will require 2 cleanup patches, one for
bluez and one for kernel. thats what you want?
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 7325300..0b19852 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1928,6 +1928,8 @@ static inline void hci_disconn_complete_evt(struct=
 hci_dev *hdev, struct sk_buff
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (ev->status =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (conn->type =3D=3D ACL_LINK && conn->temp_l=
ink_key)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_remove_link_key(hdev, &con=
n->dst);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_proto_disconn_cfm(conn, ev->reason);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_del(conn);
>> =A0 =A0 =A0 }
>
> Otherwise this looks all reasonable.
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Thanks
Vishal
