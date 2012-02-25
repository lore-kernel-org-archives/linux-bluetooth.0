Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F483477.2050907@codeaurora.org>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
	<1330029469-8565-3-git-send-email-mathewm@codeaurora.org>
	<CAA37ikYHwKfBV8Ojgqoc8XYQpgv2oHFkzZA6NEZgFkF9nVjBSw@mail.gmail.com>
	<4F483477.2050907@codeaurora.org>
Date: Sat, 25 Feb 2012 12:52:04 -0300
Message-ID: <CAA37ikbYkfwsCTWGt+dPmEU6CVXfMkfyphfUBxUBJphnd7uB4Q@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: L2CAP ERTM state machine replacement
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Feb 24, 2012 at 10:08 PM, Mat Martineau <mathewm@codeaurora.org> wr=
ote:
> On 2/24/2012 12:13 PM, Ulisses Furquim wrote:
>>
>> Hi Mat,
>>
>> On Thu, Feb 23, 2012 at 6:37 PM, Mat Martineau<mathewm@codeaurora.org>
>> =A0wrote:
>>>
>>> The previous ERTM implementation had a handler for each frame type,
>>> and each handler had to figure out what the current state was and
>>> handle each frame accordingly.
>>>
>>> This implementation has a state machine that chooses an execution path
>>> first based on the receive or transmit state, then each state has
>>> handlers for the frame types. This is easier to match up with the
>>> spec, which is defined similarly.
>>>
>>> Signed-off-by: Mat Martineau<mathewm@codeaurora.org>
>>
>>
>> <snip>
>>
>> @@ -1245,7 +1457,8 @@ int __l2cap_wait_ack(struct sock *sk)
>>
>> =A0 =A0 =A0 =A0 add_wait_queue(sk_sleep(sk),&wait);
>> =A0 =A0 =A0 =A0 set_current_state(TASK_INTERRUPTIBLE);
>> - =A0 =A0 =A0 while (chan->unacked_frames> =A00&& =A0chan->conn) {
>>
>> + =A0 =A0 =A0 while (chan->unacked_frames> =A00&& =A0chan->conn&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_read(&chan->ertm_queued)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!timeo)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeo =3D HZ/5;
>>
>> Can we have unacked_frames> =A00 and nothing queued? Or have I
>> misinterpreted?
>
>
> In normal operation, there should be unacked frames when ertm_queued is
> non-zero. =A0I think I ran in to a corner case with AMP, where unacked_fr=
ames
> can be forced to 0 during a channel move. =A0There are AMP components to =
the
> state machine that are not included in this patch.

Ok, I thought you might have a reason for that. Thanks.

>> <snip>
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bt_cb(skb)->retries =3D=3D 1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chan->unacked_frames++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_hold(chan);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sock_hold(chan->sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_skb->sk =3D chan->sk;
>>
>> Do we really need these? Do we always have chan->sk? (We have that in
>> l2cap_ertm_send() and l2cap_ertm_resend()).
>
> The upstream ERTM code still relies on having chan->sk, so I didn't try t=
o
> finish splitting channels & sockets within this patch. =A0skb destructors
> expect to have an sk pointer, so it is critical to modify these reference
> counts so the socket and chan are around when the skb leaves the hci tx
> queue.

If I'm not mistaken the skb destructor relies on sk only to be able to
access chan, right? It'd be good if we could not rely on sk here.
Andrei, what do you think?

>>
>> <snip>
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keep_sk =3D schedule_work(&chan->tx_work);
>>
>> Would make sense to schedule this in hdev->workqueue?
>
> It's a tradeoff. =A0If this is scheduled on hdev->workqueue, then that
> workqueue can get blocked waiting for the socket lock. =A0If these are
> scheduled on the system workqueue, there is potential for more latency (b=
ut
> it hasn't been a problem in practice, even with AMP data rates).

Hmm. I just was wondering if we don't have any problems with tasks in
both worqueues running simultaneously.

>>
>> <snip>
>>
>> +static void l2cap_ertm_tx_worker(struct work_struct *work)
>> =A0{
>>
>> Why do we need this worker?
>
> To control the depth of the hci tx queue. =A0Without this, you end up wit=
h an
> entire tx window of iframes queued up at the hci layer. =A0When an sframe
> shows up from the remote device and you have to retransmit, or when an
> sframe needs to be sent, then retransmissions and sframes have to get que=
ued
> behind that full tx window of iframes. =A0It adds a HUGE amount of latenc=
y in
> those situations, which leads to ERTM timeouts and disconnects that are n=
ot
> necessary. =A0ERTM works much, much better with lossy connections (like A=
MP)
> if it does not flood the hci tx queue.

Ok.

> We had a discussion on the list about how to solve this. =A0The idea is t=
o
> push most queuing up to the L2CAP layer, and have the hci scheduler call =
up
> to L2CAP to fetch frames. =A0However, this hasn't been implemented yet.

I see.

>>
>> - =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 struct l2cap_chan *chan =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct l2cap_chan, tx_w=
ork);
>>
>> - =A0 =A0 =A0 if (!skb_queue_empty(&chan->tx_q))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 chan->tx_send_head =3D chan->tx_q.next;
>> + =A0 =A0 =A0 BT_DBG("%p", chan);
>>
>> - =A0 =A0 =A0 chan->next_tx_seq =3D chan->expected_ack_seq;
>> - =A0 =A0 =A0 ret =3D l2cap_ertm_send(chan);
>> - =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 lock_sock(chan->sk);
>> + =A0 =A0 =A0 l2cap_ertm_send(chan);
>> + =A0 =A0 =A0 release_sock(chan->sk);
>>
>> Can't we just use l2cap_chan_lock()/l2cap_chan_unlock() here? (I'm
>> assuming you saw the patches creating a lock in l2cap_chan to protect
>> it) Do we always have sk?
>
> l2cap_chan_lock() is pretty new! =A0Yes, I should use that to guard the E=
RTM
> state.
>
> Right now, we do still always have sk, but that is changing (as it should=
).

Ok. If we could not rely on sk here as well would be good.

>> + =A0 =A0 =A0 sock_put(chan->sk);
>> + =A0 =A0 =A0 l2cap_chan_put(chan);
>> =A0}
>>
>> <snip>
>>
>> +static void l2cap_monitor_timeout(struct work_struct *work)
>> +{
>> + =A0 =A0 =A0 struct l2cap_chan *chan =3D container_of(work, struct l2ca=
p_chan,
>> +
>> monitor_timer.work);
>> + =A0 =A0 =A0 struct sock *sk =3D chan->sk;
>> +
>> + =A0 =A0 =A0 BT_DBG("chan %p", chan);
>> +
>> + =A0 =A0 =A0 lock_sock(sk);
>> +
>> + =A0 =A0 =A0 if (!chan->conn) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_put(chan);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 l2cap_ertm_tx(chan, 0, 0, L2CAP_ERTM_EVENT_MONITOR_TIMER_E=
XPIRES);
>> +
>> + =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 =A0 l2cap_chan_put(chan);
>> +}
>>
>> Here we might need to use l2cap_chan_lock/unlock instead of
>> lock_sock/release_sock.
>
>
> Agreed.
>
>
>>
>> +static void l2cap_retrans_timeout(struct work_struct *work)
>> +{
>> + =A0 =A0 =A0 struct l2cap_chan *chan =3D container_of(work, struct l2ca=
p_chan,
>> +
>> retrans_timer.work);
>> + =A0 =A0 =A0 struct sock *sk =3D chan->sk;
>> +
>> + =A0 =A0 =A0 BT_DBG("chan %p", chan);
>> +
>> + =A0 =A0 =A0 lock_sock(sk);
>> +
>> + =A0 =A0 =A0 if (!chan->conn) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_put(chan);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 l2cap_ertm_tx(chan, 0, 0, L2CAP_ERTM_EVENT_RETRANS_TIMER_E=
XPIRES);
>> + =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 =A0 l2cap_chan_put(chan);
>>
>> And here as well.
>>
>> Ok, that's it for now. Have you run this code through PTS or any other
>> test? I haven't checked the actual bits of ERTM but since we're
>> replacing the current state machine code we need to be somewhat sure
>> this code is as good as or even better than the current one.
>> Introducing too many regressions would be really bad IMHO.
>
>
> The kernel I'm porting from is qualified, listed, interop'd, UPF'd, and
> heavily tested -- but I haven't validated this port yet. =A0I will defini=
tely
> run this through PTS and test against other ERTM implementations before w=
e
> merge the changes.

I'm aware your kernel is on a very good state but as you said this is
a port to upstream. And that's why I also said "too many regressions"
because some we might not be able to see now. And running through PTS
and maybe against your qualified kernel would be good, yes.

Thank you,
Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
