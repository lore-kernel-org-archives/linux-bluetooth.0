Return-Path: <bluez-devel@schaettgen.de>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Force pairing on single connection?
Date: Wed, 17 Mar 2004 15:23:44 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
   Nils Faerber <nils.faerber@kernelconcepts.de>
References: <1076339030.2892.64.camel@localhost> <1076407517.32750.36.camel@pegasus>
In-Reply-To: <1076407517.32750.36.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200403171523.44542.bluez-devel@schaettgen.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tuesday 10 February 2004 11:05, Marcel Holtmann wrote:
> Hi Nils,
>
> > Is it possible to force a pairing process for a single device pair?
> > The situation is that I have a device that seems to accept non-paired
> > and paired connections. I would now like to pair with this device and
> > thus force the pairing, but only for this device - I am quite happy with
> > not being forced to pair for mostly all other devices ;)
>
> you must issue a HCI_Authenticate command on the HCI socket. There is no
> other method at the moment. I was thinking about adding an ioctl to the
> L2CAP socket so this can also be triggered by normal users.

This would in fact be very useful. With it we could make our obex push server 
accept connections from everyone, while other services require authentication 
(the services don't have root privileges). Did you add that ioctl already? 
If not, do you think it's save for us to use a little suid program to let 
normal users issue HCI_AUTHENTICATION_REQUESTED in the meantime?

> Other proposals are welcome.

I don't understand why there should be an l2cap ioctl for it. Isn't it enough 
to let everybody use HCI_AUTHENTICATION_REQUESTED, just like it's the case 
for HCI_INQUIRY and add a helper function to hci_lib.h?

Btw. there is a related issue where I don't have an answer for..
how can we deal with pairing in a multi-user environment? At the moment, 
whoever is logged in can enter a pin when a device requests authentication. 
What if I don't trust the other users? Someone else may have paired with a 
device with a faked address, so the fact that a connection could be 
authenticated doesn't mean that *I* verified the identity of the other party. 
I don't have an idea how this could be handled with the standard HCI 
functions though - can I pair two devices again while the current link is 
already authenticated? If this is possible, then BlueZ could remember the old 
link key and provide an interface for applications to find out if the 
currently used link key is the "successor" of a key where we checked the 
identity of the other device ourself. 
The other solution - letting only an administrator pair devices - doesn't seem 
to be a nice solution too.  Any ideas?

greetings
Fred
