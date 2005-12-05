Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9d47cfd0512050808y8eee708maa10fca8f1cc7f4a@mail.gmail.com>
From: Abu hasnat Sayem <ahsayem@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Encryption
In-Reply-To: <1133500233.15695.3.camel@panic>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_36336_31025273.1133798925948"
References: <9d47cfd0512011325x4de6e0a6wbd78806c2072dc5f@mail.gmail.com>
	 <1133500233.15695.3.camel@panic>
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
Date: Mon, 5 Dec 2005 10:08:45 -0600

------=_Part_36336_31025273.1133798925948
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Collin,

pand does it at the L2CAP level, i am working to provide encryption at the
RFCOMM level..
Is it possible to do so via some function calls...

Abu


On 12/1/05, Collin R. Mulliner <collin@betaversion.net> wrote:
>
> Hi Abu,
>
> On Thu, 2005-12-01 at 15:25 -0600, Abu hasnat Sayem wrote:
> > I am working on doing Encryption and Authentication at the RFCOMM and
> > L2CAP level using BlueZ. I would like to know if there exists certain
> > function calls to accompolish it or i have to incorporate new code in
> > it.
>
> this is done via setsockopt(2), take a look at:
> /usr/src/bluez-utils-2.22/pand/main.c (search for SECURE)
>
> or check sobexsrv (http://www.mulliner.org/bluetooth/sobexsrv.php)
>
> ... Collin
>
> --
> Collin R. Mulliner <collin@betaversion.net>
> BETAVERSiON Systems [www.betaversion.net]
> info/pgp: finger collin@betaversion.net
> Don't talk just code!
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_36336_31025273.1133798925948
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Collin,</div>
<div>&nbsp;</div>
<div>pand does it at the L2CAP level, i am working to provide encryption at=
 the RFCOMM level..</div>
<div>Is it possible to do so via some function calls...</div>
<div>&nbsp;</div>
<div>Abu<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 12/1/05, <b class=3D"gmail_sendername">=
Collin R. Mulliner</b> &lt;<a href=3D"mailto:collin@betaversion.net">collin=
@betaversion.net</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Abu,<br><br>On Thu, 2005-12-0=
1 at 15:25 -0600, Abu hasnat Sayem wrote:<br>&gt; I am working on doing Enc=
ryption and Authentication at the RFCOMM and
<br>&gt; L2CAP level using BlueZ. I would like to know if there exists cert=
ain<br>&gt; function calls to accompolish it or i have to incorporate new c=
ode in<br>&gt; it.<br><br>this is done via setsockopt(2), take a look at:
<br>/usr/src/bluez-utils-2.22/pand/main.c (search for SECURE)<br><br>or che=
ck sobexsrv (<a href=3D"http://www.mulliner.org/bluetooth/sobexsrv.php">htt=
p://www.mulliner.org/bluetooth/sobexsrv.php</a>)<br><br>... Collin<br><br>
--<br>Collin R. Mulliner &lt;<a href=3D"mailto:collin@betaversion.net">coll=
in@betaversion.net</a>&gt;<br>BETAVERSiON Systems [<a href=3D"http://www.be=
taversion.net">www.betaversion.net</a>]<br>info/pgp: finger <a href=3D"mail=
to:collin@betaversion.net">
collin@betaversion.net</a><br>Don't talk just code!<br><br><br><br>--------=
-----------------------------------------------<br>This SF.net email is spo=
nsored by: Splunk Inc. Do you grep through log files<br>for problems?&nbsp;=
&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;al=
loc_id=3D16865&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_=
id=3D16865&amp;op=3Dclick</a><br>
_______________________________________________<br>Bluez-devel mailing list=
<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_36336_31025273.1133798925948--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
