Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
Date: Mon, 30 Jun 2003 17:03:34 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Version 3 libs/utils
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

[Resent because nobody replied]

At 05:15 AM 6/25/2003, Marcel Holtmann wrote:
>Hi Max,
>Hi Stephen,
>
>> I think branch is CVS branch is probably a bad idea. Because we want
>> to change a lot of things like command names, etc. Which means lots 
>> of file renames, CVS does not handle that.
>> 
>> How about creating completely new modules
>>         libs2 
>>         utils2
>> and start with the clean history.
>> We'll keep old ones around for a while but will only make minor fixes
>> to them.
>
>we have already discussed this and starting with new modules seemed to
>be the cleanest way. But we shouldn't name them libs2 and utils2,
>because we are already at version 2.x with the others. We should use
>libs3 and utils3 or maybe an unrelated to the version number suffix like
>"-ng".
I think version number of the current packages and '2' in libs2,utils2 are 
unrelated. '2' just means second generation or something. New packages will 
have new version numbers anyway.

So I vote for utils2 and libs2. People are used to things like glib2, libxml2.
libs3 would be something unusual :)

>If we agree on the new name, I will start to create the framework for the new modules.
Let's talk about the goals and objectives first.

Here is the list of things that I have in mind

1. API cleanup and redesign if necessary
        Better function names, etc.

2. Better hotplug support
        Device initialization via hotplug scripts
        /etc/hotplug/bluetooth.agent, /etc/sysconfig/bluetooth, etc.

3. Neighborhood and security databases and API for them
        Device names, PIN codes, Link keys, etc
        Tools to access and modify those databases

4. Integrated SDP.

5. Better (more appropriate) names for Bluetooth command line utilities and daemons.
        hciconfig -> btconfig
        rfcomm -> btport
        sdpd -> btsdpd
        etc

6. Improved PIN helper support
        D-Bus or something similar.

7. Improved documentation. 
        At least DoxyGen on headers and sources.

Comments ? Other ideas ?

Max
