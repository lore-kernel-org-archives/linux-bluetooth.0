Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] libtool and autoconf versions
From: Max Krasnyansky <maxk@qualcomm.com>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074424282.16573.52.camel@saag>
References: <1074424282.16573.52.camel@saag>
Content-Type: text/plain
Message-Id: <1074632525.1707.181.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Jan 2004 13:02:05 -0800

I'd say lets update. 
btw What exactly depends on the old autoconf ? I mean if you just run
./bootstrap on the machine that has new version it just works right.
At least it does on Fedora with the latest autoconf.

Max


On Sun, 2004-01-18 at 03:11, Edd Dumbill wrote:
> The BlueZ packages still use libtool1.4 and autoconf2.13, which are
> outdated.
> 
> Debian wants to remove support for libtool1.4.  The reasons for the
> dropping of libtool1.4 are here:
> http://lists.debian.org/debian-devel/2004/debian-devel-200401/msg00968.html
> 
> What do you think to the idea of updating to libtool1.5 and autoconf2.5
> (and a newer automake too)?
> 
> It's not actually critical right now, as I am not likely to need to
> re-run autoconf or libtool to package BlueZ, but it seems likely that
> it's a good idea to move to more updated versions of these tools.
> 
> -- Edd
> 
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
