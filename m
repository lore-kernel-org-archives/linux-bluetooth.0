Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sergei Koveshnikov <acrobat@eurocom.od.ua>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504240040.44535.acrobat@eurocom.od.ua>
Subject: [Bluez-users] LMP test mode
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
Date: Sun, 24 Apr 2005 00:40:44 +0300

Hello,
  I am trying to use LMP test mode witch described in the Bluetooth 
specification, however as it turned out I can't control test process via the 
air interface! :-(
  I have read intently Bluetooth specification and look through the
source code of BlueZ protocol stack, however I didn't find any way to
send PDU with the LMP_test_activate (opcode 56) or LMP_test_control
(opcode 57)!

Could you say to me how I can make these LMP PDU's with help of the
HCI interface?

Thank you very much for your replies!

-- 
Sergei Koveshnikov.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
