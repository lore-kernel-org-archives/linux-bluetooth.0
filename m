Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50705170355t727d3b60s818d3a643305ad8b@mail.gmail.com>
Date: Thu, 17 May 2007 16:25:55 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1179394491.14671.37.camel@panic>
MIME-Version: 1.0
References: <200705161235.51289.fernando@bluexare.org>
	<1ab01fb50705162205x224633a5k7f7d4541e512cc98@mail.gmail.com>
	<200705171018.19781.fernando@bluexare.org>
	<1179394491.14671.37.camel@panic>
Subject: Re: [Bluez-devel] How I can select between 2 bluetooth devices?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0980745192=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0980745192==
Content-Type: multipart/alternative;
	boundary="----=_Part_42618_1072626.1179399355616"

------=_Part_42618_1072626.1179399355616
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I think Collin said is right ,
See for scanning u need to have hci layer api while for file transfer u nee=
d
OBEX.
for scanning bind device before calling scan function.
hci_inquiry(iDevId, iSECOND, iMAXDEV, NULL, &inqinfo, IREQ_CACHE_FLUSH))
This DevId is device Id(file descriptor).

while for File sending u can call
handle =3D __obex_connect(devid, addr, timeout, &err);
here again devid is FD .

so by this u can differentiate 2 dongles.

On 5/17/07, Collin R. Mulliner <collin@betaversion.net> wrote:
>
> you can do this in a very simple way, just do the connect by hand (bind
> to a specific bluetooth device before connect) then pass the file
> descriptor to the OBEX library. OBEX will run in normal FD (file
> descriptor) mode then. For this to work you also need to do the sdp
> lookup yourself, but this is easy.
>
> Collin
>
> On Thu, 2007-05-17 at 10:18 +0200, Fernando Unzu wrote:
> > Hi Vikas,
> > Yes, this is I want to achieve.
> >
> > I don't understand very well the code, but I uses OBEX_GetUserData,
> > OBEX_HandleInput, OBEX_CancelRequest, OBEX_ObjectNew, OBEX_Delete,
> > OBEX_TransportConnect and more like these, and in all of them I use a
> Handle,
> > created by OBEX_Init (OBEX_TRANS_BLUETOOTH, obex_event, 0).
> >
> > So I Think this is the way..., but I don't know if it is, or how to
> do...
> >
> > in other functions I use hci_create_connection to create the handle, I
> think.
> >
> > How you can see, I don't understand good the code.
> >
> > How I can separate the two dongles to doing separated functions?
> >
> > Thanks a lot,
> > Fernando
> >
> >
> > El Jueves, 17 de Mayo de 2007 07:05, Vikas Sinha escribi=F3:
> > > Hi, Fernando
> > >
> > > If i am not wrong u have 2 Dongles and u want to use one for scan and
> other
> > > for file send... ??
> > >
> > > am I right ...
> > >
> > > On 5/16/07, Fernando Unzu <fernando@bluexare.org> wrote:
> > > > Hello,
> > > > I'm working in an application that scans for bluetooth devices and
> send
> > > > some
> > > > content to they...
> > > >
> > > > Due to several issues, I need to separate the action scan and send
> > > > between two
> > > > devices...
> > > >
> > > > I have the code for doing this in one bluetooth device, and I don't
> know
> > > > very
> > > > well how it works, but I have read it some times...
> > > >
> > > > But I don't find where i can select which bluetooth device I want t=
o
> use
> > > > to
> > > > doing one method or other...
> > > >
> > > > I have seen that "OBEX_Init" creates a handle to manage the
> conection...,
> > > > but
> > > > it can be select which bluetooth device select for doing this
> handle?
> > > >
> > > > Thank you very much and I hope somebody understand me.
> > > >
> > > > Fernando
> > > >
> > > >
> -------------------------------------------------------------------------
> > > > This SF.net email is sponsored by DB2 Express
> > > > Download DB2 Express C - the FREE version of DB2 express and take
> > > > control of your XML. No limits. Just data. Click to get it now.
> > > > http://sourceforge.net/powerbar/db2/
> > > > _______________________________________________
> > > > Bluez-devel mailing list
> > > > Bluez-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
> -------------------------------------------------------------------------
> > This SF.net email is sponsored by DB2 Express
> > Download DB2 Express C - the FREE version of DB2 express and take
> > control of your XML. No limits. Just data. Click to get it now.
> > http://sourceforge.net/powerbar/db2/
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> --
> Collin R. Mulliner <collin@betaversion.net>
> BETAVERSiON Systems [www.betaversion.net]
> info/pgp: finger collin@betaversion.net
> Life is hard, but unfair!
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--=20
Impossible
itself contain
I M Possible

Vikas

------=_Part_42618_1072626.1179399355616
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I think Collin said is right , <br>
See for scanning u need to have hci layer api while for file transfer u nee=
d OBEX. <br>
for scanning bind device before calling scan function.<br>
hci_inquiry(iDevId, iSECOND, iMAXDEV, NULL, &amp;inqinfo, IREQ_CACHE_FLUSH)=
)<br>
This DevId is device Id(file descriptor). <br>
<br>
while for File sending u can call<br>
handle =3D __obex_connect(devid, addr, timeout, &amp;err);<br>
here again devid is FD . <br>
<br>
so by this u can differentiate 2 dongles.<br><br><div><span class=3D"gmail_=
quote">On 5/17/07, <b class=3D"gmail_sendername">Collin R. Mulliner</b> &lt=
;<a href=3D"mailto:collin@betaversion.net">collin@betaversion.net</a>&gt; w=
rote:
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">you can do=
 this in a very simple way, just do the connect by hand (bind<br>to a speci=
fic bluetooth device before connect) then pass the file
<br>descriptor to the OBEX library. OBEX will run in normal FD (file<br>des=
criptor) mode then. For this to work you also need to do the sdp<br>lookup =
yourself, but this is easy.<br><br>Collin<br><br>On Thu, 2007-05-17 at 10:1=
8 +0200, Fernando Unzu wrote:
<br>&gt; Hi Vikas,<br>&gt; Yes, this is I want to achieve.<br>&gt;<br>&gt; =
I don&#39;t understand very well the code, but I uses OBEX_GetUserData,<br>=
&gt; OBEX_HandleInput, OBEX_CancelRequest, OBEX_ObjectNew, OBEX_Delete,
<br>&gt; OBEX_TransportConnect and more like these, and in all of them I us=
e a Handle,<br>&gt; created by OBEX_Init (OBEX_TRANS_BLUETOOTH, obex_event,=
 0).<br>&gt;<br>&gt; So I Think this is the way..., but I don&#39;t know if=
 it is, or how to do...
<br>&gt;<br>&gt; in other functions I use hci_create_connection to create t=
he handle, I think.<br>&gt;<br>&gt; How you can see, I don&#39;t understand=
 good the code.<br>&gt;<br>&gt; How I can separate the two dongles to doing=
 separated functions?
<br>&gt;<br>&gt; Thanks a lot,<br>&gt; Fernando<br>&gt;<br>&gt;<br>&gt; El =
Jueves, 17 de Mayo de 2007 07:05, Vikas Sinha escribi=F3:<br>&gt; &gt; Hi, =
Fernando<br>&gt; &gt;<br>&gt; &gt; If i am not wrong u have 2 Dongles and u=
 want to use one for scan and other
<br>&gt; &gt; for file send... ??<br>&gt; &gt;<br>&gt; &gt; am I right ...<=
br>&gt; &gt;<br>&gt; &gt; On 5/16/07, Fernando Unzu &lt;<a href=3D"mailto:f=
ernando@bluexare.org">fernando@bluexare.org</a>&gt; wrote:<br>&gt; &gt; &gt=
; Hello,
<br>&gt; &gt; &gt; I&#39;m working in an application that scans for bluetoo=
th devices and send<br>&gt; &gt; &gt; some<br>&gt; &gt; &gt; content to the=
y...<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Due to several issues, I need to s=
eparate the action scan and send
<br>&gt; &gt; &gt; between two<br>&gt; &gt; &gt; devices...<br>&gt; &gt; &g=
t;<br>&gt; &gt; &gt; I have the code for doing this in one bluetooth device=
, and I don&#39;t know<br>&gt; &gt; &gt; very<br>&gt; &gt; &gt; well how it=
 works, but I have read it some times...
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; But I don&#39;t find where i can selec=
t which bluetooth device I want to use<br>&gt; &gt; &gt; to<br>&gt; &gt; &g=
t; doing one method or other...<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; I have =
seen that &quot;OBEX_Init&quot; creates a handle to manage the conection...=
,
<br>&gt; &gt; &gt; but<br>&gt; &gt; &gt; it can be select which bluetooth d=
evice select for doing this handle?<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Tha=
nk you very much and I hope somebody understand me.<br>&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fernando<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; ---------------=
----------------------------------------------------------<br>&gt; &gt; &gt=
; This SF.net email is sponsored by DB2 Express<br>&gt; &gt; &gt; Download =
DB2 Express C - the FREE version of DB2 express and take
<br>&gt; &gt; &gt; control of your XML. No limits. Just data. Click to get =
it now.<br>&gt; &gt; &gt; <a href=3D"http://sourceforge.net/powerbar/db2/">=
http://sourceforge.net/powerbar/db2/</a><br>&gt; &gt; &gt; ________________=
_______________________________
<br>&gt; &gt; &gt; Bluez-devel mailing list<br>&gt; &gt; &gt; <a href=3D"ma=
ilto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</=
a><br>&gt; &gt; &gt; <a href=3D"https://lists.sourceforge.net/lists/listinf=
o/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt;<br>&gt=
; -------------------------------------------------------------------------=
<br>&gt; This SF.net email is sponsored by DB2 Express<br>&gt; Download DB2=
 Express C - the FREE version of DB2 express and take
<br>&gt; control of your XML. No limits. Just data. Click to get it now.<br=
>&gt; <a href=3D"http://sourceforge.net/powerbar/db2/">http://sourceforge.n=
et/powerbar/db2/</a><br>&gt; ______________________________________________=
_
<br>&gt; Bluez-devel mailing list<br>&gt; <a href=3D"mailto:Bluez-devel@lis=
ts.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href=
=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists=
.sourceforge.net/lists/listinfo/bluez-devel
</a><br>--<br>Collin R. Mulliner &lt;<a href=3D"mailto:collin@betaversion.n=
et">collin@betaversion.net</a>&gt;<br>BETAVERSiON Systems [<a href=3D"http:=
//www.betaversion.net">www.betaversion.net</a>]<br>info/pgp: finger <a href=
=3D"mailto:collin@betaversion.net">
collin@betaversion.net</a><br>Life is hard, but unfair!<br><br><br>--------=
-----------------------------------------------------------------<br>This S=
F.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FRE=
E version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a h=
ref=3D"http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerba=
r/db2/</a><br>_______________________________________________<br>Bluez-deve=
l mailing list
<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</=
a>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Impossible <br>itse=
lf contain <br>I M Possible<br><br>Vikas

------=_Part_42618_1072626.1179399355616--


--===============0980745192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0980745192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0980745192==--
