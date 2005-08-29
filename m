Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0508291413753e3b2e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <e1effdeb050822124710aa8798@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_730_30828703.1125350006533"
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <8c9e090508220504100c127e@mail.gmail.com>
	 <e1effdeb0508220527500878ab@mail.gmail.com>
	 <5256d0b050822053737c9cd8f@mail.gmail.com>
	 <e1effdeb05082205517cac906c@mail.gmail.com>
	 <9307f5f2050822072659387e3b@mail.gmail.com>
	 <1124721252.23599.53.camel@pegasus>
	 <e1effdeb05082210394bed468@mail.gmail.com>
	 <1124733046.23599.81.camel@pegasus>
	 <e1effdeb050822124710aa8798@mail.gmail.com>
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
Date: Mon, 29 Aug 2005 18:13:26 -0300

------=_Part_730_30828703.1125350006533
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

Sorry annoy you again, but would like received more suggestions and close=
=20
this discussion.

Marcel, I remember you comment something about improve the sdpd, could you=
=20
be more clear?

The core implementation (bluetoothd) and some hci functions are ready. I am=
=20
just waiting finish the specification.

http://www.cin.ufpe.br/~ckt/bluez

Regards,
Claudio.



On 8/22/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>=20
> Hi folks,
>=20
> The discussion focus moved to address multiple adapters. In the next
> BlueZ D-Bus specification I will handle only the default
> adapter(BDADDR_ANY).
>=20
> There are other points that I want feebacks.
> * Unify rfcomm and dun D-Bus interfaces/path?
> * Provide IP parameter setup. Is it necessary provide D-Bus services
> to configurate IP address, netmask, ...?
> * Provide services for automatic bridge creation(PAN context). Is really=
=20
> useful?
> * Where provide pair/authentication? Pair services does not belongs to
> a nice object path. Maybe should be "org.bluez.bluetoothd.security"
> * How SDP should work? How should be the interaction between SDP and
> the profiles in order to save memory, avoid code dupplication and use
> cache?
> * Multi level signals. For connection, disconnections and signal level
> would make sense to have both low level signals(eg: hci vs. pan). Is
> it really necessary?
> * Remove "Sig", "Req" from the method name. The type field in the
> header can be used to identify the message type(method call, method
> return, message error or signal), but in my opinion we must keep to
> make messages more clear.
>=20
> The latest specification (draft 00.05) can be found at:
> http://www.cin.ufpe.br/~ckt/bluez
>=20
> Regards,
> Claudio.
>=20
> On 8/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Claudio,
> >
> > > After this long discussion I think control multiple apdaters
> > > will not be easy. If we register multiple paths will not be easy
> > > map device register/unregister to D-Bus paths. When the user
> > > remove the default dongle the D-Bus path should be unregistered and
> > > the default adapter should be changed.
> >
> > never was and never will be ;)
> >
> > > Considering that bluez daemons are using the BDADDR_ANY. The D-Bus
> > > services should use the same approach. I agree that the default
> > > adapter must go through the kernel.
> > >
> > > Is there a way/interface to change the default adapter in the kernel?
> >
> > No. It has a simple route heuristic and normally uses the first adapter
> > that is marked as up and is not a raw device. Unless the destination is
> > not itself.
> >
> > This means that the default adapter depends on the destination which is
> > not easy to configure.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > SF.Net email is Sponsored by the Better Software Conference & EXPO
> > September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices
> > Agile & Plan-Driven Development * Managing Projects & Teams * Testing &=
=20
> QA
> > Security * Process Improvement & Measurement *=20
> http://www.sqe.com/bsce5sf
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>

------=_Part_730_30828703.1125350006533
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,<br>
<br>
Sorry annoy you again, but would like received more suggestions and close t=
his discussion.<br>
<br>
Marcel, I remember you comment something about improve the sdpd, could you =
be more clear?<br>
<br>
The core implementation (bluetoothd) and some hci functions are ready. I am=
 just waiting finish the specification.<br>
<br>
<a href=3D"http://www.cin.ufpe.br/~ckt/bluez">http://www.cin.ufpe.br/~ckt/b=
luez</a><br>
<br>
Regards,<br>
Claudio.<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 8/22/05, <b class=3D"gmail_send=
ername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">ck=
takahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Hi folks,<br><br>The discussion focus moved to address multiple adapters. I=
n the next<br>BlueZ D-Bus specification I will handle only the default<br>a=
dapter(BDADDR_ANY).<br><br>There are other points that I want feebacks.
<br>* Unify rfcomm and dun D-Bus interfaces/path?<br>* Provide IP parameter=
 setup. Is it necessary provide D-Bus services<br>to configurate IP address=
, netmask, ...?<br>* Provide services for automatic bridge creation(PAN con=
text). Is really useful?
<br>* Where provide pair/authentication? Pair services does not belongs to<=
br>a nice object path. Maybe should be &quot;org.bluez.bluetoothd.security&=
quot;<br>* How SDP should work? How should be the interaction between SDP a=
nd
<br>the profiles in order to save memory, avoid code dupplication and use<b=
r>cache?<br>* Multi level signals. For connection, disconnections and signa=
l level<br>would make sense to have both low level signals(eg: hci vs. pan)=
. Is
<br>it really necessary?<br>* Remove &quot;Sig&quot;, &quot;Req&quot; from =
the method name. The type field in the<br>header can be used to identify th=
e message type(method call, method<br>return, message error or signal), but=
 in my opinion we must keep to
<br>make messages more clear.<br><br>The latest specification (draft 00.05)=
 can be found at:<br><a href=3D"http://www.cin.ufpe.br/~ckt/bluez">http://w=
ww.cin.ufpe.br/~ckt/bluez</a><br><br>Regards,<br>Claudio.<br><br>On 8/22/05=
, Marcel Holtmann &lt;
<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<b=
r>&gt; Hi Claudio,<br>&gt;<br>&gt; &gt; After this long discussion I think =
control multiple apdaters<br>&gt; &gt; will not be easy. If we register mul=
tiple paths will not be easy
<br>&gt; &gt; map device register/unregister to D-Bus paths. When the user<=
br>&gt; &gt; remove the default dongle the D-Bus path should be unregistere=
d and<br>&gt; &gt; the default adapter should be changed.<br>&gt;<br>&gt; n=
ever was and never will be ;)
<br>&gt;<br>&gt; &gt; Considering that bluez daemons are using the BDADDR_A=
NY. The D-Bus<br>&gt; &gt; services should use the same approach. I agree t=
hat the default<br>&gt; &gt; adapter must go through the kernel.<br>&gt; &g=
t;
<br>&gt; &gt; Is there a way/interface to change the default adapter in the=
 kernel?<br>&gt;<br>&gt; No. It has a simple route heuristic and normally u=
ses the first adapter<br>&gt; that is marked as up and is not a raw device.=
 Unless the destination is
<br>&gt; not itself.<br>&gt;<br>&gt; This means that the default adapter de=
pends on the destination which is<br>&gt; not easy to configure.<br>&gt;<br=
>&gt; Regards<br>&gt;<br>&gt; Marcel<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>
&gt; -------------------------------------------------------<br>&gt; SF.Net=
 email is Sponsored by the Better Software Conference &amp; EXPO<br>&gt; Se=
ptember 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
<br>&gt; Agile &amp; Plan-Driven Development * Managing Projects &amp; Team=
s * Testing &amp; QA<br>&gt; Security * Process Improvement &amp; Measureme=
nt * <a href=3D"http://www.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a>
<br>&gt; _______________________________________________<br>&gt; Bluez-deve=
l mailing list<br>&gt; <a href=3D"mailto:Bluez-devel@lists.sourceforge.net"=
>Bluez-devel@lists.sourceforge.net</a><br>&gt; <a href=3D"https://lists.sou=
rceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt;<br></b=
lockquote></div><br>

------=_Part_730_30828703.1125350006533--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
