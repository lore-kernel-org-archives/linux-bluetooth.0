Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 15 Apr 2008 09:59:04 +0800
Message-ID: <FFED2D1514034841A6270D98984E7D0C020C7159@pdsmsx415.ccr.corp.intel.com>
From: "Zhu, Peter J" <peter.j.zhu@intel.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Unable to read data via RFCOMM socket from a JSR82
	program running on phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

These days I tried to write one RFCOMM socket server that reads input
from a JSR82 client running on a phone but failed. My server program
runs on a Ubuntu gutsy distribution. This server registers a service
with a unique UUID and client looks for this service and send some
string request to server once found and then server sends back some
string data response to client. That's it. 

>>From both log of JSR82 client and hcidump output in linux host, I can
see this service is successfully found and a successful connection is
setup between linux host and phone. This successful connection can also
be verified by both "hcitool con" and "l2ping". l2ping means L2CAP layer
communication is good, I think. The accept() of this server is
succesful, as well. But at same time,  read() with sockid returned by
accept() just blocks,  and hcidump output shows that no data is read
from low level host interface. 

Another info that might be useful is that I also wrote a bluez C client
with RFCOMM socket that does same thing as JSR82 client. The blueZ C
client runs in the other linux machine. The result is perfectly good,
with everything going very smooth as expected. Noticeably, this
linux-linux successful communication doesn't require any pin
input/pairing process. That's a bit strange. 

Any help or info is extremely appreciated. Thanks to bluez and linux and
all people here. 


-Peter


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
