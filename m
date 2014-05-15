Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CABBYNZK4A6qOeRvnHXo8JrS8JTUuM951=eCtNSGxHAdraX409Q@mail.gmail.com>
References: <1399666440-14078-1-git-send-email-armansito@chromium.org>
	<1399666440-14078-2-git-send-email-armansito@chromium.org>
	<01CD59B6-44C7-425A-8686-82C428F41C87@holtmann.org>
	<CAHrH25RubNJx89MabHvHQc8ZsymcdDB2VoNVxwEooHEDv2=ybA@mail.gmail.com>
	<CABBYNZLmDazb+0=-sph80yXsVYY4CcP0EVgBiJt00spE-=YhTw@mail.gmail.com>
	<CAHrH25TYbP7mkwJeJO3vcECetbTCx_TguUDuE1k02XC=a6pOmQ@mail.gmail.com>
	<CABBYNZK4A6qOeRvnHXo8JrS8JTUuM951=eCtNSGxHAdraX409Q@mail.gmail.com>
Date: Thu, 15 May 2014 10:22:41 -0700
Message-ID: <CAHrH25Q5ZZdc0iSyw7qN1dL5kDW-O5Auch01y5w_i=S-OwKWxQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Well personally I would have dedicated function for each opcode, that
> way there is very little room for confusion i.e using
> bt_att_send_op_with_rsp for an opcode that does not solicit a response
> and vice-versa, internally you can still have them using common
> functions.

While I see your point, I think I'm not going to go with individual
functions for each opcode at the moment. Especially because, for
incoming PDUs, we need a generic way to propagate the PDU to the upper
layer anyway, and the current opcode + param structure based signature
allows upper layers to set a single callback with a unified signature,
instead of setting a separate callback with a different function
signature for each incoming opcode. I believe the former is cleaner in
general and the current way of having a generic bt_att_send makes
things consistent between incoming and outgoing PDUs. The alternative
would be to have a dedicated function to send outgoing operations and
then a generic callback (opcode + param) for incoming ones, but I
don't prefer this.

We could remove the ambiguity that you mention by having the functions
fail and return false in those cases and by explicitly documenting how
they should be used. We'll document that bt_att_send_op_with_rsp will
return false for all opcodes that don't have control flow and that
multiple operations posted through this function will be queued until
a response for each one has been received. We'll document that
bt_att_send_op[_no_rsp] will send the PDU as soon as the buffer is
ready.

-Arman
