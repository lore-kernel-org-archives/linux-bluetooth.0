Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60701051340yaaba457ybc8a992d9496c677@mail.gmail.com>
Date: Fri, 5 Jan 2007 13:40:25 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm command usage for binding to *any* device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2121997472=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2121997472==
Content-Type: multipart/alternative;
	boundary="----=_Part_30248_25109318.1168033225842"

------=_Part_30248_25109318.1168033225842
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:

I managed to issue this command:

  rfcomm bind 0 <bt address> 4

and I am able to get going any a connection to the remote device specified
by the given bluetooth address.

However, I am now in a situation that I do not always know the remote device
ahead of time.  Is there a way to establish rfcomm binding on demand?  The
remote device uses SPP so it is a serial port.

Thanks

Mark

------=_Part_30248_25109318.1168033225842
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:<br><br>I managed to issue this command:<br><br>&nbsp; rfcomm bind 0 &lt;bt address&gt; 4<br><br>and I am able to get going any a connection to the remote device specified by the given bluetooth address.<br><br>However, I am now in a situation that I do not always know the remote device ahead of time.&nbsp; Is there a way to establish rfcomm binding on demand?&nbsp; The remote device uses SPP so it is a serial port.
<br><br>Thanks<br><br>Mark<br><br>

------=_Part_30248_25109318.1168033225842--


--===============2121997472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2121997472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2121997472==--
