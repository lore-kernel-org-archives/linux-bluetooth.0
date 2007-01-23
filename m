Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60701221641p6a4a534uf5ce6a54b5fbbe79@mail.gmail.com>
Date: Mon, 22 Jan 2007 16:41:40 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] SPP connections
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0898858008=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0898858008==
Content-Type: multipart/alternative;
	boundary="----=_Part_216807_10498327.1169512900565"

------=_Part_216807_10498327.1169512900565
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All:

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

------=_Part_216807_10498327.1169512900565
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All:<br><br>I have a program and listen for connections from a device that uses SPP.&nbsp; My program just opens RFCOMM socket and waits for connection to come in.&nbsp; The device that connects into my program has a connection LED indicating a successful connections.
<br><br>I have noticed that if close my RFCOMM socket, even if I stop my listener process, the connection LED on the device remains lit.&nbsp; The only thing I get it to not lit (and thus indicates that it is giving up on that connection) is to remove my USB bluetooth dongle.
<br><br>Is there anyway I can do a full disconnect on SPP?<br><br>Thanks<br><br>Mark<br>

------=_Part_216807_10498327.1169512900565--


--===============0898858008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0898858008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0898858008==--
