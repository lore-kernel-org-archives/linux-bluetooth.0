Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050406091011.21254.qmail@webmail29.rediffmail.com>
MIME-Version: 1.0
From: "vaishali  paisal" <vaishalipaisal@rediffmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Re: [Bluez-users] Can anybody help plz?
Content-type: multipart/alternative;
	boundary="Next_1112778611---0-203.199.83.37-21249"
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
Date: 6 Apr 2005 09:10:11 -0000

 This is a multipart mime message


--Next_1112778611---0-203.199.83.37-21249
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello there,=0A=0AThanks for the information.And i can now find out the ioc=
tl intearction stuff .But I think that RFCOMM layer is implemented as a ker=
nel module .So it should use the same EXPORT_SYMBOL() concept to communicat=
e with l2cap,why sockets?????=0AIs there any other way in which the kernel =
modules can interact among themselves?=0A=0ARegards=0Avaishali =A0=0A=0A=0A=
On Tue, 05 Apr 2005 Marcel Holtmann wrote :=0A>Hi,=0A>=0A> > I have a small=
 problem in understanding the blueZ source code for=0A> > kernel 2.6.11.I a=
m unable to find out exactly how the kernel=0A> > implementations of the l2=
cap layer,hcilayer and rfcomm layer are=0A> > interacting amongst themselve=
s ?As well as how they interact with the=0A> > user space libraries?=0A> >=
=0A> > I have seen some functions in l2cap.c calling functions from=0A> > h=
ci_core.c which have been put as EXPORT_SYMBOL() in hci_core.c.=0A> > Is it=
 the way they are communicating or am i missing something?=0A>=0A>the modul=
e interaction is done by the exported symbols as you already=0A>realized. T=
he upper layer modules like RFCOMM, BNEP etc. are using the=0A>L2CAP socket=
 interface inside the kernel. All userspace tools are using=0A>the ioctls a=
nd the socket interfaces.=0A>=0A>Regards=0A>=0A>Marcel=0A>=0A>=0A>=0A>=0A>-=
------------------------------------------------------=0A>SF email is spons=
ored by - The IT Product Guide=0A>Read honest & candid reviews on hundreds =
of IT Products from real users.=0A>Discover which products truly live up to=
 the hype. Start reading now.=0A>http://ads.osdn.com/?ad_id=3D6595&alloc_id=
=3D14396&op=3Dclick=0A>_______________________________________________=0A>B=
luez-users mailing list=0A>Bluez-users@lists.sourceforge.net=0A>https://lis=
ts.sourceforge.net/lists/listinfo/bluez-users=0A
--Next_1112778611---0-203.199.83.37-21249
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHello there,<BR>=0A<BR>=0AThanks for the information.And i can now fi=
nd out the ioctl intearction stuff .But I think that RFCOMM layer is implem=
ented as a kernel module .So it should use the same EXPORT_SYMBOL() concept=
 to communicate with l2cap,why sockets?????<BR>=0AIs there any other way in=
 which the kernel modules can interact among themselves?<BR>=0A<BR>=0ARegar=
ds<BR>=0Avaishali&nbsp; <BR>=0A<BR>=0A<BR>=0AOn Tue, 05 Apr 2005 Marcel Hol=
tmann wrote :<BR>=0A&gt;Hi,<BR>=0A&gt;<BR>=0A&gt; &gt; I have a small probl=
em in understanding the blueZ source code for<BR>=0A&gt; &gt; kernel 2.6.11=
.I am unable to find out exactly how the kernel<BR>=0A&gt; &gt; implementat=
ions of the l2cap layer,hcilayer and rfcomm layer are<BR>=0A&gt; &gt; inter=
acting amongst themselves ?As well as how they interact with the<BR>=0A&gt;=
 &gt; user space libraries?<BR>=0A&gt; &gt;<BR>=0A&gt; &gt; I have seen som=
e functions in l2cap.c calling functions from<BR>=0A&gt; &gt; hci_core.c wh=
ich have been put as EXPORT_SYMBOL() in hci_core.c.<BR>=0A&gt; &gt; Is it t=
he way they are communicating or am i missing something?<BR>=0A&gt;<BR>=0A&=
gt;the module interaction is done by the exported symbols as you already<BR=
>=0A&gt;realized. The upper layer modules like RFCOMM, BNEP etc. are using =
the<BR>=0A&gt;L2CAP socket interface inside the kernel. All userspace tools=
 are using<BR>=0A&gt;the ioctls and the socket interfaces.<BR>=0A&gt;<BR>=
=0A&gt;Regards<BR>=0A&gt;<BR>=0A&gt;Marcel<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;=
<BR>=0A&gt;<BR>=0A&gt;-----------------------------------------------------=
--<BR>=0A&gt;SF email is sponsored by - The IT Product Guide<BR>=0A&gt;Read=
 honest &amp; candid reviews on hundreds of IT Products from real users.<BR=
>=0A&gt;Discover which products truly live up to the hype. Start reading no=
w.<BR>=0A&gt;http://ads.osdn.com/?ad_id=3D6595&amp;alloc_id=3D14396&amp;op=
=3Dclick<BR>=0A&gt;_______________________________________________<BR>=0A&g=
t;Bluez-users mailing list<BR>=0A&gt;Bluez-users@lists.sourceforge.net<BR>=
=0A&gt;https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>=0A=0A</=
P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clients.rediff.com/sign=
ature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/RealMedia/ads/adstre=
am_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 VSPACE=3D0 HSPACE=
=3D0></a>=0A
--Next_1112778611---0-203.199.83.37-21249--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
