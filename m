Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 30 Sep 2010 22:22:03 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Miller <davem@davemloft.net>
Cc: linville@tuxdriver.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth-2.6 2010-09-27
Message-ID: <20101001012203.GE3048@vigoh>
References: <20100928023035.GA3033@vigoh>
 <20100927.200016.226762808.davem@davemloft.net>
 <20100928224941.GA19409@vigoh>
 <20100930.172657.123994559.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100930.172657.123994559.davem@davemloft.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

* David Miller <davem@davemloft.net> [2010-09-30 17:26:57 -0700]:

> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> Date: Tue, 28 Sep 2010 19:49:41 -0300
> 
> > Actually sk_stream_wait_memory is another point why it's safe to release
> > the lock and block waiting for memory. We've been doing that safely in
> > protocols like TCP, SCTP and DCCP for a long time.
> 
> Do you notice what TCP does when sk_stream_wait_memory() returns?
> 
> It reloads all volatile state that might have changed in the socket
> while the lock was dropped.
> 
> For example, TCP will reload the current MSS that can change
> asynchronously while we don't have the socket lock.

I got your point. And what I tried to say in the last e-mail is that
ERTM doesn't have such volatile states that need to restore after get
the lock back. The others code path it affect are very simple and also
doesn't have such problem. So we are safe against asynchronous changes.
We obvious have volatiles states, but the code paths where
bt_skb_send_alloc() is used doesn't rely on that states. I'm seeing no
problem on release the lock, alloc memory, and lock it again.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
