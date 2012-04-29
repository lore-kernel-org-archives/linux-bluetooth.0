Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Apr 2012 17:25:00 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFCv2 3/8] Bluetooth: Make better use of l2cap_chan reference
 counting
Message-ID: <20120429202500.GC2917@joana>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
 <1335570655-30878-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335570655-30878-4-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:50 -0700]:

> L2CAP sockets contain a pointer to l2cap_chan that needs to be
> reference counted in order to prevent a possible dangling pointer when
> the channel is freed.
> 
> There were a few other cases where an l2cap_chan pointer on the stack
> was dereferenced after a call to l2cap_chan_del. Those pointers are
> also now reference counted.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    6 ++++++
>  net/bluetooth/l2cap_sock.c |    3 +++
>  2 files changed, 9 insertions(+)

Patches 1 to 3 applied to bluetooth-next. Thanks.

	Gustavo
