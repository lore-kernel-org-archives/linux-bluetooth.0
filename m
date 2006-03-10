Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-Id: <20060310082859.57eaf23b.fotopiper@o2.pl>
In-Reply-To: <20060310013307.GG4516@beta.private.mielke.cc>
References: <20060308230109.202dc5ff.fotopiper@o2.pl>
	<20060308221644.GA4516@beta.private.mielke.cc>
	<20060309064424.584539d2.fotopiper@o2.pl>
	<20060309055552.GB4516@beta.private.mielke.cc>
	<20060309070649.007fba22.fotopiper@o2.pl>
	<20060309061255.GC4516@beta.private.mielke.cc>
	<20060309192953.52ee8c2e.fotopiper@o2.pl>
	<20060309193423.GF4516@beta.private.mielke.cc>
	<20060309225521.0f407da9.fotopiper@o2.pl>
	<20060309230420.05dc3497.fotopiper@o2.pl>
	<20060310013307.GG4516@beta.private.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
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
Date: Fri, 10 Mar 2006 08:28:59 +0100

On Thu, 9 Mar 2006 20:33:08 -0500
Dave Mielke <dave@mielke.cc> wrote:

> Does your ipaq have /bin/bash, or did you try changing the first line
> of the script so that it points to /bin/sh. It looks like it isn't
> running bash. If bash isn't available on these platforms, or if a
> less functional version of bash is being used, then we'll just have
> to change the code to not use some of bash's cooler features.

Sorry, my foult (a bissy day and a late haur did have some evects :( )
iPAQs or rather Familiar in general have a BusyBox all in one
executable, at least for the basic comands.
Bash is not present, it could be instaled, but at great expense of free
space (or even not passible, doto lack of space).
The executable has only sh, and I'm not sure is it a 100% full
implementation.

Ps.
I did change the first line.

I'm sorry for rather poor information. I was trying to provide a fast
feedbak.. and in the proces dorgot to add much of the needed
information.

--=20
Rados=B3aw Rurarz
Warsaw Poland
GG: 7249330


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
