Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+Ya6W+Lvy__O=CEUjVicULGStY58bdsqCML3nMCYtUPzcQ@mail.gmail.com>
References: <1401586702-54238-1-git-send-email-marcel@holtmann.org>
	<CAN_7+Ya6W+Lvy__O=CEUjVicULGStY58bdsqCML3nMCYtUPzcQ@mail.gmail.com>
Date: Thu, 12 Jun 2014 11:39:05 +0200
Message-ID: <CAN_7+Ya8f7+9p8i3h_7h4dwULcP6kRK4ush29B9d_jshL+SeTQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Use struct delayed_work for HCI command timeout
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 12, 2014 at 11:25 AM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Hi Marcel,
>
> On Sun, Jun 1, 2014 at 3:38 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> This is an experimental patch that converts hdev->cmd_timer from
>> struct timer_list to struct delayed_work.
>>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  include/net/bluetooth/hci_core.h |  2 +-
>>  net/bluetooth/hci_core.c         | 17 +++++++++--------
>>  net/bluetooth/hci_event.c        |  4 ++--
>>  3 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index b386bf17e6c2..de3bb22e83f9 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -273,7 +273,7 @@ struct hci_dev {
>>
>>         struct delayed_work     service_cache;
>>
>> -       struct timer_list       cmd_timer;
>> +       struct delayed_work     cmd_timer;
>>
>>         struct work_struct      rx_work;
>>         struct work_struct      cmd_work;
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 0a43cce9a914..9e0368b02a11 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2432,7 +2432,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>>         hci_req_lock(hdev);
>>
>>         if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
>> -               del_timer_sync(&hdev->cmd_timer);
>> +               cancel_delayed_work_sync(&hdev->cmd_timer);
>>                 hci_req_unlock(hdev);
>>                 return 0;
>>         }
>> @@ -2488,7 +2488,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>>
>>         /* Drop last sent command */
>>         if (hdev->sent_cmd) {
>> -               del_timer_sync(&hdev->cmd_timer);
>> +               cancel_delayed_work_sync(&hdev->cmd_timer);
>>                 kfree_skb(hdev->sent_cmd);
>>                 hdev->sent_cmd = NULL;
>>         }
>> @@ -3205,9 +3205,10 @@ void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
>>  }
>>
>>  /* HCI command timer function */
>> -static void hci_cmd_timeout(unsigned long arg)
>> +static void hci_cmd_timeout(struct work_struct *work)
>>  {
>> -       struct hci_dev *hdev = (void *) arg;
>> +       struct hci_dev *hdev = container_of(work, struct hci_dev,
>> +                                           cmd_timer.work);
>>
>>         if (hdev->sent_cmd) {
>>                 struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
>> @@ -3884,7 +3885,7 @@ struct hci_dev *hci_alloc_dev(void)
>>
>>         init_waitqueue_head(&hdev->req_wait_q);
>>
>> -       setup_timer(&hdev->cmd_timer, hci_cmd_timeout, (unsigned long) hdev);
>> +       INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
>>
>>         hci_init_sysfs(hdev);
>>         discovery_init(hdev);
>> @@ -5287,10 +5288,10 @@ static void hci_cmd_work(struct work_struct *work)
>>                         atomic_dec(&hdev->cmd_cnt);
>>                         hci_send_frame(hdev, skb);
>>                         if (test_bit(HCI_RESET, &hdev->flags))
>> -                               del_timer(&hdev->cmd_timer);
>> +                               cancel_delayed_work(&hdev->cmd_timer);
>>                         else
>> -                               mod_timer(&hdev->cmd_timer,
>> -                                         jiffies + HCI_CMD_TIMEOUT);
>> +                               schedule_delayed_work(&hdev->cmd_timer,
>> +                                                     HCI_CMD_TIMEOUT);
>>                 } else {
>>                         skb_queue_head(&hdev->cmd_q, skb);
>>                         queue_work(hdev->workqueue, &hdev->cmd_work);
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 6cf9596ff69b..4f942ea43cd8 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2705,7 +2705,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>         }
>>
>>         if (opcode != HCI_OP_NOP)
>> -               del_timer(&hdev->cmd_timer);
>> +               cancel_delayed_work(&hdev->cmd_timer);
>>
>>         hci_req_cmd_complete(hdev, opcode, status);
>>
>> @@ -2796,7 +2796,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>         }
>>
>>         if (opcode != HCI_OP_NOP)
>> -               del_timer(&hdev->cmd_timer);
>> +               cancel_delayed_work(&hdev->cmd_timer);
>>
>>         if (ev->status ||
>>             (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> When I start to use "[PATCH v3] Bluetooth: Fix for ACL disconnect when
> pairing fails"  I was facing
> hci tx timeout on disconnect command with some chips even I saw in
> btmon that Command Status on disconnect command came on time.
>
> After I apply this patch, that issue has gone.
>

Looks like issue is still there. Ignore previous email.

[ 2826.718006] [613] l2cap_disconn_ind: hcon ffff8800c41ed000
[ 2826.718007] [613] hci_disconnect: hcon ffff8800c41ed000
[ 2826.718009] [613] hci_send_cmd: hci0 opcode 0x0406 plen 3
[ 2826.718013] [613] hci_prepare_cmd: skb len 6
[ 2826.718018] [613] hci_cmd_work: hci0 cmd_cnt 1 cmd queued 1
[ 2826.718024] [613] hci_send_frame: hci0 type 1 len 6
[ 2826.718026] [613] hci_send_to_monitor: hdev ffff8801961da000 len 6
[ 2826.718091] [6157] hci_sock_recvmsg: sock ffff8801d19ead00, sk
ffff88016929dc00
[ 2826.718136] [6157] hci_sock_recvmsg: sock ffff8801d19ead00, sk
ffff88016929dc00
[ 2826.719486] [613] hci_rx_work: hci0
[ 2826.719496] [613] hci_send_to_monitor: hdev ffff8801961da000 len 6
[ 2826.719523] [613] hci_rx_work: hci0 Event packet
[ 2826.719554] [6157] hci_sock_recvmsg: sock ffff8801d19ead00, sk
ffff88016929dc00
[ 2826.719589] [6157] hci_sock_recvmsg: sock ffff8801d19ead00, sk
ffff88016929dc00
[ 2828.724246] Bluetooth: hci0 command 0x0406 tx timeout

> \Lukasz

\Lukasz
