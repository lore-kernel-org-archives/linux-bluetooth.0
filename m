Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 22 Nov 2006 00:00:39 +0100
From: Michel Leconte <leconte.michel@cegetel.net>
To: bluez-users@lists.sourceforge.net
Message-id: <004f01c70dc0$dd7d3240$44a54256@claudia>
MIME-version: 1.0
Subject: [Bluez-users] higher rate than 115 kbits/s with an uart channel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0064030176=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0064030176==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_60PA5uMAIiBhaRKU6NOoZQ)"

This is a multi-part message in MIME format.

--Boundary_(ID_60PA5uMAIiBhaRKU6NOoZQ)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

Hi all,

I work with a Bluetooth Kit of Semtech-Xemics which is connected

to a laptop with a Serial/USB adapter (supporting a max rate of 500 kbits/s).

I have a specific command to setup the uart channel of the Kit. 

At Bluez side, I setup the uart rate with the command :

"hciattach /dev/ttyUSB0 any 230400" (for 230,4 kbits/s) 

as I would like to work with a higher rate than 115 kbits/s.

But, at this rate, I couldn't control or setup the kit.

The "hciconfig -a" gives :

hci0: Type: UART

BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0

DOWN

RX bytes:10 acl:0 sco:0 events:0 errors:10

TX bytes:4 acl:0 sco:0 commands:1 errors:0

at Rx side, all the packets are with errors. 

What do I miss ? 

Do I have to setup the uart channel rate somewhere else in bluez ? 

The "hciconfig hci0 up" gives :

Can't init device hci0: Connection timed out (110)

For information, at 115 kbits/s, all is fine.

thanks for any suggestion or idea.

Regards.

Michel



--Boundary_(ID_60PA5uMAIiBhaRKU6NOoZQ)
Content-type: text/html; charset=iso-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV>
<P><FONT face=Arial size=2>Hi all,</FONT></P>
<P><FONT face=Arial size=2>I work with a Bluetooth Kit of Semtech-Xemics which 
is connected</FONT></P>
<P><FONT face=Arial size=2>to a laptop with a Serial/USB adapter (supporting a 
max rate of 500 kbits/s).</FONT></P>
<P><FONT face=Arial size=2>I have a specific command to setup the uart channel 
of the Kit. </FONT></P>
<P><FONT face=Arial size=2>At Bluez side, I setup the uart rate with the command 
:</FONT></P>
<P><FONT face=Arial size=2>"hciattach /dev/ttyUSB0 any 230400" (for 230,4 
kbits/s) </FONT></P>
<P><FONT face=Arial size=2>as I would like to work with a higher rate than 115 
kbits/s.</FONT></P>
<P><FONT face=Arial size=2>But, at this rate, I couldn't control or setup the 
kit.</FONT></P>
<P><FONT face=Arial size=2>The "hciconfig -a" gives :</FONT></P>
<P><FONT face=Arial size=2>hci0: Type: UART</FONT></P>
<P><FONT face=Arial size=2>BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 
0:0</FONT></P>
<P><FONT face=Arial size=2>DOWN</FONT></P>
<P><FONT face=Arial size=2>RX bytes:10 acl:0 sco:0 events:0 errors:10</FONT></P>
<P><FONT face=Arial size=2>TX bytes:4 acl:0 sco:0 commands:1 errors:0</FONT></P>
<P><FONT face=Arial size=2>at Rx side, all the packets are with errors. 
</FONT></P>
<P><FONT face=Arial size=2>What do I miss ? </FONT></P>
<P><FONT face=Arial size=2>Do I have to setup the uart channel rate somewhere 
else in bluez ? </FONT></P>
<P><FONT face=Arial size=2>The "hciconfig hci0 up" gives :</FONT></P>
<P><FONT face=Arial size=2>Can't init device hci0: Connection timed out 
(110)</FONT></P>
<P><FONT face=Arial size=2>For information, at 115 kbits/s, all is 
fine.</FONT></P>
<P><FONT face=Arial size=2>thanks for any suggestion or idea.</FONT></P>
<P><FONT face=Arial size=2>Regards.</FONT></P>
<P><FONT face=Arial size=2>Michel</FONT></P>
<P><FONT face=Arial size=2></FONT>&nbsp;</P></DIV></BODY></HTML>

--Boundary_(ID_60PA5uMAIiBhaRKU6NOoZQ)--


--===============0064030176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0064030176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0064030176==--
