Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Fredrik Noring <noring@nocrew.org>
Subject: Re: [Bluez-devel] What stuff in gnome-bluetooth does, and ideas for its future
References: <1064593223.12843.127.camel@saag> <200401291230.00801.bluez-devel@schaettgen.de> <1075401893.22564.51.camel@akka.yeti.nocrew.org>
In-Reply-To: <1075401893.22564.51.camel@akka.yeti.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401292119.45926.bluez-devel@schaettgen.de>
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
Date: Thu, 29 Jan 2004 21:19:45 +0100

(..persistent device name cache..)
> tor 2004-01-29 klockan 12.30 skrev Fred Sch=E4ttgen:
> > I wasn't able to follow your whole discussion.. do you think this
> > functionality should go into bluez itself or into gnome-bluetooth only?
>
> I think having Bluez managing this is a good idea, as it isn't a Gnome
> (or KDE) specific thing.

I also think that wouldn't be misplaced in bluez. But since it can be easil=
y=20
done with a gnome/kde service, this proposal will surely go to the bottom=20
part of the wishlist if there is no demand from other unrelated projects.=20

> Any ideas on tools and interfaces? Btw., what's the character encoding
> for Bluetooth device names?

UTF-8 and null-terminated as long as the name less than 248 bytes long.

greetings
=46red



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
