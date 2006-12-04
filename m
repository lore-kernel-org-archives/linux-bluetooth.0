Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5dccebe0612040036w43593c77xcb45bdef114ca95f@mail.gmail.com>
References: <b5dccebe0612031030v75c15bf6o688a5b198d6d6bb5@mail.gmail.com>
	<1165171236.19590.65.camel@localhost>
	<b5dccebe0612031122h4d49b82ehb26400eb1e350437@mail.gmail.com>
	<1165180510.19590.68.camel@localhost>
	<b5dccebe0612040036w43593c77xcb45bdef114ca95f@mail.gmail.com>
Date: Mon, 04 Dec 2006 09:45:21 +0100
Message-Id: <1165221921.12640.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Timeout for connections
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

> I ended up creating a little helper program that I run suid root that
> sets the Page Timeout on startup of my application. I also use this
> program to set the local name and try to force the inquiry mode to get
> RSSI. I have a feeling that you won't like hearing about this at all
> and you will probably take the opportunity to tell me I should use
> D-BUS. Something which I'm thinking about more and more. The problem
> with D-BUS is just that there is no Obex service available, and I
> don't want half my application using D-BUS and the other half not. So
> then I'm thinking more and more about writing a D-BUS Obex service.
> But before I do that it would be nice to get some feedback on the
> thoughts I have for that API. Where would be a good place to get that
> feedback? This mailing list is certanly one place, but what more is
> there?

first of all, you should call "man hcid.conf" and check the options for
setting the name and pageto. The inquiry mode is selected automatically
with bluez-utils-3.x and it picks the best one of course. In case of
Bluetooth 2.1 hardware this would mean of course extended inquiry. For
the bluez-utils-2.x we had the inqmode option to do it manually.

Even using D-Bus only for half of the tasks is still worth using D-Bus
for whatever possible. You can actually script most of the stuff very
easily with dbus-send or a small python program.

And yes, I have plans for a simple OBEX service that allows you to
handle incoming files, but also send files. However I have no idea when
I will get around to write that service. Feel free to start with it.

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
