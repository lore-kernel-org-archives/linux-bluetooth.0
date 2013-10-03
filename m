Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <349C4B8E-04AA-4122-8CC5-7C4342FA767E@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
 <1380668636-30654-7-git-send-email-andre.guedes@openbossa.org>
 <E33B98BD-8E7D-4384-9893-29837A323066@holtmann.org> <CACJA=fUFak6t2tEc9oFLF0cu_pPOAxf-pY1L-UH1jsFYUU46wg@mail.gmail.com>
 <349C4B8E-04AA-4122-8CC5-7C4342FA767E@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Thu, 3 Oct 2013 15:22:00 -0300
Message-ID: <CACJA=fXifO-bA8LJMQjuDzbjcvEWHGjG-4jSPq0-ABZDzKsHaQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] Bluetooth: Refactor LE Connection Complete HCI event handler
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 3, 2013 at 11:15 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>>>> This patch does some code refactorig in LE Connection Complete HCI
>>>> event handler. It basically adds a switch statement to separate new
>>>> master connection code from new slave connection code.
>>>>
>>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>>>> ---
>>>> include/net/bluetooth/hci.h |  1 +
>>>> net/bluetooth/hci_event.c   | 55 ++++++++++++++++++++++++++++++++-----=
--------
>>>> 2 files changed, 41 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>>> index 7ede266..8c98f60 100644
>>>> --- a/include/net/bluetooth/hci.h
>>>> +++ b/include/net/bluetooth/hci.h
>>>> @@ -1442,6 +1442,7 @@ struct hci_ev_num_comp_blocks {
>>>>
>>>> /* Low energy meta events */
>>>> #define LE_CONN_ROLE_MASTER   0x00
>>>> +#define LE_CONN_ROLE_SLAVE   0x01
>>>>
>>>> #define HCI_EV_LE_CONN_COMPLETE               0x01
>>>> struct hci_ev_le_conn_complete {
>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>> index 1d1ffa6..0e4a9f4 100644
>>>> --- a/net/bluetooth/hci_event.c
>>>> +++ b/net/bluetooth/hci_event.c
>>>> @@ -3444,8 +3444,42 @@ static void hci_le_conn_complete_evt(struct hci=
_dev *hdev, struct sk_buff *skb)
>>>>
>>>>      hci_dev_lock(hdev);
>>>>
>>>> -     conn =3D hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
>>>> -     if (!conn) {
>>>> +     if (ev->status) {
>>>> +             conn =3D hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CO=
NNECT);
>>>> +             if (!conn)
>>>> +                     goto unlock;
>>>> +
>>>> +             mgmt_connect_failed(hdev, &conn->dst, conn->type,
>>>> +                                 conn->dst_type, ev->status);
>>>> +             hci_proto_connect_cfm(conn, ev->status);
>>>> +             conn->state =3D BT_CLOSED;
>>>> +             hci_conn_del(conn);
>>>> +             goto unlock;
>>>> +     }
>>>> +
>>>> +     switch (ev->role) {
>>>> +     case LE_CONN_ROLE_MASTER:
>>>> +             conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bda=
ddr);
>>>> +             /* If there is no hci_conn object with the given address=
, it
>>>> +              * means this new connection was triggered through HCI s=
ocket
>>>> +              * interface. For that case, we should create a new hci_=
conn
>>>> +              * object.
>>>> +              */
>>>
>>> this comments belong one level down inside the if block. You already co=
mmenting on the negative outcome of the if check.
>>
>> Ok, I'll fix it.
>>
>>>
>>>
>>>> +             if (!conn) {
>>>> +                     conn =3D hci_conn_add(hdev, LE_LINK, &ev->bdaddr=
);
>>>> +                     if (!conn) {
>>>> +                             BT_ERR("No memory for new connection");
>>>> +                             goto unlock;
>>>> +                     }
>>>> +
>>>> +                     conn->out =3D true;
>>>> +                     conn->link_mode |=3D HCI_LM_MASTER;
>>>> +                     conn->sec_level =3D BT_SECURITY_LOW;
>>>> +                     conn->dst_type =3D ev->bdaddr_type;
>>>> +             }
>>>> +             break;
>>>> +
>>>> +     case LE_CONN_ROLE_SLAVE:
>>>
>>> And why are we not checking for an existing connection here? At least a=
 small comment is needed to make that part clear.
>>
>> Differently from master connection, there is no existing hci_conn for
>> slave connections. For that reason we don't check for an existing
>> connection here. I'll add a comment.
>>
>>>
>>>
>>>>              conn =3D hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
>>>>              if (!conn) {
>>>>                      BT_ERR("No memory for new connection");
>>>> @@ -3453,19 +3487,11 @@ static void hci_le_conn_complete_evt(struct hc=
i_dev *hdev, struct sk_buff *skb)
>>>>              }
>>>>
>>>>              conn->dst_type =3D ev->bdaddr_type;
>>>> +             conn->sec_level =3D BT_SECURITY_LOW;
>>>> +             break;
>>>>
>>>> -             if (ev->role =3D=3D LE_CONN_ROLE_MASTER) {
>>>> -                     conn->out =3D true;
>>>> -                     conn->link_mode |=3D HCI_LM_MASTER;
>>>> -             }
>>>> -     }
>>>> -
>>>> -     if (ev->status) {
>>>> -             mgmt_connect_failed(hdev, &conn->dst, conn->type,
>>>> -                                 conn->dst_type, ev->status);
>>>> -             hci_proto_connect_cfm(conn, ev->status);
>>>> -             conn->state =3D BT_CLOSED;
>>>> -             hci_conn_del(conn);
>>>> +     default:
>>>> +             BT_ERR("Used reserved Role parameter %d", ev->role);
>>>>              goto unlock;
>>>>      }
>>>>
>>>> @@ -3473,7 +3499,6 @@ static void hci_le_conn_complete_evt(struct hci_=
dev *hdev, struct sk_buff *skb)
>>>>              mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
>>>>                                    conn->dst_type, 0, NULL, 0, NULL);
>>>>
>>>> -     conn->sec_level =3D BT_SECURITY_LOW;
>>>>      conn->handle =3D __le16_to_cpu(ev->handle);
>>>>      conn->state =3D BT_CONNECTED;
>>>
>>> All in all, I am not really understanding why this makes it this code s=
impler. I actually think it turns it into more complicated code. So please =
explain what we are really gaining here. I just see more hash table lookup =
and for hci_conn_add calls with more error checks.
>>
>> When controller sends a LE Connection Complete event to host, we have
>> three different handling: failure, new master connection and new slave
>> connection. Additionally, new master connection has a special handling
>> since the connection could be triggered by HCI socket interface.
>> Before, all these logic were mixed up, making hard to add specific
>> code for new master connection for instance.
>
> I do not follow the difference between master and slave roles. Why do we =
have a difference here in the first place.
>
>> So this patch explicitly separates the three different handling and
>> adds extra comments aiming to improve hci_le_conn_complete_evt()
>> readability. Besides that, keeping these different handling separated,
>> it'll be easier to add the auto connection hooks.
>
> I am getting the feeling the overall code gets more complicated than simp=
ler. The goal is to make the connection handling simpler. And right now, I =
do not see this.

Ok, I'll drop this patch in v2.

I'll recheck if we really need to differentiate between master and
slave new connection for auto connection. If positive, I can add this
patch to auto connection patchset.

Thanks,

Andre
