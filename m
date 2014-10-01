Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141001123408.GA26432@t440s.lan>
References: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
	<1412163494-20283-2-git-send-email-luiz.dentz@gmail.com>
	<20141001123408.GA26432@t440s.lan>
Date: Wed, 1 Oct 2014 15:50:35 +0300
Message-ID: <CABBYNZLK6JfiQWp+pNK8+Pg-YOcShrm4TcbwHdnAKtbfhOcJmg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] shared/gatt-client: Take fd in bt_gatt_client_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Oct 1, 2014 at 3:34 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Oct 01, 2014, Luiz Augusto von Dentz wrote:
>> -struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
>> +struct bt_gatt_client *bt_gatt_client_new(int fd, uint16_t mtu)
>
> This becomes a bit cumbersome since pretty much any time you have a
> connected ATT socket you must be able to be both client and server in
> order not to exhibit broken behavior.
>
> With the above change you'd need something like the following since the
> fd should really only be processed in one place (bt_att).
>
>         client = client_new(fd);
>         att = client_get_att(client);
>         server = server_new(att);
>
> Without your change I assume the code has been something like:
>
>         att = att_new(fd);
>         client = client_new(att);
>         server = server_new(att);
>
> The above is fine except I don't really see the point in having separate
> client and server objects to begin with. I might have missed the
> reasoning behind it (in which case please enlighten me), but why don't
> we hide both roles behind the same object, since they're anyway tied to
> the same connection?
>
> I have no objections to having clearly name-spaced functions for client
> and server side behavior, and even keeping these in separate c-files,
> but having independent objects for them seems a bit pointless. So why
> couldn't we have server_foo(att) and client_foo(att) while keeping just
> this one "att" context?

I was thinking something similar, anyway I got to this point while
doing the unit tester based on the testing spec, which btw has both
client and server tests, then I realize I would have to managed bt_att
along with bt_gatt_client for no apparent reason.

So I do agree that it seems much simpler API to unify client and
server and let it self manage the ATT connection, we could even notify
disconnects via ready callback, well if we fix it because right now if
the remote does not respond or respond with something invalid it
doesn't seems to be called. For the server side it seems to be just a
matter of attaching the db, which could perhaps be passed in
bt_gatt_new or having dedicated bt_gatt_attach_db/bt_gatt_detach_cb.


-- 
Luiz Augusto von Dentz
