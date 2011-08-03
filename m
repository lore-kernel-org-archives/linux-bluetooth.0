Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBeW+kcfadcTbnPgY6H+CUjxMvTkrVofNc4d88ox1dvY3A@mail.gmail.com>
References: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
 <1312310109-27082-7-git-send-email-anderson.briglia@openbossa.org> <CAKT1EBeW+kcfadcTbnPgY6H+CUjxMvTkrVofNc4d88ox1dvY3A@mail.gmail.com>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Wed, 3 Aug 2011 15:10:26 -0400
Message-ID: <CALJ2SBK9DD5aNbFiA8V-em2fg7Q=MoKLDTVi0zYUJsRGGg9Lgg@mail.gmail.com>
Subject: Re: [RFC 6/7] Bluetooth: Add RSSI Monitor timer and list lock
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Aug 3, 2011 at 3:01 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Briglia,
>
> On Tue, Aug 2, 2011 at 3:35 PM, Anderson Briglia
> <anderson.briglia@openbossa.org> wrote:
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
>>        struct timer_list       le_scan_timer;
>>
>> +       struct timer_list       rssi_monitor_timer;
>> +
>>        struct hci_dev_stats    stat;
>>
>>        struct sk_buff_head     driver_init;
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
>>        hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>>  }
>>
>> +static void hci_do_read_rssi(unsigned long arg)
>> +{
>> +       struct hci_dev *hdev = (void *) arg;
>> +
>> +       if (test_bit(HCI_UP, &hdev->flags))
>> +               mgmt_do_read_rssi(hdev);
>> +}
>> +
>>  /* Register HCI device */
>>  int hci_register_dev(struct hci_dev *hdev)
>>  {
>> @@ -1522,6 +1530,9 @@ int hci_register_dev(struct hci_dev *hdev)
>>        setup_timer(&hdev->le_scan_timer, hci_disable_le_scan,
>>                                                (unsigned long) hdev);
>>
>> +       setup_timer(&hdev->rssi_monitor_timer, hci_do_read_rssi,
>> +                                               (unsigned long) hdev);
>> +
>>        INIT_WORK(&hdev->power_on, hci_power_on);
>>        INIT_WORK(&hdev->power_off, hci_power_off);
>>        setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
>> @@ -1604,6 +1615,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
>>        hci_del_off_timer(hdev);
>>        del_timer(&hdev->adv_timer);
>>        del_timer(&hdev->le_scan_timer);
>> +       del_timer(&hdev->rssi_monitor_timer);
>>
>>        destroy_workqueue(hdev->workqueue);
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 65ddbff..b034290 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -48,6 +48,8 @@ enum bt_device_type {
>>  #define RSSI_MONITOR_ALERT_LOW         0x01
>>  #define RSSI_MONITOR_ALERT_HIGH                0x02
>>
>> +#define RSSI_MONITOR_TIMEOUT           2000
>> +
>>  struct pending_cmd {
>>        struct list_head list;
>>        __u16 opcode;
>> @@ -70,6 +72,9 @@ struct rssi_monitor {
>>
>>  static LIST_HEAD(rssi_monitor_list);
>>
>> +static rwlock_t rssi_monitor_list_lock;
>> +static DEFINE_RWLOCK(rssi_monitor_list_lock);
>> +
>>  static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
>>  {
>>        struct sk_buff *skb;
>> @@ -1916,21 +1921,46 @@ static struct rssi_monitor *rssi_monitor_find(u16 index, bdaddr_t *bdaddr)
>>        return NULL;
>>  }
>>
>> +static void rssi_monitor_start(u16 index)
>> +{
>> +       struct hci_dev *hdev;
>> +
>> +       if (list_empty(&rssi_monitor_list))
>> +               return;
>> +
>> +       hdev = hci_dev_get(index);
>> +       if (!hdev)
>> +               return;
>> +
>> +       mod_timer(&hdev->rssi_monitor_timer, jiffies +
>> +                       msecs_to_jiffies(RSSI_MONITOR_TIMEOUT));
>> +       hci_dev_put(hdev);
>> +}
>> +
>>  static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
>>                                                        s8 high_trigger)
>>  {
>>        struct rssi_monitor *rm;
>> +       int err = 0;
>>
>> -       if (rssi_monitor_find(index, bdaddr))
>> -               return -EEXIST;
>> +       write_lock_bh(&rssi_monitor_list_lock);
>> +
>> +       if (rssi_monitor_find(index, bdaddr)) {
>> +               err = -EEXIST;
>> +               goto out;
>> +       }
>>
>>        if (low_trigger < -127 || low_trigger > 128 ||
>> -                       high_trigger < -127 || high_trigger > 128)
>> -               return -EINVAL;
>> +                       high_trigger < -127 || high_trigger > 128) {
>> +               err = -EINVAL;
>> +               goto out;
>> +       }
>
> Threshold validation could be the first operation in this function.
> It is also missing low < high

Ok. Will fix it.

>
> BR,
> Claudio.
>



-- 
INdT - Instituto Nokia de tecnologia
+55 92 2126 1122
+55 92 8423 3183
