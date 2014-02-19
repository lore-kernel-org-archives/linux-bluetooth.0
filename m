Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9E70336A-B971-4FBB-A185-0F28BE27A5F5@holtmann.org>
References: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
 <1392754534-12747-6-git-send-email-andre.guedes@openbossa.org> <9E70336A-B971-4FBB-A185-0F28BE27A5F5@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 19 Feb 2014 13:37:42 -0300
Message-ID: <CACJA=fU_x9vDMcsQ2+Q4mNmiEHYjH2u-TsXty3FOE7m=03PJUQ@mail.gmail.com>
Subject: Re: [RFC v10 06/10] Bluetooth: Introduce LE auto connection infrastructure
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014 at 5:52 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
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
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |  2 +
>> net/bluetooth/hci_conn.c         |  5 +++
>> net/bluetooth/hci_core.c         | 83 ++++++++++++++++++++++++++++++++++=
+++++-
>> net/bluetooth/hci_event.c        | 44 +++++++++++++++++++++
>> 4 files changed, 132 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index f0617ab..297b954 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -788,6 +788,8 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bdad=
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
>> index 0ae7692..e291d68 100644
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
>> index 992f9ea..18ef960 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3114,7 +3114,7 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bd=
addr_t *addr, u8 addr_type)
>>
>>       entry =3D hci_pend_le_conn_lookup(hdev, addr, addr_type);
>>       if (entry)
>> -             return;
>> +             goto done;
>>
>>       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
>>       if (!entry) {
>> @@ -3128,6 +3128,9 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, bd=
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
>> @@ -3137,12 +3140,15 @@ void hci_pend_le_conn_del(struct hci_dev *hdev, =
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
>> @@ -4706,3 +4712,76 @@ void hci_req_add_le_scan_disable(struct hci_reque=
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
>> +             memset(&param_cp, 0, sizeof(param_cp));
>> +             param_cp.type =3D LE_SCAN_PASSIVE;
>> +             param_cp.interval =3D cpu_to_le16(hdev->le_scan_interval);
>> +             param_cp.window =3D cpu_to_le16(hdev->le_scan_window);
>> +             hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_c=
p),
>> +                         &param_cp);
>> +
>> +             memset(&enable_cp, 0, sizeof(enable_cp));
>> +             enable_cp.enable =3D LE_SCAN_ENABLE;
>> +             enable_cp.filter_dup =3D LE_SCAN_FILTER_DUP_DISABLE;
>> +             hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable=
_cp),
>> +                         &enable_cp);
>> +
>> +             BT_DBG("%s starting background scanning", hdev->name);
>> +     }
>
> so I was inclined to take the whole patch set as it is, but this code is =
not useful at all at the moment.
>
> Disabling the duplicate filter is a horrible idea. I just have my control=
ler going crazy. I rather background scan with the filter enabled and then =
from time to time disable scanning and start it again to make sure that new=
 devices are captured. This idea of reporting everything up to the host eve=
ry single time is insane.

How many time should we wait to re-enable scan?

> Also we need to fine tune the scan_interval and scan_window we use for co=
nnection attempts for background scanning. This is just crazy. We have a mg=
mt command that lets us configure these values. So please make sure that it=
 integrates with the background scanning and allows us to change these para=
meters on the fly. I want to see what kind of difference different values m=
ake.

The "Set Scan Parameters" command and the background scan are already
integrated. I'll just add an extra patch to restart background scan if
scan parameters are changed.

> There is a difference between we lost our link and want to reconnect as q=
uickly as possible. And hey, we have some devices that we might want to con=
nect to. When you find it, go ahead and connect, but no hurry type of conne=
ction establishment.
>
> And most importantly. Make sure this works with the RPA resolving work th=
at we just merged. I am testing this against my iPhone and auto-connect is =
not picking up my public identity address.

Ok.

Regards,

Andre
