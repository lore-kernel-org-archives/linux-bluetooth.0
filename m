Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Nov 2014 23:27:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Subject: Re: Handling EBUSY for LE connections.
Message-ID: <20141119212751.GA6364@t440s.P-661HNU-F1>
References: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
 <50181A20-3313-48C7-924B-05C67B975139@holtmann.org>
 <CAHrH25T6tmUO2Zvsr=R7+yHwQE0_hY_sMt4UQAmCBMZBOH0PRQ@mail.gmail.com>
 <ED9629AB-B978-49FE-A7D7-5D9E62642504@holtmann.org>
 <CAHrH25Te4J6ospnJYA00mb1RofwHrS4=KD8LjmTLvo5Y4Jy8EQ@mail.gmail.com>
 <CAHrH25S5X5UZJwH0JuoWGW70bDdO48iS8Ex5pF0K9Cd7JsRV8A@mail.gmail.com>
 <7ED5AE30-EF53-47EA-A9CE-DD371CE10910@holtmann.org>
 <CAHrH25QzAYG-uHgEJ2rBmpJ_RMgW9zZ0+WvwtY3Mo0zKUxgB9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25QzAYG-uHgEJ2rBmpJ_RMgW9zZ0+WvwtY3Mo0zKUxgB9w@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Nov 17, 2014, Arman Uguray wrote:
> >> I guess I'm seeking some programming advice now as a net/bluetooth
> >> noob. So it looks like in l2cap_code.c:l2cap_chan_connect I want to
> >> replace the call to "hci_connect_le" with some variant of
> >> hci_conn_params_set. Based on my understanding, eventually if an ADV
> >> report is received, hci_event.c:process_adv_report will handle
> >> creating the connection for us (in hci_event.c:check_pending_le_conn).
> >>
> >> From here, what would be the best (and proper) way to propagate this
> >> information and the newly created hci_conn structure to the l2cap
> >> layer so that the l2cap_conn structure can be set up?
> >
> > that is a good question. I think Johan is a bit deeper in the code.
> > Might worthwhile to jump on IRC and brainstorm with him on this.
> >
> 
> I'm pretty much always out of luck getting ahold of people on IRC, so
> hopefully Johan will see this thread and respond eventually.
> 
> > He has done connection creation for the slave side using direct
> > advertising and that would have some similar logical handling. At
> > least I think it does. And if not, we might first need a few
> > cleanups to make the LE connection handling for L2CAP sockets more
> > streamlined and easy to integrate.
> >
> 
> So, from looking at the code, I see that l2cap_sock_connect calls
> l2cap_chan_connect, which internally creates the hci_conn via
> hci_connect_le. If all goes well, l2cap_sock_connect simply sits and
> waits until the socket state becomes BT_CONNECTED. So, I guess we may
> want something similar to that. We could revise hci_connect_le so that
> it automatically creates the temporary whitelist entry and listens for
> AD. Or perhaps we could have an additional API that sends an LE Create
> Connection that accepts an hci_conn instead of an hci_dev, which can
> then be called from hci_event.c:check_pending_le_conn.
> 
> Anyway, I think I have a rough idea of what needs to be done overall
> but I'd appreciate Johan's input.

It sounds like you're pretty much on the right track. Creating a
temporary entry to the same list that's used for the usual passive
scanning based connections should work. All other code that deals with
notifying the l2cap_chan once we get the LE_Connection_Complete event
should already be there and do the right thing, so the only new thing
that should be needed at that point is to permanently remove the
temporary entry you added.

Anyway, this is what I *think* should work. Once you have some initial
patches ready it'll be easier to see how things really are :)

Johan
