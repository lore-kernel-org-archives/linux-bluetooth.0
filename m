Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
Message-Id: <1057107686.15797.101.camel@pegasus>
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
Date: 02 Jul 2003 03:01:19 +0200
Content-Type: text/plain

Hi Max,

> [Resent because nobody replied]

I read your post, but don't got enough time to reply :(

> >> I think branch is CVS branch is probably a bad idea. Because we want
> >> to change a lot of things like command names, etc. Which means lots 
> >> of file renames, CVS does not handle that.
> >> 
> >> How about creating completely new modules
> >>         libs2 
> >>         utils2
> >> and start with the clean history.
> >> We'll keep old ones around for a while but will only make minor fixes
> >> to them.
> >
> >we have already discussed this and starting with new modules seemed to
> >be the cleanest way. But we shouldn't name them libs2 and utils2,
> >because we are already at version 2.x with the others. We should use
> >libs3 and utils3 or maybe an unrelated to the version number suffix like
> >"-ng".
> I think version number of the current packages and '2' in libs2,utils2 are 
> unrelated. '2' just means second generation or something. New packages will 
> have new version numbers anyway.
> 
> So I vote for utils2 and libs2. People are used to things like glib2, libxml2.
> libs3 would be something unusual :)

I prefer using the -ng suffix for the CVS repositories, so we can decide
later how we proceed with the name/version of the packages.

> >If we agree on the new name, I will start to create the framework for the new modules.
> Let's talk about the goals and objectives first.
> 
> Here is the list of things that I have in mind
> 
> 1. API cleanup and redesign if necessary
>         Better function names, etc.

I already started to implement the missing HCI defines and functions.
And we should clean this up and check the ordering. With Bluetooth 1.2
we will get some more.

The "timeout" parameter is not needed by many functions. Kill it and use
some global timeout settings. But functions like the name resolv need a
bigger timeout, so we must take care of this.

The inquiry must be rewritten to take care of Bluetooth devices that
report BDADDR more than once.

> 2. Better hotplug support
>         Device initialization via hotplug scripts
>         /etc/hotplug/bluetooth.agent, /etc/sysconfig/bluetooth, etc.

One clean /etc/init.d/bluetooth, because I don't like the current way of
multiple init scripts which are used by the Debian packages.

> 3. Neighborhood and security databases and API for them
>         Device names, PIN codes, Link keys, etc
>         Tools to access and modify those databases

What about a Bluetooth daemon (for exmaple btmgr) which integrates the
security manager and the sdpd. It can also store an userspace Bluetooth
inquiry cache, name database and remote SDP cache. The local
configuration (like local device name) for example can also modified
through this daemon and restored on next boot, which is good for
handheld devices. The access can be done through a defined protocol over
unix sockets.

> 4. Integrated SDP.

The SDP API should be get more shortcuts for often needed routines, like
getting service name and PSM number or RFCOMM channel. Maybe it is a
good idea to have some profile specific SDP functions, which get the
most needed information for a profile and stores them in its own data
structure.

> 5. Better (more appropriate) names for Bluetooth command line utilities and daemons.
>         hciconfig -> btconfig
>         rfcomm -> btport
>         sdpd -> btsdpd
>         etc

I think we should have one tool (for example btconfig) which is staticly
linked with the Bluetooth library and can do all the configuration
stuff. This includes HCI, RFCOMM, BNEP etc. and such a tool should be
used by the bluetooth.agent and can be placed in an initrd.

And we should keep the old names (or programs) for compat reasons.

> 6. Improved PIN helper support
>         D-Bus or something similar.

We need some really good stuff here. The Gnome Desktop makes some
progress in integrating Bluetooth and we should also take care of it.

> 7. Improved documentation. 
>         At least DoxyGen on headers and sources.

Some kind of "Bluetooth Programing Manual" would be fine :)

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
