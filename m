Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <187c15580703281446p1732a40eifdce3dc4c1261789@mail.gmail.com>
References: <187c15580703281446p1732a40eifdce3dc4c1261789@mail.gmail.com>
Date: Sat, 31 Mar 2007 15:51:50 +0200
Message-Id: <1175349110.5815.267.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Paired with Nokia phone but not connected
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

Hi Luis,

> My hardware is a USB Dongle Bluetooth D-Link DBT-122 and a Nokia 6230.
> 
> I can't set passkey with error:
> Can't register passkey agent
> Passkey agent already exists
> process 5391: Applications must not close shared connections - see
> dbus_connection_close() docs. This is a bug in the application.
> 
> My .gammurc is:
> port = <Mobile MAC Address>
> model = 6230
> connection = bluerffbus
> 
> When running gammu --identify bluez-gnome pops up a window to enter a
> password to pair mobile and PC. The pairing works but can't connect
> after. It just says disconneted!

run "hcidump -X -V" as root to see what happens.

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
