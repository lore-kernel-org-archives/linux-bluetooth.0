Return-Path: <bluez-devel@schaettgen.de>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Force pairing on single connection?
Date: Fri, 19 Mar 2004 18:06:21 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <1076339030.2892.64.camel@localhost> <200403171523.44542.bluez-devel@schaettgen.de> <1079655201.3301.113.camel@pegasus>
In-Reply-To: <1079655201.3301.113.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200403191806.21101.bluez-devel@schaettgen.de>
List-ID: <bluez-devel.lists.sourceforge.net>

On Friday 19 March 2004 01:13, Marcel Holtmann wrote:
> Hi Fred,
..
> > I don't understand why there should be an l2cap ioctl for it. Isn't it
> > enough to let everybody use HCI_AUTHENTICATION_REQUESTED, just like it's
> > the case for HCI_INQUIRY and add a helper function to hci_lib.h?
>
> the point for an ioctl is to make it easier for the programmer, because
> for the HCI command you need to find out the connection handle and the
> open L2CAP/RFCOMM socket already knows its handle.

I don't really care how to do it, if only it can be done as an ordinary 
user :) Otherwise we can't use authentication at all if only one service 
should work without it and if we don't want to bother the users with 
unnecessary PIN-popups.
Or is it a potential security hazard to allow everybody to request 
authentication? I don't think so, since the other device could ask for 
authentication itself.

...
> In the early days I had a long discussion about multi-user environments
> with Max. I hope everything of that is in the archive, but actually none
> of us had the right solution for it. The Bluetooth specification don't
> really talks about it, as it also don't talks about multiple dongles on
> the same host and the interface to the HCI, L2CAP and RFCOMM layers for
> userspace applications.

You're right, it's in the SF archive, sorry. I only searched in the gmane 
archive, but failed to realize that it doesn't contain everything from the 
beginning.
It looks like there is really no good way to associate link keys with users. 
But then it might be a good idea let only a selected group of users answer pin 
requests, because often link level authentication is the only option. Or you 
simply have to trust any other users of your system...

greetings
Fred
