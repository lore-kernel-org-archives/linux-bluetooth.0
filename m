Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Nov 2010 14:12:48 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
cc: haijun liu <liuhaijun.er@gmail.com>,
	Haijun Liu <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix system crash caused by
 del_timer()
In-Reply-To: <20101103175645.GA17561@vigoh>
Message-ID: <alpine.DEB.2.00.1011031309090.23497@linux-sea-02>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com> <20101022171825.GA980@vigoh> <AANLkTi=C5biCuJV335yfNWkY77xK29aa5JQ+9xvaE1yr@mail.gmail.com> <20101025110131.GA7721@vigoh> <AANLkTin2RaOZbRbg4faCFUxMLVi-FoY2xnNqq0a8cHpN@mail.gmail.com>
 <20101028075346.GA15997@vigoh> <AANLkTi=Q3g2UTiHV1i2gBa=POY0jS6GbBWAD1ddOaETx@mail.gmail.com> <20101103175645.GA17561@vigoh>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo and Haijun -

On Wed, 3 Nov 2010, Gustavo F. Padovan wrote:

> Hi Haijun,
>
> * haijun liu <liuhaijun.er@gmail.com> [2010-11-01 09:22:14 +0800]:
>
>> Hi Gustavo,
>>
>>>>>>>> During test session with another vendor's bt stack, found that in
>>>>>>>> l2cap_chan_del() using del_timer() caused l2cap_monitor_timeout()
>>>>>>>> be called after the sock was freed, so it raised a system crash.
>>>>>>>> So I just replaced del_timer() with del_timer_sync() to solve it.
>>>>>>>
>>>>>>> NAK on this. If you read the del_timer_sync() documentation you can
>>>>>>> see that you can't call del_timer_sync() on interrupt context. The
>>>>>>> possible solution here is to check in the beginning of
>>>>>>> l2cap_monitor_timeout() if your sock is still valid.
>>>>>>>
>>>>>>
>>>>>> You are right, I only considered close() interface, so missed the interrupt
>>>>>> context.
>>>>>>
>>>>>> It's very difficult to check sock valid or not in timeout procedure, since it's
>>>>>> an interrupt context, and only can get context from parameter pre-stored,
>>>>>> except global variables.
>>>>>
>>>>> I think you can check for sk == null there.
>>>>>
>>>>
>>>> It's a pre-stored parameter, it will not change by itself.
>>>
>>> I looked a bit into this and a good solution seems to be to hold a
>>> reference to the sock when we call a mod_timer() and then put the
>>> reference when we call del_timer() and the timer is inactive or when
>>> l2cap_monitor_timeout(). Look net/sctp/ for examples.
>>>
>>
>> Same situation still is there, in this case, l2cap_monitor_timeout()
>> how to know the reference has been released by del_timer()?
>>
>> If we refer to net/sctp, use timer_pending() to detect it, unless we can
>> ensure del_timer() always be called in interrupt context and same
>> level compare to timer interrupt, otherwise it's not an atomic operation
>> for this case.
>
> No, the socket lock take care of that, so there will be no race
> condition here. One related thing that we should fix is a locking
> problem in l2cap_monitor_timeout() and l2cap_retrans_timeout() already
> reported by Mat Martineau. (I just can't find his e-mail about that).
> So I think you should go ahead and this problem using ref counting and
> then we can also fix the problem reported by Mat.

Here's the message you're referring to:

http://www.spinics.net/lists/linux-bluetooth/msg06734.html

I do have patches to use a workqueue instead of timers that I'll 
upstream soon, but it looks like some kind of reference counting is 
still necessary.

del_timer_sync() or cancel_delayed_work_sync() could be called by a 
workqueue function.  We could sock_hold(), queue the cancellation 
work, then let the workqueue function call sock_put() after the 
timeouts (monitor, retrans, and ack) are all synchronously cancelled.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

