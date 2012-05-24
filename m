Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 10:18:07 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 1/2] Bluetooth: Create chan->ops->set_err()
In-Reply-To: <20120524170412.GE3105@joana>
Message-ID: <alpine.DEB.2.02.1205241014250.18142@mathewm-linux>
References: <1337839374-20443-3-git-send-email-gustavo@padovan.org> <1337842817-27865-1-git-send-email-gustavo@padovan.org> <20120524082603.GE24715@aemeltch-MOBL1> <20120524170412.GE3105@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Thu, 24 May 2012, Gustavo Padovan wrote:

> Hi Andrei,
>
> * Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-24 11:26:04 +0300]:
>
>> Hi Gustavo,
>>
>> On Thu, May 24, 2012 at 04:00:16AM -0300, Gustavo Padovan wrote:
>>> -	lock_sock(sk);
>>> -	__l2cap_state_change(chan, BT_DISCONN);
>>> -	__l2cap_chan_set_err(chan, err);
>>> -	release_sock(sk);
>>> +	l2cap_state_change(chan, BT_DISCONN);
>>> +	if(chan->ops->set_err)
>>> +		chan->ops->set_err(chan->data, err);
>>
>> I do not know can it be done somehow better, currently we lock and unlock
>> sockets for each operation.
>
> I'm having trouble to get your point, could you please explain?

What I see is that the lock used to be acquired once, with both 
state_change and set_err happening while locked.  With this change, 
the lock is acquired twice, once for state_change and once for 
set_err.  I'm not sure it's good to release the lock between 
state_change and set_err.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
