Return-Path: <cyrus@holtmann.org>
Message-ID: <55A3F5F8.4070800@mentor.com>
Date: Mon, 13 Jul 2015 18:31:36 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>,
	<Joshua_Frkuska@mentor.com>
Subject: Re: [PATCH v2 3/8] Bluetooth: Unwind l2cap_sock_shutdown()
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com> <1435078779-4436-4-git-send-email-Dean_Jenkins@mentor.com> <20150713110731.GA21598@t440s.lan>
In-Reply-To: <20150713110731.GA21598@t440s.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 13/07/15 12:07, Johan Hedberg wrote:
> Hi Dean,
>
> On Tue, Jun 23, 2015, Dean Jenkins wrote:
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -1100,6 +1100,13 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>>   	if (!sk)
>>   		return 0;
>>   
>> +	lock_sock(sk);
>> +
>> +	if (sk->sk_shutdown)
>> +		goto shutdown_already;
>> +
>> +	sk->sk_shutdown = SHUTDOWN_MASK;
>> +
>>   	/* prevent sk structure from being freed whilst unlocked */
>>   	sock_hold(sk);
>>   
>> @@ -1114,30 +1121,21 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
>>   		mutex_lock(&conn->chan_lock);
>>   
>>   	l2cap_chan_lock(chan);
>> -	lock_sock(sk);
> I guess this is at least part of the reason for the lockdep warnings we
> started getting after your patches. The order of these locks should
> always be l2cap_chan_lock() and then lock_sock(). Any other order
> exposes us to potential deadlocks and the kernel lockdep system rightly
> warns about it.
>
> Do you think you'll be able to fix this as well as the missing
> mutex_lock(&conn->chan_lock) issue this week? Otherwise we'll need to
> consider reverting your patches since it's quite clear we can't make any
> bluetooth-next pull requests with the current state of the tree.

I think it would be wise to revert the changes as I am unable to 
guarantee that I get time to propose a fix during this week. I will try 
to work on a v3 patchset based on your feedback.

The use of the

mutex_lock(&conn->chan_lock)

is troublesome because the underlying conn connection can disappear 
whilst waiting for acks, that is why I eliminated the conn variable and 
used chan->state instead. Is there an atomic method to check conn and 
take the lock ?

I did some lockdep checking on our ARM kernel 3.14 but I get an 
unrelated early lockdep report. This might be why we did not see any 
lockdep issue for L2CAP. I think we might have a patch to force multiple 
lockdeps to be reported, I will need to investigate.

I am trying to work out how to build l2cap-tester for a cross-compiled 
ARM environment which was built from bitbake. I suspect I need to create 
a bitbake recipe to build l2cap-tester, perhaps a recipe already exists 
in Yocto ?

I now have a PTS dongle but I am having difficulties understanding how 
to run any of the test cases. Do you have any hints ?

Thanks,

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Linux Transportation Solutions
Mentor Embedded Software Division
Mentor Graphics (UK) Ltd.

