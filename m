Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101022171825.GA980@vigoh>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com> <20101022171825.GA980@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Mon, 25 Oct 2010 09:35:33 +0800
Message-ID: <AANLkTi=C5biCuJV335yfNWkY77xK29aa5JQ+9xvaE1yr@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix system crash caused by del_timer()
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Haijun Liu <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>> During test session with another vendor's bt stack, found that in
>> l2cap_chan_del() using del_timer() caused l2cap_monitor_timeout()
>> be called after the sock was freed, so it raised a system crash.
>> So I just replaced del_timer() with del_timer_sync() to solve it.
>
> NAK on this. If you read the del_timer_sync() documentation you can
> see that you can't call del_timer_sync() on interrupt context. The
> possible solution here is to check in the beginning of
> l2cap_monitor_timeout() if your sock is still valid.
>

You are right, I only considered close() interface, so missed the interrupt
context.

It's very difficult to check sock valid or not in timeout procedure, since it's
an interrupt context, and only can get context from parameter pre-stored,
except global variables.

Let's think about it and come up a good solution for this situation.

-- 
Haijun Liu
