Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F11FDC6DE6FBCEC9843FF66C1B20@phx.gbl>
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011A99@netbe01.net.unimis>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] RE: Port BlueZ lib and utility on embedded uClinux
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
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
Date: Thu, 18 Aug 2005 19:21:41 +0000

<html><div style='background-color:'><DIV class=RTE>
<P>Hi,</P>
<P>When I am porting BlueZ to uCLinux, I found the same problem.<BR>I try with "select()" instead of "poll()", but I did not &nbsp;solve the problem.</P>
<P>I decided disable this option, and do not read the local name or other characteristics that I do not remenber.<BR></P>
<P>Regards.<BR></P></DIV>
<DIV></DIV>
<BLOCKQUOTE style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #a0c6e5 2px solid; MARGIN-RIGHT: 0px"><FONT style="FONT-SIZE: 11px; FONT-FAMILY: tahoma,sans-serif">
<HR color=#a0c6e5 SIZE=1>

<DIV></DIV>From:&nbsp;&nbsp;<I>"Al" &lt;Al_chane@issc.com.tw&gt;</I><BR>Reply-To:&nbsp;&nbsp;<I>bluez-users@lists.sourceforge.net</I><BR>To:&nbsp;&nbsp;<I>&lt;bluez-users@lists.sourceforge.net&gt;</I><BR>Subject:&nbsp;&nbsp;<I>[Bluez-users] RE: Port BlueZ lib and utility on embedded uClinux</I><BR>Date:&nbsp;&nbsp;<I>Thu, 18 Aug 2005 14:42:09 +0800</I><BR>&gt;<BR>&gt;Hi,<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The poll() always return error :<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;while ((n = poll(&amp;p, 1, to)) &lt; 0) in funcion int hci_send_req () (file: hci.c) results in "Can't read local name on hci0: Connection timed out (110)"<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Has anyone had same problem using poll() in embedded linux?<BR>&gt;<BR>&gt;thanks a lot,<BR>&gt;<BR>&gt;Al<BR>&gt;-----Original Message-----<BR>&gt;From: Al on behalf of 
Al<BR>&gt;Sent: Wed 8/17/2005 3:48 PM<BR>&gt;To: bluez-users@lists.sourceforge.net<BR>&gt;Cc:<BR>&gt;Subject: Port BlueZ lib and utility on embedded uClinux<BR>&gt;Hi, there:<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I'm trying to port BlueZ on embedded uClinux. Kernel part seems ok so far.<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; For the HCI utility on user space part, I first have /hci-lib and /hcid<BR>&gt;compiled to hcid. Then have /hci-lib and /hciconfig compiled to hciconfig.<BR>&gt;Copy two applications, hcid and hciconfig, to ramdisk. Also I have hcid.conf<BR>&gt;copied to ramdisk /etc/bluetooth/<BR>&gt;<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;After boot up, run hcid, then hciconfig hci0 up to bring up the device.<BR>&gt;MAC address is read correctly. But when running hciconfig -a, it can't read local name correctly.<BR>&gt;Are those steps correct? What do I 
miss?<BR>&gt;<BR>&gt;thanks a lot,<BR>&gt;<BR>&gt;Al<BR>&gt;<BR>&gt;--------------------------------------<BR>&gt;If I rn hcid -n to see the printout:<BR>&gt;<BR>&gt;/&gt;hcid -n<BR>&gt;hcid[18]: Bluetooth HCI deamon<BR>&gt;hcid[18]: Starting security manager 0<BR>&gt;<BR>&gt;---------------------------------------------------------------<BR>&gt;/&gt; hcid<BR>&gt;/&gt; hciconfig hci0 up<BR>&gt;/&gt; hciconfig -a<BR>&gt;hci0:&nbsp;&nbsp; Type: USB<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:03:DB:62 ACL MTU: 678:8 SCO MTU: 48:10<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:323 acl:0 sco:0 events:9 errors:0<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:33 acl:0 sco:0 commands:9 errors:0<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<BR>&gt;<BR>&gt;<BR>&gt;Can't read local name on hci0: Connection timed out (110)<BR>&gt;pid 17: failed 256<BR>&gt;/&gt;<BR>&gt;-------------------------------------------------------------------------------------------<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>
<P>&gt;&lt;&lt; winmail.dat &gt;&gt;
<DIV></DIV>
<P></FONT></P></BLOCKQUOTE></div></html>



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
