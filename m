Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] epox-presenter
References: <4017F953.1090108@virgin.net> <1075314868.26729.34.camel@pegasus> <401830B2.5070407@virgin.net>
In-Reply-To: <401830B2.5070407@virgin.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401282334.52360.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 28 Jan 2004 23:34:51 +0100

Dne st 28. ledna 2004 22:59 Rob Davis napsal(a):
> Marcel Holtmann wrote:
> >Hi Rob,
> >
> >>I've just picked up one of these devices, and was quite happy to see it
> >>supported under linux, and even working with remote X windows..
> >>
> >>However, I was wondering if there was a way of slowing or speeding up
> >>the speed of the mouse point, and getting the extra buttons working like
> >>a wheel mouse, like in windoze?
> >
> >the code is quite self-explanatory and very simple. So go ahead and send
> >me a patch for your features.
>
> Okay, my first ever C hack...
>
> Implemented three functions, back button triggers mouse button 4, next
> button triggers mouse button 5, fn button triggers a keyboard alt + tab,
> which changes window focus in kde, and probably gnome.
>
> I have also reduced the speed of the pointer from 12 to 4, which I am
> much happier with as I have a hope of landing on the correct window.
>
> Sorry, I'm not sure how to do patch, but the file is small...
>
> All the best - Rob

diff -urN original_directory original_patched> /tmp/patch

Michal



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
