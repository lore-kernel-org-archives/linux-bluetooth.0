Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: ben4fun <ben_4_fun@freenet.de>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/alternative; boundary="=-GLR8HwHO06hhW3ydxULt"
Message-Id: <1091742606.6143.17.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] can't establish a connection
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 Aug 2004 23:50:07 +0200


--=-GLR8HwHO06hhW3ydxULt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Good evening,

I have a bluetooth dongle (broadcom) which is recognised when I plugged
it. I think so because kdebluetooth says that an adaptor was found. But
I can't pair it to my mobile phone (SE T610). The dongle doesn't
recognise any incoming connection.

I found on the mailing list archive the following command: " hciconfig
-a" this is what I obtained. I hope it could help.

"hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:3 acl:0 sco:0 commands:1 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy:
        Link mode: SLAVE ACCEPT"

I maybe should say that I have a mandrake 10.0 and the kernel 2.6.3.

Regards,

Ben.



--=-GLR8HwHO06hhW3ydxULt
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Good evening,<BR>
<BR>
I have a bluetooth dongle (broadcom) which is recognised when I plugged it. I think so because kdebluetooth says that an adaptor was found. But I can't pair it to my mobile phone (SE T610). The dongle doesn't recognise any incoming connection.<BR>
<BR>
I found on the mailing list archive the following command: &quot; hciconfig -a&quot; this is what I obtained. I hope it could help.<BR>
<BR>
&quot;hci0:&nbsp;&nbsp; Type: USB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0&nbsp; SCO MTU: 0:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:3 acl:0 sco:0 commands:1 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DH1 HV1<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT&quot;<BR>
<BR>
I maybe should say that I have a mandrake 10.0 and the kernel 2.6.3.<BR>
<BR>
Regards,<BR>
<BR>
Ben.<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-GLR8HwHO06hhW3ydxULt--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
