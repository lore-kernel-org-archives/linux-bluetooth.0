Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] audio transmission
From: Marcel Holtmann <marcel@holtmann.org>
To: JW <jwnospam@speakeasy.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <8BFCB1DF-2F4C-11D8-8E4B-0003930D291E@speakeasy.net>
References: <D645C889-2C3F-11D8-9778-0003930D291E@speakeasy.net>
	 <1071193461.27256.94.camel@pegasus>
	 <8BFCB1DF-2F4C-11D8-8E4B-0003930D291E@speakeasy.net>
Content-Type: text/plain
Message-Id: <1071527878.23713.121.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 15 Dec 2003 23:37:59 +0100

Hi,

> Google tells me that we won't be seeing products based on 1.2 until
> Q2 2004 or so - or is there already something available?

actually I know of two usable development kits based on 1.2, but don't
ask me about any further details ;)

> Also, how much work will bluez need to utilize new 1.2 features?

The parts for the Bluetooth 1.2 HCI layer are almost finished. The
needed kernel patches are on its way and the new Bluetooth library got
full support of all Bluetooth 1.2 HCI commands and events. The eSCO part
is more difficult and I don't have access to any hardware for testing. I
don't expect eSCO support very soon, but once we start with it, it will
result in a complete new framework for SCO and eSCO.

But the most important part is the new flow and error control for the
L2CAP layer, which can also be used over a Bluetooth 1.1 HCI link and it
will give us a SOCK_STREAM on the L2CAP level. At the moment I don't
know of anyone who is working on it and this is not good :(

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
