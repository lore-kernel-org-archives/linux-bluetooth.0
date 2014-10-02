Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25T1FqMi7zho+gYCbuhmdQpsVoqV5ee3H+UbZwwhqeNC9A@mail.gmail.com>
References: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
	<1412163494-20283-2-git-send-email-luiz.dentz@gmail.com>
	<20141001123408.GA26432@t440s.lan>
	<CABBYNZLK6JfiQWp+pNK8+Pg-YOcShrm4TcbwHdnAKtbfhOcJmg@mail.gmail.com>
	<CAHrH25T1FqMi7zho+gYCbuhmdQpsVoqV5ee3H+UbZwwhqeNC9A@mail.gmail.com>
Date: Thu, 2 Oct 2014 11:36:03 +0300
Message-ID: <CABBYNZLBVPswz2C7xQMN4XCk4Dw+V4mZ08v65iQ+jfH7WmDpLQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] shared/gatt-client: Take fd in bt_gatt_client_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Oct 1, 2014 at 7:17 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz & Johan,
>
>
>>> The above is fine except I don't really see the point in having separate
>>> client and server objects to begin with. I might have missed the
>>> reasoning behind it (in which case please enlighten me), but why don't
>>> we hide both roles behind the same object, since they're anyway tied to
>>> the same connection?
>>>
>
> I think eventually this is may be what we want but it seems more
> natural to me for client and server roles to be in different objects,
> at least internally. There's never an "overlap" between server and
> client roles that I know of and these should be pretty much
> orthogonal. I think eventually we can have a more global object that
> owns the fd & att structure and owns the server and the client, but
> it's more intuitive IMO if the server & client procedures are grouped
> in their own modules. Apart from the transport, there's really nothing
> that they'll share (afaik).

Right, it might make the code more modular but also allow mistakes
such as creating 2 different instances of bt_att for handling client
and server separately.

>
>>> I have no objections to having clearly name-spaced functions for client
>>> and server side behavior, and even keeping these in separate c-files,
>>> but having independent objects for them seems a bit pointless. So why
>>> couldn't we have server_foo(att) and client_foo(att) while keeping just
>>> this one "att" context?
>
> Having independent objects made sense initially, since the kind of
> state they keep is mostly different. bt_gatt_server will mostly only
> interact with gatt_db and bt_att, while bt_gatt_client stores a high
> level client cache. And this isn't too bad from an implementation
> stand-point (in fact it makes sense from an OO perspective) and it
> would be quite ok for a higher-level bt_gatt object to create and own
> these two.
>
> In any case, these could in fact be unified eventually but for now
> let's keep them separate and see how the server turns out without
> overthinking it. I'm going to start sending out patches for the server
> code soon, and once that starts taking shape, I think we can decide if
> they should be unified or not.
>
>
>> So I do agree that it seems much simpler API to unify client and
>> server and let it self manage the ATT connection, we could even notify
>> disconnects via ready callback, well if we fix it because right now if
>> the remote does not respond or respond with something invalid it
>> doesn't seems to be called.
>
> Yeah this is actually a bug in the code. If the remote end doesn't
> respond, then att.c:timeout_cb will be called eventually, which will
> destroy the connection by destroying the io. It notifies this via a
> timeout_callback to the upper layer but the disconnect_callback
> doesn't automatically get called, since io simply closes the fd
> instead of receiving an event (which is how the regular
> disconnect_callback is currently invoked). I suppose this can be fixed
> by calling all registered disconnect callbacks in att.c:timeout_cb.
> I've been aware of this bug though never got around to fixing it :)

Actually we should probably notify a error response otherwise it may
call destroy which gives no hint what happened with the call itself,
but now I figure you actually have a timeout callback which can be
used but it is not per operation and I can only register one at time
so I cannot register one in gatt-client.c otherwise it may get
overwritten, perhaps we should add a timeout callback to bt_att_send
or just remove since disconnect callback should be called anyway and
that can be registered by gatt-client.c.

> If the remote responds with something invalid, bt_att doesn't do
> anything currently. If the opcode is bad, it simply drops it. We'll
> have to figure out a way to correctly handle this, either at the
> bt_att level or at the gatt level.
>
>
>> ... For the server side it seems to be just a
>> matter of attaching the db, which could perhaps be passed in
>> bt_gatt_new or having dedicated bt_gatt_attach_db/bt_gatt_detach_cb.
>
> So, the current idea is this:
>
>    db = gatt_db_new();
>    ... /* Populate DB */
>    att = bt_att_new(fd);
>    client = bt_gatt_client_new(att, mtu);
>    server = bt_gatt_server_new(db, att, mtu);
>
> All of this could be done by a higher-level bt_gatt object that puts
> everything together but for now, let's not create bt_att inside
> bt_gatt_client. I think Marcel's longer term idea is to put these all
> inside an even higher-level bt_gap that basically puts SDP and GATT
> together. (I saw some patches fly by for shared/gap).

Hmm, didn't know about this, anyway going all the way up to GAP seems
a little bit overkill but lets see what Marcel had in mind.

Btw, I resend the patches skipping this one, please check if they are
no breaking anything for you.


-- 
Luiz Augusto von Dentz
