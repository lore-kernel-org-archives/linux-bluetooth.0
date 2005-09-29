Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A53@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Trouble communicating to a non-discoverable BT
	device
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C51D.E0158F80"
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
Date: Thu, 29 Sep 2005 10:47:35 -0700

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C51D.E0158F80
Content-Type: text/plain;
	charset="ISO-8859-2"

I am able to get the rfcomm tool to connect with this message:
rfcomm0: 00:A0:96:0D:3B:80 channel 1 config [tty-attached]
 
but when I attempt to echo commands like this:
echo Send Me > /dev/rfcomm0
 
I get this error: ./detectbluetoothdevice.sh: 108: cannot create
/dev/rfcomm0: Host is down
 
How do I find out why I am getting this error?
 

-----Original Message-----
From: Robert Wlaschin [mailto:robertw@bigbird.hhn.com]
Sent: Wednesday, September 28, 2005 5:04 PM
To: 'bluez-users@lists.sourceforge.net'
Subject: [Bluez-users] Trouble communicating to a non-discoverable BT devi
ce




I have a slightly different problem than what I've seen posted in the
mailing list thus far, please point me in the right direction if I have
misspoke.  I am attempting to create an Ash script (on Busybox, Arm
processor -- uClib cross compile, Deb Kernel 2.6.10) w/ bluez-libs-2.19, and
bluez-utils-2.19.  The system I am using is semi-embedded and has a limited
amount of space for various utilities.

My BT device is non-discoverable, I am unable to change this.  Therefore, I
am forced to wait until I am signaled by the device to attempt a connection.
This device is also battery operated and the Manufacturer designed it to
conserve power by allowing only a minimal time slice for the device to link
with my system.  Once I have a connection I have to read the data by sending
ACK's back across the device.

I was attempting to create a script that watched the system log messages
dumped by hcid and sdpd.  I was able to create a script using rfcomm's bind
and connect, which allowed me to read from /dev/rfcomm0 but I was unable to
send without receiving a 'Host is down' error.  I did some reading and it
was suggested that both the devices were setup as clients and this was why I
was receiving this message.  Another suggestion was to use rfcomm's listen
to setup the device.  I have attempted an implementation of that but I
receive a Disconnect extremely quickly and I am having difficulty detecting
when the listen connects to my device so I can extract the BT address and
other pertinent data.

First off am I even heading in the correct direction, should I use the
rfcomm listen command, instead of the connect?  Is there an easier way to do
what I need to get done, using already created tools I don't know about?  Do
I need to run the sdptool and add the SP interface?  Where are the doc's
that explain how to use the rfcomm and sdptool utils -- the man pages have
various information/knowledge gaps?

Thanks, 
Robert 


------_=_NextPart_001_01C5C51D.E0158F80
Content-Type: text/html;
	charset="ISO-8859-2"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-2">
<TITLE>[Bluez-users] Trouble communicating to a non-discoverable BT device</TITLE>

<META content="MSHTML 6.00.2900.2722" name=GENERATOR></HEAD>
<BODY>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff size=2>I am 
able to get the rfcomm tool to connect with this message:</FONT></SPAN></DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff 
size=2>rfcomm0: 00:A0:96:0D:3B:80 channel 1 config 
[tty-attached]</FONT></SPAN></DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff size=2>but 
when I attempt to echo commands like this:</FONT></SPAN></DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff size=2>echo 
Send Me &gt; /dev/rfcomm0</FONT></SPAN></DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff size=2>I get 
this error: </FONT></SPAN><SPAN class=704414417-29092005><FONT face=Arial 
color=#0000ff size=2>./detectbluetoothdevice.sh: 108: cannot create 
/dev/rfcomm0: Host is down</FONT></SPAN></DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff size=2>How do 
I find out why I am getting this error?</FONT></SPAN></DIV>
<DIV><SPAN class=704414417-29092005><FONT face=Arial color=#0000ff 
size=2></FONT></SPAN>&nbsp;</DIV>
<BLOCKQUOTE dir=ltr style="MARGIN-RIGHT: 0px">
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT face=Tahoma 
  size=2>-----Original Message-----<BR><B>From:</B> Robert Wlaschin 
  [mailto:robertw@bigbird.hhn.com]<BR><B>Sent:</B> Wednesday, September 28, 2005 
  5:04 PM<BR><B>To:</B> 'bluez-users@lists.sourceforge.net'<BR><B>Subject:</B> 
  [Bluez-users] Trouble communicating to a non-discoverable BT devi 
  ce<BR><BR></FONT></DIV><BR>
  <P><FONT size=2>I have a slightly different problem than what I've seen posted 
  in the mailing list thus far, please point me in the right direction if I have 
  misspoke.&nbsp; I am attempting to create an Ash script (on Busybox, Arm 
  processor -- uClib cross compile, Deb Kernel 2.6.10) w/ bluez-libs-2.19, and 
  bluez-utils-2.19.&nbsp; The system I am using is semi-embedded and has a 
  limited amount of space for various utilities.</FONT></P>
  <P><FONT size=2>My BT device is non-discoverable, I am unable to change 
  this.&nbsp; Therefore, I am forced to wait until I am signaled by the device 
  to attempt a connection.&nbsp; This device is also battery operated and the 
  Manufacturer designed it to conserve power by allowing only a minimal time 
  slice for the device to link with my system.&nbsp; Once I have a connection I 
  have to read the data by sending ACK's back across the device.</FONT></P>
  <P><FONT size=2>I was attempting to create a script that watched the system 
  log messages dumped by hcid and sdpd.&nbsp; I was able to create a script 
  using rfcomm's bind and connect, which allowed me to read from /dev/rfcomm0 
  but I was unable to send without receiving a 'Host is down' error.&nbsp; I did 
  some reading and it was suggested that both the devices were setup as clients 
  and this was why I was receiving this message.&nbsp; Another suggestion was to 
  use rfcomm's listen to setup the device.&nbsp; I have attempted an 
  implementation of that but I receive a Disconnect extremely quickly and I am 
  having difficulty detecting when the listen connects to my device so I can 
  extract the BT address and other pertinent data.</FONT></P>
  <P><FONT size=2>First off am I even heading in the correct direction, should I 
  use the rfcomm listen command, instead of the connect?&nbsp; Is there an 
  easier way to do what I need to get done, using already created tools I don't 
  know about?&nbsp; Do I need to run the sdptool and add the SP interface?&nbsp; 
  Where are the doc's that explain how to use the rfcomm and sdptool utils -- 
  the man pages have various information/knowledge gaps?</FONT></P>
  <P><FONT size=2>Thanks,</FONT> <BR><FONT size=2>Robert</FONT> 
</P></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C5C51D.E0158F80--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
