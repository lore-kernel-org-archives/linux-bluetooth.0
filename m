Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4225D4B4.7050306@rcs.ei.tum.de>
From: Reinald Gfuellner <Reinald.Gfuellner@lpr.e-technik.tu-muenchen.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] EPOX BT-PM01B (new) and linux 2.4 ?
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
Date: Wed, 02 Mar 2005 15:59:00 +0100

Are there different Versions of Epox Presenter BT-PM01B and can
the latest one be used with kernel 2.4  ?

The device I bought recently
	- is hdi-based
	- has to be brought to "pairing mode" by pressing 3 buttons
	  after poweron in order to react to hcitool scan.

(Both facts are not mentioned in
http://www.holtmann.org/linux/bluetooth/epox.html)

epox-presenter:			"no devices in range"
epox-presenter <hw_addr>:	"socket:connection refused"


The BT-PM01B works great on linux 2.6.10 using hidd --server.
I have one 2.4.29 - System however I can not upgrade yet.

Thanks
   Reinald



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
