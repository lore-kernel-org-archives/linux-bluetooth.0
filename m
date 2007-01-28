Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 28 Jan 2007 12:28:31 -0800 (PST)
From: Imran Siddique <imran_stdu@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <545015.6254.qm@web37701.mail.mud.yahoo.com>
Subject: [Bluez-users] poll() problem ...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0849966492=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0849966492==
Content-Type: multipart/alternative; boundary="0-1865991597-1170016111=:6254"
Content-Transfer-Encoding: 8bit

--0-1865991597-1170016111=:6254
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

HI,

   I am making a assignment 'file transfer using Bluetooth on hci layer'. I take code from hci.c. The problem is sometime my program works perfectly and transfer file successful. But most of the time it failed. 
Sender sends the Handshake packet and on Receiving side it receives. Receiver sends HACK to Sender but didn't receive anything. Means

n = poll(&p, 1, timeout)

n goes to 0. and the error is ETIMEDOUT. 
But the same program works fine sometime.
I am getting sick from this problem. 
I also try with different and same timeout values. but it doesn't effect in anyway.

Please help me.

Regards,

 
---------------------------------
TV dinner still cooling?
Check out "Tonight's Picks" on Yahoo! TV.
--0-1865991597-1170016111=:6254
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

HI,<br><br>&nbsp;&nbsp; I am making a assignment 'file transfer using Bluetooth on hci layer'. I take code from hci.c. The problem is sometime my program works perfectly and transfer file successful. But most of the time it failed. <br>Sender sends the Handshake packet and on Receiving side it receives. Receiver sends HACK to Sender but didn't receive anything. Means<br><br>n = poll(&amp;p, 1, timeout)<br><br>n goes to 0. and the error is ETIMEDOUT. <br>But the same program works fine sometime.<br>I am getting sick from this problem. <br>I also try with different and same timeout values. but it doesn't effect in anyway.<br><br>Please help me.<br><br>Regards,<br><p>&#32;

<hr size=1>TV dinner still cooling?<br><a href="http://us.rd.yahoo.com/evt=49979/*http://tv.yahoo.com/">Check out "Tonight's Picks"</a> on Yahoo! TV.
--0-1865991597-1170016111=:6254--


--===============0849966492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0849966492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0849966492==--
