Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9d47cfd0512061151xc2cf038sd7def9e9035fb465@mail.gmail.com>
From: Abu hasnat Sayem <ahsayem@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Encryption
In-Reply-To: <ef9938ec0512050819s3a34e44fic3256a56fdda3907@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4593_16188624.1133898667441"
References: <9d47cfd0512011325x4de6e0a6wbd78806c2072dc5f@mail.gmail.com>
	 <1133500233.15695.3.camel@panic>
	 <9d47cfd0512050808y8eee708maa10fca8f1cc7f4a@mail.gmail.com>
	 <ef9938ec0512050819s3a34e44fic3256a56fdda3907@mail.gmail.com>
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
Date: Tue, 6 Dec 2005 13:51:07 -0600

------=_Part_4593_16188624.1133898667441
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I had tried using dund with the following two commands for authentication
and encription: dund -i hci0 -s -A -E
dund -i hci1 -c <bdaddr(hci0)>
For some reason it is not connecting...I ran hcidump on hci0
Let me know if I am not doing it right..do ihave initiate something else
before using dund..

Abu


On 12/5/05, Albert Huang <ashuang@gmail.com> wrote:
>
> replace L2CAP_LM_ENCRYPT with RFCOMM_LM_ENCRYPT, etc...
> also see dund
>
> -albert
>
> On 12/5/05, Abu hasnat Sayem <ahsayem@gmail.com> wrote:
> >
> > Collin,
> >
> > pand does it at the L2CAP level, i am working to provide encryption at
> > the RFCOMM level..
> > Is it possible to do so via some function calls...
> >
> > Abu
> >
> >
> >  On 12/1/05, Collin R. Mulliner <collin@betaversion.net > wrote:
> > >
> > > Hi Abu,
> > >
> > > On Thu, 2005-12-01 at 15:25 -0600, Abu hasnat Sayem wrote:
> > > > I am working on doing Encryption and Authentication at the RFCOMM
> > > and
> > > > L2CAP level using BlueZ. I would like to know if there exists
> > > certain
> > > > function calls to accompolish it or i have to incorporate new code
> > > in
> > > > it.
> > >
> > > this is done via setsockopt(2), take a look at:
> > > /usr/src/bluez-utils-2.22/pand/main.c (search for SECURE)
> > >
> > > or check sobexsrv (http://www.mulliner.org/bluetooth/sobexsrv.php )
> > >
> > > ... Collin
> > >
> > > --
> > > Collin R. Mulliner <collin@betaversion.net>
> > > BETAVERSiON Systems [ www.betaversion.net]
> > > info/pgp: finger collin@betaversion.net
> > > Don't talk just code!
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.net email is sponsored by: Splunk Inc. Do you grep through lo=
g
> > > files
> > > for problems?  Stop!  Download the new AJAX search engine that makes
> > > searching your log files as easy as surfing the  web.  DOWNLOAD
> > > SPLUNK!
> > > http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> >
> >
>

------=_Part_4593_16188624.1133898667441
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I had tried using dund with the following two commands for authentication a=
nd encription:=20
<div>dund -i hci0 -s -A -E</div>
<div>dund -i hci1 -c &lt;bdaddr(hci0)&gt;</div>
<div>For some reason it is not connecting...I ran hcidump on hci0</div>
<div>Let me know if I am not doing it right..do ihave initiate something el=
se before using dund..</div>
<div>&nbsp;</div>
<div>Abu</div><span></span><br><br>
<div><span class=3D"gmail_quote">On 12/5/05, <b class=3D"gmail_sendername">=
Albert Huang</b> &lt;<a href=3D"mailto:ashuang@gmail.com">ashuang@gmail.com=
</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">replace L2CAP_LM_ENCRYPT with RF=
COMM_LM_ENCRYPT, etc...<br>also see dund<br><span class=3D"sg"><br>-albert<=
/span>
=20
<div><span class=3D"e" id=3D"q_107fbb92212facdf_2"><br><br>
<div><span class=3D"gmail_quote">On 12/5/05, <b class=3D"gmail_sendername">=
Abu hasnat Sayem</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,eve=
nt,this)" href=3D"mailto:ahsayem@gmail.com" target=3D"_blank">ahsayem@gmail=
.com</a>
&gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0=
pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">
<div>Collin,</div>
<div>&nbsp;</div>
<div>pand does it at the L2CAP level, i am working to provide encryption at=
 the RFCOMM level..</div>
<div>Is it possible to do so via some function calls...</div><span>
<div>&nbsp;</div>
<div>Abu<br><br>&nbsp;</div></span>
<div><span>
<div><span class=3D"gmail_quote">On 12/1/05, <b class=3D"gmail_sendername">=
Collin R. Mulliner</b> &lt;<a onclick=3D"return top.js.OpenExtLink(window,e=
vent,this)" href=3D"mailto:collin@betaversion.net" target=3D"_blank">collin=
@betaversion.net=20
</a>&gt; wrote:</span>=20
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">Hi Abu,<br><br>On Th=
u, 2005-12-01 at 15:25 -0600, Abu hasnat Sayem wrote:<br>&gt; I am working =
on doing Encryption and Authentication at the RFCOMM and=20
<br>&gt; L2CAP level using BlueZ. I would like to know if there exists cert=
ain<br>&gt; function calls to accompolish it or i have to incorporate new c=
ode in<br>&gt; it.<br><br>this is done via setsockopt(2), take a look at:=
=20
<br>/usr/src/bluez-utils-2.22/pand/main.c (search for SECURE)<br><br>or che=
ck sobexsrv (<a onclick=3D"return top.js.OpenExtLink(window,event,this)" hr=
ef=3D"http://www.mulliner.org/bluetooth/sobexsrv.php" target=3D"_blank">htt=
p://www.mulliner.org/bluetooth/sobexsrv.php=20
</a>)<br><br>... Collin<br><br>--<br>Collin R. Mulliner &lt;<a onclick=3D"r=
eturn top.js.OpenExtLink(window,event,this)" href=3D"mailto:collin@betavers=
ion.net" target=3D"_blank">collin@betaversion.net</a>&gt;<br>BETAVERSiON Sy=
stems [
<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://=
www.betaversion.net/" target=3D"_blank"> www.betaversion.net</a>]<br>info/p=
gp: finger <a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=
=3D"mailto:collin@betaversion.net" target=3D"_blank">
collin@betaversion.net</a><br>Don't talk just code!<br><br><br><br>--------=
-----------------------------------------------<br>This SF.net email is spo=
nsored by: Splunk Inc. Do you grep through log files<br>for problems?&nbsp;=
&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search engine that makes=20
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a onclick=3D"return top.js.OpenExtLink(window,even=
t,this)" href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp=
;op=3Dclick" target=3D"_blank">
http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a><b=
r>_______________________________________________<br>Bluez-devel mailing li=
st<br><a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"m=
ailto:Bluez-devel@lists.sourceforge.net" target=3D"_blank">
Bluez-devel@lists.sourceforge.net </a><br><a onclick=3D"return top.js.OpenE=
xtLink(window,event,this)" href=3D"https://lists.sourceforge.net/lists/list=
info/bluez-devel" target=3D"_blank">https://lists.sourceforge.net/lists/lis=
tinfo/bluez-devel
</a><br></blockquote></div><br></span></div></blockquote></div><br></span><=
/div></blockquote></div><br>

------=_Part_4593_16188624.1133898667441--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
