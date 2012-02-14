Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120213143617.GB19288@aemeltch-MOBL1>
References: <1328792777-25914-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikbgSAYWuft+Yu=+PfBirsnHWidkqQemWTCJ3Y8hoz92Jg@mail.gmail.com>
	<20120213143617.GB19288@aemeltch-MOBL1>
Date: Mon, 13 Feb 2012 22:08:10 -0300
Message-ID: <CAA37ikaipG56oNndivrdt+FF5t7RR5CWgXPPHrQhExTsnXMqQw@mail.gmail.com>
Subject: Re: [RFCv0] Bluetooth: Remove extra chan_put
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 13, 2012 at 11:36 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Fri, Feb 10, 2012 at 04:33:51PM -0200, Ulisses Furquim wrote:
>> Hi Andrei,
>>
>> On Thu, Feb 9, 2012 at 11:06 AM, Emeltchenko Andrei
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Removing l2cap_chan_put since in this function we use l2cap_chan_close
>> > and ops->close which use l2cap_chan_put.
>> >
>> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> > ---
>> > I am not sure that I have checked all possible cases, so I am sending
>> > this as RFC.
>> >
>> >  net/bluetooth/l2cap_core.c |    1 -
>> >  1 files changed, 0 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> > index f1a6b3c..7db6d7f 100644
>> > --- a/net/bluetooth/l2cap_core.c
>> > +++ b/net/bluetooth/l2cap_core.c
>> > @@ -274,7 +274,6 @@ static void l2cap_chan_timeout(struct work_struct *work)
>> >        release_sock(sk);
>> >
>> >        chan->ops->close(chan->data);
>> > -       l2cap_chan_put(chan);
>> >  }
>> >
>> >  struct l2cap_chan *l2cap_chan_create(struct sock *sk)
>> > --
>> > 1.7.8.3
>>
>> While I think you maybe right, please add BT_DBG() to l2cap_chan_hold
>> and l2cap_chan_put and check that. If so, put that information also in
>> your patch, please.
>
> I try to do it, but this case is hard to reproduce (maybe I need to reduce
> timeout for the check).

Well, if it's hard to reproduce than we really need to be sure we're
fixing the problem by removing this _chan_put() call. With the debug
messages printed in _hold() and _put() we can more easily check if we
have an imbalance.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
