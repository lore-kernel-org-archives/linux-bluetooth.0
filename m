Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Varat Chaikasetsin <varat_c@hotmail.com>
Message-ID: <loom.20040210T083307-660@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Limitation of emulator ?
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
Date: Tue, 10 Feb 2004 07:34:48 +0000 (UTC)

Hello ,
   I'm doing  my final year project about routing in Scatternet.I need to have 
lots of BT devices for this project so I decided to use "hciemu" to simulate 
many BT devices instead of using the real ones.
   Everthing seems to be allright with that emulator but now I'm facing a big 
problem. I can't simulate BT device more than 15 devices (hci0 - hci15).I  
use "hciemu localhost:xx" command to simulated all devices. 
   Moreover, when I've simulated 15 devices then pluged the USB device in ,I 
can't see or use that USB device by using "hciconfig" command.
    What am I doing wrong? what should I do ? or it's a limitation of the 
emulator ?
    Thanks for your help.
Regards,
Varat



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
