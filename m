Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44891608.2030906@personnelware.com>
Date: Fri, 09 Jun 2006 01:32:40 -0500
From: Carl K <carl@personnelware.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] PM325 by LG cell phone - pairing failed
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

I am trying to pair my phone to my ubuntu/dapper laptop . 
carl@asus17:~$ lsusb

Bus 003 Device 002: ID 044e:3001 Alps Electric Co., Ltd UGTZ4 Bluetooth
carl@asus17:~$ cat /etc/bluetooth/pin
1234
carl@asus17:~$ sudo /etc/init.d/bluez-utils start

On the phone:  menu, bluetooth, add new, Searching and Pairing,
it shows asus17-0, I select that, phone prompts "Enter PIN code", I 
enter 1234<Next> and within a second get "pairing failed"

guessing because of this:

Jun  9 00:37:42 localhost gconfd (root-7749): starting (version 2.14.0), 
pid 7749 user 'root'
Jun  9 00:37:42 localhost gconfd (root-7749): Resolved address 
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only 
configuration source at position 0
Jun  9 00:37:42 localhost gconfd (root-7749): Resolved address 
"xml:readwrite:/root/.gconf" to a writable configuration source at 
position 1
Jun  9 00:37:42 localhost gconfd (root-7749): Resolved address 
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only 
configuration source at position 2
Jun  9 00:37:42 localhost gconfd (root-7749): Resolved address 
"xml:readonly:/var/lib/gconf/debian.defaults" to a read-only 
configuration source at position 3
Jun  9 00:37:42 localhost gconfd (root-7749): Resolved address 
"xml:readonly:/var/lib/gconf/defaults" to a read-only configuration 
source at position 4
Jun  9 00:38:42 localhost gconfd (root-7749): GConf server is not in 
use, shutting down.
Jun  9 00:38:42 localhost gconfd (root-7749): Exiting

Jun  9 01:03:08 localhost hcid[8572]: Bluetooth HCI daemon
Jun  9 01:03:08 localhost hcid[8572]: Can't get system message bus name: 
Connection ":1.15" is not allowed to own the service "org.bluez" due to 
security policies in the configuration file
Jun  9 01:03:08 localhost hcid[8572]: Starting security manager 0
Jun  9 01:03:08 localhost sdpd[8577]: Bluetooth SDP daemon


I probably need to file a bug report with ubuntu, but I would like to 
get some feedback from the experts so that the report has some useful info.

Or do I need to be doing something else?

Carl K


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
