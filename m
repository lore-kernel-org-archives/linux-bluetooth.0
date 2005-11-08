Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter
	getting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051107215732.GA19351@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain>
	 <1131315924.5824.14.camel@blade>
	 <20051107093436.GB6845@localhost.localdomain>
	 <1131359661.5824.97.camel@blade>
	 <20051107121354.GA9950@localhost.localdomain>
	 <1131368088.5824.116.camel@blade>
	 <e1effdeb0511070612u7555e383kaaade3f1f0c7bbd1@mail.gmail.com>
	 <20051107145430.GA12669@localhost.localdomain>
	 <1131397067.5824.145.camel@blade>
	 <20051107215732.GA19351@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131457496.5824.172.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 08 Nov 2005 14:44:56 +0100

Hi Johan,

> > > > Every time that a client establish a connection with the d-bus daemon
> > > > the connection id changes.  Therefore control client id is useful only
> > > > for clients that is always connected with the daemon.
> > > 
> > > True, and that was also one thing I was worried about when it comes to
> > > the practicality of that solution (the settings wouldn't be persistent
> > > enough). So, I think using the user id might be better in this respect.
> > 
> > I don't think so, because this options might be used not very often and
> > so having them per unix user doesn't help. Two different applications
> > running as them same user might have different needs. One wants to do
> > inquiry with another IAC, the other with the general IAC. This tends to
> > be a race condition.
> 
> Ok, I see your point. I didn't quite understand the use-case you were
> thinking of earlier. One extra requirement that the dbus-id settings has
> is that we will have to monitor the lifetime of a D-BUS client (by
> listening NameOwnerChanged D-BUS signals) and remove the corresponding
> entry from the settings table when an id gets removed from the bus.

this might be too much work for the current interface. Or do you think
it can be easily implemented?

> > > However, let me now introduce a third option which we just discussed on
> > > IRC with Claudio: optional D-BUS method parameters. It would be quite
> > > easy to implement the methods so that the client could leave out most
> > > parameters in which case hcid (or bluetoothd) would use some set of
> > > default values. You could e.g. call the Inquiry method without any
> > > parameters and it would just work (kind of the same way that dbus-test
> > > allows doing "./dbus-test Inquiry" in which case it uses length=10 &
> > > num_resp=100 as the default values). If the client insists on using its
> > > own values for the method it would simply include them in the method
> > > call.
> > 
> > Let's do this proposal first.
> 
> Ok, I'll begin by doing a patch for Inquiry and PeriodicInquiry
> (probably during tomorrow).

This would be great. For the next release I like to have the inquiry (or
better name it device discovery) working. This will include some nice
support for the extended inquiry. So you will get the remote name for
free with a discovery. So is it possible to have different signatures
for signals too?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
