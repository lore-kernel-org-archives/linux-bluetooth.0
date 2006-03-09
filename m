Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-Id: <20060309225521.0f407da9.fotopiper@o2.pl>
In-Reply-To: <20060309193423.GF4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl>
	<20060308214031.GZ4516@beta.private.mielke.cc>
	<20060308230109.202dc5ff.fotopiper@o2.pl>
	<20060308221644.GA4516@beta.private.mielke.cc>
	<20060309064424.584539d2.fotopiper@o2.pl>
	<20060309055552.GB4516@beta.private.mielke.cc>
	<20060309070649.007fba22.fotopiper@o2.pl>
	<20060309061255.GC4516@beta.private.mielke.cc>
	<20060309192953.52ee8c2e.fotopiper@o2.pl>
	<20060309193423.GF4516@beta.private.mielke.cc>
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
Date: Thu, 9 Mar 2006 22:55:21 +0100

On Thu, 9 Mar 2006 14:34:23 -0500
Dave Mielke <dave@mielke.cc> wrote:

> The latest version of the script is attached to this post. Please
> have a look at it and/or give it a try. I've went with making this
> option (-c) be non-cumulative for the time being, but it'd be very
> easy to change that. Please let me know what else you think needs to
> be done.

Ok, in place.. and working, at least with sending the pin form the
list :) (which is the part that I need).
Thank you...

For others ideas.. a config file, lets say /etc/bluetooth/pins.conf for
puting options like -n and -c ;) (disabling promp and seting
alternative helpers).

Still, as much as I'm concerned... I'm for changing the default
pinhelper to yours and adding the python X helper as one colled from it.

My regards.

Ps.
In a moment I'll put the script on iPAQ, if it works there.. I have
nothing more to ask for.


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
