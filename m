Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050915131226.8041.qmail@web15710.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1743937648-1126789946=:5290"
Subject: [Bluez-users] BlueCore2 speed problem!
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
Date: Thu, 15 Sep 2005 21:12:26 +0800 (CST)

--0-1743937648-1126789946=:5290
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,
I use two BlueCore2-External modules to transfer data through UART interface,but the max speed is only 5KB/s!!!  Howerver,in the data sheet,it says "The maximum UART data rate is 1.5 MBaud"!!   1.5Mb/s / 8=192KB/s,am i  right?
 
so,why my speed is slow? How can I do to improve the speed??
 
hci0:   Type: UART
        BD Address: 4A:49:4E:00:15:2F ACL MTU: 384:4 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:70 acl:0 sco:0 events:7 errors:0
        TX bytes:34 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'B'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver: 1.1 (0x1) LMP Subver: 0x2c1
        Manufacturer: Cambridge Silicon Radio (10)
 
gadfly
 

		
---------------------------------
DO YOU YAHOO!?
  ÑÅ»¢Ãâ·ÑGÓÊÏä£­No.1µÄ·À¶¾·ÀÀ¬»ø³¬´óÓÊÏä  
--0-1743937648-1126789946=:5290
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>
<DIV>I use two BlueCore2-External modules to transfer data through UART interface,but the max speed is only 5KB/s!!!&nbsp; Howerver,in the data sheet,it says "The maximum UART data rate is 1.5 MBaud"!!&nbsp;&nbsp; 1.5Mb/s / 8=192KB/s,am i &nbsp;right?</DIV>
<DIV>&nbsp;</DIV>
<DIV>so,why my speed is slow? How can I do to improve the speed??</DIV>
<DIV>&nbsp;</DIV>
<DIV>hci0:&nbsp;&nbsp; Type: UART<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 4A:49:4E:00:15:2F ACL MTU: 384:4 SCO MTU: 64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:70 acl:0 sco:0 events:7 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:34 acl:0 sco:0 commands:7 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'B'<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class:
 Miscellaneous,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver: 1.1 (0x1) LMP Subver: 0x2c1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)</DIV>
<DIV>&nbsp;</DIV>
<DIV>gadfly</DIV>
<DIV>&nbsp;</DIV><p>
		<hr size=1>DO YOU YAHOO!?<br> 
<a href="http://cn.mail.yahoo.com" target=blank> 
ÑÅ»¢Ãâ·ÑGÓÊÏä£­No.1µÄ·À¶¾·ÀÀ¬»ø³¬´óÓÊÏä </a> 
--0-1743937648-1126789946=:5290--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
