Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050303110744.23882.qmail@web40621.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: [Bluez-users] Zaurus SL6000 & Socket CF
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 3 Mar 2005 12:07:44 +0100 (CET)

Hi!
I've installed on my Zaurus this ipk from Bluez site:
bluez-libs_2.8
bluez-hcidump 1.9
bluez-utils 2.8
bluez-kernel-2.4.18-mh14

I've loaded the modules by hand with insmod
hci_uart
bluez
l2cap

now i must  attach to the serial device:
hciattach /dev/ttySX socket
As X i tried 0 and 1 and this get me this error: "BCSP
initialization timeout".

If as X i use 2, 3 i get "Can't open serial port: No
such device"

without hciattaching i can't use Bluez, anybody could
hilight me?
Thannk's
Best regards 
 Andrea S.



		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
