Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404162339.01392.cijoml@volny.cz>
Subject: [Bluez-users] BlueZ error in cc,cc,dc sequence
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
Date: Fri, 16 Apr 2004 23:39:01 +0200

Hi Marcel,

see this:

notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
Can't create connection: Input/output error
notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
Can't create connection: Input/output error
notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
Can't create connection: Input/output error
notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
Not connected.
notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
Not connected.
notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
Can't create connection: Input/output error
notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
Not connected.

But device is connected

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
