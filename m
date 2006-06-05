Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149543750.14142.11.camel@neutrino.cosmos.net>
References: <1149543750.14142.11.camel@neutrino.cosmos.net>
Date: Mon, 05 Jun 2006 23:57:29 +0200
Message-Id: <1149544649.7238.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] crazy mouse
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

Hi Didier,

> Thanks to Marcel to have so quickly publish the patch 2.6.16-mh1 after
> my request ! I've patched a 2.6.16.19 kernel and all seems to works
> after the reboot.
> 
> But my mouse (Logitech MX900 BT) move strangely. The movement seems to
> be by "hop" on the screen, I've never see this before, it's annoying ...
> 
> For a better explanation, its as if the mouse send is move data normally
> but X and the console (gpm) receive it asynchronously and at a point the
> cursor "freeze" a 1/4 of second and move quickly at the real position,
> all along the move of the mouse ...
> 
> Very strange no ?
> 
> After rebooting on my 2.6.15-mh2 kernel all works good !
> 
> Any idea ? Or maybe a procedure to debug that I can do ?

check your Xorg configuration. You might have configured two inputs and
the events add up. There was a report about that some time ago.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
