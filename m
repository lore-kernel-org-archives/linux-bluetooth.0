Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1159114194.5088.44.camel@localhost>
References: <1159114194.5088.44.camel@localhost>
Date: Sun, 24 Sep 2006 18:55:05 +0200
Message-Id: <1159116905.28425.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] GNOME bluez applet request
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

Hi Reinout,

> As part of the Bluetooth support in Mandriva Linux 2007, which will be
> released shortly, the GNOME bluez applet is required. "Applet" is a bit
> of a misnomer here, because the icon settles in the notification area.
> Once activated, it stays there and the only thing it does is showing
> discoverability status changes.
> 
> I would like to point out that it goes against the GNOME Human Interface
> Guidelines to display a notification icon perpetually.[1] The reasoning
> behind this is that the notification area is designed to inform the user
> of important events, and when lots of notification icons are displayed
> at the same time, this waters down the primary function of the
> notification area.

the CVS version of bluez-gnome has an option (compile time) to hide the
icon, when no adapter is attached. This should become a GConf option,
but it hasn't been integrated yet. Feel free to send patches.

> In fact there is another bluetooth-related icon in my notification area
> that spends 99,9% of its time doing nothing, for which I've filed a bug
> already.[2] Is there a bug tracker for bluez where I could file a
> request to only display the notification icon for important events?

The mailing list is the correct of addressing this.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
