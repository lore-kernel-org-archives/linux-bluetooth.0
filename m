Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057134871.523.123.camel@baroque.rococosoft.com>
References: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
	<1057134871.523.123.camel@baroque.rococosoft.com>
Message-Id: <1057163407.963.122.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Version 3 libs/utils
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
Date: 02 Jul 2003 18:29:55 +0200
Content-Type: text/plain

Hi Stephen,

> > I prefer using the -ng suffix for the CVS repositories, so we can decide
> > later how we proceed with the name/version of the packages.
> 
> How about the suffix "+"? This isn't rocket science you know :-) I
> really don't care what is used.

it isn't important, but we should take care of not confusing the people.
And this is the only argument against the "2" suffix, because non
developer tend to mix module name with version number :(

And about the "+" - no special chars please, because they always cause
troubles you don't think of at the moment.

> > I already started to implement the missing HCI defines and functions.
> > And we should clean this up and check the ordering. With Bluetooth 1.2
> > we will get some more.
> 
> Yeah perhaps we could do a cleanup of the names along the lines of SDP.
> (Then again maybe that's not needed but if it is it should happen at the
> start.)

So maybe this is a good starting point. After I included all HCI
definition into the current CVS, we can fork and start the new version.

Everybody can help here. If you found a HCI command or event definition
which is not in the current CVS version of the libs package. Please send
me a patch and save me some time.

> > The "timeout" parameter is not needed by many functions. Kill it and use
> > some global timeout settings. But functions like the name resolv need a
> > bigger timeout, so we must take care of this.
> > 
> > The inquiry must be rewritten to take care of Bluetooth devices that
> > report BDADDR more than once.
> 
> Asynchronous interface to inquiry?

Yes, of course. I forgot this point. A common inquiry interface can
maybe also included into btmgr and forward inquiry event to the
application. Any ideas how to implement this in a clean way?

> > What about a Bluetooth daemon (for exmaple btmgr) which integrates the
> > security manager and the sdpd. It can also store an userspace Bluetooth
> > inquiry cache, name database and remote SDP cache. The local
> > configuration (like local device name) for example can also modified
> > through this daemon and restored on next boot, which is good for
> > handheld devices. The access can be done through a defined protocol over
> > unix sockets.
> 
> I quite like this idea, except the SDP server functionality won't be
> needed for some devices (e.g., handhelds).

This is not the truth. If you want to connect from a Windows based iPAQ
to a Bluetooth enabled Zaurus and transfer files over OBEX you need a
SDP server on your Zaurus.

But an option to disable it for people who know what they are doing
seems to be a good idea.

> > The SDP API should be get more shortcuts for often needed routines, like
> > getting service name and PSM number or RFCOMM channel. Maybe it is a
> > good idea to have some profile specific SDP functions, which get the
> > most needed information for a profile and stores them in its own data
> > structure.
> 
> I would like to see C++ wrappers around the commonly used functions.
> Much though I loathe the language itself, the SymbianOS code for
> manipulating data-elements is quite succinct.

I don't know much about C++, but we don't want to use C++ in any core
library or tool. The Bluetooth library itself should be usable with C++
(as it is today), but if you need extra stuff it must be included in an
extra library.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
