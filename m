Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christian Schubert <mail@apexo.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501151854.40656.mail@apexo.de>
Subject: [Bluez-users] error attaching device
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
Date: Sat, 15 Jan 2005 18:54:40 +0100

Hi there,

I'm using linux kernel 2.6.10 with the following debian bluez packages:
bluez-bluefw            1.0-1
bluez-hcidump           1.12-1
bluez-pin               0.24-1
bluez-utils             2.10-5

my problem now is:
I have a Acer Bluetooth USB Dongle which works correctly when plugged into 
either one of the primary USB ports as well as within the Microsoft Natural 
Keyboad USB Hub but NOT in my newly acquired Acer USB 2.0 Hub which leaves 
the following error messages in the syslog:

kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c6586b74 err 
-28
hcid[11781]: Can't init device hci0. Input/output error(5)

Any hints?

Cheers,
Christian

p.s.: not subscribed to the list


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
