Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BFCD757D-FF1F-40B4-AD64-61D6EC10C346@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
 <1393362104-12175-9-git-send-email-andre.guedes@openbossa.org> <BFCD757D-FF1F-40B4-AD64-61D6EC10C346@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 26 Feb 2014 16:34:19 -0300
Message-ID: <CACJA=fUZgbhAUyQ1fdjFfnBNjv71WLUK4jeAJJTjhmUxTwVu-Q@mail.gmail.com>
Subject: Re: [PATCH 08/17] Bluetooth: Introduce LE auto connection infrastructure
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 26, 2014 at 3:31 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> This patch introduces the LE auto connection infrastructure which
>> will be used to implement the LE auto connection options.
>>
>> In summary, the auto connection mechanism works as follows: Once the
>> first pending LE connection is created, the background scanning is
>> started. When the target device is found in range, the kernel
>> autonomously starts the connection attempt. If connection is
>> established successfully, that pending LE connection is deleted and
>> the background is stopped.
>>
>> To achieve that, this patch introduces the hci_update_background_scan()
>> which controls the background scanning state. This function starts or
>> stops the background scanning based on the hdev->pend_le_conns list. If
>> there is no pending LE connection, the background scanning is stopped.
>> Otherwise, we start the background scanning.
>>
>> Then, every time a pending LE connection is added we call hci_update_
>> background_scan() so the background scanning is started (in case it is
>> not already running). Likewise, every time a pending LE connection is
>> deleted we call hci_update_background_scan() so the background scanning
>> is stopped (in case this was the last pending LE connection) or it is
>> started again (in case we have more pending LE connections). Finally,
>> we also call hci_update_background_scan() in hci_le_conn_failed() so
>> the background scan is restarted in case the connection establishment
>> fails. This way the background scanning keeps running until all pending
>> LE connection are established.
>>
>> At this point, resolvable addresses are not support by this
>> infrastructure. The proper support is added in upcoming patches.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |  2 +
>> net/bluetooth/hci_conn.c         |  5 +++
>> net/bluetooth/hci_core.c         | 93 ++++++++++++++++++++++++++++++++++=
+++++-
>> net/bluetooth/hci_event.c        | 38 ++++++++++++++++
>> 4 files changed, 136 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index e08405d..617cf49 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -806,6 +806,8 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bdad=
dr_t *addr, u8 addr_type);
>> void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_=
type);
>> void hci_pend_le_conns_clear(struct hci_dev *hdev);
>>
>> +void hci_update_background_scan(struct hci_dev *hdev);
>> +
>> void hci_uuids_clear(struct hci_dev *hdev);
>>
>> void hci_link_keys_clear(struct hci_dev *hdev);
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index ccf4a4f..e79351c 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -527,6 +527,11 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 s=
tatus)
>>       hci_proto_connect_cfm(conn, status);
>>
>>       hci_conn_del(conn);
>> +
>> +     /* Since we may have temporarily stopped the background scanning i=
n
>> +      * favor of connection establishment, we should restart it.
>> +      */
>> +     hci_update_background_scan(hdev);
>> }
>>
>> static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 142ecd8..d242217 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3281,7 +3281,7 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bd=
addr_t *addr, u8 addr_type)
>>
>>       entry =3D hci_pend_le_conn_lookup(hdev, addr, addr_type);
>>       if (entry)
>> -             return;
>> +             goto done;
>>
>>       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
>>       if (!entry) {
>> @@ -3295,6 +3295,9 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bd=
addr_t *addr, u8 addr_type)
>>       list_add(&entry->list, &hdev->pend_le_conns);
>>
>>       BT_DBG("addr %pMR (type %u)", addr, addr_type);
>> +
>> +done:
>> +     hci_update_background_scan(hdev);
>> }
>>
>> /* This function requires the caller holds hdev->lock */
>> @@ -3304,12 +3307,15 @@ void hci_pend_le_conn_del(struct hci_dev *hdev, =
bdaddr_t *addr, u8 addr_type)
>>
>>       entry =3D hci_pend_le_conn_lookup(hdev, addr, addr_type);
>>       if (!entry)
>> -             return;
>> +             goto done;
>>
>>       list_del(&entry->list);
>>       kfree(entry);
>>
>>       BT_DBG("addr %pMR (type %u)", addr, addr_type);
>> +
>> +done:
>> +     hci_update_background_scan(hdev);
>> }
>>
>> /* This function requires the caller holds hdev->lock */
>> @@ -4946,3 +4952,86 @@ void hci_req_add_le_scan_disable(struct hci_reque=
st *req)
>>       cp.enable =3D LE_SCAN_DISABLE;
>>       hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> }
>> +
>> +static void update_background_scan_complete(struct hci_dev *hdev, u8 st=
atus)
>> +{
>> +     if (status)
>> +             BT_DBG("HCI request failed to update background scanning: =
"
>> +                    "status 0x%2.2x", status);
>> +}
>> +
>> +/* This function controls the background scanning based on hdev->pend_l=
e_conns
>> + * list. If there are pending LE connection we start the background sca=
nning,
>> + * otherwise we stop it.
>> + *
>> + * This function requires the caller holds hdev->lock.
>> + */
>> +void hci_update_background_scan(struct hci_dev *hdev)
>> +{
>> +     struct hci_cp_le_set_scan_param param_cp;
>> +     struct hci_cp_le_set_scan_enable enable_cp;
>> +     struct hci_request req;
>> +     struct hci_conn *conn;
>> +     int err;
>> +
>> +     hci_req_init(&req, hdev);
>> +
>> +     if (list_empty(&hdev->pend_le_conns)) {
>> +             /* If there is no pending LE connections, we should stop
>> +              * the background scanning.
>> +              */
>> +
>> +             /* If controller is not scanning we are done. */
>> +             if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +                     return;
>> +
>> +             hci_req_add_le_scan_disable(&req);
>> +
>> +             BT_DBG("%s stopping background scanning", hdev->name);
>> +     } else {
>> +             u8 own_addr_type;
>> +
>> +             /* If there is at least one pending LE connection, we shou=
ld
>> +              * keep the background scan running.
>> +              */
>> +
>> +             /* If controller is already scanning we are done. */
>> +             if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +                     return;
>> +
>> +             /* If controller is connecting, we should not start scanni=
ng
>> +              * since some controllers are not able to scan and connect=
 at
>> +              * the same time.
>> +              */
>> +             conn =3D hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONN=
ECT);
>> +             if (conn)
>> +                     return;
>> +
>> +             /* Use private address since remote doesn't need to identi=
fy us.
>> +              * Strictly speaking, this is not required since no SCAN_R=
EQ is
>> +              * sent in passive scanning.
>> +              */
>> +             if (hci_update_random_address(&req, true, &own_addr_type))
>> +                     return;
>
> the comment above is confusing. Reason is simple. We might use a RPA if L=
E Privacy has been enabled. The require_privacy =3D=3D true will fallback t=
o URPA in case privacy is not enabled. If privacy is enabled, then no matte=
r what require_privacy is set to, we will use a random address.
>
> It should say something along the lines of this:
>
>         /* Set require_privacy to true to avoid identification from
>          * unknown peer devices. Since this is passive scanning, no
>          * SCAN_REQ using the local identity should be sent. Mandating
>          * privacy is just an extra precaution.
>          */

Ok, I'll fix this comment.

BR,

Andre
