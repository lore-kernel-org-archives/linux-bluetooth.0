Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RNVpVJccoo_O_EDFQH=NOwisjKkSX1gYFGCnNsjKW8Ag@mail.gmail.com>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
	<CABBYNZLuRf89qgE6vV5PWZFZcB4em11_ySJnUXMGb+gSQ1djkw@mail.gmail.com>
	<780A1AF5-538F-4239-A4E2-86B0BB2EDDB0@holtmann.org>
	<CAHrH25RNVpVJccoo_O_EDFQH=NOwisjKkSX1gYFGCnNsjKW8Ag@mail.gmail.com>
Date: Wed, 7 May 2014 11:46:00 +0300
Message-ID: <CABBYNZ++3Zgoia1t6CkWwVVNo+O_4nkUn+Vmw9phgAu3gdXdxw@mail.gmail.com>
Subject: Re: [PATCH 00/10] bt_att initial implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcin Kraglak <marcin.kraglak@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, May 7, 2014 at 9:53 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>>> Apparently you have ignored my comments regarding the API, it is
>>> probably not the best thing to base everything on mgmt API since that
>>> is a internal protocol which does not need encoding as everything is
>>> passed in host order, also unlike mgmt you have GATT on top o ATT so
>>> it is beneficial to use iovec in the API.
>
> Sorry, I must have missed those comments in my inbox somewhere, so I
> didn't mean to ignore them. That said, as Marcel also pointed out,
> bt_att is only meant for ATT protocol transactions. It doesn't do any
> state keeping apart from some internal queues for ATT request
> control-flow, but that's pretty much it. The intended use is to create
> a bt_att around a file descriptor, use bt_att_send with the opcode and
> the relevant parameters to send requests/commands, bt_att_reply to
> send replies to incoming requests/indications, and some other function
> to subscribe to events. In that regard, the structure of
> src/shared/mgmt is remarkably suitable for bt_att. The encoding of the
> PDU, including the necessary endianness conversion, is handled by
> bt_att.
>
> That last bit of course is different from mgmt, where the parameters
> structure definition itself encodes the data being sent over the
> socket, whereas bt_att performs encoding/decoding logic. Either way, I
> think this definition makes for a nice API.

If you can really tell by opcode how to encode/decode the data that
should be fine, regarding the API style I would favor functions vs use
of opcode + struct, I understand in MGMT case we did this to define
the protocol at PDU level so anyone could use those to implement a
library thus why it is placed under lib/. Anyway Im not against either
style since we can still change if we need.

>>> Regarding unit tests, I think you should take a look at test-av*, and
>>> there exists a test specification for ATT/GATT so we should start with
>>> it since is what PTS uses for qualification:
>>> https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=229871
>>>
>>> You can use the name and description of the unit test following the
>>> test specification:
>>>
>>> /TP/GAC/CL/BV-01-C: Verify that a Generic Attribute Profile client can
>>> generate an Exchange MTU Request command  to configure ATT_MTU over
>>> LE.
>>
>> This is still relevant and perhaps it should involve testing gatt-db
>> as well since the testing spec also involves the server, which leads
>> to the question if we should keep them apart? I guess this should be
>> done in a single place since we will be controlling the fd, or the
>> idea is that bt_att should access gatt_db internally to handle
>> incoming requests?
>
> This is a very good point. Currently the idea is to have a bt_gatt
> which defines GATT client-side functions for primary service
> discovery, read/write requests etc, which would then internally use
> bt_att for ATT protocol transactions, and gatt_db which solely serves
> as a medium for storage of local/remote attributes. Basically, a
> complete implementation of a GATT client/server would create and
> manage individual instances of bt_gatt/bt_att for all requests and
> gatt_db to explicitly store the results of those requests. In essence,
> the database implementation and bt_gatt/bt_att won't need to
> explicitly depend on each other.

I believe bt_gatt will actually need to depend on gatt_db at some
point because it makes it a lot more convenient to do the
qualification tests without having to implement the interaction with
gatt_db on the test itself and it is also more convenient in terms of
API since you don't have to create extra callbacks to interact with
the db.

> This is why it might make sense to hold off on writing PTS style tests
> until we have the complete picture in place. For now, I went with a
> simple set of unit tests to make sure that basic PDU encoding/decoding
> is done correctly for bt_att. As we then start putting gatt_db and
> bt_gatt together, I say we then write tests in the fashion of
> test-av*.

Well you risk having to do the same test more than once, in case of
ATT I don't think that is a problem since there doesn't seems to be
tests specific for it but in case of GATT I would stick with test spec
since the beginning.


-- 
Luiz Augusto von Dentz
