Return-Path: <Neil@OnDrugs.co.nz>
Subject: Re: [Bluez-devel] Logitech MX900 Hub + i-mate smartphone2
From: Neil Fenemor <Neil@OnDrugs.co.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1088030296.4296.14.camel@pegasus>
References: <1088029361.3703.17.camel@localhost.localdomain>
	 <1088030296.4296.14.camel@pegasus>
Content-Type: multipart/alternative; boundary="=-7RkPpufl9WrmcovDzHNG"
Message-Id: <1088031049.3703.28.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 24 Jun 2004 10:50:49 +1200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-7RkPpufl9WrmcovDzHNG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

append to the end of the hcidump the following:

< HCI Command: Read Local Name(0x03|0x0014) plen 0
> HCI Event: Command Complete(0x0e) plen 252
  01 14 0C 00 4C 61 70 74 6F 70 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
  00 00 00 00 00 00 00 00 00 00 00 00 
< HCI Command: Read Class of Device(0x03|0x0023) plen 0
> HCI Event: Command Complete(0x0e) plen 7
  01 23 0C 00 05 01 12 
< HCI Command: Read Local Version Information(0x04|0x0001) plen 0
> HCI Event: Command Complete(0x0e) plen 12
  01 01 10 00 01 4E 03 01 0A 00 4E 03 


On Thu, 2004-06-24 at 10:38, Marcel Holtmann wrote:

> Hi Neil,
> 
> choose one mailing list, because I hate cross-postings.
> 
> > I'm trying to get my MX900 Hub and my i-mate smartphone2 to place
> > nicely together, but so far, I haven't had much luck on that front.
> > The smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you
> > prefer to call it. The phone is also called a Orange SPV E200 for
> > those on that network.
> 
> Send us the information about your phone from "hcitool info <bdaddr>".
> 
> > I can get rfcomm stuff to work fine with other phones, so I believe it
> > is the phone itself at fault. The end result that I'm after, is to be
> > able to sync with my phone, and also surf from my laptop via GPRS. The
> > time frame I'm trying t work within is of course tight, as I'm needed
> > this next week for while I'm away. 
> > 
> > When all connected, peered, etc, and it looks successful, I get odd
> > things like the following.
> > 
> > [root@localhost neil]# cat /dev/rfcomm0
> > cat: /dev/rfcomm0: Connection reset by peer
> > [root@localhost neil]# 
> > 
> > I've put the hcidump information at the bottom of the e-mail.
> 
> Do it again, but this time with -x or send us the binary dump.
> 
> > I'm also having problems with the ActiveSync facilities on the phone,
> > as when I try the "BT ActiveSync" it comes up with "Please bond with
> > other Bluetooth device which supports serial port or ActiveSync
> > profile as your ActiveSync partner!"
> 
> >From the dump I saw that you use security mode 3. Do you enabled auth
> and encrypt in hcid.conf? Don't do so. Show us "hciconfig -a".
> 
> Regards
> 
> Marcel
> 

--=-7RkPpufl9WrmcovDzHNG
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
append to the end of the hcidump the following:<BR>
<BR>
&lt; HCI Command: Read Local Name(0x03|0x0014) plen 0<BR>
&gt; HCI Event: Command Complete(0x0e) plen 252<BR>
&nbsp; 01 14 0C 00 4C 61 70 74 6F 70 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&nbsp; 00 00 00 00 00 00 00 00 00 00 00 00 <BR>
&lt; HCI Command: Read Class of Device(0x03|0x0023) plen 0<BR>
&gt; HCI Event: Command Complete(0x0e) plen 7<BR>
&nbsp; 01 23 0C 00 05 01 12 <BR>
&lt; HCI Command: Read Local Version Information(0x04|0x0001) plen 0<BR>
&gt; HCI Event: Command Complete(0x0e) plen 12<BR>
&nbsp; 01 01 10 00 01 4E 03 01 0A 00 4E 03 <BR>
<BR>
<BR>
On Thu, 2004-06-24 at 10:38, Marcel Holtmann wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Hi Neil,

choose one mailing list, because I hate cross-postings.

&gt; I'm trying to get my MX900 Hub and my i-mate smartphone2 to place
&gt; nicely together, but so far, I haven't had much luck on that front.
&gt; The smartphone2 FYI runs Windows Mobile 2003, or CE4, which ever you
&gt; prefer to call it. The phone is also called a Orange SPV E200 for
&gt; those on that network.

Send us the information about your phone from &quot;hcitool info &lt;bdaddr&gt;&quot;.

&gt; I can get rfcomm stuff to work fine with other phones, so I believe it
&gt; is the phone itself at fault. The end result that I'm after, is to be
&gt; able to sync with my phone, and also surf from my laptop via GPRS. The
&gt; time frame I'm trying t work within is of course tight, as I'm needed
&gt; this next week for while I'm away. 
&gt; 
&gt; When all connected, peered, etc, and it looks successful, I get odd
&gt; things like the following.
&gt; 
&gt; [root@localhost neil]# cat /dev/rfcomm0
&gt; cat: /dev/rfcomm0: Connection reset by peer
&gt; [root@localhost neil]# 
&gt; 
&gt; I've put the hcidump information at the bottom of the e-mail.

Do it again, but this time with -x or send us the binary dump.

&gt; I'm also having problems with the ActiveSync facilities on the phone,
&gt; as when I try the &quot;BT ActiveSync&quot; it comes up with &quot;Please bond with
&gt; other Bluetooth device which supports serial port or ActiveSync
&gt; profile as your ActiveSync partner!&quot;

&gt;From the dump I saw that you use security mode 3. Do you enabled auth
and encrypt in hcid.conf? Don't do so. Show us &quot;hciconfig -a&quot;.

Regards

Marcel
</I></FONT></PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-7RkPpufl9WrmcovDzHNG--
