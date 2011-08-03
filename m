Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110803184826.GD28119@joana>
References: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
 <1312310109-27082-7-git-send-email-anderson.briglia@openbossa.org> <20110803184826.GD28119@joana>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 3 Aug 2011 15:09:50 -0400
Message-ID: <CALJ2SB+H4v=18rYhYrD+FMSH5Keo-oFPNqwAYU+J6N-1PT=VLQ@mail.gmail.com>
Subject: Re: [RFC 6/7] Bluetooth: Add RSSI Monitor timer and list lock
To: Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

On Wed, Aug 3, 2011 at 2:48 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> Hi Briglia,
>
> * Anderson Briglia <anderson.briglia@openbossa.org> [2011-08-02 14:35:08 -0400]:
>
>> This is the polling mechanism to send HCI Read RSSI commands. The
>> command responses are used by the RSSI Monitor to get the current RSSI
>> value and calculate the current alert level for a given monitored
>> connection.
>>
>> This patch also adds read and write locks on rssi_monitor_list in
>> order to avoid race conditions.
>>
>> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
>> ---
>>  include/net/bluetooth/hci_core.h |    3 +
>>  net/bluetooth/hci_core.c         |   12 +++++
>>  net/bluetooth/mgmt.c             |   99 ++++++++++++++++++++++++++++++++++----
>>  3 files changed, 104 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index a3cf433..8ff3448 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -211,6 +211,8 @@ struct hci_dev {
>>
>>       struct timer_list       le_scan_timer;
>>
>> +     struct timer_list       rssi_monitor_timer;
>
> call this rssi_timer is enough.
>
>> +
>>       struct hci_dev_stats    stat;
>>
>>       struct sk_buff_head     driver_init;
>> @@ -869,6 +871,7 @@ int mgmt_has_pending_stop_discov(u16 index);
>>  int mgmt_cancel_discovery(u16 index);
>>  int mgmt_is_interleaved_discovery(u16 index);
>>  int mgmt_do_interleaved_discovery(u16 index);
>> +void mgmt_do_read_rssi(struct hci_dev *hdev);
>>
>>  /* HCI info for socket */
>>  #define hci_pi(sk) ((struct hci_pinfo *) sk)
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index c0c46bf..eb51b94 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1449,6 +1449,14 @@ static void hci_disable_le_scan(unsigned long arg)
>>       hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>>  }
>>
>> +static void hci_do_read_rssi(unsigned long arg)
>> +{
>> +     struct hci_dev *hdev = (void *) arg;
>> +
>> +     if (test_bit(HCI_UP, &hdev->flags))
>> +             mgmt_do_read_rssi(hdev);
>> +}
>> +
>>  /* Register HCI device */
>>  int hci_register_dev(struct hci_dev *hdev)
>>  {
>> @@ -1522,6 +1530,9 @@ int hci_register_dev(struct hci_dev *hdev)
>>       setup_timer(&hdev->le_scan_timer, hci_disable_le_scan,
>>                                               (unsigned long) hdev);
>>
>> +     setup_timer(&hdev->rssi_monitor_timer, hci_do_read_rssi,
>> +                                             (unsigned long) hdev);
>> +
>>       INIT_WORK(&hdev->power_on, hci_power_on);
>>       INIT_WORK(&hdev->power_off, hci_power_off);
>>       setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
>> @@ -1604,6 +1615,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
>>       hci_del_off_timer(hdev);
>>       del_timer(&hdev->adv_timer);
>>       del_timer(&hdev->le_scan_timer);
>> +     del_timer(&hdev->rssi_monitor_timer);
>>
>>       destroy_workqueue(hdev->workqueue);
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 65ddbff..b034290 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -48,6 +48,8 @@ enum bt_device_type {
>>  #define RSSI_MONITOR_ALERT_LOW               0x01
>>  #define RSSI_MONITOR_ALERT_HIGH              0x02
>>
>> +#define RSSI_MONITOR_TIMEOUT         2000
>> +
>>  struct pending_cmd {
>>       struct list_head list;
>>       __u16 opcode;
>> @@ -70,6 +72,9 @@ struct rssi_monitor {
>>
>>  static LIST_HEAD(rssi_monitor_list);
>>
>> +static rwlock_t rssi_monitor_list_lock;
>> +static DEFINE_RWLOCK(rssi_monitor_list_lock);
>
> Use a normal spinlock here.

Ok.
>
>> +
>>  static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
>>  {
>>       struct sk_buff *skb;
>> @@ -1916,21 +1921,46 @@ static struct rssi_monitor *rssi_monitor_find(u16 index, bdaddr_t *bdaddr)
>>       return NULL;
>>  }
>>
>> +static void rssi_monitor_start(u16 index)
>> +{
>> +     struct hci_dev *hdev;
>> +
>> +     if (list_empty(&rssi_monitor_list))
>> +             return;
>> +
>> +     hdev = hci_dev_get(index);
>> +     if (!hdev)
>> +             return;
>> +
>> +     mod_timer(&hdev->rssi_monitor_timer, jiffies +
>> +                     msecs_to_jiffies(RSSI_MONITOR_TIMEOUT));
>> +     hci_dev_put(hdev);
>> +}
>> +
>>  static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
>>                                                       s8 high_trigger)
>>  {
>>       struct rssi_monitor *rm;
>> +     int err = 0;
>>
>> -     if (rssi_monitor_find(index, bdaddr))
>> -             return -EEXIST;
>> +     write_lock_bh(&rssi_monitor_list_lock);
>> +
>> +     if (rssi_monitor_find(index, bdaddr)) {
>> +             err = -EEXIST;
>> +             goto out;
>> +     }
>>
>>       if (low_trigger < -127 || low_trigger > 128 ||
>> -                     high_trigger < -127 || high_trigger > 128)
>> -             return -EINVAL;
>> +                     high_trigger < -127 || high_trigger > 128) {
>> +             err = -EINVAL;
>> +             goto out;
>> +     }
>>
>>       rm = kzalloc(sizeof(*rm), GFP_ATOMIC);
>> -     if (!rm)
>> -             return -ENOMEM;
>> +     if (!rm) {
>> +             err = -ENOMEM;
>> +             goto out;
>> +     }
>>
>>       rm->index = index;
>>       bacpy(&rm->bdaddr, bdaddr);
>> @@ -1940,20 +1970,46 @@ static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
>>
>>       list_add(&rm->list, &rssi_monitor_list);
>>
>> -     return 0;
>> +     rssi_monitor_start(index);
>> +
>> +out:
>> +     write_unlock_bh(&rssi_monitor_list_lock);
>> +     return err;
>>  }
>>
>>  static int rssi_monitor_remove(u16 index, bdaddr_t *bdaddr)
>>  {
>>       struct rssi_monitor *rm;
>> +     struct hci_dev *hdev;
>> +     int err = 0;
>> +
>> +     write_lock_bh(&rssi_monitor_list_lock);
>>
>>       rm = rssi_monitor_find(index, bdaddr);
>> -     if (!rm)
>> -             return -EINVAL;
>> +     if (!rm) {
>> +             err = -EINVAL;
>> +             goto out;
>> +     }
>>
>>       list_del(&rm->list);
>> +     kfree(rm);
>>
>> -     return 0;
>> +     if (!list_empty(&rssi_monitor_list))
>> +             goto out;
>
> This need to be a per hdev list, otherwise we will only disable the timer if
> there is no monitor for all adapters.

Agreed. Will fix it.

>
>> +
>> +     hdev = hci_dev_get(index);
>> +     if (!hdev) {
>> +             err = -EINVAL;
>> +             goto out;
>> +     }
>> +
>> +     del_timer(&hdev->rssi_monitor_timer);
>> +
>> +     hci_dev_put(hdev);
>> +
>> +out:
>> +     write_unlock_bh(&rssi_monitor_list_lock);
>> +     return err;
>>  }
>>
>>  static int enable_rssi_monitor(struct sock *sk, u16 index,
>> @@ -1995,7 +2051,11 @@ static int rssi_monitor_send_alert(u16 index, bdaddr_t *bdaddr, s8 rssi)
>>       struct mgmt_ev_rssi_monitor_alert ev;
>>       u8 alert;
>>
>> +     read_lock(&rssi_monitor_list_lock);
>> +
>>       rm = rssi_monitor_find(index, bdaddr);
>> +
>> +     read_unlock(&rssi_monitor_list_lock);
>>       if (!rm)
>>               return -EINVAL;
>>
>> @@ -2718,3 +2778,22 @@ void mgmt_read_rssi_complete(u16 index, bdaddr_t *bdaddr, s8 rssi, u8 status)
>>
>>       rssi_monitor_send_alert(index, bdaddr, rssi);
>>  }
>> +
>> +void mgmt_do_read_rssi(struct hci_dev *hdev)
>> +{
>> +     struct rssi_monitor *rm;
>> +
>> +     read_lock(&rssi_monitor_list_lock);
>> +
>> +     list_for_each_entry(rm, &rssi_monitor_list, list) {
>> +
>> +             if (rm->index != hdev->id)
>> +                     continue;
>> +
>> +             mgmt_read_rssi(hdev, &rm->bdaddr);
>> +     }
>
> Per adapter list could make this code better as well.

The idea to keep this list only into Management module was to avoid
modifications in other part of bluetooth code since this RSSI
monitoring is expected to be implemented inside the controllers. But I
agree with you, if we have this list per adapter it could simplify the
code. What should I do? Move the list to hdev?

Briglia

>
>        Gustavo
>



-- 
INdT - Instituto Nokia de tecnologia
+55 92 2126 1122
+55 92 8423 3183
