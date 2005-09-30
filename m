Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <01C5C5C5.C3297370.emonturus@teltronic.es>
From: Esteban Monturus <emonturus@teltronic.es>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Re: Converting a PC in a multiradio access point
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
Date: Fri, 30 Sep 2005 13:49:21 +0200

	Hi Marcel,

	I have finally solved the problems of my boot process, so I continue 
investigating the problem of converting a PC in a multiradio access point. 
The PC-access point has two dongles and a pand --listen process is 
listening in each one. After having established the first connection from 
the PANU to the PC-access point, I try to connect from the same PANU-dongle 
to the other dongle of the PC-access point. This second connection fails 
and in the /var/log/messages appears "Connection failed. File exists(17)". 
When I plug a second dongle in the PANU and try to establish from this 
dongle the second connection to the PC-access point, there is no problem.

	I think that when pand --listen receives a new connection, the function 
bnep_connectionadd checks the source Bluetooth address. If this address 
belongs to a device which is already connected to the system, the said 
function returns -1 and the connection gets aborted. It seems that BlueZ 
can not distinguish between connections that it receives from a Bluetooth 
device to two different dongles plugged.

	I hope this information would help to solve the problem.

	Best regards,

	Esteban.



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
