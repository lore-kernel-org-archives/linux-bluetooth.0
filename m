Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <CBBBD909D2D6D211B4700090273F9E6E04C49A56@polaris.hhn.com>
From: Robert Wlaschin <robertw@healthhero.com>
To: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Trouble communicating to a non-discoverable BT
	device
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C5DD.AC405A30"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 30 Sep 2005 09:40:31 -0700

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5C5DD.AC405A30
Content-Type: text/plain;
	charset="ISO-8859-2"

Hi,
 
Sorry I posted this to the Bluez-user list but I think that was the wrong
place.
 
I  have a slightly different problem than what I've seen posted in the
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


------_=_NextPart_001_01C5C5DD.AC405A30
Content-Type: text/html;
	charset="ISO-8859-2"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-2">
<TITLE>[Bluez-users] Trouble communicating to a non-discoverable BT device</TITLE>

<META content="MSHTML 6.00.2900.2722" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial><FONT size=2><SPAN 
class=134493716-30092005>Hi,</SPAN></FONT></FONT></DIV>
<DIV><FONT face=Arial><FONT size=2><SPAN 
class=134493716-30092005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial><FONT size=2><SPAN class=134493716-30092005>Sorry I posted 
this to the Bluez-user&nbsp;list but I think that was the wrong 
place.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=Arial><FONT size=2><SPAN 
class=134493716-30092005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial><FONT size=2><SPAN 
class=134493716-30092005>I&nbsp;</SPAN>&nbsp;have a slightly different problem 
than what I've seen posted in the mailing list thus far, please point me in the 
right direction if I have misspoke.&nbsp; I am attempting to create an Ash 
script (on Busybox, Arm processor -- uClib cross compile, Deb Kernel 2.6.10) w/ 
bluez-libs-2.19, and bluez-utils-2.19.&nbsp; The system I am using is 
semi-embedded and has a limited amount of space for various 
utilities.</FONT></FONT></DIV>
<P dir=ltr style="MARGIN-RIGHT: 0px"><FONT face=Arial size=2>My BT device is 
non-discoverable, I am unable to change this.&nbsp; Therefore, I am forced to 
wait until I am signaled by the device to attempt a connection.&nbsp; This 
device is also battery operated and the Manufacturer designed it to conserve 
power by allowing only a minimal time slice for the device to link with my 
system.&nbsp; Once I have a connection I have to read the data by sending ACK's 
back across the device.</FONT></P>
<P dir=ltr style="MARGIN-RIGHT: 0px"><FONT face=Arial size=2>I was attempting to 
create a script that watched the system log messages dumped by hcid and 
sdpd.&nbsp; I was able to create a script using rfcomm's bind and connect, which 
allowed me to read from /dev/rfcomm0 but I was unable to send without receiving 
a 'Host is down' error.&nbsp; I did some reading and it was suggested that both 
the devices were setup as clients and this was why I was receiving this 
message.&nbsp; Another suggestion was to use rfcomm's listen to setup the 
device.&nbsp; I have attempted an implementation of that but I receive a 
Disconnect extremely quickly and I am having difficulty detecting when the 
listen connects to my device so I can extract the BT address and other pertinent 
data.</FONT></P>
<P dir=ltr style="MARGIN-RIGHT: 0px"><FONT face=Arial size=2>First off am I even 
heading in the correct direction, should I use the rfcomm listen command, 
instead of the connect?&nbsp; Is there an easier way to do what I need to get 
done, using already created tools I don't know about?&nbsp; Do I need to run the 
sdptool and add the SP interface?&nbsp; Where are the doc's that explain how to 
use the rfcomm and sdptool utils -- the man pages have various 
information/knowledge gaps?</FONT></P>
<P dir=ltr style="MARGIN-RIGHT: 0px"><FONT face=Arial size=2>Thanks, 
<BR>Robert</FONT> </P></BODY></HTML>

------_=_NextPart_001_01C5C5DD.AC405A30--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
