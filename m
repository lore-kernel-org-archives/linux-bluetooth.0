Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Sybren Stuvel <sybren@thirdtower.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031105121405.GA9763@sybren.thirdtower.com>
References: <200311050945.34166.sybren@thirdtower.com>
	 <1068027414.10388.149.camel@pegasus>
	 <20031105121405.GA9763@sybren.thirdtower.com>
Content-Type: text/plain
Message-Id: <1068034941.10385.190.camel@pegasus>
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
Date: Wed, 05 Nov 2003 13:22:21 +0100

Hi Sybren,

> > And why do you need this for scripting? You can bind a RFCOMM channel
> > to a device and all stuff would be done in background without user
> > interaction.
> 
> I wanted to delay the starting of pppd until the connection was actually
> made. I thought it was the easiest to just parse rfcomm's output.

try to implement an updetach feature ;) But I prefer that you use this

	rfcomm bind 0 <bdaddr> [channel]	(only once needed)
	pppd /dev/rfcomm0 ...

> PS: What is the list's policy on PGP-signed messages? 

We have no policy about that and I never sign messages that go out to a
mailing list.

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
