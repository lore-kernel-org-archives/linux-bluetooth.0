Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ae97cd740510170300k3c5e6877o1bdc4d6f51834c9d@mail.gmail.com>
From: aCiDBiTS <acidbits@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: "Wrong data" from my BT GPS Roylatek
In-Reply-To: <20051015213050.GC12751@elmicha.333200002251-0001.dialin.t-online.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3115_25278946.1129543237940"
References: <ae97cd740510150951l76f4b0d3qe28795c25fe8411b@mail.gmail.com>
	 <20051015211946.GB12751@elmicha.333200002251-0001.dialin.t-online.de>
	 <20051015213050.GC12751@elmicha.333200002251-0001.dialin.t-online.de>
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
Date: Mon, 17 Oct 2005 12:00:37 +0200

------=_Part_3115_25278946.1129543237940
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/15/05, Michael Mauch <michael.mauch@gmx.de> wrote:
>
> I wrote:
>
> > (or google for NMEA-0182).
>
> Oops, that should have been NMEA-0183 or NMEA0183 or "NMEA 0183".
>
> http://faq.royaltek.com/phpBB2/viewtopic.php?p=3D25 suggests that you
> should send "$PSRF 100".
>

Finally I made it work ... well it was already working ... :-) Thanks to
your SiRF clue!

I wanted GPSD (gpsd.berlios.de <http://gpsd.berlios.de>) to read data from
my GPS reciever, and I found that it also process SiRF data. No need to
switch the GPS to NMEA mode. I was stuck in the point that I couldn't read
NMEA data from /dev/rfcomm0, and thought that gpsd would have the same
problem.

Anyway, it is possible to switch back to NMEA sending a SiRF command, it is
a binary string. If someone is interested google says there was a pdf manua=
l
in royaltek , not availible by now, but you can look at Google PDF->HTML
cache:

http://64.233.161.104/search?q=3Dcache:W2SCQz2NLwkJ:www.royaltek.com/Manual=
s/software%2520interface%25201.1(SIRF).pdf+sirf+command+nmea+mode+switch&hl=
=3Den&client=3Dfirefox

I wasn't able to switch it to NMEA sending this binary string through "cat
go2NMEAmode.dat > /dev/rfcomm0"

go2NMEAmode.dat 64 bytes long (Hex value):
A0 A2 00 18 81 02 01 01 00 01 05 01 05 01 00 01 00 01 00 01 00 01 00 01 00
01 1 2 C0 01 6A B0 B3

Thanks!

------=_Part_3115_25278946.1129543237940
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/15/05, <b class=3D"gmail_sendername">Michael Mauch</b> &lt;<a href=3D=
"mailto:michael.mauch@gmx.de">michael.mauch@gmx.de</a>&gt; wrote:<div><span=
 class=3D"gmail_quote"></span><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
I wrote:<br><br>&gt; (or google for NMEA-0182).<br><br>Oops, that should ha=
ve been NMEA-0183 or NMEA0183 or &quot;NMEA 0183&quot;.<br><br><a href=3D"h=
ttp://faq.royaltek.com/phpBB2/viewtopic.php?p=3D25">http://faq.royaltek.com=
/phpBB2/viewtopic.php?p=3D25
</a> suggests that you<br>should send &quot;$PSRF 100&quot;.<br></blockquot=
e></div><br>
Finally I made it work ... well it was already working ... :-) Thanks to yo=
ur SiRF clue!<br>
<br>
I wanted GPSD (<a href=3D"http://gpsd.berlios.de">gpsd.berlios.de</a>) to r=
ead data from my GPS reciever, and
I found that it also process SiRF data. No need to switch the GPS to
NMEA mode. I was stuck in the point that I couldn't read NMEA data from
/dev/rfcomm0, and thought that gpsd would have the same problem.<br>
<br>
Anyway, it is possible to switch back to NMEA sending a SiRF command,
it is a binary string. If someone is interested google says there was a
pdf manual in royaltek , not availible by now, but you can look at
Google PDF-&gt;HTML cache:<br>
<br>
<a href=3D"http://64.233.161.104/search?q=3Dcache:W2SCQz2NLwkJ:www.royaltek=
.com/Manuals/software%2520interface%25201.1(SIRF).pdf+sirf+command+nmea+mod=
e+switch&amp;hl=3Den&amp;client=3Dfirefox">http://64.233.161.104/search?q=
=3Dcache:W2SCQz2NLwkJ:www.royaltek.com/Manuals/software%2520interface%25201=
.1(SIRF).pdf+sirf+command+nmea+mode+switch&amp;hl=3Den&amp;client=3Dfirefox
</a><br>
<br>
I wasn't able to switch it to NMEA sending this binary string through &quot=
;cat go2NMEAmode.dat &gt; /dev/rfcomm0&quot;<br>
<br>
go2NMEAmode.dat 64 bytes long (Hex value):<br>
<font face=3D"Times" size=3D"3"><span style=3D"font-size: 11px; font-family=
: Times;">A0 A2 00 18 </span></font><font face=3D"Times" size=3D"3"><span s=
tyle=3D"font-size: 11px; font-family: Times;">81 02 01 01 00 01 05 01 05 01=
 00 01 00 01 00 01 00 01 0
</span></font><font face=3D"Times" size=3D"3"><span style=3D"font-size: 11p=
x; font-family: Times;">0 01 00 01 1 2 C0 </span></font><font face=3D"Times=
" size=3D"3"><span style=3D"font-size: 11px; font-family: Times;">01 6A B0 =
B3</span>
</font><br>
<br>
Thanks!<br>

------=_Part_3115_25278946.1129543237940--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
