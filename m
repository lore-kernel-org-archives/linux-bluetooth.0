Return-Path: <cyrus@holtmann.org>
Message-ID: <1408979217.7335.9.camel@pohly-mobl1.fritz.box>
Subject: Re: org.bluez.obex.Transfer1 Suspend/Resume in queued state
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Von Dentz <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mateusz Potrola <mateusz.polrola@gmail.com>
Date: Mon, 25 Aug 2014 17:06:57 +0200
In-Reply-To: <CABBYNZLTF9s1v=wTSSLN0A2zPEgyAAyKhpJ+KaLDSLfZxCG-Tg@mail.gmail.com>
References: <1408961443.27910.149.camel@pohly-mobl1.fritz.box>
	 <CABBYNZLTF9s1v=wTSSLN0A2zPEgyAAyKhpJ+KaLDSLfZxCG-Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2014-08-25 at 13:57 +0300, Luiz Augusto von Dentz wrote:
> Hi Patrick,
> 
> On Mon, Aug 25, 2014 at 1:10 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > Hello!
> >
> > When testing support for Suspend/Resume in SyncEvolution's PBAP backend
> > I ran into a situation that is not handled well at the moment:
> >
> >      1. PullAll creates a new transfer and queues it.
> >      2. Suspend is called while the transfer is not running yet ->
> >         "GDBus.Error:org.bluez.obex.Error.NotInProgress: Not in
> >         progress"
> >      3. When ready, the transfer runs (untested; at the moment,
> >         SyncEvolution cancels the transfer when receiving the error).
> 
> Well this behavior is documented:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/obex-api.txt

I know. The implication slipped past me when we discussed the API,
otherwise I would have brought it up sooner.

> > The only way how SyncEvolution can suspend in this case is to catch the
> > error, wait for the "active" Status and retry to suspend. This is
> > sub-optimal (besides being more complex) because the whole point of the
> > suspend is to not interfere with other activities until the transfer
> > gets resumed again.
> 
> But why you want to suspend a transfer that is currently not active?

Because otherwise it will become active, which is no longer desirable.

>  I
> expected that the active would be suspended thus suspending the whole
> queue since OBEX can only support one at time.

I'm not sure I follow here. Are you saying that if there is an active
transfer A and a queued transfer B, transfer A should get suspended?
That only works if they both came from the same process, which is not
guaranteed.

Even if they are, there's still the race that a suspend of A could hit
the time window when A has already completed and B became active.

> > Would it be possible to get rid of the NotInProgress error during Status
> > = "queued", for example by keeping the transfer in the queued state
> > until it gets resumed?
> 
> Perhaps if we come up with a use case that benefit from it, maybe it
> is valid if we want to be able to suspend transfer after the active,
> or deeper in queue, has completed? I would turn it suspended and then
> a call to Resume should turn the transfer back to queued so it is
> easier to monitor what is going on.

The use case is simple: a transfer was requested and should be either
completed or suspended after a Suspend() call. Having it change from
"queued" to "suspended" would be fine.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.



