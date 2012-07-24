Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120724083136.GA11981@aemeltch-MOBL1>
References: <manojkr.sharma@stericsson.com>
	<1343117537-31501-1-git-send-email-manojkr.sharma@stericsson.com>
	<20120724083136.GA11981@aemeltch-MOBL1>
Date: Tue, 24 Jul 2012 16:26:38 +0530
Message-ID: <CAHH5__7ztyWrEo02BvS0CMoxHLq+Z4EeF4fbkT0NhX97QMJPdA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Usage of HCI channels in L2CAP
From: Manoj Sharma <ursmanoj@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Manoj Kumar Sharma <manojkr.sharma@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 7/24/12, Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> wrote:
> Hi Manoj,
>
> On Tue, Jul 24, 2012 at 01:42:16PM +0530, Manoj Kumar Sharma wrote:
>> This patch enables L2CAP to use HCI channel feature. This can be
>> used to reflect L2CAP socket properties onto HCI channel.
>
> the description is not good. This looks like
> "Move HCI chan from l2cap_conn to l2cap_chan"

I have pushed new patch set with your comments incorporated. Please have a look.

>
>> Change-Id: Iac2b54a1b8204695162491d09161066d90495e06
>> Signed-off-by: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
>> ---
>>  include/net/bluetooth/l2cap.h |    1 +
>>  net/bluetooth/l2cap_core.c    |   10 +++++++++-
>>  2 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h
>> b/include/net/bluetooth/l2cap.h
>> index 9b242c6..f26a468 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -410,6 +410,7 @@ struct l2cap_chan {
>>  	struct sock *sk;
>>
>>  	struct l2cap_conn	*conn;
>> +	struct hci_chan	*hchan;
>>
>>  	__u8		state;
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 6f9c25b..e487731 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -300,6 +300,8 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
>>
>>  void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>>  {
>> +	struct hci_chan *hchan;
>> +
>>  	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
>>  			chan->psm, chan->dcid);
>>
>> @@ -342,6 +344,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct
>> l2cap_chan *chan)
>>  	chan->local_acc_lat	= L2CAP_DEFAULT_ACC_LAT;
>>  	chan->local_flush_to	= L2CAP_DEFAULT_FLUSH_TO;
>>
>> +	hchan = hci_chan_create(conn->hcon);
>> +	chan->hchan = hchan;
>> +
>> +
>
> extra new line

Removed extra line in new patch set.

>
>>  	l2cap_chan_hold(chan);
>>
>>  	list_add(&chan->list, &conn->chan_l);
>> @@ -396,6 +402,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan,
>> int err)
>>
>>  	skb_queue_purge(&chan->tx_q);
>>
>> +	hci_chan_del(chan->hchan);
>> +
>>  	if (chan->mode == L2CAP_MODE_ERTM) {
>>  		struct srej_list *l, *tmp;
>>
>> @@ -596,7 +604,7 @@ static void l2cap_do_send(struct l2cap_chan *chan,
>> struct sk_buff *skb)
>>  		flags = ACL_START;
>>
>>  	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
>> -	hci_send_acl(chan->conn->hchan, skb, flags);
>> +	hci_send_acl(chan->hchan, skb, flags);
>
> So what about hchan in l2cap_conn structure?
The hchan in l2cap_conn is used for sending L2CAP control signals.
Thus there is one hchan per L2CAP channel created and one already
available will be used only for control signals.
>
> Best regards
> Andrei Emeltchenko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Best regards,
Manoj Sharma
