Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: 2 Nov 2006 13:08:48 -0000
Message-ID: <20061102130848.26974.qmail@webmail58.rediffmail.com>
MIME-Version: 1.0
From: "Rupesh Gujare" <rupesh_gujare@rediffmail.com>
To: bluez-devel@lists.sourceforge.net
Cc: Peter Wippich <pewi@gw-instruments.de>
Subject: Re: [Bluez-devel] Need Help In SDP Programming......
Reply-To: Rupesh Gujare <rupesh_gujare@rediffmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1357633111=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 This is a multipart mime message


--===============1357633111==
Content-type: multipart/alternative;
	boundary="Next_1162472928---0-202.54.124.239-26971"

 This is a multipart mime message


--Next_1162472928---0-202.54.124.239-26971
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  =0AThanks Peter, =0A  Currently i am testing this code on desktop. withou=
t any multiple threads. But in future i need to port it on embedded device =
with multiple threads. =0A Please do let me know if i can do it with latest=
 kernel.=0A So any of your experience will be of great help for me.=0A Than=
ks and regards.=0A Rupesh=0A=0AOn Thu, 02 Nov 2006 Peter Wippich wrote :=0A=
>=0A>Hello Rupesh,=0A>=0A>On Thu, 2 Nov 2006, Rupesh Gujare wrote:=0A>=0A> =
>=0A> > Thanks Peter and Mingfan for your suggestions and code review. I wi=
ll=0A> > definately try to improve on it.=0A> >   I am currently working on=
 2.6.15 kernel. and had not applied any patch.=0A> >  I will like to ask pe=
ter that which kernel you are using? Are you facing same problem after patc=
hing to latest kernel?=0A> >   Do let me know.=0A> >   Thanks and regards.=
=0A> >  Rupesh=0A>=0A>The concurrency problem Mingfan talked about is not w=
hat causes your=0A>problem. This would only show up when you use multiple t=
hreads to do=0A>concurrent SDP connections, and you use a single thread.=0A=
>=0A>I observed something similar as you with an unpatched 2.6.14 kernel.=
=0A>Because this was on an embedded platform I have not tried newer version=
s=0A>(this simply causes to much work just for a try).=0A>=0A>Ciao,=0A>=0A>=
Peter=0A>=0A>=0A>|       Peter Wippich                   Voice: +49 30 4677=
6411          |=0A>|       G&W Instruments GmbH            fax:   +49 30 46=
776419          |=0A>|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw=
-instruments.de   |=0A>|       D-13355 Berlin  / Germany                   =
                    |=0A>=0A
--Next_1162472928---0-202.54.124.239-26971
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0AThanks Peter, <BR>=0A&nbsp; Currently i am testing this=
 code on desktop. without any multiple threads. But in future i need to por=
t it on embedded device with multiple threads. <BR>=0A Please do let me kno=
w if i can do it with latest kernel.<BR>=0A So any of your experience will =
be of great help for me.<BR>=0A Thanks and regards.<BR>=0A Rupesh<BR>=0A<BR=
>=0AOn Thu, 02 Nov 2006 Peter Wippich wrote :<BR>=0A&gt;<BR>=0A&gt;Hello Ru=
pesh,<BR>=0A&gt;<BR>=0A&gt;On Thu, 2 Nov 2006, Rupesh Gujare wrote:<BR>=0A&=
gt;<BR>=0A&gt; &gt;<BR>=0A&gt; &gt; Thanks Peter and Mingfan for your sugge=
stions and code review. I will<BR>=0A&gt; &gt; definately try to improve on=
 it.<BR>=0A&gt; &gt;&nbsp;  I am currently working on 2.6.15 kernel. and ha=
d not applied any patch.<BR>=0A&gt; &gt;&nbsp; I will like to ask peter tha=
t which kernel you are using? Are you facing same problem after patching to=
 latest kernel?<BR>=0A&gt; &gt;&nbsp;  Do let me know.<BR>=0A&gt; &gt;&nbsp=
;  Thanks and regards.<BR>=0A&gt; &gt;&nbsp; Rupesh<BR>=0A&gt;<BR>=0A&gt;Th=
e concurrency problem Mingfan talked about is not what causes your<BR>=0A&g=
t;problem. This would only show up when you use multiple threads to do<BR>=
=0A&gt;concurrent SDP connections, and you use a single thread.<BR>=0A&gt;<=
BR>=0A&gt;I observed something similar as you with an unpatched 2.6.14 kern=
el.<BR>=0A&gt;Because this was on an embedded platform I have not tried new=
er versions<BR>=0A&gt;(this simply causes to much work just for a try).<BR>=
=0A&gt;<BR>=0A&gt;Ciao,<BR>=0A&gt;<BR>=0A&gt;Peter<BR>=0A&gt;<BR>=0A&gt;<BR=
>=0A&gt;|&nbsp; &nbsp; &nbsp;  Peter Wippich&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;  Voice: +49 30 46776411&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; |<BR>=0A&gt;|&nbsp; &nbsp; &nbsp;  G&amp;W Instruments GmbH&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fax:&nbsp;  +49 30 46776419&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; |<BR>=0A&gt;|&nbsp; &nbsp; &nbsp;  Gustav-Meyer=
-Allee 25, Geb. 12&nbsp; Email: pewi@gw-instruments.de&nbsp;  |<BR>=0A&gt;|=
&nbsp; &nbsp; &nbsp;  D-13355 Berlin&nbsp; / Germany&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  |<BR>=0A&gt;<BR>=0A=0A</P>=0A<br><br>=
=0A<a href=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.re=
diff.com/signature-home.htm/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D"htt=
p://adworks.rediff.com/cgi-bin/AdWorks/sigimpress.cgi/www.rediff.com/signat=
ure-home.htm/1963059423@Middle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D0 VS=
PACE=3D0 HSPACE=3D0></a>=0A
--Next_1162472928---0-202.54.124.239-26971--



--===============1357633111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1357633111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1357633111==--
