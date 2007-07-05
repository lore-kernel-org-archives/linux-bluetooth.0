Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707050940n7ffece6cs2ec5836def9e3ae9@mail.gmail.com>
Date: Thu, 5 Jul 2007 10:40:40 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <468CE233.8000909@free.fr>
MIME-Version: 1.0
References: <46852386.8050608@free.fr>
	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
	<46892FEC.7000705@free.fr>
	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>
	<468A02F2.7030903@free.fr>
	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>
	<1183514223.6351.56.camel@aeonflux.holtmann.net>
	<468CE233.8000909@free.fr>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Guys

> > no and NO. The Bluetooth plugin is not dealing with any wire connection.
> > The plugin has to be simple and can actually be stupid. I don't wanna
> > have any intelligence inside the ALSA plugin.
> >
>
> If the ALSA plugin is not dealing with any wire connection, then
> wired/wireless handover has to be performed somewhere else. :-)

pulse would handle this nicely without a lot of smarts in its bt
plugin. My thinking was we would get a "poor man's" sort of routing
audio server by doing some tricks in alsa, but maybe it's just too
gross :)

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
