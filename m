Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
Date: Thu, 17 Jul 2003 17:00:16 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Version 3 libs/utils
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057107686.15797.101.camel@pegasus>
References: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

I finally have some time to read bluez mailing list. 
Sorry for being ridiculously slow.

At 06:01 PM 7/1/2003, Marcel Holtmann wrote:
>> >> I think branch is CVS branch is probably a bad idea. Because we want
>> >> to change a lot of things like command names, etc. Which means lots 
>> >> of file renames, CVS does not handle that.
>> >> 
>> >> How about creating completely new modules
>> >>         libs2 
>> >>         utils2
>> >> and start with the clean history.
>> >> We'll keep old ones around for a while but will only make minor fixes
>> >> to them.
>> >
>> >we have already discussed this and starting with new modules seemed to
>> >be the cleanest way. But we shouldn't name them libs2 and utils2,
>> >because we are already at version 2.x with the others. We should use
>> >libs3 and utils3 or maybe an unrelated to the version number suffix like
>> >"-ng".
>> I think version number of the current packages and '2' in libs2,utils2 are 
>> unrelated. '2' just means second generation or something. New packages will 
>> have new version numbers anyway.
>> 
>> So I vote for utils2 and libs2. People are used to things like glib2, libxml2.
>> libs3 would be something unusual :)
>
>I prefer using the -ng suffix for the CVS repositories, so we can decide
>later how we proceed with the name/version of the packages.

I still think utils2 is better. Let's just go with that. You don't seem to
have very strong preference. Other folks seem to be ok with it too.
So utils2 and libs2. I'll create top level CVS modules.

>> >If we agree on the new name, I will start to create the framework for the new modules.
>> Let's talk about the goals and objectives first.
>> 
>> Here is the list of things that I have in mind
>> 
>> 1. API cleanup and redesign if necessary
>>         Better function names, etc.
>
>I already started to implement the missing HCI defines and functions.
>And we should clean this up and check the ordering. With Bluetooth 1.2
>we will get some more.
>
>The "timeout" parameter is not needed by many functions. Kill it and use
>some global timeout settings. But functions like the name resolv need a
>bigger timeout, so we must take care of this.
>
>The inquiry must be rewritten to take care of Bluetooth devices that
>report BDADDR more than once.
Sounds good. Let's keep timeout for hci_send_req().

>> 2. Better hotplug support
>>         Device initialization via hotplug scripts
>>         /etc/hotplug/bluetooth.agent, /etc/sysconfig/bluetooth, etc.
>
>One clean /etc/init.d/bluetooth, because I don't like the current way of
>multiple init scripts which are used by the Debian packages.
/etc/init.d/bluetooth is not enough. We have to have /etc/hotplug/bluetooth.agent 
for hotplug. And it has to read configuration options like devices settings, etc.
That stuff will be stored in /etc/sysconfig/bluetooth.

>> 3. Neighborhood and security databases and API for them
>>         Device names, PIN codes, Link keys, etc
>>         Tools to access and modify those databases
>
>What about a Bluetooth daemon (for exmaple btmgr) which integrates the
>security manager and the sdpd. It can also store an userspace Bluetooth
>inquiry cache, name database and remote SDP cache. The local
>configuration (like local device name) for example can also modified
>through this daemon and restored on next boot, which is good for
>handheld devices. The access can be done through a defined protocol over
>unix sockets.
In general I don't like a 'kitchen sink' approach. Security manager, device names, etc
is fine. But SDP is unrelated service. I'd keep SDP separate. 
Also I don't see a need for user space inquiry cache. I guess you mean name database or
something.

>> 4. Integrated SDP.
>
>The SDP API should be get more shortcuts for often needed routines, like
>getting service name and PSM number or RFCOMM channel. Maybe it is a
>good idea to have some profile specific SDP functions, which get the
>most needed information for a profile and stores them in its own data
>structure.
Agree.

>> 5. Better (more appropriate) names for Bluetooth command line utilities and daemons.
>>         hciconfig -> btconfig
>>         rfcomm -> btport
>>         sdpd -> btsdpd
>>         etc
>
>I think we should have one tool (for example btconfig) which is staticly
>linked with the Bluetooth library and can do all the configuration
>stuff. This includes HCI, RFCOMM, BNEP etc. and such a tool should be
>used by the bluetooth.agent and can be placed in an initrd.
NO NO NO :-). We're going to have separate tools. hciconfig for example
needs to be separate from rfcomm and pand. There is no questions about that. 
If you absolutely need a single binary we could use Busybox way of combining
things into a single binary.

>And we should keep the old names (or programs) for compat reasons.
Yep.

>> 6. Improved PIN helper support
>>         D-Bus or something similar.
>
>We need some really good stuff here. The Gnome Desktop makes some
>progress in integrating Bluetooth and we should also take care of it.
I guess it will be via dbus or whatever other messaging supported by GUIs.

>> 7. Improved documentation. 
>>         At least DoxyGen on headers and sources.
>
>Some kind of "Bluetooth Programing Manual" would be fine :)
Sure. But who's going to write it ? ;-) 
If we use doxygen we'll at least have API reference.

Max
