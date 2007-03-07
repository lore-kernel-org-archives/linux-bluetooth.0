Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 07 Mar 2007 15:31:22 +0100
From: =?iso-8859-1?Q?=22Hans-J=FCrgen_Lange=22?= <Hans-Juergen.Lange@gmx.de>
In-Reply-To: <1173274910.28512.33.camel@aeonflux.holtmann.net>
Message-ID: <20070307143122.81130@gmx.net>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

this is for all other that may need help.
if only running the normal way of building software

./configure
make
make install

this does install the dbus configuration files in /etc . But if you created the dbus daemon and its tools the same way, the configuration files of the dbus-daemon are searched in /usr/local/etc. 
So the hcid cannot connect to dbus-daemon and wont work at all.

Anyway with the above way all other parts of the bluez-utils are installed in /usr/local. and the libs as well but that is part of the confusing system that a correct handling leads to strange results.

if you want the configuration file even been held in /usr/local, as expected, run ./configure --prefix=/usr/local that makes the default behaviour of the ./configure script behave as the default should. Install all below /usr/local. And it works like a charme.

What a glance of support.

BR to all 

-------- Original-Nachricht --------
Datum: Wed, 07 Mar 2007 14:41:50 +0100
Von: Marcel Holtmann <marcel@holtmann.org>
An: BlueZ users <bluez-users@lists.sourceforge.net>
CC: 
Betreff: Re: [Bluez-users] Wrong installation path of configuration files

> Hi Hans-Juergen,
> 
> > i did install the bluez-utils-3.9 from source. 
> > configure --help tells me that all files are installed below /usr/local
> which is nice to keep the system clean.
> > But after running make install i find the hcid.conf and the dbus
> configuration files in /etc and not where expected in /usr/local/etc
> > Is it possible to move the configuration files from /etc to
> /usr/local/etc ?
> 
> look at the README for an example on howto call configure.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
"Feel free" - 5 GB Mailbox, 50 FreeSMS/Monat ...
Jetzt GMX ProMail testen: www.gmx.net/de/go/mailfooter/promail-out

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
