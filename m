Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Documentation
Cc: "Michael.S.G." <OzFalcon@bden.org>
References: <1126632421.43270be545c73@student.up.ac.za> <1126703897.16166.37.camel@station6.example.com> <43289DFF.3050504@BDen.org>
In-Reply-To: <43289DFF.3050504@BDen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509150118.18043.bluez-user@schaettgen.de>
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
Date: Thu, 15 Sep 2005 01:18:15 +0200

On Thursday, 15. September 2005 00:02, Michael.S.G. wrote:
...
> Im in the same boat. With two problems that SHOULD be relatively easy to
> locate info on resloving.
> These are pretty common things, Id take a guess.
>     1) Using KDE bluez interface, I can connect to nokia, But sending
> files constantly "STALLS"

In that case it's probably the wrong mailinglist ;)
Just follow the link in the about-box of kbluetoothd 
(hint: http://kde-bluetooth.sf.net)

>           Encryption & Auth is turned off. (Who know's if is't supposed
> to be..... Lack of info again).

That's alright.

>        *** I'd rather be using gnome, But KDE has GUI interface is
> already built.......Is there a WORKING gnome equal?
>     2) Getting a simple headset/dongle to work with Bluez. Mabie it's
> does work, But I can't compile BTSCO drivers.
>
> Im moderatly competant in using linux, But found good, Concise Bluez
> information/help to be sadly lacking - To the
> extent that average users just don't know how to get it going!
>
> I will however be investigating to link
> (http://openobex.sourceforge.net/applications.html) that Jon Kristian
> was thoughtful enough to post.

The obex push tools of kdebluetooth use openobex so far, but the obex ioslave 
(obex:/-urls) doesn't. If your phone supports obex file transfer, then please 
try uploading a file that way and check if it makes a difference.

> Sorry to be blunt, Perhaps you are tired of Noob type questions and
> would rather palm em off into oblivion. But that's what it seems like.

Well, I guess it's our (the KDE guys) duty to provide really conveniant tools 
for end users, but unfortunately we don't offer much more than file transfer 
at the moment. There is a bemused remote control server, an irmc sync plugin 
and a few things more, but nothing for networking or using headsets.
So these things still have to be done with the command line tools or whatever 
your distribution offers you.
The problem is that we all simply lack the time to fill all these gaps. And 
perhaps Marcel still hopes that someone else will help out with writing good 
user documentation. It's certainly his job to document command line 
parameters, but writing and maintaining a good official introduction and 
HOWTOs for Bluetooth/BlueZ is a lot of work and it can be done by someone who 
is not a programmer. I would go as far as saying that this kind of 
documentation *should not* be written but only checked by the developers. 
Maybe an official bluez wiki would be the most efficient way to make people 
contribute documentation.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
