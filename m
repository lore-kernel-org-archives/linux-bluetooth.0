Return-Path: <steve.crane@rococosoft.com>
Subject: Re: Version 3 libs/utils
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057107686.15797.101.camel@pegasus>
References: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
Message-Id: <1057134871.523.123.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 02 Jul 2003 09:34:31 +0100
Content-Type: text/plain
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2003-07-02 at 02:01, Marcel Holtmann wrote:
> > >we have already discussed this and starting with new modules seemed to
> > >be the cleanest way. But we shouldn't name them libs2 and utils2,
> > >because we are already at version 2.x with the others. We should use
> > >libs3 and utils3 or maybe an unrelated to the version number suffix like
> > >"-ng".
> > I think version number of the current packages and '2' in libs2,utils2 are 
> > unrelated. '2' just means second generation or something. New packages will 
> > have new version numbers anyway.
> > 
> > So I vote for utils2 and libs2. People are used to things like glib2, libxml2.
> > libs3 would be something unusual :)
> 
> I prefer using the -ng suffix for the CVS repositories, so we can decide
> later how we proceed with the name/version of the packages.

How about the suffix "+"? This isn't rocket science you know :-) I
really don't care what is used.

> > >If we agree on the new name, I will start to create the framework for the new modules.
> > Let's talk about the goals and objectives first.
> > 
> > Here is the list of things that I have in mind
> > 
> > 1. API cleanup and redesign if necessary
> >         Better function names, etc.
> 
> I already started to implement the missing HCI defines and functions.
> And we should clean this up and check the ordering. With Bluetooth 1.2
> we will get some more.

Yeah perhaps we could do a cleanup of the names along the lines of SDP.
(Then again maybe that's not needed but if it is it should happen at the
start.)

> The "timeout" parameter is not needed by many functions. Kill it and use
> some global timeout settings. But functions like the name resolv need a
> bigger timeout, so we must take care of this.
> 
> The inquiry must be rewritten to take care of Bluetooth devices that
> report BDADDR more than once.

Asynchronous interface to inquiry?

> > 2. Better hotplug support
> >         Device initialization via hotplug scripts
> >         /etc/hotplug/bluetooth.agent, /etc/sysconfig/bluetooth, etc.
> 
> One clean /etc/init.d/bluetooth, because I don't like the current way of
> multiple init scripts which are used by the Debian packages.
> 
> > 3. Neighborhood and security databases and API for them
> >         Device names, PIN codes, Link keys, etc
> >         Tools to access and modify those databases
> 
> What about a Bluetooth daemon (for exmaple btmgr) which integrates the
> security manager and the sdpd. It can also store an userspace Bluetooth
> inquiry cache, name database and remote SDP cache. The local
> configuration (like local device name) for example can also modified
> through this daemon and restored on next boot, which is good for
> handheld devices. The access can be done through a defined protocol over
> unix sockets.

I quite like this idea, except the SDP server functionality won't be
needed for some devices (e.g., handhelds).

> > 4. Integrated SDP.
> 
> The SDP API should be get more shortcuts for often needed routines, like
> getting service name and PSM number or RFCOMM channel. Maybe it is a
> good idea to have some profile specific SDP functions, which get the
> most needed information for a profile and stores them in its own data
> structure.

I would like to see C++ wrappers around the commonly used functions.
Much though I loathe the language itself, the SymbianOS code for
manipulating data-elements is quite succinct.

> > 5. Better (more appropriate) names for Bluetooth command line utilities and daemons.
> >         hciconfig -> btconfig
> >         rfcomm -> btport
> >         sdpd -> btsdpd
> >         etc
> 
> I think we should have one tool (for example btconfig) which is staticly
> linked with the Bluetooth library and can do all the configuration
> stuff. This includes HCI, RFCOMM, BNEP etc. and such a tool should be
> used by the bluetooth.agent and can be placed in an initrd.
> 
> And we should keep the old names (or programs) for compat reasons.
> 
> > 6. Improved PIN helper support
> >         D-Bus or something similar.
> 
> We need some really good stuff here. The Gnome Desktop makes some
> progress in integrating Bluetooth and we should also take care of it.
> 
> > 7. Improved documentation. 
> >         At least DoxyGen on headers and sources.
> 
> Some kind of "Bluetooth Programing Manual" would be fine :)

Err, or even, the mythical "one true how-to" :-)

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
