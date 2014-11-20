Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Nov 2014 11:34:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Subject: Re: Handling EBUSY for LE connections.
Message-ID: <20141120093403.GA20651@t440s.lan>
References: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
 <50181A20-3313-48C7-924B-05C67B975139@holtmann.org>
 <CAHrH25T6tmUO2Zvsr=R7+yHwQE0_hY_sMt4UQAmCBMZBOH0PRQ@mail.gmail.com>
 <ED9629AB-B978-49FE-A7D7-5D9E62642504@holtmann.org>
 <CAHrH25Te4J6ospnJYA00mb1RofwHrS4=KD8LjmTLvo5Y4Jy8EQ@mail.gmail.com>
 <CAHrH25S5X5UZJwH0JuoWGW70bDdO48iS8Ex5pF0K9Cd7JsRV8A@mail.gmail.com>
 <7ED5AE30-EF53-47EA-A9CE-DD371CE10910@holtmann.org>
 <CAHrH25QzAYG-uHgEJ2rBmpJ_RMgW9zZ0+WvwtY3Mo0zKUxgB9w@mail.gmail.com>
 <20141119212751.GA6364@t440s.P-661HNU-F1>
 <CAHrH25Qds=wD87kT-_6f+RJP-MDVmjDSATa0qQmHKmHMUNv0iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25Qds=wD87kT-_6f+RJP-MDVmjDSATa0qQmHKmHMUNv0iw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Nov 19, 2014, Arman Uguray wrote:
> I now have a few of questions before I start implementing anything:
> 
> 1. I'm confused about how the current code handles the case where
> hci_connect_le returns -EBUSY while handling an advertisement report.
> The code simply ignores the error and hci_conn object gets created, so
> the next time an advertisement report gets received and we call
> hci_connect_le, won't that just return early since
> hci_conn_hash_lookup_ba will return something? How will this actually
> ever get to adding the LE Create Connection request?

Regarding advertising reports while there's a connect attempt in
progress, hci_connect_le() disables advertising before issuing
HCI_LE_Create_Conn so advertising should never be active while we're
trying to connect. Only once the connection times out or we're
successfully connected does advertising get re-enabled and we're ready
again to connect any other device that might be around.

Regarding conn objects stuck in BT_CONNECT, the state is only set to
that later in hci_connect_le() when calling hci_req_add_le_create_conn()
i.e. when we know we can issue the command, so I don't see any obvious
problems here.

> 2. The background scan code currently assigns ownership of the
> hci_conn structure to the hci_conn_params structure that triggered it.
> I guess it's OK if a reference is held both by the parameters AND the
> l2cap_conn structure if this is triggered by an L2CAP connect instead?

I don't see any problems in having multiple references like this.

> 3. The background scan code currently passes BT_SECURITY_LOW to
> hci_connect_le, but we probably need a way to obtain the security
> level from the l2cap sock options in the l2cap connect case. What's
> the best way to pass this data along?

The first thing that comes to mind is to add an extra u8 sec_level
variable to the hci_conn_params struct.

Johan
