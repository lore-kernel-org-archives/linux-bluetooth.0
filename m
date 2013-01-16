Return-Path: <cyrus@holtmann.org>
Message-id: <B327FC7ABEF3480E9C05E237A509BE46@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1358254892-11303-1-git-send-email-jaganath.k@samsung.com>
 <1358254892-11303-3-git-send-email-jaganath.k@samsung.com>
 <1358266671.2445.1.camel@aeonflux>
In-reply-to: <1358266671.2445.1.camel@aeonflux>
Subject: Re: [PATCH v3 3/3] Bluetooth: Fix stop discovery while in STARTING
 state
Date: Wed, 16 Jan 2013 11:33:57 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=UTF-8; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

--------------------------------------------------
From: "Marcel Holtmann" <marcel@holtmann.org>
Sent: Tuesday, January 15, 2013 9:47 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Bluetooth: Fix stop discovery while in STARTING 
state

> Hi Jaganath,
>
>> If stop_discovery() is called when discovery state is STARTING, it
>> will be failed currently. This patch fixes this.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    1 +
>>  net/bluetooth/hci_event.c        |   14 ++++++++++++--
>>  net/bluetooth/mgmt.c             |   12 +++++++++++-
>>  3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h 
>> b/include/net/bluetooth/hci_core.h
>> index d8f68c7..01c723a 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -64,6 +64,7 @@ struct discovery_state {
>>  DISCOVERY_RESOLVING,
>>  DISCOVERY_STOPPING,
>>  } state;
>> + u8  discovering;
>
> what is this double spaces for? And why not a bool. Or a better name.

I just followed the type of "discovering" in mgmt_discovering(). I am not
sure why it is u8 and not bool since the possible values are only 0 and 1.
If you are ok with bool I will raise a separate patch to first change the 
type
of discovering in mgmt_discovering() and also in struct mgmt_ev_discovering.

>>  struct list_head all; /* All devices found during inquiry */
>>  struct list_head unknown; /* Name state not known */
>>  struct list_head resolve; /* Name needs to be resolved */
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 97b4828..c616cbf 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1259,7 +1259,12 @@ static void hci_cc_le_set_scan_enable(struct 
>> hci_dev *hdev,
>>  set_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>>  hci_dev_lock(hdev);
>> - hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING) {
>> + hci_cancel_le_scan(hdev);
>> + mgmt_start_discovery_cancelled(hdev);
>> + } else {
>> + hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + }
>>  hci_dev_unlock(hdev);
>>  break;
>>
>> @@ -1375,7 +1380,12 @@ static void hci_cs_inquiry(struct hci_dev *hdev, 
>> __u8 status)
>>  set_bit(HCI_INQUIRY, &hdev->flags);
>>
>>  hci_dev_lock(hdev);
>> - hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING) {
>> + hci_cancel_inquiry(hdev);
>> + mgmt_start_discovery_cancelled(hdev);
>> + } else {
>> + hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + }
>>  hci_dev_unlock(hdev);
>>  }
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 0db9d66..6dc275f 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2394,7 +2394,8 @@ static int stop_discovery(struct sock *sk, struct 
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
>> @@ -2442,6 +2443,10 @@ static int stop_discovery(struct sock *sk, struct 
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
>> @@ -3720,6 +3725,11 @@ int mgmt_discovering(struct hci_dev *hdev, u8 
>> discovering)
>>  mgmt_pending_remove(cmd);
>>  }
>>
>> + if (hdev->discovery.discovering == discovering)
>> + return 0;
>> +
>> + hdev->discovery.discovering = discovering;
>> +
>>  memset(&ev, 0, sizeof(ev));
>>  ev.type = hdev->discovery.type;
>>  ev.discovering = discovering;
>

Thanks,
Jaganath 
