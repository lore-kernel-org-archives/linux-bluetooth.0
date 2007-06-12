Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: kde-announce@kde.org
Date: Tue, 12 Jun 2007 11:49:13 +0200
MIME-Version: 1.0
Message-Id: <200706121149.14306.dgollub@suse.de>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] kdebluetooth release 1.0 Beta 3
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

Hi,

kdebluetooth 1.0 Beta 3 is ready!

kdebluetooth got mostly rewritten to make use of the BlueZ  D-BUS API and all 
of their services. libkbluetooth wraps the BlueZ D-BUS API and makes it quite 
easy to write some Bluetooth related application.

kbluetoothd is now a simple trayicon application without any daemon 
functionality and got renamed to kbluetooth. It also acts as Passkey Agent 
for Bluetooth device pairing request and as Authorization Agent for Bluetooth 
service request from remote Bluetooth devices. So no more evil hacks to get 
pairing with bluez-utils 3.x working in KDE. Bye bye, pin-helpers!

With kbluetooth you can also configure your Bluetooth interface. Changed the 
mode to discoverable (for other devices) or only connectable (still 
connectable but not visible for other devices). Or change the discoverable 
name of the Bluetooth interface.

Another highlight is the initial implementation of a Bluetooth Input Wizard. 
Which allows to setup and manage Bluetooth Input devices from KDE in easy 
way. The Input  Wizard is still experimental and doesn't looks like eye-candy 
at the moment.

kio_obex got replaced by kio_obex2 which is based only on obexftp (no need for 
libkobex/libqobex) and supports also now USB as transport (libusb).

kbluelock got rewritten by Tom Patzig which locks the KDE session if a 
configured Bluetooth remote device disappaers - e.g. your mobile phone. So if 
you leave your office, with enabled Bluetooth, kbluelock is going to lock the 
screen.


The next steps:

- testing
- make it stable
- make it userfriendly
- make it something like eye-candy
- implement a transfer service (OBEX Push)
- implement the audio service (Bluetooth Headsets, ...)

Note to packagers: this software contains a shared library (libkbluetooth) and 
related headers. Please include them in your package, other software 
(currently kmobiletools) will require them to properly work.

I would like to thank Tom Patzig and Marco Gulino who developed as well on 
this branch!

best regards,
Daniel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
