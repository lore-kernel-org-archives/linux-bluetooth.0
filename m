Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
From: Marcel Holtmann <marcel@holtmann.org>
To: Guy Harris <guy@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
In-Reply-To: <81F98C36-0AA1-11D8-BD2F-000A958097E4@alum.mit.edu>
References: <1067379074.2419.24.camel@paul>
	<1067425631.24043.224.camel@pegasus>
	<D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu>
	<1067482224.18114.6.camel@pegasus>
	<81F98C36-0AA1-11D8-BD2F-000A958097E4@alum.mit.edu>
Content-Type: text/plain
Message-Id: <1067516563.11791.23.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 30 Oct 2003 13:22:38 +0100

Hi Guy,

> > here is my patch that adds a Wiretap module for reading files created
> > with "hcidump -w".
> 
> OK, it reads them - but it supplies a link-layer encapsulation type of 
> WTAP_ENCAP_BLUETOOTH_H4, for which there isn't any dissector.  Do you 
> have dissectors for various Bluetooth protocols, or should we take the 
> ones from the affix patches to Ethereal and modify one of them (HCI?) 
> to register for an encapsulation of WTAP_ENCAP_BLUETOOTH_H4?

it is the first step ;)

Actually I don't want to use the Affix code, because I don't like the
idea of using code that I don't understand. And at the moment I have
limited knowlodge how the Ethereal dissectors work.

However the Bluetooth H4 format is a standard definied in the Bluetooth
specification and my plan is to write a packet-bt-hci.c dissector that
can decode it. All other Bluetooth layers like L2CAP, RFCOMM, BNEP etc.
should be done by someone else. The HCI dissector is the important one,
because it can make it reusable for other Bluetooth protocol stacks and
my plan is to do it from scratch and not hacking the current Affix code.

Regards

Marcel
 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
