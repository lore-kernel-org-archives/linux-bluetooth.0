Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030717170310.0703eec8@unixmail.qualcomm.com>
Date: Thu, 17 Jul 2003 17:10:15 -0700
To: Stephen Crane <steve.crane@rococosoft.com>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Version 3 libs/utils
Cc: Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057134871.523.123.camel@baroque.rococosoft.com>
References: <1057107686.15797.101.camel@pegasus>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 01:34 AM 7/2/2003, Stephen Crane wrote:
>> > So I vote for utils2 and libs2. People are used to things like glib2, libxml2.
>> > libs3 would be something unusual :)
>> 
>> I prefer using the -ng suffix for the CVS repositories, so we can decide
>> later how we proceed with the name/version of the packages.
>
>How about the suffix "+"? This isn't rocket science you know :-) I
>really don't care what is used.
Good (that you don't care :)). We'll go with utils2 and libs2. In fact I already created them
in CVS.

>> > >If we agree on the new name, I will start to create the framework for the new modules.
>> > Let's talk about the goals and objectives first.
>> > 
>> > Here is the list of things that I have in mind
>> > 
>> > 1. API cleanup and redesign if necessary
>> >         Better function names, etc.
>> 
>> I already started to implement the missing HCI defines and functions.
>> And we should clean this up and check the ordering. With Bluetooth 1.2
>> we will get some more.
>
>Yeah perhaps we could do a cleanup of the names along the lines of SDP.
>(Then again maybe that's not needed but if it is it should happen at the
>start.)
Yep. I did a lot of HCI header cleanup in 2.5 kernel.

>> The "timeout" parameter is not needed by many functions. Kill it and use
>> some global timeout settings. But functions like the name resolv need a
>> bigger timeout, so we must take care of this.
>> 
>> The inquiry must be rewritten to take care of Bluetooth devices that
>> report BDADDR more than once.
>
>Asynchronous interface to inquiry?
Yep.

>> > 3. Neighborhood and security databases and API for them
>> >         Device names, PIN codes, Link keys, etc
>> >         Tools to access and modify those databases
>> 
>> What about a Bluetooth daemon (for exmaple btmgr) which integrates the
>> security manager and the sdpd. It can also store an userspace Bluetooth
>> inquiry cache, name database and remote SDP cache. The local
>> configuration (like local device name) for example can also modified
>> through this daemon and restored on next boot, which is good for
>> handheld devices. The access can be done through a defined protocol over
>> unix sockets.
>
>I quite like this idea, except the SDP server functionality won't be
>needed for some devices (e.g., handhelds).
Agreed.

>> > 4. Integrated SDP.
>> 
>> The SDP API should be get more shortcuts for often needed routines, like
>> getting service name and PSM number or RFCOMM channel. Maybe it is a
>> good idea to have some profile specific SDP functions, which get the
>> most needed information for a profile and stores them in its own data
>> structure.
>
>I would like to see C++ wrappers around the commonly used functions.
>Much though I loathe the language itself, the SymbianOS code for
>manipulating data-elements is quite succinct.
Sure.

>> > 7. Improved documentation. 
>> >         At least DoxyGen on headers and sources.
>> 
>> Some kind of "Bluetooth Programing Manual" would be fine :)
>
>Err, or even, the mythical "one true how-to" :-)
:)

Max
