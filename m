Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408979217.7335.9.camel@pohly-mobl1.fritz.box>
References: <1408961443.27910.149.camel@pohly-mobl1.fritz.box>
	<CABBYNZLTF9s1v=wTSSLN0A2zPEgyAAyKhpJ+KaLDSLfZxCG-Tg@mail.gmail.com>
	<1408979217.7335.9.camel@pohly-mobl1.fritz.box>
Date: Tue, 26 Aug 2014 11:07:48 +0300
Message-ID: <CABBYNZLJBSJZkiVin0uLo=jy6-ZvyAvU+FM_03p7cri67OzPdQ@mail.gmail.com>
Subject: Re: org.bluez.obex.Transfer1 Suspend/Resume in queued state
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Luiz Von Dentz <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mateusz Potrola <mateusz.polrola@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Mon, Aug 25, 2014 at 6:06 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Mon, 2014-08-25 at 13:57 +0300, Luiz Augusto von Dentz wrote:
>> Hi Patrick,
>>
>> On Mon, Aug 25, 2014 at 1:10 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> > Hello!
>> >
>> > When testing support for Suspend/Resume in SyncEvolution's PBAP backend
>> > I ran into a situation that is not handled well at the moment:
>> >
>> >      1. PullAll creates a new transfer and queues it.
>> >      2. Suspend is called while the transfer is not running yet ->
>> >         "GDBus.Error:org.bluez.obex.Error.NotInProgress: Not in
>> >         progress"
>> >      3. When ready, the transfer runs (untested; at the moment,
>> >         SyncEvolution cancels the transfer when receiving the error).
>>
>> Well this behavior is documented:
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/obex-api.txt
>
> I know. The implication slipped past me when we discussed the API,
> otherwise I would have brought it up sooner.
>
>> > The only way how SyncEvolution can suspend in this case is to catch the
>> > error, wait for the "active" Status and retry to suspend. This is
>> > sub-optimal (besides being more complex) because the whole point of the
>> > suspend is to not interfere with other activities until the transfer
>> > gets resumed again.
>>
>> But why you want to suspend a transfer that is currently not active?
>
> Because otherwise it will become active, which is no longer desirable.
>
>>  I
>> expected that the active would be suspended thus suspending the whole
>> queue since OBEX can only support one at time.
>
> I'm not sure I follow here. Are you saying that if there is an active
> transfer A and a queued transfer B, transfer A should get suspended?
> That only works if they both came from the same process, which is not
> guaranteed.

Yep, I guess we ignored the fact different processes may create their
own transfers but it is a valid point.

> Even if they are, there's still the race that a suspend of A could hit
> the time window when A has already completed and B became active.

That is true, its more an IPC problem where things don't happen
instantaneously but it can happen, but again as OBEX can only deal
with 1 transfer at the time if the current transfer is suspended the
next one wont continue, or perhaps we want a master suspend e.g.
Session.Suspend that suspend everything at once but that Im afraid
should only be possible by creator of the session.

>> > Would it be possible to get rid of the NotInProgress error during Status
>> > = "queued", for example by keeping the transfer in the queued state
>> > until it gets resumed?
>>
>> Perhaps if we come up with a use case that benefit from it, maybe it
>> is valid if we want to be able to suspend transfer after the active,
>> or deeper in queue, has completed? I would turn it suspended and then
>> a call to Resume should turn the transfer back to queued so it is
>> easier to monitor what is going on.
>
> The use case is simple: a transfer was requested and should be either
> completed or suspended after a Suspend() call. Having it change from
> "queued" to "suspended" would be fine.

I will start with this design then and allow transfer owner to suspend
their transfer while they are queued, later we can discuss if we need
a master suspend/resume

-- 
Luiz Augusto von Dentz
