Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312388716.3358.58.camel@THOR>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
	<1312377094-11285-2-git-send-email-luiz.dentz@gmail.com>
	<1312388716.3358.58.camel@THOR>
Date: Wed, 3 Aug 2011 20:49:19 +0300
Message-ID: <CABBYNZJ9DVr5kPE3ZrWgyWUGBayZTyY+=rfEXpckXT3xkL6X8w@mail.gmail.com>
Subject: Re: [RFC 1/3] Bluetooth: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Aug 3, 2011 at 7:25 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>
> I believe that the existing tx scheduler is already inefficient and that
> this approach significantly compounds that inefficiency.
>
> Consider the following scenarios with 4 ACL connections (keyboard,
> mouse, phone, headset):
>
> For *one* scheduled ACL tx packet, the connection list will be searched
> 35~42 times -- that's 140~168 connection list node visits to find one
> packet! Here's the math:
>        (7 - priority of tx packet) x 4 connections => found the packet
>        7 pri levels x 4 connections => no more ACL tx packets
>        7 pri levels x 4 connections => no SCO tx packets
>        7 pri levels x 4 connections => no ESCO tx packets
>        7 pri levels x 4 connections => no LE tx packets
>        7 pri levels x 4 connections => recalc priority
>
> If the connection type doesn't match, it's not going to match at any
> priority level.

Obviously there are a few things that we might change to not traverse
the list of connection over and over, remember this is an RFC, besides
it 8 priorities (0-7), but we can skip much earlier if connection
doesn't match as you said. Also I guess for SCO/ESCO/LE e doesn't make
much sense to have many queues/priorities, it is basically ACL only,
that simplify a lot already.

>> +
>> +                       if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
>> +                               continue;
>>
>> -               num++;
>> +                       num++;
>>
>> -               if (c->sent < min) {
>> -                       min  = c->sent;
>> -                       conn = c;
>> +                       if (c->sent < min) {
>> +                               min  = c->sent;
>> +                               conn = c;
>> +                               *queue = &c->data_q[i];
>> +                       }
>
> Why preserve the fairness logic?

It does need to fair if there is 2 or more sockets with the same
priority, otherwise the first connection in the list might get all the
quote and even if we promote the starving queues it may still happen
to top most priority since there it cannot be promoted anymore.

>> +static void hci_prio_recalculate(struct hci_dev *hdev)
>> +{
>> +       struct hci_conn_hash *h = &hdev->conn_hash;
>> +       int i;
>> +
>> +       BT_DBG("%s", hdev->name);
>> +
>> +       for (i = HCI_PRIO_MAX - 1; i > 0; i--) {
>> +               struct list_head *p;
>> +
>> +               list_for_each(p, &h->list) {
>> +                       struct hci_conn *c;
>> +                       c = list_entry(p, struct hci_conn, list);
>> +
>> +                       if (c->sent || skb_queue_empty(&c->data_q[i - 1]))
>> +                               continue;
>
> The test for unacked packets does not allow the priority to advance if
> the unacked packets are from a previously executed hci_tx_task (ie., a
> connection transmitted packets on an earlier scheduled tx_task but those
> packets haven't been acked yet).

IMO it does, why should it be promoted to a higher priority if it
still is pending from the last time, this is specifically to throttle
lower priority in favor of higher, if throughput is important the
application should request be able to sets its priority according, and
it can do it at any time.

> This would allow a higher priority connection to almost monopolize
> transmission when the controller is near max load. A higher priority
> link will receive a tx quota of all available tx buffers, whereas a
> lower priority link will not advance until it's previous tx packets are
> acked. Worst-case scheduling could take a long time to schedule a lower
> priority packet.

You probably have never run this code did you? Only priority 7 can
really monopolize the connection, and that is on purpose, and yes
lower priority are throttled so higher priority can get lower latency,
what is wrong with that?

>>  static void hci_tx_task(unsigned long arg)
>>  {
>>         struct hci_dev *hdev = (struct hci_dev *) arg;
>> @@ -2253,6 +2316,8 @@ static void hci_tx_task(unsigned long arg)
>>         while ((skb = skb_dequeue(&hdev->raw_q)))
>>                 hci_send_frame(skb);
>>
>> +       hci_prio_recalculate(hdev);
>
> The priority recalculation should only be performed if one of the
> hci_sched_* functions was unable to schedule all outstanding packets
> (ie., a tx buffer count dropped to zero).

Yep, gonna fix that too.

> How does this scheduler + priority recalc behave if *no* packets could
> be scheduled at all? For example, if acl_cnt == 0 when the tx_task is
> scheduled?

Right now it promotes starving queues, all of them, but maybe it
shouldn't so that we simplify the complexity a little bit.


-- 
Luiz Augusto von Dentz
