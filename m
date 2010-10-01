Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 17:26:57 -0700 (PDT)
Message-Id: <20100930.172657.123994559.davem@davemloft.net>
To: padovan@profusion.mobi
Cc: linville@tuxdriver.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth-2.6 2010-09-27
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100928224941.GA19409@vigoh>
References: <20100928023035.GA3033@vigoh>
	<20100927.200016.226762808.davem@davemloft.net>
	<20100928224941.GA19409@vigoh>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Tue, 28 Sep 2010 19:49:41 -0300

> Actually sk_stream_wait_memory is another point why it's safe to release
> the lock and block waiting for memory. We've been doing that safely in
> protocols like TCP, SCTP and DCCP for a long time.

Do you notice what TCP does when sk_stream_wait_memory() returns?

It reloads all volatile state that might have changed in the socket
while the lock was dropped.

For example, TCP will reload the current MSS that can change
asynchronously while we don't have the socket lock.
