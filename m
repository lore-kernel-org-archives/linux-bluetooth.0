Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAPFR022I+ek2ATkOW7ZKVBgEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1102515083.9988.76.camel@pegasus>
Subject: [Bluez-users] BT unter SuSE 9.2
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
Date: Thu, 9 Dec 2004 14:37:55 +0100

Hi Marcel,

##>maybe you simply have to run YaST once and activate Bluetooth.

In the meantime, I'm able to establish a connection to teh =
Bluetooth-Modul.
I solved the problem by the boot-command pci=3Dnoapci
after this I was able to start dmabt and now, the bluetooth-function of =
my
notebook is identified by kbluetoothd! What is to be done in order to =
start
dmabt automatically on the right time?

##>
##>> At the moment I'm working with Windows, also connected by the=20
##>> BT-device to my network.

But, when I try to find the use the LAN-Service of the BT-Accesspoint I =
get
get teh message
Authorization failure

The BT-accesspoint is asking for a PIN and I think it's acting as a =
master.
So I'm not able to send the right PIN. I changed in hcid.conf the =
PIN-asking
from auto to none and user, witout any success. The BT-accesspoint =
requires
a PIN, it is not possible to set this routine out of function.

Regards
Peter




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
