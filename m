Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for Clock offset event
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3E6EFB60.1B36829@esk.fhg.de>
References: <5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030307165419.01bb5668@mail1.qualcomm.com>
	<3E6E22B3.8E6E87FA@esk.fhg.de> <1047428151.28416.8.camel@pegasus.local>
	<3E6EFB60.1B36829@esk.fhg.de>
Message-Id: <1048320898.911.43.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 Mar 2003 09:14:48 +0100
Content-Type: text/plain

Hi Wolfgang,

> the patch alone doesn't help to accelerate connection establishment.
> And of course you are right, that the clock offset event is only
> generated
> if someone requests it for an existing acl-conenction. But maybe
> some people want to do this.
> But maybe if you terminate the connection and want to establish it again
> without inquiry (just using the inquiry cache), the clock offset event
> is 
> helpful (why do we have the inquiry cache?). Especially if you want to
> do this automatically. For the normal user this has no benefit until
> now.
> 
> In this context INQUIRY_ENTRY_AGE_MAX should be set to e.g. one hour
> (see the mails from 30th. of January, Subject "Connecting with clock
> offset").
> 
> But the main reason for integrating this event in bluez is: 
> The clock offset event exists in the spec
> and can be generated if someone wants to do this
> and there is no reason to omit these few lines of code.

the reason to omit these few lines is that we don't get any advantages
of it and we should keep the kernel code as small as possible. We don't
put code into the kernel only because it is in the spec. The Bluetooth
spec. is not as good as it seems at some points and this is one of them.
If the clock offset event will be automaticly send on disconnect or
something else I would say "go and include it", but the fact that this
event must be requested and can only be requested with an existing
connection is the reason for me to leave it out.

If you talk about fast reconnection you will see that such a thing is
already in the kernel with the HCI_DISCONN_TIMEOUT. In this time it is
possible to reuse the ACL link.

Anyway, I have included the hci_read_clock_offset() command into the
Bluetooth library for completeness.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
