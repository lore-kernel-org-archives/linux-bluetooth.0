Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bthid question
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031128143645.Y44245@minotaur.apache.org>
References: <20031128011412.C61007@minotaur.apache.org>
	 <1070025957.9036.153.camel@pegasus>
	 <20031128060135.H61007@minotaur.apache.org>
	 <1070031670.9036.166.camel@pegasus>
	 <20031128070531.F61007@minotaur.apache.org>
	 <20031128125922.O44245@minotaur.apache.org>
	 <1070057994.9033.209.camel@pegasus>
	 <20031128143645.Y44245@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1070061033.9036.222.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 29 Nov 2003 00:10:33 +0100

HI Gareth,

> > I am thinking of having only one bthid running and using an event loop
> > to multiplex all the file descriptors. We can also try to use uinput and
> > have our own HID parser in userspace. What do you think?
> 
> Sounds good to me. I will happily put some time in. I am going to read the
> Bluetooth spec over the weekend. Any other reading materials you suggest
> that I should read before we attempt this?

have fun with the Bluetooth spec. ;) The new 1.2 core spec. has 1200
pages and covers only HCI, L2CAP and SDP on the host side. However
reading the spec. is not so important, but you must understand how
Bluetooth works and how the layers interact. For the HID part you have
to read the HID profile and the USB HID documents. If we decide to
implement our own HID parser I need someone who will do this, because I
have no time for working on a HID parser. I can do everything which
depends on L2CAP and HIDP, but the HID part must be done by someone
else.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
