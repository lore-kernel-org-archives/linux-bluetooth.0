Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CABBYNZ++3Zgoia1t6CkWwVVNo+O_4nkUn+Vmw9phgAu3gdXdxw@mail.gmail.com>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
	<CABBYNZLuRf89qgE6vV5PWZFZcB4em11_ySJnUXMGb+gSQ1djkw@mail.gmail.com>
	<780A1AF5-538F-4239-A4E2-86B0BB2EDDB0@holtmann.org>
	<CAHrH25RNVpVJccoo_O_EDFQH=NOwisjKkSX1gYFGCnNsjKW8Ag@mail.gmail.com>
	<CABBYNZ++3Zgoia1t6CkWwVVNo+O_4nkUn+Vmw9phgAu3gdXdxw@mail.gmail.com>
Date: Wed, 7 May 2014 12:25:11 -0700
Message-ID: <CAHrH25Tmw0HUAW=j1wHJ5sOhhpuCCdP_QBjUr6xVDg+YKeQLEw@mail.gmail.com>
Subject: Re: [PATCH 00/10] bt_att initial implementation
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcin Kraglak <marcin.kraglak@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> That last bit of course is different from mgmt, where the parameters
>> structure definition itself encodes the data being sent over the
>> socket, whereas bt_att performs encoding/decoding logic. Either way, I
>> think this definition makes for a nice API.
>
> If you can really tell by opcode how to encode/decode the data that
> should be fine, regarding the API style I would favor functions vs use
> of opcode + struct, I understand in MGMT case we did this to define
> the protocol at PDU level so anyone could use those to implement a
> library thus why it is placed under lib/. Anyway Im not against either
> style since we can still change if we need.

Yes, the opcode tells you exactly what the final PDU will look like. I
had to make a decision between opcode + struct vs functions and I went
with the former as it felt more consistent. Though, as you said, we
can always change things up later if we feel like there's a better
way.

>> This is a very good point. Currently the idea is to have a bt_gatt
>> which defines GATT client-side functions for primary service
>> discovery, read/write requests etc, which would then internally use
>> bt_att for ATT protocol transactions, and gatt_db which solely serves
>> as a medium for storage of local/remote attributes. Basically, a
>> complete implementation of a GATT client/server would create and
>> manage individual instances of bt_gatt/bt_att for all requests and
>> gatt_db to explicitly store the results of those requests. In essence,
>> the database implementation and bt_gatt/bt_att won't need to
>> explicitly depend on each other.
>
> I believe bt_gatt will actually need to depend on gatt_db at some
> point because it makes it a lot more convenient to do the
> qualification tests without having to implement the interaction with
> gatt_db on the test itself and it is also more convenient in terms of
> API since you don't have to create extra callbacks to interact with
> the db.

That's true. It mostly depends on whether the code is implementing a
GATT client or server so we should make bt_att and gatt_db not depend
on each other, so as to make the code reusable for both client/server.
Since bt_gatt is going to end up being mostly client-only, I'm fine
with an instance of bt_gatt creating its own internal gatt_db.

>> This is why it might make sense to hold off on writing PTS style tests
>> until we have the complete picture in place. For now, I went with a
>> simple set of unit tests to make sure that basic PDU encoding/decoding
>> is done correctly for bt_att. As we then start putting gatt_db and
>> bt_gatt together, I say we then write tests in the fashion of
>> test-av*.
>
> Well you risk having to do the same test more than once, in case of
> ATT I don't think that is a problem since there doesn't seems to be
> tests specific for it but in case of GATT I would stick with test spec
> since the beginning.

Exactly what I'm thinking. For GATT we should plan tests based on the
test spec as we develop the code.

-Arman
