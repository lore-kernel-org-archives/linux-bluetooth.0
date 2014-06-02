Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 01/10] src/shared/att: Introduce struct bt_att.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLvODjLHemMHfTxNUkqR4+w9b-HjLoGe0E-jaiccXmdTA@mail.gmail.com>
Date: Mon, 2 Jun 2014 10:32:06 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <2A819317-69D0-469D-B49F-659E2F2EF1B3@holtmann.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org> <1400271298-29769-2-git-send-email-armansito@chromium.org> <2DDA7254-76A3-43EE-A116-B6D5B245D8A3@holtmann.org> <CAHrH25SdNUQ+5SUC0vmoU90q57iKVkkLERyK7UZ+W=8j7uGKsg@mail.gmail.com> <A75E24DA-B69D-452D-8E27-B75DBF2855C8@holtmann.org> <CABBYNZL6WrM1sCC4VSXzWWCv8jK-ebpGZdhQ52hCo-v=oFTHVg@mail.gmail.com> <CAHrH25RCoFeA9hrQPOndyQzxNiySGkiPziaT+nuLkGqcityQBQ@mail.gmail.com> <CABBYNZ++Z7eYNSorqTnBKed1L-gE-Bx89+M5Tj1C4B5btBQ+ZQ@mail.gmail.com> <0AB53D52-1724-4D6A-AA92-A6276C357910@holtmann.org> <CABBYNZLvODjLHemMHfTxNUkqR4+w9b-HjLoGe0E-jaiccXmdTA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>>>> ATT is a really simple protocol in this regard.
>>>>>> 
>>>>>> It is simple, but it is also not structured. Opcode numbers have no higher meaning. They are just numbers. That why having a table of known opcodes and its semantics might be the simplest way.
>>>> 
>>>> Sure. At least for requests, responses, and indications/notifications
>>>> we can have a table. For commands, you can actually check if the
>>>> command bit of the opcode has been set; in that regard the opcodes do
>>>> have some higher meaning: they do encode whether or not the operation
>>>> should be signed and whether or not they are commands. Then again, the
>>>> spec does define specifically which opcodes should have those bits
>>>> set. Eitherway, I will make it so that the semantic meaning of opcodes
>>>> is more explicitly checked in the source file.
>>>> 
>>>>>>> Absolutely. Let me know if this has convinced you. So my idea is to
>>>>>>> have a bt_att_send and bt_att_send_without_rsp. I originally had a
>>>>>>> single bt_att_send for all opcodes, but Luiz brought up the fact that
>>>>>>> having a one for all function leads to some inconsistencies, such as
>>>>>>> cases where a callback is passed along with an opcode that doesn't
>>>>>>> expect a response. Personally I don't think this is such a problem as
>>>>>>> long as the API is well documented.
>>>>>> 
>>>>>> Right now as said above, just having bt_att_send seems enough. Start with that and see how it goes. Add an extra simpler helper that utilizes bt_att_send with an empty callback is dead simple. We can worry about that later.
>>>> 
>>>> So, basically what I had earlier, with more explicit handling of
>>>> opcode semantics instead of somewhat vague handlers?
>>>> 
>>>>>> In case of MGMT perhaps it was different because there you don't
>>>>>> actually have responses but actual requests that needs to be
>>>>>> acknowledged before the next request can be sent out.
>>>>> 
>>>>> Actually mgmt with calling write directly caused a bunch of issues. We are not doing that anymore. We nicely queue > everything so that orders actually become predictable.
>>>> 
>>>> Well this is also true for ATT. I.e. a client is not supposed to send
>>>> a second request before it has received a response to a previous
>>>> request on the same connection, hence they have to go through two
>>>> queues: a write queue waiting for POLLOUT, and a pending queue while
>>>> waiting for the response from the remote device, where the pending
>>>> queue bars any more requests from getting added to the write queue.
>>>> Outgoing indications will also go through the same queues. Commands
>>>> and notifications, on the other hand, skip the pending queue and can
>>>> go straight to the write queue.
>>> 
>>> Well regardless if you have it calling write directly or waiting
>>> POLLOUT it can still fail which needs a callback and if the caller did
>>> not have it maybe we should write it immediately.
>> 
>> if it fails due to the fact the kernel interrupted it, then you just queue it first item again and enter the main loop for the next attempt. It it fails fatal, then you disconnect the link. Either way, we are going through a queue and POLLOUT.
>> 
>>>> The way I ended up implementing this involved having separate queues
>>>> for requests, responses, commands, notifications, and indications, but
>>>> I think that's overkill. We really just need a "sequential" queue, to
>>>> queue requests and indications and a "non-sequential" queue for
>>>> commands/notifications. In the former case, I think it's fine to use
>>>> the same queue for indications and requests, since indications are
>>>> only sent from servers and requests are only sent from clients, and
>>>> afaik you can't have both ends of the same ATT connection be
>>>> simultaneously in peripheral and central roles, though I may be wrong.
>>>> At least this is why iOS (& Android afaik) seem to expose a different
>>>> LE random address for each app that implements a GATT server.
>>> 
>>> Here is where things get interesting, the role of a server and client
>>> I believe is not per connection but per profile, so in a given
>>> connection device A may act as a client for profile X but as a server
>>> for profile Y.
>> 
>> They are, but this does not change the fact that in case you have two profiles that use client roles that they can send requests at the same time. It all needs to be sequentially handled. No matter what.
>> 
>>> Take a look at 3.3.2 Sequential Protocol in the core spec, I think in
>>> some cases it is actually allowed to have multiple outstanding
>>> requests if their types are different, perhaps that is why you had the
>>> idea of multiple queues, but this makes the handling much more
>>> complicated for the client but as a server we have to be able to
>>> respond to those in parallel. One think that catches my eye was these
>>> huge timeout of 30 seconds for a transaction, having a single request
>>> queue can have a bad impact in responsiveness where a single request
>>> can block anything to happen for 30 seconds.
>> 
>> I do not not see how this is valid at all. Lets quote the spec here (same section)
>> 
>> "Once a client sends a request to a server, that client shall send no other request to the same server until a response PDU has been received.”
>> 
>> This makes it pretty clear that if you send a request, then you are not allow to send any other request. No matter if it is for a different profile/service or different PDU type. The same applies to indications.
> 
> Im afraid the spec is talking about a PDU with request type since it
> has this kind of note:
> 
> "It is possible for a server to receive a request and then a command
> before responding to the original request. The flow control of requests is not
> affected by the transmission of commands."
> 
> My comments regarding requests was in general for outstanding PDUs
> that requires a response (any type), this is reinforced by:
> 
> "Flow control for each client and a server is independent."

that is pretty much what I said. Since requests and commands are different, you can only having one request at a time, but potentially multiple commands as well.

>> "Indications sent from a server also use a sequential indication-confirmation protocol. No other indications shall be sent to the same client from this server until a confirmation PDU has been received.”
> 
> Since the client and server are independent I believe you can have a
> both a request and a indication outstanding given that the role is
> defined by profile and we can have independent profiles using bt_att.

That is my current assumption as well. You can send a request, then send an indication. However I am curious on how many current implementations handle this correctly. We need test cases for this interleaving.

>> This falls also in line that transaction between a server and multiple clients are required to be atomic. And it is clear that the flow control / transaction model is applied for each direction individual.
>> 
>> "The client, however, is free to send commands and requests prior to sending a confirmation.”
>> 
>> What the specification is missing is a bit in the opcode that says, I am a notification. At that point it would be really simple to know which opcodes are allowed when a transaction is going on and which are not. More important which ones are part of the transaction and which are not when receiving.
>> 
>> That is why I was going to propose an internal table that clearly identifies which opcodes are requests, which ones are responses and most important which one is the notification.
> 
> Well my argument was that we gonna need different queues for different
> PDUs types due to the fact that each transaction has a huge timeout of
> 30 seconds, perhaps this is actually what you meant by identifying
> what type of request it is but you didn't talk about how this would
> affect the queueing. For commands in special there is no need for
> queuing as they don't have any flow control.

See my other email for how we should handle this. While commands do not need flow control, the commands still have to go through a queue for writing.

Regards

Marcel

