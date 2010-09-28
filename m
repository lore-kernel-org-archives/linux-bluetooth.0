Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 20:00:16 -0700 (PDT)
Message-Id: <20100927.200016.226762808.davem@davemloft.net>
To: padovan@profusion.mobi
Cc: linville@tuxdriver.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth-2.6 2010-09-27
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100928023035.GA3033@vigoh>
References: <20100928023035.GA3033@vigoh>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Mon, 27 Sep 2010 23:30:35 -0300

> And a fix for a deadlock issue between the sk_sndbuf and the backlog
> queue in ERTM. The rest are also needed bug fixes.

This fix is still under discussion.

That change effects quite a few code paths.  And when I looked
at them, I was not at all convinced that dropping the socket
lock like that is safe.

Are you sure there are no pieces of socket or socket related state
that might change under us while we drop that lock, which would thus
make the operation suddenly invalid or cause a state corruption or
crash?

You really need to audit this.
