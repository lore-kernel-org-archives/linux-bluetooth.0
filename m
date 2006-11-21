Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0611210136ob437829ya7abeb2ce412dff9@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:36:20 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1164100634.28429.19.camel@localhost>
MIME-Version: 1.0
References: <b5dccebe0611190350p4801a631m3cca5cc0b5c9abb3@mail.gmail.com>
	<1163940471.11790.2.camel@localhost>
	<b5dccebe0611200031v64a8d2d0xfdd92edf29a44d0@mail.gmail.com>
	<1164012204.28397.22.camel@localhost>
	<b5dccebe0611210114q57dca584me210abd2a37fc3da@mail.gmail.com>
	<1164100634.28429.19.camel@localhost>
Subject: Re: [Bluez-users] permissions to set local name
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

> > Do you know of something that makes it possible to use d-bus to do
> > obex pushes? I have been looking for that but not found anything. The
> > reason why I haven't used d-bus for my project before is mainly
> > because of this, it would feel strange to have half the application
> > use d-bus and the other half not.
>
> It is actually on my list of things that I like to have, but my time is
> limited and so I might work on other stuff first.
>

Ok,

It would be useful... Just in case I would feel extra productive some
day, how would you envision this? By a separate daemon that would sit
and provide this service over d-bus, or would it be built in to hcid?
Or maybe first as a separate daemon, and if it seems stable enough
later it would be built into hcid?

And would it be a good idea to build it on top of openobex? What other
implementations of obex are there?

-- Mikael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
