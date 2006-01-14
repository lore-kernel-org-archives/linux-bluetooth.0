Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY103-W1359B937207E9B8FA1D47F7190@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_db179157-60cf-42f7-8088-d3661d02a44c_"
From: "Verber Seti" <verber_s@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: Re: [Bluez-users] sendto give invalid argument
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
Date: Fri, 13 Jan 2006 19:23:21 -0500

--_db179157-60cf-42f7-8088-d3661d02a44c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the help Paul,
=A0
Unfortunately, for reasons outside the scope of this email I am restricted =
to using=20
SOCK_DGRAM only for this program instead of=A0SOCK_SEQPACKET or any other v=
alues.
=A0
Thanks again,=20
verber



> From: shackan@gmail.com> To: bluez-users@lists.sourceforge.net> Subject: =
Re: [Bluez-users] sendto give invalid argument> Date: Sat, 14 Jan 2006 00:3=
2:07 +0100> > I didn't look very carefully at your code, but the first thin=
g I> noticed is how you create the socket, I wrote a C++ wrapper over bluez=
> a while ago and it has a class for L2Cap connections, the constructor> go=
es this way:> > L2CapSocket::L2CapSocket()> : Socket( PF_BLUETOOTH, SOCK_SE=
QPACKET, BTPROTO_L2CAP )> {}> > and it worked great for me, so maybe you sh=
ould pass different> parameters to the socket(...); call.> > regards,> Paul=
> > > -------------------------------------------------------> This SF.net =
email is sponsored by: Splunk Inc. Do you grep through log files> for probl=
ems? Stop! Download the new AJAX search engine that makes> searching your l=
og files as easy as surfing the web. DOWNLOAD SPLUNK!> http://ads.osdn.com/=
?ad_idv37&alloc_id=16865&op=3Dick> ________________________________________=
_______> Bluez-users mailing list> Bluez-users@lists.sourceforge.net> https=
://lists.sourceforge.net/lists/listinfo/bluez-users
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=

--_db179157-60cf-42f7-8088-d3661d02a44c_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>=0A=
<head>=0A=
<style>=0A=
P=0A=
{=0A=
margin:0px;=0A=
padding:0px=0A=
}=0A=
body=0A=
{=0A=
FONT-SIZE: 10pt;=0A=
FONT-FAMILY:Tahoma=0A=
}=0A=
</style>=0A=
</head>=0A=
<body><P >Thanks for the help Paul,</P>
<P >&nbsp;</P>
<P >Unfortunately, for <FONT class=3D"" >reasons outside the scope of this =
email I am restricted to <FONT class=3D"" >using </P>
<P ><FONT class=3D"" >SOCK_DGRAM</FONT> only for this program instead of&nb=
sp;<FONT class=3D"" ><FONT class=3D"" >SOCK_SEQPACKET</FONT> or any other v=
alues.</FONT></FONT></FONT></P>
<P >&nbsp;</P>
<P >Thanks again, </P>
<P ><FONT class=3D"">verber</FONT><BR ><BR ></P>
<P>
<HR id=3DstopSpelling>
</P>
<P>&gt; From: shackan@gmail.com<BR>&gt; To: bluez-users@lists.sourceforge.n=
et<BR>&gt; Subject: Re: [Bluez-users] sendto give invalid argument<BR>&gt; =
Date: Sat, 14 Jan 2006 00:32:07 +0100<BR>&gt; <BR>&gt; I didn't look very c=
arefully at your code, but the first thing I<BR>&gt; noticed is how you cre=
ate the socket, I wrote a C++ wrapper over bluez<BR>&gt; a while ago and it=
 has a class for L2Cap connections, the constructor<BR>&gt; goes this way:<=
BR>&gt; <BR>&gt; L2CapSocket::L2CapSocket()<BR>&gt; : Socket( PF_BLUETOOTH,=
 <FONT class=3D"">SOCK_SEQPACKET</FONT>, BTPROTO_L2CAP )<BR>&gt; {}<BR>&gt;=
 <BR>&gt; and it worked great for me, so maybe you should pass different<BR=
>&gt; parameters to the socket(...); call.<BR>&gt; <BR>&gt; regards,<BR>&gt=
; Paul<BR>&gt; <BR>&gt; <BR>&gt; ------------------------------------------=
-------------<BR>&gt; This SF.net email is sponsored by: Splunk Inc. Do you=
 grep through log files<BR>&gt; for problems? Stop! Download the new AJAX s=
earch engine that makes<BR>&gt; searching your log files as easy as surfing=
 the web. DOWNLOAD SPLUNK!<BR>&gt; http://ads.osdn.com/?ad_idv37&amp;alloc_=
id=16865&amp;op=3Dick<BR>&gt; _____________________________________________=
__<BR>&gt; Bluez-users mailing list<BR>&gt; Bluez-users@lists.sourceforge.n=
et<BR>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></P>=
<br /><hr />Express yourself instantly with MSN Messenger! <a href=3D'http:=
//clk.atdmt.com/AVE/go/onm00200471ave/direct/01/' target=3D'_new'>MSN Messe=
nger</a></body>=0A=
</html>=

--_db179157-60cf-42f7-8088-d3661d02a44c_--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
