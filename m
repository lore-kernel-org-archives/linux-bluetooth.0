Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <810747.71088.qm@web53303.mail.yahoo.com>
References: <810747.71088.qm@web53303.mail.yahoo.com>
Date: Tue, 02 Jan 2007 17:30:35 +0100
Message-Id: <1167755435.30886.83.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] =?utf-8?q?Re=EF=BC=9A_Re=3A__Dbus_lib?=
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

Hi,

> need to correct the information in pervious mail
> the error "cannot find -ldbus-glib-1" is found in bluez-util-3.7
> (1st log)
> 
> However there still a error " cannot find -ldbus-1" found in
> bluez-util3.8
> (2nd log)

you need to have a cross-compiled libdbus-1 ready for the system. It
depends on the D-Bus low-level library.

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
