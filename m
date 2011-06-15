Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110615133932.GA14904@dell.ger.corp.intel.com>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
	<1307957658-11330-1-git-send-email-lkslawek@gmail.com>
	<1307957658-11330-2-git-send-email-lkslawek@gmail.com>
	<BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
	<20110615133932.GA14904@dell.ger.corp.intel.com>
Date: Wed, 15 Jun 2011 16:59:13 +0200
Message-ID: <BANLkTi=U2mgumWCTHBMvtROWn5iAA_fiJw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Modify obex_write_stream logic
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 15, 2011 at 3:39 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Jun 15, 2011, Luiz Augusto von Dentz wrote:
>> So this while loop is a bit dangerous since it is supposing to be
>> doing io, so what about separating the read of apparam and body in two
>> callbacks, the apparam could probably be consider a metadata of you
>> are actually accessing so separating those might be a good idea in the
>> long term. If so then read should probably only read the data itself
>> and never mix with apparams, then we have a e.g. read_apparams which
>> is only called once before reading the actual data, how about that?

The loop is only used before we start streaming. That is because if
there was no streaming started, request will be finished after
returning from OpenOBEX callback. To still allow plugins to use the
original approach, the loop guarantees that there will be another
read() if the service plugin did not explicitly returned -EAGAIN, so
read() still decides explicitly when it wants the suspending to
happen, therefore it is perfectly aware of when to call
obex_object_set_io_flags().

This is just how OpenOBEX works - unless we are streaming body
headers, we should add headers when getting event and suspend if we
want to postpone finishing the request. I would not call this loop
"dangerous".

> Seems more or less ok with me, but I'd call it get_apparams since it's
> not really a stream of data like the body. FWIW, I've completely missed
> the extension of the read callback to return other types of data besides
> that which is contained within body headers. The original intent of it
> was to only operate on the actual object body and it'd be nice if we
> could get it back to that state again.

Well, we have also another possible header types and generally in some
near future a profile may need to use more than just application
parameters header and/or body headers (e.g. user defined headers).
This might also allow sending Length header asynchronously (which by
quick looking at code is not possible now).

With approach I presented the cost of changes is very low and
additionally makes it extremely easy to return all possible headers.
Also everything just works, together with support for asynchronous
I/O.

Adding additional callback will unnecessarily complicate the code.

-- 
Slawomir Bochenski
