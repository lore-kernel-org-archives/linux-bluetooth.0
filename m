Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] name cache
From: Fredrik Noring <noring@nocrew.org>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401301949.18712.bluez-devel@schaettgen.de>
References: <1064593223.12843.127.camel@saag>
	 <200401292119.45926.bluez-devel@schaettgen.de>
	 <1075486241.14644.34.camel@akka.yeti.nocrew.org>
	 <200401301949.18712.bluez-devel@schaettgen.de>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1075496052.14644.84.camel@akka.yeti.nocrew.org>
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
Date: Fri, 30 Jan 2004 21:54:12 +0100

Hi Fred,

fre 2004-01-30 klockan 19.49 skrev Fred Sch=E4ttgen:
> This would only duplicate interfaces, since you can do it via HCI alrea=
dy.

The hcid service is a big duplicate interface for HCI. :) But the
important thing is that hcid provides these things:

   1. Persistent configurations and data across reboots.
   2. Flexible permissions management through the filesystem (using
      files and possibly sockets).
   3. Resource sharing between applications (e.g. caches).

> Just like the key management it might be cleaner to use DBUS for it.

Sorry, I meant that just to be pseudo commands. The final protocol
syntax probably looks totally different.

Fredrik




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
