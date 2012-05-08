Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANq1E4QW4vSn_r9C=rirShE+-eyPjRX+b5tpC+mx69Hs6aEYqQ@mail.gmail.com>
References: <1336391383.4325.24.camel@jlt3.sipsolutions.net>
	<CANq1E4QW4vSn_r9C=rirShE+-eyPjRX+b5tpC+mx69Hs6aEYqQ@mail.gmail.com>
Date: Tue, 8 May 2012 11:20:37 -0300
Message-ID: <CAA37ikbcPQ5UwX4Yfx9cg-J7uSFoEJmxv8fkn7Hj3b_=pUutMw@mail.gmail.com>
Subject: Re: batostr() function
From: Ulisses Furquim <ulisses@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, May 8, 2012 at 10:30 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
>
> Hi Johannes
>
> On Mon, May 7, 2012 at 1:49 PM, Johannes Berg <johannes@sipsolutions.net>
> wrote:
> > Really? 2 static buffers that are used alternately based on a static
> > variable? How can that possibly be thread-safe? That may work in very
> > restricted scenarios, but ...
>
> Looking at "git blame" it seems the whole function is still from
> linux-2.4. Looks like no-one ever noticed. I've sent a patchset fixing
> it, thanks.

Thanks for fixing it. I'm sure we haven't noticed but it's still weird
to have it this way. :-/

Regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
