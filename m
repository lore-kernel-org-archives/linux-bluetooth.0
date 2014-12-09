Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C08D7D21-92B7-468D-A630-A744738AA400@holtmann.org>
References: <1417823005-10262-1-git-send-email-jpawlowski@google.com>
	<C08D7D21-92B7-468D-A630-A744738AA400@holtmann.org>
Date: Tue, 9 Dec 2014 09:32:55 +0100
Message-ID: <CAD0=r8yUn0Z6dQ7XgzpwFysB0Km+q4_cOFU2JfOOs7=3Kd+XOw@mail.gmail.com>
Subject: Re: [RFC v4 1/2] Bluetooth: Add le_scan_restart
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 9, 2014 at 7:32 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> Currently there is no way to restart le scan, and it's needed in
>> service scan method. The way it work: it disable, and then enable le
>> scan on controller. During this restart special flag is set to make
>> sure we won't remove disable scan work from workqueue.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>> include/net/bluetooth/hci_core.h |  9 +++++++++
>> net/bluetooth/hci_core.c         | 42 ++++++++++++++++++++++++++++++++++++++++
>> net/bluetooth/hci_event.c        |  9 ++++++---
>> 3 files changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 3c78270..53e7975 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -56,6 +56,13 @@ struct inquiry_entry {
>>       struct inquiry_data     data;
>> };
>>
>> +/* BR/EDR and/or LE discovery state flags: the flags defined here should
>> + * represent state of discovery
>> + */
>> +enum {
>> +     HCI_LE_SCAN_RESTARTING,
>> +};
>> +
>> struct discovery_state {
>>       int                     type;
>>       enum {
>> @@ -79,6 +86,7 @@ struct discovery_state {
>>       s8                      rssi;
>>       u16                     uuid_count;
>>       u8                      (*uuids)[16];
>> +     unsigned long           flags;
>> };
>>
>> struct hci_conn_hash {
>> @@ -343,6 +351,7 @@ struct hci_dev {
>>       unsigned long           dev_flags;
>>
>>       struct delayed_work     le_scan_disable;
>> +     struct delayed_work     le_scan_restart;
>>
>>       __s8                    adv_tx_power;
>>       __u8                    adv_data[HCI_MAX_AD_LENGTH];
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 93f92a0..273311f 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2624,6 +2624,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>>               cancel_delayed_work(&hdev->service_cache);
>>
>>       cancel_delayed_work_sync(&hdev->le_scan_disable);
>> +     cancel_delayed_work_sync(&hdev->le_scan_restart);
>>
>>       if (test_bit(HCI_MGMT, &hdev->dev_flags))
>>               cancel_delayed_work_sync(&hdev->rpa_expired);
>> @@ -3892,6 +3893,8 @@ static void le_scan_disable_work(struct work_struct *work)
>>
>>       BT_DBG("%s", hdev->name);
>>
>> +     cancel_delayed_work_sync(&hdev->le_scan_restart);
>> +
>>       hci_req_init(&req, hdev);
>>
>>       hci_req_add_le_scan_disable(&req);
>> @@ -3901,6 +3904,44 @@ static void le_scan_disable_work(struct work_struct *work)
>>               BT_ERR("Disable LE scanning request failed: err %d", err);
>> }
>>
>> +static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
>> +{
>> +     clear_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags);
>> +
>> +     if (status)
>> +             BT_ERR("Failed to restart LE scan: status %d", status);
>
> if this actually happens, don't we have to actually tell userspace that discovery stopped now? It seems we need some error handling here.

So the error should be sent when stopping succeed, but starting
failed? I'll check scan status here with  if (!test_bit(HCI_LE_SCAN,
&hdev->dev_flags)) and report error if we're not scanning.

>
>> +}
>> +
>> +static void le_scan_restart_work(struct work_struct *work)
>> +{
>> +     struct hci_dev *hdev = container_of(work, struct hci_dev,
>> +                                         le_scan_restart.work);
>> +     struct hci_request req;
>> +     struct hci_cp_le_set_scan_enable cp;
>> +     int err;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     /* If controller is not scanning we are done. */
>> +     if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +             return;
>
> Why are we queueing this work in the first place if we are not scanning. That should be done at the calling site already.

We're queuing this work only if we are scanning, but between queuing
and execution scan might become disabled, so we have to check again
here.

>
> Same as we should check for HCI_QUIRK_STRICT_DUPLICATE_FILTER setting and only do the restart scan stuff if the driver told us that this controller is not providing multiple reports.

So I did some tests on 4 controllers I described in this email:
http://marc.info/?l=linux-bluetooth&m=141764424929887&w=2
I think that HCI_QUIRK_STRICT_DUPLICATE_FILTER wil be valid if we were
doing HCI_OP_INQUIRY, when I was using HCI_OP_LE_SET_SCAN_ENABLE with
LE_SCAN_FILTER_DUP_ENABLE none of the controllers I used reported
device twice with different RSSI except for marevell, which seems to
ignore
LE_SCAN_FILTER_DUP_ENABLE, and reports all advertisements.

The way I conducted this tests was to start the scan "tools/mgmt find
-l", and try to approach (15-20 meters) or move away from scanning
device, walk back and forth, or just keep the advertiser in place. I
was monitoring both btmgmt output and dmesg kernel logs (I added some
additional BT_INFO to make sure I won't miss anything)

Do you have different experience for LE scan ? Or maybe I just picked
wrong controllers for my tests ?

>
>> +
>> +     hci_req_init(&req, hdev);
>> +
>> +     hci_req_add_le_scan_disable(&req);
>> +
>> +     memset(&cp, 0, sizeof(cp));
>> +     cp.enable = LE_SCAN_ENABLE;
>> +     cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
>> +     hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> +
>> +     set_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags);
>> +
>> +     err = hci_req_run(&req, le_scan_restart_work_complete);
>> +     if (err)
>> +             BT_ERR("Restart LE scan request failed: err %d", err);
>> +}
>> +
>> static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
>> {
>>       struct hci_dev *hdev = req->hdev;
>> @@ -4078,6 +4119,7 @@ struct hci_dev *hci_alloc_dev(void)
>>       INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
>>       INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
>>       INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
>> +     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
>>
>>       skb_queue_head_init(&hdev->rx_q);
>>       skb_queue_head_init(&hdev->cmd_q);
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 322abbb..cefb35d 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1157,10 +1157,13 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>>                                         d->last_adv_data_len, NULL, 0);
>>               }
>>
>> -             /* Cancel this timer so that we don't try to disable scanning
>> -              * when it's already disabled.
>> +             /* If HCI_LE_SCAN_RESTARTING is set, don't cancel this timer,
>> +              * because we're just restarting scan. Otherwise cancel it so
>> +              * that we don't try to disable scanning when it's already
>> +              * disabled.
>>                */
>> -             cancel_delayed_work(&hdev->le_scan_disable);
>> +             if (!test_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags))
>> +                     cancel_delayed_work(&hdev->le_scan_disable);
>
> This could be racy. We are restarting, but it also means that we will enable scanning again. So in case we are caught in the middle of this we might end up with scanning enabled.

So the proper solution would be to add new lock that would have to be
acquired before using HCI_OP_LE_SET_SCAN_ENABLE (for both enabling and
disabling), and modify all occurences to use this lock.

So all calls will do:

1. acquire LE scan lock
2. disable or enable LE scan
3. release LE scan lock

and restart le will do:

1. acquire LE scan lock
2. disable LE scan
3. enable LE scan
4. release LE scan lock

will that be ok ?

>
>>
>>               clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
>
> Regards
>
> Marcel
>
