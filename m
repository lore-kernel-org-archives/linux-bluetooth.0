Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061020084015.40100.qmail@web52012.mail.yahoo.com>
Date: Fri, 20 Oct 2006 01:40:15 -0700 (PDT)
From: anoop <ee02m043@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Cant get dongle up
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0426947322=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0426947322==
Content-Type: multipart/alternative; boundary="0-1525568999-1161333615=:39596"
Content-Transfer-Encoding: 8bit

--0-1525568999-1161333615=:39596
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Dear Blue-z users
 I am new to Linux and blueZ, so may be my question may be  silly.
 
 My USB BT dongle has ISSC chipset (the ebay seller claimed that it will be a Bilionton dongle but it turned out to be a cheap EEPROM less dongle with 11:11.. BD address ) . It works fine in windows with blusoleil. But  I could not get it working in Linux - Kernerl 2.6.11 , Fedora core 3 redhat 12.0. 
 
 This is the output of hciconfig
 
 [root@localhost ~]# hciconfig -a
 hci0:   Type: USB
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
         DOWN
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:9 acl:0 sco:0 commands:4 errors:1
         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DH1 HV1
         Link policy:
         Link mode: SLAVE ACCEPT
 [root@localhost ~]# hciconfig -a
 hci0:   Type: USB
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
         DOWN
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:9 acl:0 sco:0 commands:4 errors:1
         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DH1 HV1
         Link policy:
         Link mode: SLAVE ACCEPT
 
 When I try hciconfig hci0 up , this is the response
 
 [root@localhost ~]# hciconfig hci0 up
 Can't init device hci0. Connection timed out(110)
 [root@localhost ~]#        
 
 lsusb displays this
   [root@localhost ~]# lsusb
 Bus 004 Device 001: ID 0000:0000
 Bus 003 Device 001: ID 0000:0000
 Bus 002 Device 003: ID 046d:c517 Logitech, Inc.
 Bus 002 Device 002: ID 1131:1001 Integrated System Solution Corp.
 Bus 002 Device 001: ID 0000:0000
 Bus 001 Device 001: ID 0000:0000
 
 The dongle's green LED is ON continuosly.
 
 I searched google and went through the bluez posts and found similar posts.
 but could not find  a solution. Any help on this would be great since I already wasted more than a week after this.
 
 Thanks
 Anoop
 
 
 
 
 		
---------------------------------
Do you Yahoo!?
 Everyone is raving about the  all-new Yahoo! Mail.
--0-1525568999-1161333615=:39596
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Dear Blue-z users<br> I am new to Linux and blueZ, so may be my question may be&nbsp; silly.<br> <br> My USB BT dongle has ISSC chipset (the ebay seller claimed that it will be a Bilionton dongle but it turned out to be a cheap EEPROM less dongle with 11:11.. BD address ) . It works fine in windows with blusoleil. But&nbsp; I could not get it working in Linux - Kernerl 2.6.11 , Fedora core 3 redhat 12.0. <br> <br> This is the output of hciconfig<br> <br> [root@localhost ~]# hciconfig -a<br> hci0:&nbsp;&nbsp; Type: USB<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0&nbsp; SCO MTU: 0:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 errors:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:9 acl:0 sco:0 commands:4 errors:1<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DH1 HV1<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br> [root@localhost ~]# hciconfig -a<br> hci0:&nbsp;&nbsp; Type: USB<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0&nbsp; SCO MTU: 0:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 errors:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:9 acl:0 sco:0 commands:4 errors:1<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DH1 HV1<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br> <br> When I try hciconfig hci0 up , this is the response<br> <br>
 [root@localhost ~]# hciconfig hci0 up<br> Can't init device hci0. Connection timed out(110)<br> [root@localhost ~]#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br> <br> lsusb displays this<br> &nbsp; [root@localhost ~]# lsusb<br> Bus 004 Device 001: ID 0000:0000<br> Bus 003 Device 001: ID 0000:0000<br> Bus 002 Device 003: ID 046d:c517 Logitech, Inc.<br> Bus 002 Device 002: ID 1131:1001 Integrated System Solution Corp.<br> Bus 002 Device 001: ID 0000:0000<br> Bus 001 Device 001: ID 0000:0000<br> <br> The dongle's green LED is ON continuosly.<br> <br> I searched google and went through the bluez posts and found similar posts.<br> but could not find&nbsp; a solution. Any help on this would be great since I already wasted more than a week after this.<br> <br> Thanks<br> Anoop<br> <br> <br> <br> <p>&#32;
		<hr size=1>Do you Yahoo!?<br> Everyone is raving about the <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta"> all-new Yahoo! Mail.</a>
--0-1525568999-1161333615=:39596--


--===============0426947322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0426947322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0426947322==--
