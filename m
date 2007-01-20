Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5dccebe0701200259i156f623ci1fc12159affbd2f4@mail.gmail.com>
References: <b5dccebe0701190517t50869e29y4fcacda8475db035@mail.gmail.com>
	<1169219863.29458.10.camel@violet>
	<b5dccebe0701200259i156f623ci1fc12159affbd2f4@mail.gmail.com>
Date: Sat, 20 Jan 2007 15:05:46 +0100
Message-Id: <1169301946.30356.7.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BlueZ on other platforms
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

Hi Mikel,

> > > Is it possible to get bluez to work on other platforms than Linux? I'm
> > > asking because it's a real good bluetooth stack and that's a rare
> > > thing... So technically it's not bluez, but bluez-libs. So what about
> > >
> > > Bluez on Mac?
> > > Bluez on Windows?
> > > Bluez on Cygwin on Windows?
> >
> > non of that will work. The Bluetooth library depends on kernel
> > structures and one of the big advantages of BlueZ is the native
> > integration with the socket API.
>
> So not even for Cygwin? How difficult would this be to add? I.e. how
> big parts of bluez would have to be rewritten and how much could be
> reused to make it work on cygwin (I suppose this would be layered on
> top of the Microsoft bluetooth stack)?

this all depends on what's your goal and how your applications look
like. The best emulation would be of course our D-Bus based API, but
even that is a lot of work. A native emulation of BlueZ is not realistic
from my point of view. Feel free to prove me wrong.

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
