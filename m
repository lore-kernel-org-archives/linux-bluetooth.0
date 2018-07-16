Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <685125A7-C980-49FE-B614-29703E4F0936@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-8-git-send-email-jaganathx.kanakkassery@intel.com> <685125A7-C980-49FE-B614-29703E4F0936@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 16 Jul 2018 11:57:37 +0530
Message-ID: <CAJzH+brjqyHKuXdYHO1cjzvfRDxLE6Sfp-_V092mhiTs6VUeXQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] Bluetooth: Read no of adv sets during init
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 14, 2018 at 11:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaganath,
>
>> This patch reads the number of advertising sets in the controller
>> during init and save it in hdev.
>>
>> This also checks ext adv support before send Read Adv TX Power
>> since legacy and extended Adv commands should not be mixed.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>> ---
>> include/net/bluetooth/hci.h      |  7 +++++++
>> include/net/bluetooth/hci_core.h |  4 ++++
>> net/bluetooth/hci_core.c         | 12 ++++++++++--
>> net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
>> 4 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index fcd1d57..e584863 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -411,6 +411,7 @@ enum {
>> #define HCI_LE_SLAVE_FEATURES         0x08
>> #define HCI_LE_PING                   0x10
>> #define HCI_LE_DATA_LEN_EXT           0x20
>> +#define HCI_LE_EXT_ADV                       0x10
>> #define HCI_LE_EXT_SCAN_POLICY                0x80
>> #define HCI_LE_PHY_2M                 0x01
>> #define HCI_LE_PHY_CODED              0x08
>> @@ -1580,6 +1581,12 @@ struct hci_cp_le_ext_conn_param {
>>       __le16 max_ce_len;
>> } __packed;
>>
>> +#define HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS        0x203b
>> +struct hci_rp_le_read_num_supported_adv_sets {
>> +     __u8  status;
>> +     __u8  num_of_sets;
>> +} __packed;
>> +
>> /* ---- HCI Events ---- */
>> #define HCI_EV_INQUIRY_COMPLETE               0x01
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 33aab89e..e845ca6 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -222,6 +222,7 @@ struct hci_dev {
>>       __u8            le_features[8];
>>       __u8            le_white_list_size;
>>       __u8            le_resolv_list_size;
>> +     __u8            le_no_of_adv_sets;
>
> I think our style was to use _num instead of _no. See num_iac for example.
>
>>       __u8            le_states[8];
>>       __u8            commands[64];
>>       __u8            hci_ver;
>> @@ -1180,6 +1181,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>> /* Use ext create connection if command is supported */
>> #define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
>>
>> +/* Extended advertising support */
>> +#define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
>> +
>> /* ----- HCI protocols ----- */
>> #define HCI_PROTO_DEFER             0x01
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 0d88dc9..b423587 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -715,8 +715,10 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>>               hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
>>                           events);
>>
>> -             if (hdev->commands[25] & 0x40) {
>> -                     /* Read LE Advertising Channel TX Power */
>> +             if ((hdev->commands[25] & 0x40) && !ext_adv_capable(hdev)) {
>> +                     /* Read LE Advertising Channel TX Power only if
>> +                      * extended advertising is not supported
>> +                      */
>>                       hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
>>               }
>
> Why? I prefer that we read the adv TX power always. Even if we are not using it, it is good to have it in the traces.

Mixing of legacy and extended commands is forbidden as per HCI TS spec
Please see  "HCI/GEV/BV-02-C [Disallow Mixing Legacy and Extended Advertising
Commands]"

Thanks,
Jaganath
