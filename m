Return-Path: <Steven.Singer@csr.com>
Message-ID: <40CDA70D.7010008@csr.com>
Date: Mon, 14 Jun 2004 14:24:29 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>,
   Bluez Devel
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_create_connection assuming timeout too soon
References: <20040609154824.531c71b8.Andreas.Gaufer@blue-cell-networks.com>
    <1087033515.4306.0.camel@pegasus>
In-Reply-To: <1087033515.4306.0.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
>Andreas Gaufer wrote:
>> To catch a condition where the chip is stalled in some way i think the best
>> approach would be to time out on host side after the chips
>> page time out * 1,5 or so.

Even that might not be sufficient.

There are two potentially large delays, you've identified just one - the
page timeout. By default this is just over 5 seconds, but it could be
raised as high as 41 seconds.

The page timeout, however, is applied only over the initial baseband
connection. Before the connection complete event can be reported to the
host, the LMP negotiation also has to take place. This can include
authentication and pairing. In theory, the whole LMP negotiation should
be bounded by a 30 second timeout, but, in practice I suspect it's better
to err on the cautious side.

Normally, this isn't a problem as you just wait for the connection
complete event and it'll give a success or failure code. However, I
understand that you want to detect non-responsive host controllers.

> your change is me too much at the moment. I simply changed the timeout
> to 25000 for the hcitool cc command.

If you want just a rough figure that'll probably work, I'd suggest
assuming that the page timeout is about 10 seconds and allow the full
30 seconds LMP timeout. That'd give a 40 second timeout.

If you wanted to be sure, then somwhere above 71 seconds is better, but
to be really, really sure I suspect 2 minutes is better still.

If this is too long, then I suggest a shorter timeout on the command
status event. This event should always be reported promptly. You
could get away with a one second timeout on that followed by a two
minute timeout on the connection complete event.

	- Steven
-- 




**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
