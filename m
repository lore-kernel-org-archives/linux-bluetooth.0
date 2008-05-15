Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20080514112424.56650@gmx.net>
References: <20080514112424.56650@gmx.net>
Date: Thu, 15 May 2008 11:36:15 +0200
Message-Id: <1210844175.7025.29.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Using bluez-utils from another application
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Johannes,

> Just installed bluez-libs-2.25 and bluez-utils-2.25.
> I know there are more recent versions avaiable but since Im developping for an Embedded Linux System based on ARM9 my resources are very limited and I was not able to compile "libdbus" which is necessary for the recent version of bluez.However... the installed versions are working fine. 

your version is ancient. I have the release date as January 2006 and
this means it is over two years old. That is a full lifetime in the
Linux world.

I am simply not buying the D-Bus cross-compilation issue. Sorry, but it
is not that hard.

> By the way Im using a 2.2.21 Kernel, but the bluetooth related stuff is patched to 2.2.26.

We never had a 2.2.21 kernel with Bluetooth support.

> My goal is to use functionalities provided by hciconfig and hcitool in another C Program. Finally this features (e.g. Listing active local bluetooth devices, do a scan for remote devices, ask for available services) will be visualized graphically in this C programm.

You are going to duplicate all the work that has been done for now
reason. Spending the time to cross-compile D-Bus would be better
invested.

> So there are basically tow ways:
> - System Calls like system("hciconfig") (which is not very handy and beautiful)
> - Using the Library

Again, cross-compile D-Bus and use our D-Bus based API. It is more
elegant than any low-level stuff will ever be.

> Concerning the second point (using Library) I did some research in hciconfig.c.
> I expected that there a some higher-level functions that I can call from another C programm by including the necessary header files.
> But it seems there must be also done some low-level stuff, like opening a HCI socket.

Yes. You always have to open a HCI raw socket to do raw packet
manipulation.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
