Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0611210140u7ab8b44dv392d83826b7af205@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:40:30 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1164101366.28429.22.camel@localhost>
MIME-Version: 1.0
References: <b5dccebe0611210124h5076b396xa2e9c0617658cf13@mail.gmail.com>
	<1164101366.28429.22.camel@localhost>
Subject: Re: [Bluez-users] concurrent operations
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

> you can't run an inquiry and a page at the same time. That is basically
> all that matters. However a remote name resolve includes a page, but
> that is the only exception. All the rest can run fully concurrent.
>

And a "page" does that mean a service search? I've seen the term page
in the bluetooth standard but haven't really understood it. What about
several "pages" at the same time, i. e. service search for several
remote devices at the same time?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
