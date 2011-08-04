Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312404825.3358.173.camel@THOR>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
	<1312377094-11285-2-git-send-email-luiz.dentz@gmail.com>
	<1312388716.3358.58.camel@THOR>
	<CABBYNZJ9DVr5kPE3ZrWgyWUGBayZTyY+=rfEXpckXT3xkL6X8w@mail.gmail.com>
	<1312404825.3358.173.camel@THOR>
Date: Thu, 4 Aug 2011 12:04:57 +0300
Message-ID: <CABBYNZ+Z6CvFdekTQmw8e=Z0fDw3+vC8RqZnXLZ3PiCTEBLupQ@mail.gmail.com>
Subject: Re: [RFC 1/3] Bluetooth: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Aug 3, 2011 at 11:53 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> My point here (besides pointing out the massive iteration) was to
> suggest that perhaps some scheduler state should be preserved such that
> already-visited priority levels are not revisited more than once per tx
> tasklet schedule.

That is a valid point, Im gonna try to come up with something that address that.

>>  Also I guess for SCO/ESCO/LE e doesn't make
>> much sense to have many queues/priorities, it is basically ACL only,
>> that simplify a lot already.
>
> LE should still have priorities. In fact, in a private test we've been
> running here, we've merged the scheduler so that LE conns that share ACL
> buffers are scheduled alongside other ACL conns (because they share the
> same resource -- namely, the acl_cnt. We also merged SCO/ESCO scheduling
> together as well).

Well I guess it would make sense, specially for SCO/ESCO, now LE Im
not sure, it is not always the case the it uses acl_cnt, but in case
it does it should be prioritized according.

>>
>> >> +
>> >> +                       if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
>> >> +                               continue;
>> >>
>> >> -               num++;
>> >> +                       num++;
>> >>
>> >> -               if (c->sent < min) {
>> >> -                       min  = c->sent;
>> >> -                       conn = c;
>> >> +                       if (c->sent < min) {
>> >> +                               min  = c->sent;
>> >> +                               conn = c;
>> >> +                               *queue = &c->data_q[i];
>> >> +                       }
>> >
>> > Why preserve the fairness logic?
>>
>> It does need to fair if there is 2 or more sockets with the same
>> priority, otherwise the first connection in the list might get all the
>> quote and even if we promote the starving queues it may still happen
>> to top most priority since there it cannot be promoted anymore.
>
> Right. What I meant here was this: if the tx scheduler is re-made as
> priority-based, then it seems logical to discard the fairness logic and
> design the priority scheme such that starvation is not possible. For
> example, the pri levels could be like this:
>        0 ~ 5   socket-programmable priorities
>        6       special CAP_NET_ADMIN priority
>        7       only possible via promotion
> (Not that I'm suggesting that's the only or even best way to make
> starvation not possible).

I would like to stick with current approach with bigger than 6 needing
CAP_NET_ADMIN which is aligned with with SO_PRIORITY current does,
otherwise it would immediately break the current application that uses
priority 6. Besides I don't think having one possible promotion index
is a good idea, it would completely ignore priorities in starvation
case, but there is exactly where it is most needed to throttle lower
priorities in favor of higher.

>> You probably have never run this code did you? Only priority 7 can
>> really monopolize the connection, and that is on purpose, and yes
>> lower priority are throttled so higher priority can get lower latency,
>> what is wrong with that?
>
> With no offense meant, simply running this code would be insufficient to
> qualify it's appropriateness as a replacement scheduler. A bare-minimum
> test matrix would ascertain comparative values for minimum/mean/maximum
> latency and throughput for best-case/nominal/worst-case tx loads.

But it would give a hint if your assumption are correct or not.

> My main concern here is that app-level socket settings can have dramatic
> effects on tx scheduling behavior, especially at near max tx loads.

An that is ultimately what is needed for guaranteed channels (priority
7), best effort is nearly unchanged because there is no guarantees of
latency or throughput.

> What I meant about near monopolization is this:  a priority 6 link that
> retires 2 packets every 55 ms would mean that priority 0 links could
> only xmit every 330 ms (1/3 sec.), assuming the controller was already
> saturated by the priority 6 link. Even priority 3 links are only going
> to be able to xmit every 165ms under these conditions.

So what? the application can and should be set its priority according
to not get throttled, it should only be fair with the same priority,
the other are left behind. Im gonna be repeating this over and over,
best effort channel as we have today have no guarantees (latency,
throughput), so it is perfectly ok to throttle them.

> What if, instead, links that are being promoted because the controller
> is saturated, are promoted to the same (or maybe, higher) priority level
> than was last successful?

Ive tried that, it breaks the prioritization when it is most needed
because it returns the schedulers to its fairness state and complete
ignores the priorities.

>> Right now it promotes starving queues, all of them, but maybe it
>> shouldn't so that we simplify the complexity a little bit.
>
> My thinking here is that the tx tasklet shouldn't be scheduled at all if
> no work can be performed. Of course, the existing code suffers from the
> same defect. Really, the only reason the tx tasklet *needs* to be
> scheduled when the relevant buffer counter is 0 is to catch tx timeouts.

Yep, that can indeed be fixed but then we need to find some other
place to detect tx timeouts.

-- 
Luiz Augusto von Dentz
