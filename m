Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Radoslav Reznicek" <radecek@email.cz>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000e01c3f4d0$8128de60$4461daa0@radecek>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Subject: [Bluez-users] pairing i-Tech BT USB dongle and Nokia 6310i
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
Date: Mon, 16 Feb 2004 21:55:47 +0100

I can't paired i-Tech BT USB dongle and phone Nokia 6310i. When I want
connect to phone,  phone ask me for PIN. After enter PIN phone says "bad
PIN". PC do not ask me for PIN. When I  try run bluepin script from shell,
it return error. What do I bad?
OS Mandrake9.2 kernel 2.4.22
When I using Windows, i-Tech BT USB dongle and phone work correctly.

[root@localhost bluetooth]# hcitool scan
Scanning ...
        00:60:57:10:CE:17       Nokia 6310i
[root@localhost bluetooth]# rfcomm connect rfcomm0 00:60:57:10:CE:17
Can't connect RFCOMM socket: Connection refused
[root@localhost bluetooth]# bluepin
Traceback (most recent call last):
  File "/bin/bluepin", line 39, in ?
    class Dialog(GtkDialog):
NameError: name 'GtkDialog' is not defined
[root@localhost bluetooth]#


[root@localhost bluetooth]#cat /var/log/syslog
Feb 15 18:26:10 localhost kernel: BlueZ RFCOMM ver 1.0
Feb 15 18:26:10 localhost kernel: Copyright (C) 2002 Maxim Krasnyansky
<maxk@qualcomm.com>
Feb 15 18:26:10 localhost kernel: Copyright (C) 2002 Marcel
Holtmann<marcel@holtmann.org>
Feb 15 18:26:35 localhost hcid[1587]: link_key_request
(sba=C3:D1:00:1B:08:00,  dba=17:CE:10:57:60:00)
Feb 15 18:26:37 localhost hcid[1587]: pin_code_request
(sba=C3:D1:00:1B:08:00,  dba=17:CE:10:57:60:00)
Feb 15 18:28:06 localhost hcid[1587]: pin_code_request
(sba=C3:D1:00:1B:08:00,  dba=17:CE:10:57:60:00)
Feb 15 18:29:51 localhost hcid[1587]: pin_code_request
(sba=C3:D1:00:1B:08:00,  dba=17:CE:10:57:60:00)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
