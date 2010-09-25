Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Sep 2010 21:18:24 -0700 (PDT)
Message-Id: <20100924.211824.242130957.davem@davemloft.net>
To: padovan@profusion.mobi
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcel@holtmann.org, mathewm@codeaurora.org
Subject: Re: Deadlock in Bluetooth code in 2.6.36
From: David Miller <davem@davemloft.net>
In-Reply-To: <1285104013-9946-1-git-send-email-padovan@profusion.mobi>
References: <1285104013-9946-1-git-send-email-padovan@profusion.mobi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Tue, 21 Sep 2010 18:20:12 -0300

> My questions here is on how to fix this properly. Maybe
> sock_alloc_send_skb() should not be used with SOCK_STREAM and reliable
> protocols and I'm not aware of that? And should I use something like
> sk_stream_alloc_skb() instead?
> 
> Any comments are welcome. With lucky we can fix that for 2.6.36 and
> together with others fixes we have queued deliver a fully functional
> L2CAP layer on 2.6.36.

Use sock_alloc_send_skb() as you do now, but if it fails wait for socket
space to become available just like TCP does, then loop back and try to
allocate again if the space-wait doesn't return an error.

I think you should be able to reuse sk_stream_wait_memory() for this
purpose just fine and without any problems.
