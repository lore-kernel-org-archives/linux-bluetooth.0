Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Radoslav Reznicek" <radecek@email.cz>
To: "'Pavel Ruzicka'" <pavouk@pavouk.org>
Cc: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] pairing i-Tech BT USB dongle and Nokia 6310i
Message-ID: <001c01c3f707$0aa1e640$2974daa0@radecek>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
In-Reply-To: <200402162247.13628.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 19 Feb 2004 17:32:13 +0100

SOLVED

(see HOWTO http://www.holtmann.org/linux/bluetooth/)

File
/etc/bluetooth/hcid.conf
contains bad pin_helper (/bin/bluepin)

To make this work with the hcid.conf file above you need the
/etc/bluetooth/givepin script. Here is mine:

##############givepin##########
#!/bin/sh
echo "PIN:123456"
################

Just open an editor and copy this into a file and save it as
/etc/bluetooth/givepin Then do

chmod 710 /etc/bluetooth/givepin

Thank to Pavel Ruzicka


Radoslav Reznicek



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
