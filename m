Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: ben4fun <ben_4_fun@freenet.de>
To: bluez-users mailing list <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408060216.05030.cijoml@volny.cz>
References: <1091742606.6143.17.camel@localhost>
	 <1091747064.6143.25.camel@localhost> <1091748133.20839.63.camel@pegasus>
	 <200408060216.05030.cijoml@volny.cz>
Content-Type: multipart/alternative; boundary="=-cyvUB1lxshuMBwgUxZBX"
Message-Id: <1091810383.4570.14.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 06 Aug 2004 18:39:45 +0200


--=-cyvUB1lxshuMBwgUxZBX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


> add 
> 
> none            /proc/bus/usb   usbdevfs faults                 0       0
> 
> into /etc/fstab
> 
> then write
> mount -a 

It's done.
After a reboot, I did  "mount -t usbdevfs none /proc/bus/usb" from the
USB-howto . It confirmed me it was already mounted. But it is strange
that /proc/bus/usb/device file is still empty.

Then I did "hciconfig hci0 up"
and I still have "Can't init device hci0. Connection timed out(110)"

But the hciconfig message changed. It is now: 

"hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:6 acl:0 sco:0 commands:2 errors:0"

No idea why I have so much difficulties with this dongle.

Regards,

Ben


--=-cyvUB1lxshuMBwgUxZBX
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
Hi,<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>add 

none            /proc/bus/usb   usbdevfs faults                 0       0

into /etc/fstab

then write
mount -a </I></FONT></PRE>
</BLOCKQUOTE>
It's done.<BR>
After a reboot, I did <TT> &quot;mount -t usbdevfs none /proc/bus/usb&quot; from the USB-howto . It confirmed me it was already mounted. But it is strange that /proc/bus/usb/device file is still empty.<BR>
<BR>
Then I did &quot;hciconfig hci0 up&quot;<BR>
and I still have &quot;Can't init device hci0. Connection timed out(110)&quot;</TT><BR>
<BR>
But the hciconfig message changed. It is now: <BR>
<BR>
&quot;hci0:&nbsp;&nbsp; Type: USB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0&nbsp; SCO MTU: 0:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 errors:0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:6 acl:0 sco:0 commands:2 errors:0&quot;<BR>
<BR>
No idea why I have so much difficulties with this dongle.<BR>
<BR>
Regards,<BR>
<BR>
Ben<BR>
<BR>
</BODY>
</HTML>

--=-cyvUB1lxshuMBwgUxZBX--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
