Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 19:25:09 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v3] Bluetooth: Add MSG_MORE support to L2CAP sockets
Message-ID: <20120525222509.GF31623@joana>
References: <1337384778-25135-1-git-send-email-gustavo@padovan.org>
 <1337385587.2058.31.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337385587.2058.31.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

* Marcel Holtmann <marcel@holtmann.org> [2012-05-18 16:59:47 -0700]:

> Hi Gustavo,
> 
> > MSG_MORE enables us to save buffer space in userspace, the packet is
> > built directly in the kernel and sent only when a msg with the MSG_MORE
> > flag not set arrives. If a send() tries to add more chan->omtu bytes
> > -EMSGSIZE is returned.
> > 
> > Only MSG_MORE for Basic Mode is supported right now. chan->skb_more keeps
> > a pointer to the L2CAP packet that is being build through many calls to
> > send().
> 
> so this is really not acceptable. We need to start supporting all modes
> with MSG_MORE at the same time. Otherwise we can not merge this.

The ERTM/Streaming sending code is bit different from the Basic mode sending
so implementing a MSG_MORE code that fits in both cases is not that trivial.
I have a different proposal for this that would make the code a lot simpler,
however we will need more memory.

We could add a extra buffer to keep the data coming from userspace until a
send with the MSG_MORE is not sent arrives, at that point we pass a to sending
side that will treat the buffer according to the L2CAP mode. This is simpler
but as said has extra buffer copy. On the other side, when one is using
MSG_MORE it saves a data copy in userspace, as we don't need to build the
packet there anymore.

comments?
