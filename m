Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] inquiry scan problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41A91085.2000004@gmx.ch>
References: <41A91085.2000004@gmx.ch>
Content-Type: text/plain
Message-Id: <1101625153.18467.35.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 28 Nov 2004 07:59:13 +0100

Hi Marco,

> My goal is to get a list of all bluetooth devices in rainge. I do five 
> inquirys in a row (with one second break between two complete scans).
> The problems now are:
> 
> - the inquiry doesn't always find all devices
> that raises the question: how reliable/secure is it that all devices are 
> found in an inquiry? how possible is that one or more devices are missed?
> 
> - the fife inquirys sometimes stop in the middle and won't continue.
> for example after starting the 3. inquiry, it never completes (comes to 
> [public void inquiryCompleted(int status)] (jsr82)
> 
> - [RemoteDevice].getFriendlyName(true) sometimes (well - in fact often) 
> returns the String "null" (not null object) instead of the real friendly 
> name. if i do a loop with getFriendlyName(true), after ~8 times it gets 
> the correct friendlyName...
> the null (object) should only be returned if the hardware doesn't 
> support getting the friendlyName (but obviusly this works). i have no 
> idea why the "null" string is supposed to be returned...
> I added the hcidump of a request with "null" returns... maybe someone of 
> you can do more with it than me...
> 
> - [RemoteDevice].getFrienlyName(true) returns a friendly name of another 
> device if multiple devices are in rainge.
> 
> - general question: what if multiple bluetooth devices are connected to 
> the computer. which level has to support that?
> bluez / avetana (jsr82 implementation)?

can your reproduce it without using any JSR-82 stuff?

> I don't know which one of the problems are a subject of bluez.
> If it's not a bluez subject, i would appreciate if someone could point 
> me to the source of the problem.
> 
> I assume the usb dongle is the problem here. Someone on this mailinglist 
> already mentioned that it's a crappy dongle. (thanks again for the time 
> you invested - you really helped me a lot!)
> If it's the dongle again, what do other users here use? which ones work 
> reliably?

This is the Zeevo TC2001 based dongle, right? If yes, then replace it,
because I won't rely on this hardware.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
