Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <be976db60701221642w1a2ff16wd8f51f44e4db3185@mail.gmail.com>
Date: Mon, 22 Jan 2007 16:42:02 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] SPP connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0424297556=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0424297556==
Content-Type: multipart/alternative;
	boundary="----=_Part_216811_31030983.1169512922671"

------=_Part_216811_31030983.1169512922671
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All

I have a program and listen for connections from a device that uses SPP.  My
program just opens RFCOMM socket and waits for connection to come in.  The
device that connects into my program has a connection LED indicating a
successful connections.

I have noticed that if close my RFCOMM socket, even if I stop my listener
process, the connection LED on the device remains lit.  The only thing I get
it to not lit (and thus indicates that it is giving up on that connection)
is to remove my USB bluetooth dongle.

Is there anyway I can do a full disconnect on SPP?

Thanks

Mark

------=_Part_216811_31030983.1169512922671
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All<br><br>I have a program and listen for connections from a device that uses
SPP.&nbsp; My program just opens RFCOMM socket and waits for connection to
come in.&nbsp; The device that connects into my program has a connection LED
indicating a successful connections.<br>
<br>
I have noticed that if close my RFCOMM socket, even if I stop my
listener process, the connection LED on the device remains lit.&nbsp; The
only thing I get it to not lit (and thus indicates that it is giving up
on that connection) is to remove my USB bluetooth dongle.<br>
<br>
Is there anyway I can do a full disconnect on SPP?<br>
<br>Thanks<br><br>Mark<br><br>

------=_Part_216811_31030983.1169512922671--


--===============0424297556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0424297556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0424297556==--
