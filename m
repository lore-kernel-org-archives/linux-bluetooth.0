Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] libtool and autoconf versions
From: Edd Dumbill <edd@usefulinc.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074632525.1707.181.camel@localhost>
References: <1074424282.16573.52.camel@saag>
	 <1074632525.1707.181.camel@localhost>
Content-Type: text/plain
Message-Id: <1074632708.23181.56.camel@saag>
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
Date: Tue, 20 Jan 2004 21:05:09 +0000

On Tue, 2004-01-20 at 21:02, Max Krasnyansky wrote:
> I'd say lets update. 
> btw What exactly depends on the old autoconf ? I mean if you just run
> ./bootstrap on the machine that has new version it just works right.
> At least it does on Fedora with the latest au

I'm talking about what's shipped in the tarballs, which uses
libtool1.4.  Packagers for distros rely on the tarball releases.  In the
(admittedly) unlikely event that changes need to be made and autoconf
re-run for the purposes of packaging, the old ac and libtool would be
needed.

-- Edd




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
