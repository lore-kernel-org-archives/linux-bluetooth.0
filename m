Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Force pairing on single connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Nils Faerber <nils.faerber@kernelconcepts.de>
In-Reply-To: <200403171523.44542.bluez-devel@schaettgen.de>
References: <1076339030.2892.64.camel@localhost>
	 <1076407517.32750.36.camel@pegasus>
	 <200403171523.44542.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1079655201.3301.113.camel@pegasus>
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
Date: Fri, 19 Mar 2004 01:13:21 +0100

Hi Fred,

> > you must issue a HCI_Authenticate command on the HCI socket. There is no
> > other method at the moment. I was thinking about adding an ioctl to the
> > L2CAP socket so this can also be triggered by normal users.
> 
> This would in fact be very useful. With it we could make our obex push server 
> accept connections from everyone, while other services require authentication 
> (the services don't have root privileges). Did you add that ioctl already? 
> If not, do you think it's save for us to use a little suid program to let 
> normal users issue HCI_AUTHENTICATION_REQUESTED in the meantime?
> 
> > Other proposals are welcome.
> 
> I don't understand why there should be an l2cap ioctl for it. Isn't it enough 
> to let everybody use HCI_AUTHENTICATION_REQUESTED, just like it's the case 
> for HCI_INQUIRY and add a helper function to hci_lib.h?

the point for an ioctl is to make it easier for the programmer, because
for the HCI command you need to find out the connection handle and the
open L2CAP/RFCOMM socket already knows its handle.

> Btw. there is a related issue where I don't have an answer for..
> how can we deal with pairing in a multi-user environment? At the moment, 
> whoever is logged in can enter a pin when a device requests authentication. 
> What if I don't trust the other users? Someone else may have paired with a 
> device with a faked address, so the fact that a connection could be 
> authenticated doesn't mean that *I* verified the identity of the other party. 
> I don't have an idea how this could be handled with the standard HCI 
> functions though - can I pair two devices again while the current link is 
> already authenticated? If this is possible, then BlueZ could remember the old 
> link key and provide an interface for applications to find out if the 
> currently used link key is the "successor" of a key where we checked the 
> identity of the other device ourself. 
> The other solution - letting only an administrator pair devices - doesn't seem 
> to be a nice solution too.  Any ideas?

In the early days I had a long discussion about multi-user environments
with Max. I hope everything of that is in the archive, but actually none
of us had the right solution for it. The Bluetooth specification don't
really talks about it, as it also don't talks about multiple dongles on
the same host and the interface to the HCI, L2CAP and RFCOMM layers for
userspace applications.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
