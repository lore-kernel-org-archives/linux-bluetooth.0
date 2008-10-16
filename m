Return-Path: <cyrus@holtmann.org>
Message-ID: <64207.71.207.70.33.1224123822.squirrel@gallery.slackdot.org>
In-Reply-To: <d89ddf300810151713red04b2dx1f58d00bc1ba3ed1@mail.gmail.com>
References: <48F63E95.4010605@slackdot.org>
	<d89ddf300810151713red04b2dx1f58d00bc1ba3ed1@mail.gmail.com>
Date: Wed, 15 Oct 2008 22:23:42 -0400 (EDT)
From: deker@slackdot.org
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Some questions about audio on embedded systems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

 Thanks for the pointers. I was getting a little confused WRT what was the
current best path. Where can I find info on the hciattach patches, etc? I
don't recall seeing anything about that in my searching.

I figured I'd have to use a different BT module, so I'm working with
prototyping on a laptop until I get my gumstix gear together. I need to
figure out how to use the HFP to get handsfree device events, and I figure
that may take a bit of time.

Thanks again,

-d

> Deker
>
> The best option is to use the most recent bluez version you can and
> use the built-in audio service it provides. btsco and plugz are both
> dead ends. There is a little bit of hackery you'll have to do with eg
> hciattach which has patches that can't go upstream. See the gumstix
> openembedded package for details. Make sure you ask the gumstix folks
> because I believe they have a newer bluez than the default one you get
> in their openembedded environment.
>
> As far as hardware, if you're not using a prototype of the next
> gumstix board then you should add a bluetooth USB adapter that has a
> CSR chip in it to a verdex board. The integrated bluetooth module has
> not been used successfully for SCO.
>
> Brad
>
> On Wed, Oct 15, 2008 at 1:03 PM, deker <deker@slackdot.org> wrote:
>> Hi,
>>
>>  I'm doing some research for an upcoming project where I'll need to use
>> a bluetooth headset for audio (send & recv) with a gumstix. I found the
>> following two pages:
>>
>> http://bluetooth-alsa.sourceforge.net/embed.html
>> http://bluetooth-alsa.sourceforge.net/embedv1.html
>>
>> which have great information, but I'm curious as to which is the most
>> current/correct. Specifically, I'm wondering what the current status of
>> SCO audio with the gumstix (and just on regular PCs frankly) is. I
>> understand that the blues-alsa project is moving away from btsco toward
>> plugz, but didn't know how this would affect me on a gumstix.
>>
>> Any info would be greatly appreciated.
>>
>> Thanks,
>>
>> -d
>>
>> -------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Moblin Your Move Developer's
>> challenge
>> Build the coolest Linux based applications with Moblin SDK & win great
>> prizes
>> Grand prize is a trip for two to an Open Source event anywhere in the
>> world
>> http://moblin-contest.org/redirect.php?banner_id=100&url=/
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>
>
>
> --
> Brad Midgley
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the
> world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
