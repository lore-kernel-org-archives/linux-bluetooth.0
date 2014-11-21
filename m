Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Nov 2014 12:08:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Subject: Re: Handling EBUSY for LE connections.
Message-ID: <20141121100818.GA25744@t440s.lan>
References: <50181A20-3313-48C7-924B-05C67B975139@holtmann.org>
 <CAHrH25T6tmUO2Zvsr=R7+yHwQE0_hY_sMt4UQAmCBMZBOH0PRQ@mail.gmail.com>
 <ED9629AB-B978-49FE-A7D7-5D9E62642504@holtmann.org>
 <CAHrH25Te4J6ospnJYA00mb1RofwHrS4=KD8LjmTLvo5Y4Jy8EQ@mail.gmail.com>
 <CAHrH25S5X5UZJwH0JuoWGW70bDdO48iS8Ex5pF0K9Cd7JsRV8A@mail.gmail.com>
 <7ED5AE30-EF53-47EA-A9CE-DD371CE10910@holtmann.org>
 <CAHrH25QzAYG-uHgEJ2rBmpJ_RMgW9zZ0+WvwtY3Mo0zKUxgB9w@mail.gmail.com>
 <20141119212751.GA6364@t440s.P-661HNU-F1>
 <CAHrH25Qds=wD87kT-_6f+RJP-MDVmjDSATa0qQmHKmHMUNv0iw@mail.gmail.com>
 <20141120093403.GA20651@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141120093403.GA20651@t440s.lan>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Nov 20, 2014, Johan Hedberg wrote:
> On Wed, Nov 19, 2014, Arman Uguray wrote:
> > I now have a few of questions before I start implementing anything:
> > 
> > 1. I'm confused about how the current code handles the case where
> > hci_connect_le returns -EBUSY while handling an advertisement report.
> > The code simply ignores the error and hci_conn object gets created, so
> > the next time an advertisement report gets received and we call
> > hci_connect_le, won't that just return early since
> > hci_conn_hash_lookup_ba will return something? How will this actually
> > ever get to adding the LE Create Connection request?
> 
> Regarding advertising reports while there's a connect attempt in
> progress, hci_connect_le() disables advertising before issuing
> HCI_LE_Create_Conn so advertising should never be active while we're
> trying to connect. Only once the connection times out or we're
> successfully connected does advertising get re-enabled and we're ready
> again to connect any other device that might be around.

Sorry, you must have gotten quite confused by my bs here. I was
obviously mixing advertising and scanning. My point still stands though:
hci_connect_le also disables scanning for the connection attempt so no
advertising reports should be coming while trying to connect.

Johan
