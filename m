Return-Path: <bluez-users-admin@lists.sourceforge.net>
In-Reply-To: <40365D60.7070208@itelefonica.com.br>
To: Daniel Moraes <ra002890@itelefonica.com.br>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] CSR experimental uart board!
MIME-Version: 1.0
Message-ID: <OF40F49FA9.701D9ADF-ON85256E40.00768FF6-85256E40.007698DC@alps_aai.com>
From: scott.meesseman@alpsautomotive.com
Content-Type: multipart/alternative; boundary="=_alternative 007698DA85256E40_="
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
Date: Fri, 20 Feb 2004 16:35:23 -0500

This is a multipart message in MIME format.
--=_alternative 007698DA85256E40_=
Content-Type: text/plain; charset="US-ASCII"

For BCSP try hciattach /dev/ttyS0 bcsp 115200 flow

or for H4

hciattach /dev/ttyS0 any 115200 flow

Regards,
Scott







Daniel Moraes <ra002890@itelefonica.com.br>
Sent by: bluez-users-admin@lists.sourceforge.net
02/20/2004 04:17 PM
 
        To:     bluez-users@lists.sourceforge.net
        cc: 
        Subject:        [Bluez-users] CSR experimental uart board!


Hello everybody! I have a experimental CSR dongle on my hands and I have 
to put 
it to work with linux bluez! But my problem is: what configuration bluez 
uses?!
It works with BCSP or I need to use H4 Link on my board?!? I m trying to 
use BCSP 
but it not works at all... Please, someone can help me.... 
When I put " hciattach /dev/ttyS0 csr 115200 flow " I receive a timeout 
message!
Someone have a CSR developer board and have installed it all right. A 
tutorial would be so nice to me....

Thanks a lot, Daniel Moraes! 





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


--=_alternative 007698DA85256E40_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">For BCSP try </font><font size=2><tt>hciattach
/dev/ttyS0 bcsp 115200 flow</tt></font>
<br>
<br><font size=2><tt>or for H4</tt></font>
<br>
<br><font size=2><tt>hciattach /dev/ttyS0 any 115200 flow</tt></font>
<br>
<br><font size=2 face="sans-serif">Regards,<br>
Scott</font>
<br>
<br><font size=2 face="sans-serif"><br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>Daniel Moraes &lt;ra002890@itelefonica.com.br&gt;</b></font>
<br><font size=1 face="sans-serif">Sent by: bluez-users-admin@lists.sourceforge.net</font>
<p><font size=1 face="sans-serif">02/20/2004 04:17 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;bluez-users@lists.sourceforge.net</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;[Bluez-users] CSR experimental uart
board!</font></table>
<br>
<br>
<br><font size=2><tt>Hello everybody! I have a experimental CSR dongle
on my hands and I have to put <br>
it to work with linux bluez! But my problem is: what configuration bluez
<br>
uses?!<br>
It works with BCSP or I need to use H4 Link on my board?!? I m trying to
use BCSP <br>
but it not works at all... Please, someone can help me.... <br>
When I put &quot; hciattach /dev/ttyS0 csr 115200 flow &quot; I receive
a timeout message!<br>
Someone have a CSR developer board and have installed it all right. A tutorial
would be so nice to me....<br>
<br>
Thanks a lot, Daniel Moraes! <br>
<br>
<br>
<br>
<br>
<br>
-------------------------------------------------------<br>
SF.Net is sponsored by: Speed Start Your Linux Apps Now.<br>
Build and deploy apps &amp; Web services for Linux with<br>
a free DVD software kit from IBM. Click Now!<br>
http://ads.osdn.com/?ad_id=1356&amp;alloc_id=3438&amp;op=click<br>
_______________________________________________<br>
Bluez-users mailing list<br>
Bluez-users@lists.sourceforge.net<br>
https://lists.sourceforge.net/lists/listinfo/bluez-users<br>
</tt></font>
<br>
--=_alternative 007698DA85256E40_=--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
