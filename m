Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111219110504.GD3982@aemeltch-MOBL1>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
	<1324157382-1815-2-git-send-email-padovan@profusion.mobi>
	<1324157382-1815-3-git-send-email-padovan@profusion.mobi>
	<1324157382-1815-4-git-send-email-padovan@profusion.mobi>
	<1324157382-1815-5-git-send-email-padovan@profusion.mobi>
	<1324157382-1815-6-git-send-email-padovan@profusion.mobi>
	<1324157382-1815-7-git-send-email-padovan@profusion.mobi>
	<20111219110504.GD3982@aemeltch-MOBL1>
Date: Mon, 19 Dec 2011 10:59:17 -0200
Message-ID: <CAA37ikaGqA0ATef8760UiwmJ7dg14UBN_t2T8VFJn6PRfMkcww@mail.gmail.com>
Subject: Re: [RFC 06/22] Bluetooth: Move L2CAP timers to workqueue
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 19, 2011 at 9:05 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Gustavo,
>
> On Sat, Dec 17, 2011 at 07:29:26PM -0200, Gustavo F. Padovan wrote:
>> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
>>
>> L2CAP timers also need to run in process context. As the works in l2cap
>> are small we are using the system worqueue.
>>
>> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
>> ---
>>  include/net/bluetooth/l2cap.h |   17 +++++-----
>>  net/bluetooth/l2cap_core.c    |   70 ++++++++++++++++++-----------------------
>>  2 files changed, 40 insertions(+), 47 deletions(-)
>
> ...
>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 0369a9b..89cda6d 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -213,20 +213,18 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
>>       return 0;
>>  }
>>
>> -static void l2cap_set_timer(struct l2cap_chan *chan, struct timer_list *timer, long timeout)
>> +static void l2cap_set_timer(struct l2cap_chan *chan, struct delayed_work *work, long timeout)
>>  {
>>       BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
>>
>> -     if (!mod_timer(timer, jiffies + msecs_to_jiffies(timeout)))
>> -             chan_hold(chan);
>> +     cancel_delayed_work_sync(work);
>> +
>> +     schedule_delayed_work(work, timeout);
>>  }
>>
>> -static void l2cap_clear_timer(struct l2cap_chan *chan, struct timer_list *timer)
>> +static void l2cap_clear_timer(struct delayed_work *work)
>>  {
>> -     BT_DBG("chan %p state %d", chan, chan->state);
>> -
>> -     if (timer_pending(timer) && del_timer(timer))
>> -             chan_put(chan);
>> +     cancel_delayed_work_sync(work);
>>  }
>
>
> Do you think we do not need to use chan_hold / chan_put?

It's good you spotted it too. It's a known issue Padovan is looking at. Thanks.

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
