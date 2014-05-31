Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FECA0402-C331-45EA-B914-29E16092C07F@holtmann.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org>
	<1400271298-29769-2-git-send-email-armansito@chromium.org>
	<2DDA7254-76A3-43EE-A116-B6D5B245D8A3@holtmann.org>
	<CAHrH25SdNUQ+5SUC0vmoU90q57iKVkkLERyK7UZ+W=8j7uGKsg@mail.gmail.com>
	<A75E24DA-B69D-452D-8E27-B75DBF2855C8@holtmann.org>
	<CABBYNZL6WrM1sCC4VSXzWWCv8jK-ebpGZdhQ52hCo-v=oFTHVg@mail.gmail.com>
	<CAHrH25RCoFeA9hrQPOndyQzxNiySGkiPziaT+nuLkGqcityQBQ@mail.gmail.com>
	<FECA0402-C331-45EA-B914-29E16092C07F@holtmann.org>
Date: Sat, 31 May 2014 00:14:26 -0700
Message-ID: <CAHrH25Ts6XG_MAqrCzQv=Z_o-1jfEptXmiryGtqFND5ONgTVTQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks, this conversation was very helpful. I'll revise the initial
patch and send it to the mailing list some time next week.

Cheers,
-Arman

On Fri, May 30, 2014 at 10:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Arman,
>
>>>>> ATT is a really simple protocol in this regard.
>>>>
>>>> It is simple, but it is also not structured. Opcode numbers have no higher meaning. They are just numbers. That why having a table of known opcodes and its semantics might be the simplest way.
>>
>> Sure. At least for requests, responses, and indications/notifications
>> we can have a table. For commands, you can actually check if the
>> command bit of the opcode has been set; in that regard the opcodes do
>> have some higher meaning: they do encode whether or not the operation
>> should be signed and whether or not they are commands. Then again, the
>> spec does define specifically which opcodes should have those bits
>> set. Eitherway, I will make it so that the semantic meaning of opcodes
>> is more explicitly checked in the source file.
>
> good point with the commands. I wish they would have done the same for notifications.
>
> This reminds me that we should include the support for signed payloads right into bt_att. We ran into this with the Android support. The actual opcode is part of the signed data. So I think we just need to have functions that allows us to attach the CSRK for signing and resolving right to the bt_att and we do the actual signing and resolving in the background for the user.
>
>>
>>>>> Absolutely. Let me know if this has convinced you. So my idea is to
>>>>> have a bt_att_send and bt_att_send_without_rsp. I originally had a
>>>>> single bt_att_send for all opcodes, but Luiz brought up the fact that
>>>>> having a one for all function leads to some inconsistencies, such as
>>>>> cases where a callback is passed along with an opcode that doesn't
>>>>> expect a response. Personally I don't think this is such a problem as
>>>>> long as the API is well documented.
>>>>
>>>> Right now as said above, just having bt_att_send seems enough. Start with that and see how it goes. Add an extra simpler helper that utilizes bt_att_send with an empty callback is dead simple. We can worry about that later.
>>
>> So, basically what I had earlier, with more explicit handling of
>> opcode semantics instead of somewhat vague handlers?
>
> Yes. If you go with one bt_att_send that just takes the opcode, then we need builtin semantics on what that opcode means and in case of errors, just returns false.
>
>>>> In case of MGMT perhaps it was different because there you don't
>>>> actually have responses but actual requests that needs to be
>>>> acknowledged before the next request can be sent out.
>>>
>>> Actually mgmt with calling write directly caused a bunch of issues. We are not doing that anymore. We nicely queue > everything so that orders actually become predictable.
>>
>> Well this is also true for ATT. I.e. a client is not supposed to send
>> a second request before it has received a response to a previous
>> request on the same connection, hence they have to go through two
>> queues: a write queue waiting for POLLOUT, and a pending queue while
>> waiting for the response from the remote device, where the pending
>> queue bars any more requests from getting added to the write queue.
>> Outgoing indications will also go through the same queues. Commands
>> and notifications, on the other hand, skip the pending queue and can
>> go straight to the write queue.
>
> In general I think we need a request queue and an indication queue. Since these are the two transaction that we have. One is for the client and one for the server and they can intermix. Additionally we keep a busy flag for each queue. That way the write handler can easily process the queues. In addition we need a general queue for commands and notifications since they can go at any time. This is the sending side. When we are the client for requests/commands and when we are the server for indications/notifications.
>
> For the receiving side and having to respond to requests and indications, we can just use the general queue to get things written out. However the API might be a bt_att_reply in that case.
>
>> The way I ended up implementing this involved having separate queues
>> for requests, responses, commands, notifications, and indications, but
>> I think that's overkill. We really just need a "sequential" queue, to
>> queue requests and indications and a "non-sequential" queue for
>> commands/notifications. In the former case, I think it's fine to use
>> the same queue for indications and requests, since indications are
>> only sent from servers and requests are only sent from clients, and
>> afaik you can't have both ends of the same ATT connection be
>> simultaneously in peripheral and central roles, though I may be wrong.
>> At least this is why iOS (& Android afaik) seem to expose a different
>> LE random address for each app that implements a GATT server.
>
> The peripheral and central roles have nothing to do with GATT. A peripheral can implement a GATT client + server and a central can also have a GATT client + server. In the general case, you have a server and client no matter what LE role you are in.
>
> And for iOS and the different LE random addresses, that is just plain LE Privacy support with resolvable random addresses. You will see that iOS devices switch their address every 9 minutes. However if you have the IRK, then you can resolve them into the device public address. Newer Linux kernels will do that job for you. Once paired with an iOS peripheral or central, the kernel will just give you the public address.
>
> Regards
>
> Marcel
>
