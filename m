Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB79190470938E6@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Bluez-devel@lists.sourceforge.net'"
	 <Bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C40122.73CF7C70"
Subject: [Bluez-devel] hciattach killed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 3 Mar 2004 14:21:35 +0100

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C40122.73CF7C70
Content-Type: text/plain

Hi,
 
I run Bluez (PAN) on an arm processor device with a kernel with all bluez
drivers built-in.
I can perfectly PAN (ping, ftp, etc.) with other devices.
 
The problem is now, when I stop any program  (l2ping, ping or higher
application e.g. upnp)
with <Ctrl-C>,  the BT chip is always detached :
"hciconfig" shows only 00:00:00:00:00:00 MAC-adress
I have to hciattach again.
If I stop programs regular, e.g. ftp with "quit", then it is NOT detached,
only
Crtl-C causes the problem.
(I also observed similar "automatic detach" when devices (e.g. a Zaurus) go
into power save 
mode, but I think this is due to a voltage drop at the BT chip, which Ctrl-C
shouldnt
cause.)
 
I didnt experience this on arm processor devices, where the bluez modules
(l2cap,
hci_uart, bnep) havent been built in, so my only idea at the moment is, that
the
problem is due to the fact, that all is built-in. Can it be, that killing a
program 
with Ctrl-C kills also a socket / port / whatever  used by the
build-in-hciattach. 
 
Do you have any idea?
 
Kind regards, Matthias
 

------_=_NextPart_001_01C40122.73CF7C70
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<TITLE>Nachricht</TITLE>

<META content="MSHTML 6.00.2800.1400" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2><SPAN 
class=203412712-03032004>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=203412712-03032004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>I&nbsp;run Bluez 
(PAN) on an arm processor device </SPAN></FONT><FONT face=Arial size=2><SPAN 
class=203412712-03032004><FONT size=2>with a kernel with all bluez drivers 
built-in.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004><FONT 
size=2>I&nbsp;can&nbsp;perfectly PAN (ping, ftp, etc.)&nbsp;with other 
devices.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004></SPAN></FONT><FONT 
face=Arial size=2><SPAN class=203412712-03032004><FONT 
size=2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>The problem is now, 
when I stop any program&nbsp;&nbsp;(l2ping, ping or higher application e.g. 
upnp)</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>with 
&lt;Ctrl-C&gt;,&nbsp;</SPAN></FONT><FONT face=Arial size=2><SPAN 
class=203412712-03032004> the BT chip is always detached :</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>"hciconfig" shows 
only 00:00:00:00:00:00 MAC-adress</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004><FONT size=2>I have 
to hciattach again.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004><FONT size=2>If I 
stop programs regular, e.g. ftp&nbsp;with&nbsp;"quit", then it is NOT detached, 
only</FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>Crtl-C causes the 
problem.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004></SPAN></FONT><FONT 
face=Arial size=2><SPAN class=203412712-03032004>(I also observed similar 
"automatic detach" when devices (e.g. a Zaurus) go into power save 
</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>mode, but I think 
this is due to <FONT face="Times New Roman" size=3>a voltage drop at the BT 
chip, which Ctrl-C shouldnt</FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=203412712-03032004>cause.)</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=203412712-03032004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004><FONT size=2>I didnt 
experience this on arm processor devices, where the bluez modules 
(l2cap,</FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>hci_uart, bnep) 
havent been built in, so my only idea at the moment is, 
that&nbsp;the</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>problem&nbsp;is 
</SPAN></FONT><FONT face=Arial size=2><SPAN class=203412712-03032004>due to the 
fact, that all&nbsp;is</SPAN></FONT><FONT face=Arial size=2><SPAN 
class=203412712-03032004><FONT size=2> built-in. Can it be, that killing a 
program </FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004><FONT size=2>with 
Ctrl-C kills also a socket / port / whatever&nbsp; used by the 
build-in-</FONT></SPAN></FONT><FONT face=Arial size=2><SPAN 
class=203412712-03032004><FONT size=2>hciattach. </FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=203412712-03032004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004></SPAN></FONT><FONT 
face=Arial size=2><SPAN class=203412712-03032004><FONT size=2>Do you have any 
idea?</DIV></FONT></SPAN></FONT>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=203412712-03032004>Kind regards, 
Matthias</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C40122.73CF7C70--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
