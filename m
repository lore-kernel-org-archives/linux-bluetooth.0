Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB7919047093972@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Bluez-devel@lists.sourceforge.net'"
	 <Bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4426D.5B442E80"
Subject: [Bluez-devel] pand + socket filtering on zaurus
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
Date: Tue, 25 May 2004 17:31:32 +0200

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4426D.5B442E80
Content-Type: text/plain

Hi,
 
I am running bluez / bnep / pan on a zaurus; it works fine.
 
But thenI needed to change my kernel (zImage) to get some other software
running: 
I had to build in the Socket Filtering    (make menuconfig: Networking
Options -> Socket Filtering).
This was the only change I did to the kernel.
 
With the new kernel, pand has some problems: I can "pand -s" ( remote
station does "pand -c <MAC>").
They can ping. but when the connection is terminated ("pand -K"), no matter
from which station,
the zaurus gets frozen. I have to reboot the zaurus.
Also, I cannot "pand -c <MAC>" from the zaurus side, which works fine
without the "Socket Filtering" .
 
This problem occurs only on zaurus. On my desktop the Socket Filtering
doesnt interfere with pand.
But there, I have a completely different kernel (2.4.19) than on zaurus
(2.4.6), with a different set of 
kernel build-ins
Does anybody know, whether "Socket Filtering" requires or forbids some other
kernel build-ins, 
in order to work with pand ?
 
Any comments on this are welcome. Thanks, Matthias
 
 
 
 
 
 

------_=_NextPart_001_01C4426D.5B442E80
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<TITLE>Nachricht</TITLE>

<META content="MSHTML 6.00.2800.1400" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>I am running bluez / 
bnep / pan on a zaurus; it works fine.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>But thenI needed to 
change my kernel (zImage) to get some other software running: 
</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>I had to build in 
the Socket Filtering&nbsp;&nbsp;&nbsp; </SPAN></FONT><FONT face=Arial 
size=2><SPAN class=683561915-25052004>(make menuconfig: Networking Options -&gt; 
Socket Filtering).</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>This was the only 
change I did to the kernel.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>With the new kernel, 
pand has some problems: I can "pand -s" ( remote station does "pand -c 
&lt;MAC&gt;").</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>They can ping. but 
when the connection is terminated ("pand -K"), no matter from which 
station,</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>the zaurus gets 
frozen. I have to reboot the zaurus.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>Also, I cannot "pand 
-c &lt;MAC&gt;" from the zaurus side, which works fine without the "Socket 
Filtering" .</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>This problem occurs 
only on zaurus. On my desktop the Socket Filtering doesnt interfere with 
pand.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>But there, I have a 
completely different kernel (2.4.19) than on zaurus (2.4.6), with 
a&nbsp;different set of </SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>kernel 
build-ins</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004></SPAN></FONT><FONT 
face=Arial size=2><SPAN class=683561915-25052004>Does anybody know, whether 
"Socket Filtering" requires or <FONT face=Arial size=2><SPAN 
class=683561915-25052004>forbids some other kernel build-ins, 
</SPAN></FONT></SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004><FONT face=Arial 
size=2><SPAN class=683561915-25052004>in order to work with pand 
?</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV></SPAN></FONT>
<DIV><FONT face=Arial size=2><SPAN class=683561915-25052004>Any comments on this 
are welcome. </SPAN></FONT><FONT face=Arial size=2><SPAN 
class=683561915-25052004>Thanks, Matthias</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=683561915-25052004></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C4426D.5B442E80--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
