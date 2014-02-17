Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B1545869-A8B6-4E2B-83AA-EF425235F79E@holtmann.org>
References: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org>
 <1391639006-26311-4-git-send-email-andre.guedes@openbossa.org> <B1545869-A8B6-4E2B-83AA-EF425235F79E@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Mon, 17 Feb 2014 17:24:53 -0300
Message-ID: <CACJA=fXqQL5TwKfOWj-PaHSLvZb-3EbPUnpcUMWXM8rU07zQUQ@mail.gmail.com>
Subject: Re: [RFC v8 04/10] Bluetooth: Remove unused function
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 14, 2014 at 7:28 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch removes hci_create_le_conn() since it is not used anymore.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_conn.c | 32 --------------------------------
>> 1 file changed, 32 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 166d7a5..70f4226 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -551,38 +551,6 @@ done:
>>       hci_dev_unlock(hdev);
>> }
>>
>> -static int hci_create_le_conn(struct hci_conn *conn)
>> -{
>> -     struct hci_dev *hdev = conn->hdev;
>> -     struct hci_cp_le_create_conn cp;
>> -     struct hci_request req;
>> -     int err;
>> -
>> -     hci_req_init(&req, hdev);
>> -
>> -     memset(&cp, 0, sizeof(cp));
>> -     cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
>> -     cp.scan_window = cpu_to_le16(hdev->le_scan_window);
>> -     bacpy(&cp.peer_addr, &conn->dst);
>> -     cp.peer_addr_type = conn->dst_type;
>> -     cp.own_address_type = conn->src_type;
>> -     cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
>> -     cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
>> -     cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
>> -     cp.min_ce_len = __constant_cpu_to_le16(0x0000);
>> -     cp.max_ce_len = __constant_cpu_to_le16(0x0000);
>> -
>> -     hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
>> -
>> -     err = hci_req_run(&req, create_le_conn_complete);
>> -     if (err) {
>> -             hci_conn_del(conn);
>> -             return err;
>> -     }
>> -
>> -     return 0;
>> -}
>> -
>> static void create_le_conn_req(struct hci_request *req, struct hci_conn *conn)
>> {
>>       struct hci_cp_le_create_conn cp;
>
> not about this patch, but with my other comment, this one might be better renamed into hci_req_add_le_create_conn at some point. Not urgent though.

I'll rename it.

BR,

Andre
