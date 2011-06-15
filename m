Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 16:39:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Modify obex_write_stream logic
Message-ID: <20110615133932.GA14904@dell.ger.corp.intel.com>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
 <1307957658-11330-1-git-send-email-lkslawek@gmail.com>
 <1307957658-11330-2-git-send-email-lkslawek@gmail.com>
 <BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jun 15, 2011, Luiz Augusto von Dentz wrote:
> So this while loop is a bit dangerous since it is supposing to be
> doing io, so what about separating the read of apparam and body in two
> callbacks, the apparam could probably be consider a metadata of you
> are actually accessing so separating those might be a good idea in the
> long term. If so then read should probably only read the data itself
> and never mix with apparams, then we have a e.g. read_apparams which
> is only called once before reading the actual data, how about that?

Seems more or less ok with me, but I'd call it get_apparams since it's
not really a stream of data like the body. FWIW, I've completely missed
the extension of the read callback to return other types of data besides
that which is contained within body headers. The original intent of it
was to only operate on the actual object body and it'd be nice if we
could get it back to that state again.

Johan
