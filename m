Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth kernel patch for 2.6.1
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074196988.2559.270.camel@localhost>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196988.2559.270.camel@localhost>
Content-Type: text/plain
Message-Id: <1074198649.2629.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Jan 2004 21:30:49 +0100

Hi Max,

> - BCM203x loader
> Should mention (at the top) that it's based on the user-space BCM loader
> Copyright (C) such and such (eg me ;-))

I am going to add this. From an USB dump of the Windows driver I
remember that it is doing some more stuff before it finishes the
firmware loading. Do you have the complete specs from Broadcom for these
devices?

> - RFCOMM disable CFC by default
> Comment should mention that it's a forward port of 2.4 patch by maxk.

I am sorry about that. Simply forgot to add the statement while porting
all left over stuff from 2.4 and 2.6. I keep an eye on it in the future.

> - This
> > static inline void hci_conn_put(struct hci_conn *conn) 
> >  {
> >  	if (atomic_dec_and_test(&conn->refcnt)) {
> > -		if (conn->type == SCO_LINK)
> > +		if (conn->type == ACL_LINK) {
> > +			unsigned long timeo = (conn->out) ?
> > +				HCI_DISCONN_TIMEOUT : HCI_DISCONN_TIMEOUT * 2;
> > +			hci_conn_set_timer(conn, timeo);
> > +		} else
> >  			hci_conn_set_timer(conn, HZ / 100);
> > -		else if (conn->out)
> > -			hci_conn_set_timer(conn, HCI_DISCONN_TIMEOUT);
> >  	}
> >  }
> 
> will kill _incoming_ connection when last local socket is closed. I used
> to have HCI_CONNIDLE_TIMEOUT for that. But I got rid of it because I
> think it's wrong. We should not kill incoming ACL connection. It should
> be killed by the initiator.

You are absolutly right and I can only agree with you, but the reality
is different. The problem is that some devices don't care about their
ACL links (for example the Apple Bluetooth mouse) and the Bluetooth
specification says nothing about the ownership of an ACL link. There is
no rule who must terminate an ACL link if it is no longer used.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
