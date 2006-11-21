Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5dccebe0611210124h5076b396xa2e9c0617658cf13@mail.gmail.com>
References: <b5dccebe0611210124h5076b396xa2e9c0617658cf13@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:29:26 +0100
Message-Id: <1164101366.28429.22.camel@localhost>
Mime-Version: 1.0
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

Hi Mikael,

> This is a general bluetooth question...
> 
> I have been experimenting with bluetooth for some time now and I'm
> wondering what is actually possible to do simultaneously. My
> application is doing device discovery, service search and obex push.
> It seems as if it is possible to do several obex pushes at the same
> time (guess that would go for any kind of RFCOMM  connections), but
> it's just possible to do one device discovery or one service search
> simultaneously. I. e. it's not possible to do service search at the
> same time as device discovery, and it's only possible to do service
> search for one remote device at the same time.
> 
> So to sort things out once and for all, what is actually possible? And
> why does this limitation exist, is it something fundamental to
> bluetooth or just because of current implementations?

you can't run an inquiry and a page at the same time. That is basically
all that matters. However a remote name resolve includes a page, but
that is the only exception. All the rest can run fully concurrent.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
