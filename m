Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Sean Barry" <sfelkes@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F19GQq9RFSdXuF000530ae@hotmail.com>
Subject: [Bluez-devel] BlueZ on Linux iPAQ
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Jan 2004 02:51:08 +0000

Hi,

Could anyone help me get BlueZ installed and configured on any of Familiar 
v0.7, 0.7.1 or 0.7.2.  Ideally the latter I have a 3970 iPAQ which is not 
able to access the Internet.  Thus far I have installed the following: -

bluez-modules-2.4.18-rmk3_2.1-1_arm.ipk
task-bluez_1.3-hh1_arm.ipk

Task-bluez required some other ipkgs which I installed until task-bluez 
install completed successfully.  However, when I install the Rococo 
reference implementation of Java APIs in Bluetooth I get the following 
error.

/mnt/hda # ipkg install impronto_1.1_arm.ipk
ERROR: Cannot satisfy the following dependencies for impronto:
         libbluetooth libsdp

bluez-libs-2.0_0.9-hh1_arm.ipk is installed as is bluez-sdp_0.7-hh7_arm.ipk.

Are these the right files? Where can I get the right files? I can switch the 
BT radio on from GPE and perform hciconfig hci0, hcitool scan and hcitool 
inquiry.  Do I need to install any BlueZ packages in Familiar v0.7.2.

Please help me this problem is really bothering me.

Regards,

Sean

_________________________________________________________________
It's fast, it's easy and it's free. Get MSN Messenger today! 
http://www.msn.co.uk/messenger



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
