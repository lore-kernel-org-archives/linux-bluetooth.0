Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Bluetooth kernel patch for 2.6.1
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074198649.2629.67.camel@pegasus>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196988.2559.270.camel@localhost>  <1074198649.2629.67.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074288307.2559.434.camel@localhost>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 13:25:08 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-01-15 at 12:30, Marcel Holtmann wrote:
> Hi Max,
> 
> > - BCM203x loader
> > Should mention (at the top) that it's based on the user-space BCM loader
> > Copyright (C) such and such (eg me ;-))
> 
> I am going to add this. From an USB dump of the Windows driver I
> remember that it is doing some more stuff before it finishes the
> firmware loading. Do you have the complete specs from Broadcom for these
> devices?
No. I have several email with Broadcomm engineer who explained how
protocol works. That's pretty much it. He didn't mention any additional
stuff.

> > - This
> > > static inline void hci_conn_put(struct hci_conn *conn) 
> > >  {
> > >  	if (atomic_dec_and_test(&conn->refcnt)) {
> > > -		if (conn->type == SCO_LINK)
> > > +		if (conn->type == ACL_LINK) {
> > > +			unsigned long timeo = (conn->out) ?
> > > +				HCI_DISCONN_TIMEOUT : HCI_DISCONN_TIMEOUT * 2;
> > > +			hci_conn_set_timer(conn, timeo);
> > > +		} else
> > >  			hci_conn_set_timer(conn, HZ / 100);
> > > -		else if (conn->out)
> > > -			hci_conn_set_timer(conn, HCI_DISCONN_TIMEOUT);
> > >  	}
> > >  }
> > 
> > will kill _incoming_ connection when last local socket is closed. I used
> > to have HCI_CONNIDLE_TIMEOUT for that. But I got rid of it because I
> > think it's wrong. We should not kill incoming ACL connection. It should
> > be killed by the initiator.
> 
> You are absolutly right and I can only agree with you, but the reality
> is different. The problem is that some devices don't care about their
> ACL links (for example the Apple Bluetooth mouse) and the Bluetooth
> specification says nothing about the ownership of an ACL link. There is
> no rule who must terminate an ACL link if it is no longer used.
I'm trying to remember scenario where it was a problem (ie us killing
incoming connection) but it simply vanished from my memory :).
But I still think it's not right, even though spec does not say who must
close the connection (are you sure it doesn't btw ?). That Bluetooth
mouse must have its reasons for keeping connection and if you kill it
most likely they just reconnect immediately.

Max 
