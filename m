Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Problems connecting to multiple rfcomm sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Drew <steve.drew@empics.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <0DD4EA5DCF754A409C4E182C758C37F38231@tigris.i.empics.co.uk>
References: <0DD4EA5DCF754A409C4E182C758C37F38231@tigris.i.empics.co.uk>
Content-Type: text/plain
Message-Id: <1099591273.7022.70.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 04 Nov 2004 19:01:13 +0100

Hi Steve,

> 	I've tried increasing the page timeout and the error still
> remains. 

two more options left to try.

> 	I have found that the problem is due to the mobile handsets we
> were      using (3x Nokia 6310i). Using a different handsets (Nokia
> 6230's) we were able to get bluetooth connections to 3 6230s (on top of
> this we could also have 2 6310s connected).

Yeah, the old Nokia Bluetooth chips are not quite the best for such
scenarios. The 6230 contains a CSR chip, right?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
