Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 07 Mar 2007 13:52:50 +0100
From: =?iso-8859-1?Q?=22Hans-J=FCrgen_Lange=22?= <Hans-Juergen.Lange@gmx.de>
In-Reply-To: <1173274910.28512.33.camel@aeonflux.holtmann.net>
Message-ID: <20070307125250.81130@gmx.net>
MIME-Version: 1.0
References: <20070307111732.15900@gmx.net>
	<1173274910.28512.33.camel@aeonflux.holtmann.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Wrong installation path of configuration files
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

this is no answer at all. =


./configure --help should give information about the configuration paramete=
r. And it did. README may be a good start.

This is the output from ./configure --help

By default, `make install' will install all the files in
`/usr/local/bin', `/usr/local/lib' etc.  You can specify
an installation prefix other than `/usr/local' using `--prefix',
for instance `--prefix=3D$HOME'.

It is a kind of ignorance to point someone to a file and think thats it. Yo=
ur are working like M$. Take it or leave it.

The configuration files are in the wrong place. Can I move them to /usr/loc=
al/etc or not. That has been my question. And you did not tell me that. And=
 it is not described in the README file whether to move the files.

The configuration utility. Gives wrong information about the place where fi=
les are installed. That is a fact. But it seems that it is out of your inte=
rest to change that.

Thank you for your not existing help.



-------- Original-Nachricht --------
Datum: Wed, 07 Mar 2007 14:41:50 +0100
Von: Marcel Holtmann <marcel@holtmann.org>
An: BlueZ users <bluez-users@lists.sourceforge.net>
CC: =

Betreff: Re: [Bluez-users] Wrong installation path of configuration files

> Hi Hans-Juergen,
> =

> > i did install the bluez-utils-3.9 from source. =

> > configure --help tells me that all files are installed below /usr/local
> which is nice to keep the system clean.
> > But after running make install i find the hcid.conf and the dbus
> configuration files in /etc and not where expected in /usr/local/etc
> > Is it possible to move the configuration files from /etc to
> /usr/local/etc ?
> =

> look at the README for an example on howto call configure.
> =

> Regards
> =

> Marcel
> =

> =

> =

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- =

Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
