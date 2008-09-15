Return-Path: <cyrus@holtmann.org>
From: Dirk Vornheder <dirk_vornheder@yahoo.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 15 Sep 2008 23:16:25 +0200
MIME-Version: 1.0
Message-Id: <200809152316.25937.dirk_vornheder@yahoo.de>
Subject: [Bluez-users] bluez 4.6 and undefined symbols
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

Hi !

After installing bluez 4.6 i get the following messages during boot

Sep 15 22:16:43 pcneu hcid[5034]: Bluetooth HCI daemon
Sep 15 22:16:43 pcneu hcid[5034]: Starting SDP server
Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: 
/usr/lib/bluetooth/plugins/network.so: undefined symbol: device_get_path
Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: 
/usr/lib/bluetooth/plugins/service.so: undefined symbol: adapter_get_path
Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: 
/usr/lib/bluetooth/plugins/input.so: undefined symbol: device_get_path
Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: 
/usr/lib/bluetooth/plugins/serial.so: undefined symbol: device_get_path
Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: 
/usr/lib/bluetooth/plugins/audio.so: undefined symbol: device_get_path
Sep 15 22:16:43 pcneu hcid[5034]: HCI dev 0 registered
Sep 15 22:16:43 pcneu hcid[5034]: HCI dev 0 up
Sep 15 22:16:43 pcneu hcid[5034]: Device hci0 has been added
Sep 15 22:16:43 pcneu hcid[5034]: Starting security manager 0

I use openSUSE 11.0 and Kernel 2.6.27rc6 !

Dirk


		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
