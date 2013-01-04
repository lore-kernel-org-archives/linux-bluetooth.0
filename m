Return-Path: <cyrus@holtmann.org>
Message-id: <D76CDD18C783483EAF643D1B392FFAEA@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1356094225-12706-1-git-send-email-jaganath.k@samsung.com>
 <1356094225-12706-3-git-send-email-jaganath.k@samsung.com>
 <20130103193837.GB2114@joana>
In-reply-to: <20130103193837.GB2114@joana>
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix stop discovery while in STARTING
 state
Date: Fri, 04 Jan 2013 13:16:11 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

--------------------------------------------------
From: "Gustavo Padovan" <gustavo@padovan.org>
Sent: Friday, January 04, 2013 1:08 AM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix stop discovery while in STARTING 
state

> Hi Jaganath,
>
> * Jaganath Kanakkassery <jaganath.k@samsung.com> [2012-12-21 18:20:25 
> +0530]:
>
>> If stop_discovery() is called when discovery state is STARTING, it
>> will be failed currently. This patch fixes this.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    2 ++
>>  net/bluetooth/hci_event.c        |   14 ++++++++++++--
>>  net/bluetooth/mgmt.c             |   31 ++++++++++++++++++++++++++++++-
>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h 
>> b/include/net/bluetooth/hci_core.h
>> index 119fcb6..c2886b7 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -64,6 +64,7 @@ struct discovery_state {
>>  DISCOVERY_RESOLVING,
>>  DISCOVERY_STOPPING,
>>  } state;
>> + u8  discovering;
>>  struct list_head all; /* All devices found during inquiry */
>>  struct list_head unknown; /* Name state not known */
>>  struct list_head resolve; /* Name needs to be resolved */
>> @@ -1066,6 +1067,7 @@ int mgmt_device_found(struct hci_dev *hdev, 
>> bdaddr_t *bdaddr, u8 link_type,
>>  int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 
>> link_type,
>>       u8 addr_type, s8 rssi, u8 *name, u8 name_len);
>>  int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
>> +int mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
>>  int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
>>  int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
>>  int mgmt_interleaved_discovery(struct hci_dev *hdev);
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index e248e7c..b486458 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1092,7 +1092,12 @@ static void hci_cc_le_set_scan_enable(struct 
>> hci_dev *hdev,
>>  set_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>>  hci_dev_lock(hdev);
>> - hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING) {
>> + hci_cancel_le_scan(hdev);
>> + mgmt_start_discovery_complete(hdev, 0);
>
> Reply to mgmt with an error here might be better.

I think the best error which can be given here is
MGMT_STATUS_CANCELLED. But this error is not accessible in hci_event.c

>> + } else {
>> + hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + }
>>  hci_dev_unlock(hdev);
>>  break;
>>
>> @@ -1189,7 +1194,12 @@ static void hci_cs_inquiry(struct hci_dev *hdev, 
>> __u8 status)
>>  set_bit(HCI_INQUIRY, &hdev->flags);
>>
>>  hci_dev_lock(hdev);
>> - hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING) {
>> + hci_cancel_inquiry(hdev);
>> + mgmt_start_discovery_complete(hdev, 0);
>> + } else {
>> + hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + }
>>  hci_dev_unlock(hdev);
>>  }
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index d6c0d78..ba4171f 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2385,7 +2385,8 @@ static int stop_discovery(struct sock *sk, struct 
>> hci_dev *hdev, void *data,
>>
>>  hci_dev_lock(hdev);
>>
>> - if (!hci_discovery_active(hdev)) {
>> + if (hdev->discovery.state != DISCOVERY_STARTING &&
>> +     !hci_discovery_active(hdev)) {
>>  err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
>>     MGMT_STATUS_REJECTED, &mgmt_cp->type,
>>     sizeof(mgmt_cp->type));
>> @@ -2433,6 +2434,10 @@ static int stop_discovery(struct sock *sk, struct 
>> hci_dev *hdev, void *data,
>>
>>  break;
>>
>> + case DISCOVERY_STARTING:
>> + err = 0;
>> + break;
>> +
>>  default:
>>  BT_DBG("unknown discovery state %u", hdev->discovery.state);
>>  err = -EFAULT;
>> @@ -3624,6 +3629,25 @@ int mgmt_start_discovery_failed(struct hci_dev 
>> *hdev, u8 status)
>>  return err;
>>  }
>>
>> +int mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status)
>> +{
>> + struct pending_cmd *cmd;
>> + u8 type;
>> + int err;
>> +
>> + cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
>> + if (!cmd)
>> + return -ENOENT;
>> +
>> + type = hdev->discovery.type;
>> +
>> + err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
>> +    &type, sizeof(type));
>> + mgmt_pending_remove(cmd);
>> +
>> + return err;
>> +}
>
> This is exactly the same thing as mgmt_start_discovery_failed(), just 
> rename it
> to _complete() as you did with mgmt_stop_discovery_failed(). Do it as a
> separate patch.

mgmt_start_discovery_failed() sets discovery state to STOPPED which also 
sends
stop_discovery_complete internally. I think both are inappropriate at the 
point
where mgmt_start_discovery_complete() is called.

How abt renaming the new function mgmt_start_discovery_complete() to
mgmt_start_discovery_cancelled and send MGMT_STATUS_CANCELLED in that?

This way your first comment also will be taken care.

Please let me know your opinion.

Thanks,
Jaganath
 

