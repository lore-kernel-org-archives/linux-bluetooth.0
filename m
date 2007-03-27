Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: vikram.bidkar@adamya.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <380-22007312614145425@M2W012.mail2web.com>
References: <380-22007312614145425@M2W012.mail2web.com>
Date: Tue, 27 Mar 2007 11:27:08 +0200
Message-Id: <1174987628.5815.36.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in starting hcid
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

Hi Vikram,

> I am not able to start "hcid" i.e. If I run ./hcid from
> bluez-utils-3.9/hcid.
> 
> I am getting following error.
> 
> Mar 30 16:50:51 Netravathi hcid[18586]: Bluetooth HCI daemon
> Mar 30 16:50:51 Netravathi hcid[18586]: Can't connect to system message
> bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket:
> No such file or directory
> Mar 30 16:50:51 Netravathi hcid[18586]: Unable to get on D-Bus.

you need to fix this error. Make sure that the D-Bus system bus has been
started.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
