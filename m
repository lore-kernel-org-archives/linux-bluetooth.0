Return-Path: <cyrus@holtmann.org>
Message-id: <A61279851DE7416A8CD10DFCF95D37D2@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1354791958-28334-1-git-send-email-jaganath.k@samsung.com>
 <1354791958-28334-4-git-send-email-jaganath.k@samsung.com>
 <20121211221534.GA7912@joana>
In-reply-to: <20121211221534.GA7912@joana>
Subject: Re: [PATCH 3/3 v1] Bluetooth: Fix stop discovery while in STARTING
 state
Date: Tue, 18 Dec 2012 18:57:50 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

--------------------------------------------------
From: "Gustavo Padovan" <gustavo@padovan.org>
Sent: Wednesday, December 12, 2012 3:45 AM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3 v1] Bluetooth: Fix stop discovery while in STARTING 
state

> Hi Jaganath,
>
> * Jaganath Kanakkassery <jaganath.k@samsung.com> [2012-12-06 16:35:58 
> +0530]:
>
>> If stop_discovery() is called when discovery state is STARTING, it
>> will be failed currently. This patch fixes this.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    1 +
>>  net/bluetooth/hci_core.c         |    9 ++++++++-
>>  net/bluetooth/hci_event.c        |   15 +++++++++++++--
>>  net/bluetooth/mgmt.c             |    9 +++++++++
>>  4 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h 
>> b/include/net/bluetooth/hci_core.h
>> index bd63a9f..d09777a 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -64,6 +64,7 @@ struct discovery_state {
>>  DISCOVERY_RESOLVING,
>>  DISCOVERY_STOPPING,
>>  } state;
>> + int prev_state;
>>  struct list_head all; /* All devices found during inquiry */
>>  struct list_head unknown; /* Name state not known */
>>  struct list_head resolve; /* Name needs to be resolved */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index c6c67b2..93d0261 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -391,7 +391,13 @@ void hci_discovery_set_state(struct hci_dev *hdev, 
>> int state)
>>
>>  switch (state) {
>>  case DISCOVERY_STOPPED:
>> - if (hdev->discovery.state != DISCOVERY_STARTING)
>> + if (hdev->discovery.state == DISCOVERY_STARTING)
>> + break;
>> +
>> + if (hdev->discovery.state == DISCOVERY_STOPPING &&
>> +     hdev->discovery.prev_state == DISCOVERY_STARTING)
>> + mgmt_stop_discovery_complete(hdev, 0);
>> + else
>>  mgmt_discovering(hdev, 0);
>
> I don't think we need to be this complicated here, I don't think that add
> discovery.prev_state is a good a idea. I would prefer if you add
> discovery.discovering that will tell if we are discovering or not, then 
> check
> inside mgmt_discovering() if the value is the same and return right away.
> You would just need to add the mgmt_stop_discovery_complete() in case 
> state is
> DISCOVERY_STOPPING.
>

I think in this case no need to call mgmt_stop_discovery_complete() 
explicitly.
mgmt_discovering() with discovering 0 will send stop_discovery_complete().
So after sending command complete we can check the value of discovering and
return.

But one thing I see in this scenario is, when we should send 
start_discovery_complete()?
What I think is in SCAN_ENABLED event if state is STOPPING we can send
start_discovery_complete with MGMT_STATUS _CANCELLED error code.
What do you think?

>>  break;
>>  case DISCOVERY_STARTING:
>> @@ -405,6 +411,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, 
>> int state)
>>  break;
>>  }
>>
>> + hdev->discovery.prev_state = hdev->discovery.state;
>>  hdev->discovery.state = state;
>>  }
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 1fadba5..3f9f317 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1085,6 +1085,8 @@ static void hci_cc_le_set_scan_enable(struct 
>> hci_dev *hdev,
>>  if (status) {
>>  hci_dev_lock(hdev);
>>  mgmt_start_discovery_failed(hdev, status);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING)
>> + mgmt_stop_discovery_complete(hdev, status);
>
> I think this case will be handled by hci_discovery_set_state(), and you 
> could
> just remove this from here. And why you return the set_scan_enable status
> error to the stop discovery command?
>
Ok

>>  hci_dev_unlock(hdev);
>>  return;
>>  }
>> @@ -1092,7 +1094,10 @@ static void hci_cc_le_set_scan_enable(struct 
>> hci_dev *hdev,
>>  set_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>>  hci_dev_lock(hdev);
>> - hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING)
>> + hci_cancel_le_scan(hdev);
>> + else
>> + hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>>  hci_dev_unlock(hdev);
>>  break;
>>
>> @@ -1180,8 +1185,11 @@ static void hci_cs_inquiry(struct hci_dev *hdev, 
>> __u8 status)
>>  hci_req_complete(hdev, HCI_OP_INQUIRY, status);
>>  hci_conn_check_pending(hdev);
>>  hci_dev_lock(hdev);
>> - if (test_bit(HCI_MGMT, &hdev->dev_flags))
>> + if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
>>  mgmt_start_discovery_failed(hdev, status);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING)
>> + mgmt_stop_discovery_complete(hdev, status);
>> + }
>
> Saome thing as the previous comment, you don't need this.
> mgmt_start_discovery_failed() calls hci_discovery_set_state().
>

Ok

>>  hci_dev_unlock(hdev);
>>  return;
>>  }
>> @@ -1189,6 +1197,9 @@ static void hci_cs_inquiry(struct hci_dev *hdev, 
>> __u8 status)
>>  set_bit(HCI_INQUIRY, &hdev->flags);
>>
>>  hci_dev_lock(hdev);
>> + if (hdev->discovery.state == DISCOVERY_STOPPING)
>> + hci_cancel_inquiry(hdev);
>> + else
>>  hci_discovery_set_state(hdev, DISCOVERY_FINDING);
>
> Wrong indentation level inside the else.
>

Will correct in the next patch.

>>  hci_dev_unlock(hdev);
>>  }
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 332152b..a645494 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2387,6 +2387,11 @@ static int stop_discovery(struct sock *sk, struct 
>> hci_dev *hdev, void *data,
>>
>>  hci_dev_lock(hdev);
>>
>> + if (hdev->discovery.state == DISCOVERY_STARTING) {
>> + err = 0;
>> + goto proceed;
>> + }
>> +
>>  if (!hci_discovery_active(hdev)) {
>
> I would do something like this instead:
>
>        if (hdev->discovery.state != DISCOVERY_STARTING &&
>             !hci_discovery_active(hdev)) {
>
>
> And remove the label jump from here...
>

Ok

>>  err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
>>     MGMT_STATUS_REJECTED, &mgmt_cp->type,
>> @@ -2401,6 +2406,7 @@ static int stop_discovery(struct sock *sk, struct 
>> hci_dev *hdev, void *data,
>>  goto unlock;
>>  }
>>
>> +proceed:
>>  cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
>>  if (!cmd) {
>>  err = -ENOMEM;
>> @@ -2435,6 +2441,9 @@ static int stop_discovery(struct sock *sk, struct 
>> hci_dev *hdev, void *data,
>>
>>  break;
>>
>> + case DISCOVERY_STARTING:
>
> and add err = 0 here.
>
Ok

Thanks,
Jaganath 

