Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50706291727w109e0ecbx28635ddbb630421e@mail.gmail.com>
Date: Fri, 29 Jun 2007 21:27:16 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] how to get maximum throughput with Bluetooth 2.0?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0796447237=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0796447237==
Content-Type: multipart/alternative;
	boundary="----=_Part_61164_860674.1183163236399"

------=_Part_61164_860674.1183163236399
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list.

I am tryint to get the maximum throughput using 2.0 dongles (anycom
USB-250). For my tests I wrote a program that opens a l2cap socket with a
second host and continuously writes a message of 1200 bytes. Befores opening
the socket connection I change the connection packet type to 3-DH5 with
hcitool utility. My kernel is 2.6.22-rc6 and I have just installed
bluez-utils-3.12 and bluez-libs-3.12.

I thought this environment would be enough for getting close to 3Mb/s of
transfering throughput, but I am just reaching a little over 1 Mb/s.

Does anyone ever tried something similar? Can anyone give some direction
about what I am missing?

Thanks in advance!

Loreno

------=_Part_61164_860674.1183163236399
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list.<br><br>I am tryint to get the maximum throughput using 2.0 dongles (anycom USB-250). For my tests I wrote a program that opens a l2cap socket with a second host and continuously writes a message of 1200 bytes. Befores opening the socket connection I change the connection packet type to 3-DH5 with hcitool utility. My kernel is 
2.6.22-rc6 and I have just installed bluez-utils-3.12 and bluez-libs-3.12.<br><br>I thought this environment would be enough for getting close to 3Mb/s of transfering throughput, but I am just reaching a little over 1 Mb/s.
<br><br>Does anyone ever tried something similar? Can anyone give some direction about what I am missing?<br><br>Thanks in advance!<br><br>Loreno<br>

------=_Part_61164_860674.1183163236399--


--===============0796447237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0796447237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0796447237==--
