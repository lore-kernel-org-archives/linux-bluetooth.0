Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <01C5D98C.A66B35E0.emonturus@teltronic.es>
From: Esteban Monturus <emonturus@teltronic.es>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Converting a PC in a multiradio access point
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 Oct 2005 17:50:55 +0200

	Hi all,

	I have already posted this enquiry in the bluez-users list, but I think 
this is a better place to ask, as I have not received answer to this issue 
yet. My objective is to implement a multiradio PAN access point with a PC 
and two USB Bluetooth dongles. After connecting both dongles in the 
computer I enter:

	pand --listen --role NAP

	To act as PANU I plug a third dongle in another computer. I establish the 
first connection to one of the dongles of the multiradio access point. 
However, when I try to establish a second connection from the same PANU to 
the other dongle of the multiradio access point, an error ocurrs. In the 
/var/log/messages of the multiradio access point appears the following:

	Connection failed. File exists(17)

	If I plug another dongle in the PANU computer and try to establish the 
second connection from this new dongle, everything goes well.	After 
inspecting the pand source I have realised the function bnep_connectionadd 
returns -1 when the second connection is tried and it gets aborted. It 
seems that BlueZ can not distinguish between connections that it receives 
from a Bluetooth device to two different dongles plugged to it. I have seen 
pand opens an L2CAP socket when it waits for PAN connections. That socket 
is then bound to 0.0.0.0 Bluetooth address. That must make BlueZ use always 
the same dongle (the first that was plugged), which would explain the 
error.

	I have modified the pand code to enter the local listening Bluetooth 
address from the command line. I launch two pand processes, each one using 
a socket bound to one of the two Bluetooth addresses and still get the 
"connection failed" error. I have also tried to change the L2CAP channel 
descriptors, but it seems to work only when the 0x0F channnel is used.

	Could someone help me? Thank you in advance.

	Esteban.



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
