Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex <welpan@gmx.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200405211611.38038.welpan@gmx.de>
Subject: [Bluez-users] Error message
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
Date: Fri, 21 May 2004 16:11:38 +0200

Hello Everybody.

Okay this is  my first mail in this list, so I am sorry for mistakes.

I try to connect a Headset with a dongle.

The problem begins if  I plug in my dongle  and boot my System, my System 
hangs.
So i plugged my dongle after booting my System i get this message:
 
hci_scodata_packet :hci0 sco packet unknown connection for handle 0

I killed this message and  make : hciconfig 
Nothing is found

I make this in KDE-Shell
no Error message , hciconfig find my dongle
I can scan for headset and find it, but i cant get any connection.

I make hcidump, I get this message:

SCO data: handle 0x0000 dlen0


That can I do, to connect my headset.


My System: Debian unstable
                   Kernel 2.6.6
installed bluez packages:
		   bluez-bluefw
  		   bluez-hcidump
                   bluez-utils
		   bluez-pan
                   bluez-pin

P.S.:  Sorry, I am german, and my english is not so fine.









-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
