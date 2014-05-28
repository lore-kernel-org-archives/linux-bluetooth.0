Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 01/10] src/shared/att: Introduce struct bt_att.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZL6WrM1sCC4VSXzWWCv8jK-ebpGZdhQ52hCo-v=oFTHVg@mail.gmail.com>
Date: Wed, 28 May 2014 20:28:26 +0200
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B70BCDA8-CFF2-43AD-81A4-B928BD6A82A7@holtmann.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org> <1400271298-29769-2-git-send-email-armansito@chromium.org> <2DDA7254-76A3-43EE-A116-B6D5B245D8A3@holtmann.org> <CAHrH25SdNUQ+5SUC0vmoU90q57iKVkkLERyK7UZ+W=8j7uGKsg@mail.gmail.com> <A75E24DA-B69D-452D-8E27-B75DBF2855C8@holtmann.org> <CABBYNZL6WrM1sCC4VSXzWWCv8jK-ebpGZdhQ52hCo-v=oFTHVg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>> +unsigned int bt_att_send_sequential(struct bt_att *att, uint8_t opcode,
>>>>> +                             const void *param, uint16_t length,
>>>>> +                             bt_att_request_func_t callback, void *user_data,
>>>>> +                             bt_att_destroy_func_t destroy);
>>>> 
>>>> That is the implied behavior for _send functions. So I would not use _send_sequential here at all.
>>> 
>>> This mainly came about after the discussion with Luiz on patch set v1.
>>> My idea was to use bt_att_send for non-sequential ops and
>>> bt_att_send_sequential for the opposite. I could rename these to
>>> bt_att_send_without_rsp and bt_att_send, respectively.
>> 
>> I am getting the feeling that just having bt_att_send only seems much cleaner. And if you give an opcode that does not expect a response, then you have to give an empty callback function. If not you get an error. I have to scratch my head a bit against this.
>> 
>>>> I am still not sure that we should be doing it like this. We tried this with gattrib and it did not turn out that great. I really like the approach of I send this command and expect this PDU back or an error. The reason here is that in theory you can get interleaved commands/response on the same channel.
>>> 
>>> I understand the reasoning behind this; then again it introduces
>>> potential error cases such as expecting the wrong PDU back, e.g.
>>> expecting a "Write Response" while sending a "Read Request". In the
>>> end, I don't see much value in building the API that way, since in
>>> ATT, all sequential requests have a 1-to-1 mapping to a sequential
>>> response. e.g., if we receive a "Read Response", the currently pending
>>> request absolutely has to be a "Read Request", otherwise we are
>>> supposed to ignore the PDU (or drop the connection entirely, according
>>> to the spec).
>>> 
>>>> 
>>>> So this is what you would normally expect:
>>>> 
>>>>       -> command
>>>>       <- response
>>>> 
>>>> Straight forward and simple, right. However nothing is stopping the other side from issues the same command in the other direction.
>>>> 
>>>>       -> command
>>>>       <- command
>>>>       <- response
>>>>       -> response
>>>> 
>>>> And this is not to mention notifications and confirmations that can happen as well.
>>>> 
>>>> I am thinking out loud here. What might help is a table that classifies which opcode is a command, response, notification or confirmation and based on that we just do the right thing.
>>> 
>>> Well, I actually did write a similar unit test on my local branch
>>> using my current implementation and these work as expected. The way I
>>> structured the code actually does (or will do in upcoming patches)
>>> exactly what you say, though instead of using tables, each "handler"
>>> function explicitly checks the opcode to see if it falls into its
>>> expected category (e.g. handle_response, handle_notification, etc.).
>>> 
>>> ATT is a really simple protocol in this regard.
>> 
>> It is simple, but it is also not structured. Opcode numbers have no higher meaning. They are just numbers. That why having a table of known opcodes and its semantics might be the simplest way.
>> 
>>>> 
>>>> Unfortunately we need to get this one right and I know that rebasing patches can be a pain. So if you just want to send the initial 01/01 patch for this then that is fine with me as well. I think some units tests with this overlapping bi-directional communication would be amazingly great to have. I do wonder if other OSes handle this well.
>>> 
>>> Absolutely. Let me know if this has convinced you. So my idea is to
>>> have a bt_att_send and bt_att_send_without_rsp. I originally had a
>>> single bt_att_send for all opcodes, but Luiz brought up the fact that
>>> having a one for all function leads to some inconsistencies, such as
>>> cases where a callback is passed along with an opcode that doesn't
>>> expect a response. Personally I don't think this is such a problem as
>>> long as the API is well documented.
>> 
>> Right now as said above, just having bt_att_send seems enough. Start with that and see how it goes. Add an extra simpler helper that utilizes bt_att_send with an empty callback is dead simple. We can worry about that later.
>> 
>>> Luiz's suggestion was to actually have a separate function per ATT
>>> opcode. In that approach we would remove the opcode + parameter
>>> structure design entirely and have the individual functions accept the
>>> right parameters. So, no bt_att_send, but bt_att_send_read_request,
>>> etc. Do you think this would be a cleaner approach in the end?
>> 
>> I do not want this. Having separate function for each opcode pair or function gets really complicated. We have been down this rabbit hole before. The more generic approach have worked out nicely with mgmt handling and I really like trying to duplicate that. And my current feeling is that bt_att_send is the way to go.
> 
> At least the responses seems useless to queue to write latter and then
> auto acknowledge once written because that will just cause more
> latency, memory and complexity and we can probably just return
> synchronously and retry/fail if a response cannot be sent out, we have
> to remember that there is a socket in between so it is very unlikely
> that a write would fail and in case that fail it is actually better to
> return and error than just keep queuing.

that is exactly the one thing I do not not want. We are doing asynchronous IO. Meaning the write needs to be schedules once the socket signals POLLOUT. You can not do it differently. It all has to go through the same queue. We can have one queue for each direction to not block one with the other.

> In case of MGMT perhaps it was different because there you don't
> actually have responses but actual requests that needs to be
> acknowledged before the next request can be sent out.

Actually mgmt with calling write directly caused a bunch of issues. We are not doing that anymore. We nicely queue everything so that orders actually become predictable.

Regards

Marcel

