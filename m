Return-Path: <cyrus@holtmann.org>
Message-ID: <1336487108.4320.2.camel@jlt3.sipsolutions.net>
Subject: Re: batostr() function
From: Johannes Berg <johannes@sipsolutions.net>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Date: Tue, 08 May 2012 16:25:08 +0200
In-Reply-To: <CANq1E4QW4vSn_r9C=rirShE+-eyPjRX+b5tpC+mx69Hs6aEYqQ@mail.gmail.com> (sfid-20120508_153110_439793_D7D64B69)
References: <1336391383.4325.24.camel@jlt3.sipsolutions.net>
	 <CANq1E4QW4vSn_r9C=rirShE+-eyPjRX+b5tpC+mx69Hs6aEYqQ@mail.gmail.com>
	 (sfid-20120508_153110_439793_D7D64B69)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-05-08 at 15:30 +0200, David Herrmann wrote:
> Hi Johannes
> 
> On Mon, May 7, 2012 at 1:49 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> > Really? 2 static buffers that are used alternately based on a static
> > variable? How can that possibly be thread-safe? That may work in very
> > restricted scenarios, but ...
> 
> Looking at "git blame" it seems the whole function is still from
> linux-2.4. Looks like no-one ever noticed. I've sent a patchset fixing
> it, thanks.

I was thinking you could use %pM, but it seems BT addresses are stored
the wrong way around for some reason ...

johannes

