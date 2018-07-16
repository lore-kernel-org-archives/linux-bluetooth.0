Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2ACE1635-8F05-49CD-A7D0-20A70352E997@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-11-git-send-email-jaganathx.kanakkassery@intel.com> <2ACE1635-8F05-49CD-A7D0-20A70352E997@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 16 Jul 2018 13:51:28 +0530
Message-ID: <CAJzH+brLGRC+HmZPvtFdfsEeadQPt4dZ7GBmBfx-pcKQKcW9bQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/13] Bluetooth: Implement disable and removal of adv instance
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 15, 2018 at 12:20 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaganath,
>
>> If ext adv is enabled then use ext adv to disable as well.
>> Also remove the adv set during LE disable.
>>
>> < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 2
>>        Extended advertising: Disabled (0x00)
>>        Number of sets: Disable all sets (0x00)
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
>>        Status: Success (0x00)
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>> ---
>> include/net/bluetooth/hci.h |  7 +++++++
>> net/bluetooth/hci_event.c   |  2 ++
>> net/bluetooth/hci_request.c | 22 ++++++++++++++++++++--
>> net/bluetooth/hci_request.h |  1 +
>> net/bluetooth/mgmt.c        |  3 +++
>> 5 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 5b84d9a..1a68530 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -1648,6 +1648,13 @@ struct hci_cp_le_set_ext_scan_rsp_data {
>>
>> #define LE_SET_ADV_DATA_NO_FRAG               0x01
>>
>> +#define HCI_OP_LE_REMOVE_ADV_SET     0x203c
>> +struct hci_cp_le_remove_adv_set {
>> +     __u8  handle;
>> +} __packed;
>> +
>> +#define HCI_OP_LE_CLEAR_ADV_SETS     0x203d
>> +
>> /* ---- HCI Events ---- */
>> #define HCI_EV_INQUIRY_COMPLETE               0x01
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index e17002f..e703880 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1129,6 +1129,8 @@ static void hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev,
>>                       queue_delayed_work(hdev->workqueue,
>>                                          &conn->le_conn_timeout,
>>                                          conn->conn_timeout);
>> +     } else {
>> +             hci_dev_clear_flag(hdev, HCI_LE_ADV);
>>       }
>>
>>       hci_dev_unlock(hdev);
>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>> index 5fde161..7051c5b 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -933,9 +933,19 @@ static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
>>
>> void __hci_req_disable_advertising(struct hci_request *req)
>> {
>> -     u8 enable = 0x00;
>> +     if (ext_adv_capable(req->hdev)) {
>> +             struct hci_cp_le_set_ext_adv_enable cp;
>>
>> -     hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
>> +             cp.enable = 0x00;
>> +             /* Disable all adv sets */
>> +             cp.num_of_sets = 0x00;
>
> I would prefer a more details comment that we can disable all sets since we only support one set at the moment anyway.
>
>> +
>> +             hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp), &cp);
>> +     } else {
>> +             u8 enable = 0x00;
>> +
>> +             hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
>> +     }
>> }
>>
>> static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
>> @@ -1417,6 +1427,11 @@ static void adv_timeout_expire(struct work_struct *work)
>>       hci_dev_unlock(hdev);
>> }
>>
>> +void __hci_req_clear_ext_adv_sets(struct hci_request *req)
>> +{
>> +     hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, 0, NULL);
>
> Actually this needs a comment as well to note that this is fine since we are just using a single set at the moment.

Clear ext adv set can be used only to clear all the adv sets. So this
will be same
in case of single set or more than one set.

Thanks,
Jaganath
