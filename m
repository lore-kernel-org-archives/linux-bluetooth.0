Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY1-DAV1776C899FF3D88A4F64F79AAAD0@phx.gbl>
From: "Krishna" <kkb25@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C4E2D2.651E7180"
Subject: [Bluez-devel] RE: Question about role switch
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
Date: Wed, 15 Dec 2004 18:17:53 -0500

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C4E2D2.651E7180
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi, 
 
> Hi Krishna,
 
 > > Is there any way to do bi-directional Inquiry so that both the
inquiring and
 > >inquired (inquiry scanning) device/s get each others address and clock.
 
>  what do you want? You can"t get the address from the device that is
> inquiring you. You have to inquiry by yourself.
 
>  Regards
 
>  Marcel
 
Here is the situation: 
 
The host has two Bluetooth radios, 
Radio1: listening to inquiring devices  
Radio2: Connect or page devices (Inquiry is disabled on this one).
Lots of Mobile Devices: Looking for connection with the host
 
Radio1 would listen to inquiries and somehow!!! after getting addresses of
inquiring devices, would pass them onto Radio2, which would eventually page
the devices to connect.  What I would like to have is the mobile devices
looking for connection would initiate the inquiry but page would be
initiated by Radio2 on the host. This would require Radio1 to know the
address without doing inquiry (but only listening to inquiries)...  Is there
any way possible to achieve this?  Role switch attempt !? 
 
Thank you again for your invaluable help.
 
Krishna Bhoutika

------=_NextPart_000_0004_01C4E2D2.651E7180
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D245515922-15122004>Hi,=20
</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D245515922-15122004></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D245515922-15122004>&gt; </SPAN>Hi=20
Krishna,<BR>&nbsp;</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;<SPAN =
class=3D245515922-15122004>&gt;=20
</SPAN>&gt; Is there any way to do bi-directional Inquiry so that both =
the=20
inquiring and<BR>&nbsp;&gt;&nbsp;<SPAN=20
class=3D245515922-15122004>&gt;</SPAN>inquired (inquiry scanning) =
device/s get=20
each others address and clock.<BR>&nbsp;<BR><SPAN =
class=3D245515922-15122004>&gt;=20
</SPAN>&nbsp;what do you want? You can"t get the address from the device =
that=20
is<BR><SPAN class=3D245515922-15122004>&gt; </SPAN>inquiring you. You =
have to=20
inquiry by yourself.<BR>&nbsp;<BR><SPAN class=3D245515922-15122004>&gt;=20
</SPAN>&nbsp;Regards<BR>&nbsp;<BR><SPAN class=3D245515922-15122004>&gt;=20
</SPAN>&nbsp;Marcel</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial =
size=3D2>Here is the=20
situation: </FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial =
size=3D2>The host has=20
two Bluetooth radios, </FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial =
size=3D2>Radio1:=20
listening to inquiring devices&nbsp; </FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D245515922-15122004></SPAN></FONT><FONT><SPAN=20
class=3D245515922-15122004><FONT face=3DArial size=3D2>Radio2: Connect =
or page devices=20
(Inquiry is disabled on this one).</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245515922-15122004>Lots =
of Mobile=20
Devices: Looking for connection with the host</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245515922-15122004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D245515922-15122004>Radio1 =
would listen=20
to inquiries and somehow!!! after getting addresses of inquiring=20
devices,&nbsp;would pass them onto Radio2, which would =
eventually&nbsp;page the=20
devices to connect. &nbsp;What I would like to have is the mobile =
devices=20
looking for connection would initiate the inquiry but page would be =
initiated by=20
Radio2 on the host. This would require Radio1 to know the address =
without doing=20
inquiry (but only listening to inquiries)...&nbsp; Is there any way =
possible to=20
achieve this?&nbsp; Role switch attempt !? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D245515922-15122004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial =
size=3D2>Thank=20
you&nbsp;again for your invaluable help.</FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D245515922-15122004><FONT face=3DArial =
size=3D2>Krishna=20
Bhoutika</FONT></SPAN></DIV></FONT></BODY></HTML>

------=_NextPart_000_0004_01C4E2D2.651E7180--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
