Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0D963057-25A4-464F-9964-3FFE13793E52@holtmann.org>
References: <1403725710-29750-1-git-send-email-andre.guedes@openbossa.org>
 <1403725710-29750-3-git-send-email-andre.guedes@openbossa.org> <0D963057-25A4-464F-9964-3FFE13793E52@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Wed, 25 Jun 2014 20:48:08 -0300
Message-ID: <CACJA=fURD9mLboG6Pq4Gb3CO9aHY3ASMMRMbL=BZ2gT4rxTUqQ@mail.gmail.com>
Subject: Re: [RFC 2/4] Bluetooth: Connection Parameter Update Procedure
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jun 25, 2014 at 5:18 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch adds support for LE Connection Parameters Request Link
>> Layer control procedure introduced in Core spec 4.1. This procedure
>> allows a Peripheral or Central to update the Link Layer connection
>> parameters of an established connection.
>>
>> Regarding the acceptance of connection parameters, the LL procedure
>> follows the same approach of L2CAP procedure (see l2cap_conn_param_
>> update_req function). We accept any connection parameters values as
>> long as they are within the valid range.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci.h | 28 +++++++++++++++++++++++++
>> net/bluetooth/hci_event.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 78 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index cc2e88d..59bad0b 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -355,6 +355,7 @@ enum {
>> #define HCI_LK_AUTH_COMBINATION_P256  0x08
>>
>> /* ---- HCI Error Codes ---- */
>> +#define HCI_ERROR_UNKNOWN_CONN_ID    0x02
>> #define HCI_ERROR_AUTH_FAILURE                0x05
>> #define HCI_ERROR_MEMORY_EXCEEDED     0x07
>> #define HCI_ERROR_CONNECTION_TIMEOUT  0x08
>> @@ -364,6 +365,7 @@ enum {
>> #define HCI_ERROR_REMOTE_POWER_OFF    0x15
>> #define HCI_ERROR_LOCAL_HOST_TERM     0x16
>> #define HCI_ERROR_PAIRING_NOT_ALLOWED 0x18
>> +#define HCI_ERROR_INVALID_LL_PARAMS  0x1E
>> #define HCI_ERROR_ADVERTISING_TIMEOUT 0x3c
>>
>> /* Flow control modes */
>> @@ -1288,6 +1290,23 @@ struct hci_rp_le_read_supported_states {
>>       __u8    le_states[8];
>> } __packed;
>>
>> +#define HCI_OP_LE_CONN_PARAM_REQ_REPLY       0x2020
>> +struct hci_cp_le_conn_param_req_reply {
>> +     __le16  handle;
>> +     __le16  interval_min;
>> +     __le16  interval_max;
>> +     __le16  latency;
>> +     __le16  timeout;
>> +     __le16  min_ce_len;
>> +     __le16  max_ce_len;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CONN_PARAM_REQ_NEG_REPLY   0x2021
>> +struct hci_cp_le_conn_param_req_neg_reply {
>> +     __le16  handle;
>> +     __u8    reason;
>> +} __packed;
>> +
>> /* ---- HCI Events ---- */
>> #define HCI_EV_INQUIRY_COMPLETE               0x01
>>
>> @@ -1683,6 +1702,15 @@ struct hci_ev_le_ltk_req {
>>       __le16  ediv;
>> } __packed;
>>
>> +#define HCI_EV_LE_REMOTE_CONN_PARAM_REQ      0x06
>> +struct hci_ev_le_remote_conn_param_req {
>> +     __le16 handle;
>> +     __le16 interval_min;
>> +     __le16 interval_max;
>> +     __le16 latency;
>> +     __le16 timeout;
>> +} __packed;
>> +
>> /* Advertising report event types */
>> #define LE_ADV_IND            0x00
>> #define LE_ADV_DIRECT_IND     0x01
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 7a23324..4ded97b 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -4309,6 +4309,52 @@ not_found:
>>       hci_dev_unlock(hdev);
>> }
>>
>> +static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
>> +                                   u8 reason)
>> +{
>> +     struct hci_cp_le_conn_param_req_neg_reply cp;
>> +
>> +     cp.handle = cpu_to_le16(handle);
>> +     cp.reason = reason;
>> +
>> +     hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_NEG_REPLY, sizeof(cp),
>> +                  &cp);
>> +}
>> +
>> +static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
>> +                                          struct sk_buff *skb)
>> +{
>> +     struct hci_ev_le_remote_conn_param_req *ev = (void *) skb->data;
>> +     struct hci_cp_le_conn_param_req_reply cp;
>> +     struct hci_conn *hcon;
>> +     u16 handle, min, max, latency, timeout;
>> +
>> +     handle = le16_to_cpu(ev->handle);
>> +     min = le16_to_cpu(ev->interval_min);
>> +     max = le16_to_cpu(ev->interval_max);
>> +     latency = le16_to_cpu(ev->latency);
>> +     timeout = le16_to_cpu(ev->timeout);
>> +
>> +     hcon = hci_conn_hash_lookup_handle(hdev, handle);
>> +     if (!hcon || hcon->state != BT_CONNECTED)
>> +             return send_conn_param_neg_reply(hdev, handle,
>> +                                              HCI_ERROR_UNKNOWN_CONN_ID);
>> +
>> +     if (hci_check_conn_params(min, max, latency, timeout))
>> +             return send_conn_param_neg_reply(hdev, handle,
>> +                                              HCI_ERROR_INVALID_LL_PARAMS);
>> +
>> +     cp.handle = ev->handle;
>> +     cp.interval_min = ev->interval_min;
>> +     cp.interval_max = ev->interval_max;
>> +     cp.latency = ev->latency;
>> +     cp.timeout = ev->timeout;
>> +     cp.min_ce_len = 0;
>> +     cp.max_ce_len = 0;
>> +
>> +     hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
>> +}
>> +
>> static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
>> {
>>       struct hci_ev_le_meta *le_ev = (void *) skb->data;
>> @@ -4332,6 +4378,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>               hci_le_ltk_request_evt(hdev, skb);
>>               break;
>>
>> +     case HCI_EV_LE_REMOTE_CONN_PARAM_REQ:
>> +             hci_le_remote_conn_param_req_evt(hdev, skb);
>> +             break;
>> +
>
> you also need a patch that will enable this event.

Yes, I've missed that. I'll add a separate patch to enable this event.

Thanks,

Andre
