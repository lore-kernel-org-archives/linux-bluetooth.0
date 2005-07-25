Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <62268.129.247.247.239.1122287313.squirrel@mail.tts-online.biz>
From: lists@kiehne-online.de
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] Logi MX900 & Omnibook 7010
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
Date: Mon, 25 Jul 2005 12:28:33 +0200 (CEST)

Hi
I am using a HP Omnibook 7010 with a BT Logitech MX900
I've got nearly the same problem as Daniel Vollmer reported 2004-08-23

hci_acldata_packet: hci0 ACL packet for unknown connection handle 41

putting

hidd -K

in the init script solves the problem for me, too. Since the problem semms
to occur for different configurations, I'd vote for putting it in the init
script by default (but I cannot predict iff this could be harmful for any
other device).

Regards

Rainer Kiehne



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
