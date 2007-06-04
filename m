Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e96e9eeb0706040653t2a6f8da5lbc7399932ff6fcbb@mail.gmail.com>
Date: Mon, 4 Jun 2007 16:53:19 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hcid <-> dbus problem
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

hello,

I can't run bluez in my platform. i tried this series of commands:

dbus-daemon --system       (seems to work)
hcid -nsd

that last command doesn't work, i get:
Dec 31 18:48:16 8 daemon.info hcid[945]: Bluetooth HCI daemon
Dec 31 18:48:17 8 daemon.err hcid[945]: Could not become the primary
owner of org.bluez
Dec 31 18:48:17 8 daemon.err hcid[945]: Unable to get on D-Bus

I even tried:
dbus-daemon --config-file /etc/dbus-1/system.d/bluetooth.conf

but it fails with the message:
Failed to start message bus: Configuration file needs one or more
<listen> elements giving addresses

any idea ?

(running sdpd alone does not fail btw)

thanks
voni

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
