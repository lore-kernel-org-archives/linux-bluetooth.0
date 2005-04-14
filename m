Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050414102914.4371.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
From: "vaishali  paisal" <vaishalipaisal@rediffmail.com>
To: bluez-users@lists.sourceforge.net
Content-type: multipart/alternative;
	boundary="Next_1113474554---0-203.199.83.27-4369"
Subject: [Bluez-users] Exactly how the sockets are being used in between the user space and kernel?
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
Date: 14 Apr 2005 10:29:14 -0000

 This is a multipart mime message


--Next_1113474554---0-203.199.83.27-4369
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 =A0Hello Marcel,=0AThanks for replying to my question.Can u please explain=
 me how the socket communication is going on between the user space and ker=
nel space?=0AI can find out the code defining new address familiy AF_BLUETO=
OTH.then new protocols for L2CAP,HCI and RFCOMM.=0Ain bluez utilities i can=
 find that in files like l2test.c the calls are being made to socket functi=
ons.=0ABut i m unable to find out exactly how the other side i mean the ker=
nel handles the socket calls.=0AIf u can provide a sample code just expalin=
ing the socket concept i  would be grateful to u.=0A=0ARegards=0Avaishali=
=0A=0A=0AOn Tue, 05 Apr 2005 Marcel Holtmann wrote :=0A>Hi,=0A>=0A> > I hav=
e a small problem in understanding the blueZ source code for=0A> > kernel 2=
.6.11.I am unable to find out exactly how the kernel=0A> > implementations =
of the l2cap layer,hcilayer and rfcomm layer are=0A> > interacting amongst =
themselves ?As well as how they interact with the=0A> > user space librarie=
s?=0A> >=0A> > I have seen some functions in l2cap.c calling functions from=
=0A> > hci_core.c which have been put as EXPORT_SYMBOL() in hci_core.c.=0A>=
 > Is it the way they are communicating or am i missing something?=0A>=0A>t=
he module interaction is done by the exported symbols as you already=0A>rea=
lized. The upper layer modules like RFCOMM, BNEP etc. are using the=0A>L2CA=
P socket interface inside the kernel. All userspace tools are using=0A>the =
ioctls and the socket interfaces.=0A>=0A>Regards=0A>=0A>Marcel=0A>=0A>=0A>=
=0A>=0A>-------------------------------------------------------=0A>SF email=
 is sponsored by - The IT Product Guide=0A>Read honest & candid reviews on =
hundreds of IT Products from real users.=0A>Discover which products truly l=
ive up to the hype. Start reading now.=0A>http://ads.osdn.com/?ad_id=3D6595=
&alloc_id=3D14396&op=3Dclick=0A>___________________________________________=
____=0A>Bluez-users mailing list=0A>Bluez-users@lists.sourceforge.net=0A>ht=
tps://lists.sourceforge.net/lists/listinfo/bluez-users=0A
--Next_1113474554---0-203.199.83.27-4369
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; Hello Marcel,<BR>=0AThanks for replying to my question.Can u p=
lease explain me how the socket communication is going on between the user =
space and kernel space?<BR>=0AI can find out the code defining new address =
familiy AF_BLUETOOTH.then new protocols for L2CAP,HCI and RFCOMM.<BR>=0Ain =
bluez utilities i can find that in files like l2test.c the calls are being =
made to socket functions.<BR>=0ABut i m unable to find out exactly how the =
other side i mean the kernel handles the socket calls.<BR>=0AIf u can provi=
de a sample code just expalining the socket concept i&nbsp; would be gratef=
ul to u.<BR>=0A<BR>=0ARegards<BR>=0Avaishali<BR>=0A<BR>=0A<BR>=0AOn Tue, 05=
 Apr 2005 Marcel Holtmann wrote :<BR>=0A&gt;Hi,<BR>=0A&gt;<BR>=0A&gt; &gt; =
I have a small problem in understanding the blueZ source code for<BR>=0A&gt=
; &gt; kernel 2.6.11.I am unable to find out exactly how the kernel<BR>=0A&=
gt; &gt; implementations of the l2cap layer,hcilayer and rfcomm layer are<B=
R>=0A&gt; &gt; interacting amongst themselves ?As well as how they interact=
 with the<BR>=0A&gt; &gt; user space libraries?<BR>=0A&gt; &gt;<BR>=0A&gt; =
&gt; I have seen some functions in l2cap.c calling functions from<BR>=0A&gt=
; &gt; hci_core.c which have been put as EXPORT_SYMBOL() in hci_core.c.<BR>=
=0A&gt; &gt; Is it the way they are communicating or am i missing something=
?<BR>=0A&gt;<BR>=0A&gt;the module interaction is done by the exported symbo=
ls as you already<BR>=0A&gt;realized. The upper layer modules like RFCOMM, =
BNEP etc. are using the<BR>=0A&gt;L2CAP socket interface inside the kernel.=
 All userspace tools are using<BR>=0A&gt;the ioctls and the socket interfac=
es.<BR>=0A&gt;<BR>=0A&gt;Regards<BR>=0A&gt;<BR>=0A&gt;Marcel<BR>=0A&gt;<BR>=
=0A&gt;<BR>=0A&gt;<BR>=0A&gt;<BR>=0A&gt;-----------------------------------=
--------------------<BR>=0A&gt;SF email is sponsored by - The IT Product Gu=
ide<BR>=0A&gt;Read honest &amp; candid reviews on hundreds of IT Products f=
rom real users.<BR>=0A&gt;Discover which products truly live up to the hype=
. Start reading now.<BR>=0A&gt;http://ads.osdn.com/?ad_id=3D6595&amp;alloc_=
id=3D14396&amp;op=3Dclick<BR>=0A&gt;_______________________________________=
________<BR>=0A&gt;Bluez-users mailing list<BR>=0A&gt;Bluez-users@lists.sou=
rceforge.net<BR>=0A&gt;https://lists.sourceforge.net/lists/listinfo/bluez-u=
sers<BR>=0A=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clients=
.rediff.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/Real=
Media/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 V=
SPACE=3D0 HSPACE=3D0></a>=0A
--Next_1113474554---0-203.199.83.27-4369--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
