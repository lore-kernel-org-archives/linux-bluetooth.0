Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 15:13:16 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 6/8] Bluetooth: Move stream-oriented recvmsg code so it
 can be used by L2CAP.
In-Reply-To: <1280778398.12579.46.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1008021502560.18432@linux-sea-02>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>  <1280776810-18213-7-git-send-email-mathewm@codeaurora.org> <1280778398.12579.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Marcel,

On Mon, 2 Aug 2010, Marcel Holtmann wrote:

> Hi Mat,
>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/bluetooth.h |    2 +
>>  net/bluetooth/af_bluetooth.c      |  107 +++++++++++++++++++++++++++++++++++++
>>  net/bluetooth/rfcomm/sock.c       |  104 ++---------------------------------
>>  3 files changed, 115 insertions(+), 98 deletions(-)
>
> looks all like a good idea, but I really have to insist that the commit
> message explain everything in detail. Give a reason why the code is
> similar or the same and why this makes sense.
>
> Also splitting these into two or more patches makes sense. One adding
> the stream receive and the other modifying L2CAP and RFCOMM to use it.

Agreed.


>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 27a902d..08b6c2a 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -126,6 +126,8 @@ int  bt_sock_unregister(int proto);
>>  void bt_sock_link(struct bt_sock_list *l, struct sock *s);
>>  void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
>>  int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
>> +int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
>> +			struct msghdr *msg, size_t len, int flags);
>>  uint bt_sock_poll(struct file * file, struct socket *sock, poll_table *wait);
>>  int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
>>  int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>> index 421c45b..73047f5 100644
>> --- a/net/bluetooth/af_bluetooth.c
>> +++ b/net/bluetooth/af_bluetooth.c
>> @@ -265,6 +265,113 @@ int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
>>  }
>>  EXPORT_SYMBOL(bt_sock_recvmsg);
>>
>> +static long bt_sock_data_wait(struct sock *sk, long timeo)
>> +{
>> +	DECLARE_WAITQUEUE(wait, current);
>> +
>> +	add_wait_queue(sk_sleep(sk), &wait);
>> +	for (;;) {
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +		if (!skb_queue_empty(&sk->sk_receive_queue) ||
>> +		    sk->sk_err ||
>> +		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>> +		    signal_pending(current) ||
>> +		    !timeo)
>> +			break;
>
> This makes my brain hurt. Please lets do this readable and with proper
> coding style and/or a helper function.

That's unchanged code from rfcomm_sock_data_wait() in rfcomm/sock.c - 
but I'll go ahead and break it up using multiple 'if' statements.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

