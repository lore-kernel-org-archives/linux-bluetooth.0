Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <2DDA7254-76A3-43EE-A116-B6D5B245D8A3@holtmann.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org>
	<1400271298-29769-2-git-send-email-armansito@chromium.org>
	<2DDA7254-76A3-43EE-A116-B6D5B245D8A3@holtmann.org>
Date: Tue, 27 May 2014 23:07:09 -0700
Message-ID: <CAHrH25SdNUQ+5SUC0vmoU90q57iKVkkLERyK7UZ+W=8j7uGKsg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> > +unsigned int bt_att_send_sequential(struct bt_att *att, uint8_t opcode=
,
> > +                             const void *param, uint16_t length,
> > +                             bt_att_request_func_t callback, void *use=
r_data,
> > +                             bt_att_destroy_func_t destroy);
>
> That is the implied behavior for _send functions. So I would not use _sen=
d_sequential here at all.

This mainly came about after the discussion with Luiz on patch set v1.
My idea was to use bt_att_send for non-sequential ops and
bt_att_send_sequential for the opposite. I could rename these to
bt_att_send_without_rsp and bt_att_send, respectively.

> I am still not sure that we should be doing it like this. We tried this w=
ith gattrib and it did not turn out that great. I really like the approach =
of I send this command and expect this PDU back or an error. The reason her=
e is that in theory you can get interleaved commands/response on the same c=
hannel.

I understand the reasoning behind this; then again it introduces
potential error cases such as expecting the wrong PDU back, e.g.
expecting a "Write Response" while sending a "Read Request". In the
end, I don't see much value in building the API that way, since in
ATT, all sequential requests have a 1-to-1 mapping to a sequential
response. e.g., if we receive a "Read Response", the currently pending
request absolutely has to be a "Read Request", otherwise we are
supposed to ignore the PDU (or drop the connection entirely, according
to the spec).

>
> So this is what you would normally expect:
>
>         -> command
>         <- response
>
> Straight forward and simple, right. However nothing is stopping the other=
 side from issues the same command in the other direction.
>
>         -> command
>         <- command
>         <- response
>         -> response
>
> And this is not to mention notifications and confirmations that can happe=
n as well.
>
> I am thinking out loud here. What might help is a table that classifies w=
hich opcode is a command, response, notification or confirmation and based =
on that we just do the right thing.

Well, I actually did write a similar unit test on my local branch
using my current implementation and these work as expected. The way I
structured the code actually does (or will do in upcoming patches)
exactly what you say, though instead of using tables, each "handler"
function explicitly checks the opcode to see if it falls into its
expected category (e.g. handle_response, handle_notification, etc.).

ATT is a really simple protocol in this regard.

>
> Unfortunately we need to get this one right and I know that rebasing patc=
hes can be a pain. So if you just want to send the initial 01/01 patch for =
this then that is fine with me as well. I think some units tests with this =
overlapping bi-directional communication would be amazingly great to have. =
I do wonder if other OSes handle this well.

Absolutely. Let me know if this has convinced you. So my idea is to
have a bt_att_send and bt_att_send_without_rsp. I originally had a
single bt_att_send for all opcodes, but Luiz brought up the fact that
having a one for all function leads to some inconsistencies, such as
cases where a callback is passed along with an opcode that doesn't
expect a response. Personally I don't think this is such a problem as
long as the API is well documented.

Luiz's suggestion was to actually have a separate function per ATT
opcode. In that approach we would remove the opcode + parameter
structure design entirely and have the individual functions accept the
right parameters. So, no bt_att_send, but bt_att_send_read_request,
etc. Do you think this would be a cleaner approach in the end?

Cheers,
-Arman
