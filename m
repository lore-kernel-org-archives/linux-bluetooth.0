Return-Path: <cyrus@holtmann.org>
Message-ID: <5578120D.3030809@mentor.com>
Date: Wed, 10 Jun 2015 11:31:41 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>
Subject: Re: [PATCH v1 7/7] Bluetooth: __l2cap_wait_ack() limit max waiting
 time
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com> <1433545876-15800-8-git-send-email-Dean_Jenkins@mentor.com> <B5FA3BFD-DCAF-4493-BA35-2341AF79D034@holtmann.org>
In-Reply-To: <B5FA3BFD-DCAF-4493-BA35-2341AF79D034@holtmann.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

This patch is broken. Needs a redo. Please see inline comments.

On 06/06/15 05:21, Marcel Holtmann wrote:
> Hi Dean,
>
>> Add a limiter counter to prevent the do while loop
>> running in an infinite loop. This ensures that the
>> channel will be instructed to close within 10 seconds
>> so prevents l2cap_sock_shutdown() getting stuck forever.
>>
>> Returns -ENOLINK when the limit is reached as the channel
>> will be subequently closed and not all data was ACK'ed.
>>
>> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
>> ---
>> net/bluetooth/l2cap_sock.c | 11 ++++++++++-
>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 369ad0e..ee6531e 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -1059,11 +1059,13 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
>> 	DECLARE_WAITQUEUE(wait, current);
>> 	int err = 0;
>> 	int timeo = HZ/5;
>> +	int limiter = 10 * 5;	/* 10 seconds limit */
> while reading this, should timeo not be using msecs_to_jiffies() in the first place.
>
> And with that, can we have a little bit better logic on how you get to 10 seconds. I had to scratch my head a bit to realise that this is 50 * 200 msec. It seems a bit error prone in case anyone ever changes something.
Thanks for your comments. I will redo this by using a #define and use 2 
separate commits; one to add limiter, the other to use msecs_to_jiffies()
>
>> 	add_wait_queue(sk_sleep(sk), &wait);
>> 	set_current_state(TASK_INTERRUPTIBLE);
>> 	do {
>> -		BT_DBG("Waiting for %d ACKs", chan->unacked_frames);
>> +		BT_DBG("Waiting for %d ACKs, limiter %d",
>> +			chan->unacked_frames, limiter);
>>
>> 		if (!timeo)
>> 			timeo = HZ/5;
> And with that, I have no idea why we are doing this check here. Seems rather pointless unless I misses something.
Testing shows that schedule_timeout() can return before the timeo time 
period has expired. I do not know why schedule_timeout() is returning 
early, no signal is caught by the signal_pending() statement within the 
loop. This means that the patch is broken because limiter can decrement 
too fast so the elapsed time is less than 10 seconds. The fix is to move 
limiter-- to this location so that timeo is zero before doing limiter--.

The limiter counter will not give an accurate period of 10 seconds and 
will be longer than 10 seconds in most cases. However, the 10 seconds is 
arbitrary so the accuracy is unimportant.

Would you prefer an overall 10 second jiffies counter instead of using 
the limiter loop counter ? Such as
keep looping until jiffies > start_jiffies + 10*HZ
although jiffies overflow needs to be taken into account, right ?


>
> I know these are not your bugs, but while we are at it, it might be better to really clean this out.
>
>> @@ -1081,6 +1083,13 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
>> 		err = sock_error(sk);
>> 		if (err)
>> 			break;
>> +
>> +		limiter--;
>> +		if (!limiter) {
>> +			err = -ENOLINK;
>> +			break;
>> +		}
>> +
>> 	} while (chan->unacked_frames > 0 &&
>> 		 chan->state == BT_CONNECTED);
> Regards
>
> Marcel
>
Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.
