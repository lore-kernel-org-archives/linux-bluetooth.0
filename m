Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Markus Uhr <uhrm@student.ethz.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1104589274.10387.9.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] IBM Bluetooth PC Card II
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 01 Jan 2005 15:21:14 +0100

Hello

In http://www.holtmann.org/linux/bluetooth/devices.html the
IBM Bluetooth PC Card II is reported to work with the hci_uart
driver. However, when I insert to card into my computer I get these
Log-Messages:

Jan  1 14:06:08 [cardmgr] socket 0: IBM Bluetooth PC Card II
Jan  1 14:06:08 [cardmgr] executing: 'modprobe serial_cs'
Jan  1 14:06:08 [cardmgr] get dev info on socket 0 failed: No such
device
Jan  1 14:06:08 [kernel] serial_cs: no usable port range found, giving
up
Jan  1 14:06:08 [kernel] serial_cs: RequestIO: No more items

So, has anybody an idea what could be wrong that the PCMCIA subsystem
doesn't initialize the card properly? Do I need to pass some special
parameters?

My config entry in /etc/pcmcia/bluetooth.conf for the card:

card "IBM Bluetooth PC Card II"
  version "IBM", "Bluetooth PC Card II", "", ""
  bind "serial_cs" class "bluetooth"

Is anything wrong with that?

Markus Uhr



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
