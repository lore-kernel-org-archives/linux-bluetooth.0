Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RCoFeA9hrQPOndyQzxNiySGkiPziaT+nuLkGqcityQBQ@mail.gmail.com>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org>
	<1400271298-29769-2-git-send-email-armansito@chromium.org>
	<2DDA7254-76A3-43EE-A116-B6D5B245D8A3@holtmann.org>
	<CAHrH25SdNUQ+5SUC0vmoU90q57iKVkkLERyK7UZ+W=8j7uGKsg@mail.gmail.com>
	<A75E24DA-B69D-452D-8E27-B75DBF2855C8@holtmann.org>
	<CABBYNZL6WrM1sCC4VSXzWWCv8jK-ebpGZdhQ52hCo-v=oFTHVg@mail.gmail.com>
	<CAHrH25RCoFeA9hrQPOndyQzxNiySGkiPziaT+nuLkGqcityQBQ@mail.gmail.com>
Date: Thu, 29 May 2014 23:56:13 +0300
Message-ID: <CABBYNZ++Z7eYNSorqTnBKed1L-gE-Bx89+M5Tj1C4B5btBQ+ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] src/shared/att: Introduce struct bt_att.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman, Marcel,

On Wed, May 28, 2014 at 9:45 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz & Marcel,
>
>>>> ATT is a really simple protocol in this regard.
>>>
>>> It is simple, but it is also not structured. Opcode numbers have no higher meaning. They are just numbers. That why having a table of known opcodes and its semantics might be the simplest way.
>
> Sure. At least for requests, responses, and indications/notifications
> we can have a table. For commands, you can actually check if the
> command bit of the opcode has been set; in that regard the opcodes do
> have some higher meaning: they do encode whether or not the operation
> should be signed and whether or not they are commands. Then again, the
> spec does define specifically which opcodes should have those bits
> set. Eitherway, I will make it so that the semantic meaning of opcodes
> is more explicitly checked in the source file.
>
>>>> Absolutely. Let me know if this has convinced you. So my idea is to
>>>> have a bt_att_send and bt_att_send_without_rsp. I originally had a
>>>> single bt_att_send for all opcodes, but Luiz brought up the fact that
>>>> having a one for all function leads to some inconsistencies, such as
>>>> cases where a callback is passed along with an opcode that doesn't
>>>> expect a response. Personally I don't think this is such a problem as
>>>> long as the API is well documented.
>>>
>>> Right now as said above, just having bt_att_send seems enough. Start with that and see how it goes. Add an extra simpler helper that utilizes bt_att_send with an empty callback is dead simple. We can worry about that later.
>
> So, basically what I had earlier, with more explicit handling of
> opcode semantics instead of somewhat vague handlers?
>
>>> In case of MGMT perhaps it was different because there you don't
>>> actually have responses but actual requests that needs to be
>>> acknowledged before the next request can be sent out.
>>
>> Actually mgmt with calling write directly caused a bunch of issues. We are not doing that anymore. We nicely queue > everything so that orders actually become predictable.
>
> Well this is also true for ATT. I.e. a client is not supposed to send
> a second request before it has received a response to a previous
> request on the same connection, hence they have to go through two
> queues: a write queue waiting for POLLOUT, and a pending queue while
> waiting for the response from the remote device, where the pending
> queue bars any more requests from getting added to the write queue.
> Outgoing indications will also go through the same queues. Commands
> and notifications, on the other hand, skip the pending queue and can
> go straight to the write queue.

Well regardless if you have it calling write directly or waiting
POLLOUT it can still fail which needs a callback and if the caller did
not have it maybe we should write it immediately.

> The way I ended up implementing this involved having separate queues
> for requests, responses, commands, notifications, and indications, but
> I think that's overkill. We really just need a "sequential" queue, to
> queue requests and indications and a "non-sequential" queue for
> commands/notifications. In the former case, I think it's fine to use
> the same queue for indications and requests, since indications are
> only sent from servers and requests are only sent from clients, and
> afaik you can't have both ends of the same ATT connection be
> simultaneously in peripheral and central roles, though I may be wrong.
> At least this is why iOS (& Android afaik) seem to expose a different
> LE random address for each app that implements a GATT server.

Here is where things get interesting, the role of a server and client
I believe is not per connection but per profile, so in a given
connection device A may act as a client for profile X but as a server
for profile Y.

Take a look at 3.3.2 Sequential Protocol in the core spec, I think in
some cases it is actually allowed to have multiple outstanding
requests if their types are different, perhaps that is why you had the
idea of multiple queues, but this makes the handling much more
complicated for the client but as a server we have to be able to
respond to those in parallel. One think that catches my eye was these
huge timeout of 30 seconds for a transaction, having a single request
queue can have a bad impact in responsiveness where a single request
can block anything to happen for 30 seconds.


-- 
Luiz Augusto von Dentz
