Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BE96F0F6-FB1C-463E-A75B-6F9BE4EE0ABC@holtmann.org>
References: <1401277204-28062-1-git-send-email-luiz.dentz@gmail.com>
	<BE96F0F6-FB1C-463E-A75B-6F9BE4EE0ABC@holtmann.org>
Date: Sat, 31 May 2014 09:48:07 +0300
Message-ID: <CABBYNZL4GSbxuZgWT9OkXejG06+O98VJDufd6VaHt5g_6_w=bQ@mail.gmail.com>
Subject: Re: [RFC] bluetooth: Try to avoid forming scatternets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, May 31, 2014 at 8:23 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> In case of multiple connections automatically attempt to become master
>> to avoid scatternet topology.
>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>> net/bluetooth/hci_event.c | 21 ++++++++++++++++-----
>> 1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 492d8d5..e6aed6e 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2017,8 +2017,15 @@ static void hci_conn_complete_evt(struct hci_dev =
*hdev, struct sk_buff *skb)
>>       if (ev->status) {
>>               hci_proto_connect_cfm(conn, ev->status);
>>               hci_conn_del(conn);
>> -     } else if (ev->link_type !=3D ACL_LINK)
>> +     } else if (ev->link_type !=3D ACL_LINK) {
>>               hci_proto_connect_cfm(conn, ev->status);
>> +     } else if (hci_conn_num(hdev, ACL_LINK) > 1) {
>> +             /* Attempt to switch to master to avoid scatternet */
>> +             list_for_each_entry(conn, &hdev->conn_hash.list, list) {
>> +                     if (conn->type =3D=3D ACL_LINK)
>> +                             hci_conn_switch_role(conn, 0x00);
>> +             }
>> +     }
>
> I am not convinced this is a good idea. We do not know if the other also =
has two connections and wants to be the master. I think we can not generali=
ze this on the HCI level. This has to be L2CAP socket policy that will allo=
w us to make smart decisions. Sometimes the scatternet is just the better c=
hoice since our scatternet will result in a cheaper one than the others.

I thought it is a very common policy in many stacks actually, for
example apple's has the following in its bluetooth guidelines:

'In a Bluetooth connection, one device is the master and the other the
slave. The master can have multiple
slaves, thusforming a piconet. The master device can also be a slave
role to another master, creating a scatternet.
Such a scenario creates complications since the device has to
alternate between the two piconets and thus
wastes valuable bandwidth. Managing the topology of the network is
therefore important for maximum
performance. The Apple product may request a Role Switch, depending on
its current topology, and the remote
device shall accept the request. The Apple product may also reject a
request for a Role Switch because of
topology concerns. Having a suboptimal topology may degrade the audio
quality and the user's experience.

Only when it is maintaining multiple links, either Bluetooth or WiFi,
will the Apple product request or deny
role switches. Hence, it will grant a role switch if there is no
reason for the Apple product to be master. It is
expected that the accessory will behave the same, only trying to be
master when there is a legitimate reason.

The accessory should not always request to be master by default if
there is no need in the system topology to
do so. If later the accessory needs to be master in order to maintain
multiple links, it should ask to be master
at that time.'

We can't possible know how many connection the remote side has but it
can reject the role switch which will just keep us in a scatternet.

>>
>> unlock:
>>       hci_dev_unlock(hdev);
>> @@ -2035,6 +2042,12 @@ static void hci_conn_request_evt(struct hci_dev *=
hdev, struct sk_buff *skb)
>>       BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
>>              ev->link_type);
>>
>> +     hci_dev_lock(hdev);
>> +
>> +     /* Allways attempt to become the master in multiple connection cas=
e */
>> +     if (hci_conn_num(hdev, ev->link_type) > 0)
>> +             mask |=3D HCI_LM_MASTER;
>> +
>
> Isn=E2=80=99t this useless for SCO and eSCO links since the master defini=
tion is really only for the ACL link.

I believe the topology does influence SCO/eSCO too, there was actually
a patch in AOSP that did always request to be the master if SCO/eSCO
is connected which is probably the wrong think to do since that should
depend on what role of HFP/HSP we are assuming, btw if the topology
really influences SCO/eSCO I guess we shoud think about a socket
option to request the initial role like L2CAP and RFCOMM have.

>>       mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
>>                                     &flags);
>>
>> @@ -2044,8 +2057,6 @@ static void hci_conn_request_evt(struct hci_dev *h=
dev, struct sk_buff *skb)
>>               struct inquiry_entry *ie;
>>               struct hci_conn *conn;
>>
>> -             hci_dev_lock(hdev);
>> -
>>               ie =3D hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
>>               if (ie)
>>                       memcpy(ie->data.dev_class, ev->dev_class, 3);
>> @@ -2063,8 +2074,6 @@ static void hci_conn_request_evt(struct hci_dev *h=
dev, struct sk_buff *skb)
>>
>>               memcpy(conn->dev_class, ev->dev_class, 3);
>>
>> -             hci_dev_unlock(hdev);
>> -
>>               if (ev->link_type =3D=3D ACL_LINK ||
>>                   (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev)=
)) {
>>                       struct hci_cp_accept_conn_req cp;
>> @@ -2106,6 +2115,8 @@ static void hci_conn_request_evt(struct hci_dev *h=
dev, struct sk_buff *skb)
>>               cp.reason =3D HCI_ERROR_REJ_BAD_ADDR;
>>               hci_send_cmd(hdev, HCI_OP_REJECT_CONN_REQ, sizeof(cp), &cp=
);
>>       }
>> +
>> +     hci_dev_unlock(hdev);
>> }
>
> Regards
>
> Marcel
>



--=20
Luiz Augusto von Dentz
