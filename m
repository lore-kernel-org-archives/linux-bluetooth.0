Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4641DA61.8040709@tao-group.com>
References: <4641DA61.8040709@tao-group.com>
Date: Wed, 09 May 2007 16:52:36 +0200
Message-Id: <1178722356.8628.96.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] API documentation?
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

Hi David,

> I'm trying to write a Bluetooth interface layer for another API, targeting
> Bluez as the backend. Unfortunately I don't seem to be able to find any API
> documentation for how to drive Bluez. I've managed to reverse engineer a fair
> amount of it by studying the header files and the source code for libbluetooth
> and bluez-utils, but this is only getting me so far.
> 
> (Currently, I'm trying to figure out how to turn discoverability on and off on
> the local machine. This appears to be harder than it looks.)
> 
> I don't suppose someone can tell me where all this is documented?

check the dbus-api.txt document inside the bluez-utils source, because
it provides D-Bus methods for all common tasks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
