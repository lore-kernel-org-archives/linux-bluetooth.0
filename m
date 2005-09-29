Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth filesystem integration
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1127896508.5321.3.camel@localhost.localdomain>
References: <1127865130.15926.18.camel@panic>
	 <1127896508.5321.3.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1127971635.24702.7.camel@panic>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Sep 2005 22:27:14 -0700

> hink is need and useful.
> 
> please also post ideas on the directory layout. How we handle multiple
> local devices and the remote devices.

so the original filesystem layout was:

/CFG/
/CFG/inquiry_duration
/CFG/cache_time
/CFG/SCAN_NOW

just the config

/OPUSH/
/OPUSH/CollinsPhone
/OPUSH/myPalm

holds names of all devices which publish a OPUSH service record
cp <somefile> /OPUSH/myPalm (would start OPUSH to the device)

/DEVICES/
/DEVICES/00:12:34:56:78
/DEVICES/00:AB:CD:EF:AA
/DEVICES/00:1A:2B:3C:4D

just bd_addrs of all visible devices

I the future I also want to have a directory to represent device and
service classes (e.g. all printers).

And even more information about a device, like feature list or
manufacturer etc.. This should go somewhere like /DEVICES/bd_addr/info


... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
All programmers are optimists --Frederick P. Brooks, Jr.



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
