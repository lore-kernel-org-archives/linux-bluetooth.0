Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <becc9d2c0610110702g5fe862ccu69321bd4ebc650c4@mail.gmail.com>
Date: Wed, 11 Oct 2006 16:02:59 +0200
From: "Andrea Carlevato" <andrea.carlevatoml@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610111549460.644@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
	<Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110515l94f0c2bq25fdab08cdba9674@mail.gmail.com>
	<Pine.LNX.4.63.0610111422500.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110535j3eaed755s6a06a6f2e089b474@mail.gmail.com>
	<Pine.LNX.4.63.0610111443230.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110608p3865c314mc05a638970748bcf@mail.gmail.com>
	<Pine.LNX.4.63.0610111549460.644@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] How extract client address on server ??
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0262700014=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0262700014==
Content-Type: multipart/alternative;
	boundary="----=_Part_6204_16815414.1160575379795"

------=_Part_6204_16815414.1160575379795
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

including obex_main.h conflicts with the necessary inclusion in my code of
<openobex/obex.h>...
Moreover obex_main.h require all other header file of openobex libs to
compile...

is there any way to get out of all this ?


grazie
andrea








On 10/11/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
>
> Hi,
>
>
> On Wed, 11 Oct 2006, Andrea Carlevato wrote:
>
> > ok,
> > i get that stratcure as "handle" with this call:
> >
> > obex_t *handle = NULL;
> > handle = OBEX_Init(OBEX_TRANS_BLUETOOTH, obex_event, 0);
> > ....
> > btobex_accept(handle);
> >
> > OK, but if i add this code:
> >
> > getpeername(handle->fd, &addr, &addr_len);
> >
> > my compiler gives me this error:
> >
> > > > > request for member 'fd' in something not a structure or union
> >
> >
> > Do you wonder why ?
> > thanks a lot
> No ;-)
>
> You have to do something like this:
>
> #include "(path to file)/obex_main.h"
>
> .....
>
> getpeername( (struct obex *)handle->fd, ....)
>
> Ciao,
>
> Peter
>
>
> >
> >
> >
> >
> >
> > On 10/11/06, Peter Wippich <pewi@gw-instruments.de> wrote:
> > >
> > >
> > > Hi Andrea,
> > >
> > > On Wed, 11 Oct 2006, Andrea Carlevato wrote:
> > >
> > > > what do you mean with "obex structure" ? which structure are you
> > > referring ?
> > > >
> > > > andrea
> > >
> > > The structure defined in lib/obex_main.h It is not exported directly
> by
> > > the api, as far as I can see. The OBEX_Init() shall return a pointer
> to
> > > such a structure (defined as a void * for the API). It is not realy
> good
> > > style to access internal structure of the library, but I can see no
> > > "official" way to get the bd_addr of a remote client (but may be I
> missed
> > > something).
> > >
> > > Ciao,
> > >
> > > Peter
> > >
> > >
> > >
> > > |       Peter Wippich                   Voice: +49 30
> 46776411          |
> > > |       G&W Instruments GmbH            fax:   +49 30
> 46776419          |
> > > |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de
> |
> > > |       D-13355 Berlin  /
> Germany                                       |
> > >
> > >
> > >
> -------------------------------------------------------------------------
> > > Using Tomcat but need to do more? Need to support web services,
> security?
> > > Get stuff done quickly with pre-integrated technology to make your job
> > > easier
> > > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> > >
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> >
> >
>
>
> |       Peter Wippich                   Voice: +49 30 46776411          |
> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> |       D-13355 Berlin  / Germany                                       |
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_6204_16815414.1160575379795
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

including obex_main.h conflicts with the necessary inclusion in my code of &lt;openobex/obex.h&gt;... <br>Moreover obex_main.h require all other header file of openobex libs to compile...<br><br>is there any way to get out of all this ?
<br><br><br>grazie<br>andrea<br><br><br><br><br><br><br><br><br><div><span class="gmail_quote">On 10/11/06, <b class="gmail_sendername">Peter Wippich</b> &lt;<a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Hi,<br><br><br>On Wed, 11 Oct 2006, Andrea Carlevato wrote:<br><br>&gt; ok,
<br>&gt; i get that stratcure as &quot;handle&quot; with this call:<br>&gt;<br>&gt; obex_t *handle = NULL;<br>&gt; handle = OBEX_Init(OBEX_TRANS_BLUETOOTH, obex_event, 0);<br>&gt; ....<br>&gt; btobex_accept(handle);<br>&gt;
<br>&gt; OK, but if i add this code:<br>&gt;<br>&gt; getpeername(handle-&gt;fd, &amp;addr, &amp;addr_len);<br>&gt;<br>&gt; my compiler gives me this error:<br>&gt;<br>&gt; &gt; &gt; &gt; request for member 'fd' in something not a structure or union
<br>&gt;<br>&gt;<br>&gt; Do you wonder why ?<br>&gt; thanks a lot<br>No ;-)<br><br>You have to do something like this:<br><br>#include &quot;(path to file)/obex_main.h&quot;<br><br>.....<br><br>getpeername( (struct obex *)handle-&gt;fd, ....)
<br><br>Ciao,<br><br>Peter<br><br><br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; On 10/11/06, Peter Wippich &lt;<a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt;<br>
&gt; &gt; Hi Andrea,<br>&gt; &gt;<br>&gt; &gt; On Wed, 11 Oct 2006, Andrea Carlevato wrote:<br>&gt; &gt;<br>&gt; &gt; &gt; what do you mean with &quot;obex structure&quot; ? which structure are you<br>&gt; &gt; referring ?
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; andrea<br>&gt; &gt;<br>&gt; &gt; The structure defined in lib/obex_main.h It is not exported directly by<br>&gt; &gt; the api, as far as I can see. The OBEX_Init() shall return a pointer to
<br>&gt; &gt; such a structure (defined as a void * for the API). It is not realy good<br>&gt; &gt; style to access internal structure of the library, but I can see no<br>&gt; &gt; &quot;official&quot; way to get the bd_addr of a remote client (but may be I missed
<br>&gt; &gt; something).<br>&gt; &gt;<br>&gt; &gt; Ciao,<br>&gt; &gt;<br>&gt; &gt; Peter<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Peter Wippich&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voice: +49 30 46776411&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>&gt; &gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G&amp;W Instruments GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fax:&nbsp;&nbsp; +49 30 46776419&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
<br>&gt; &gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gustav-Meyer-Allee 25, Geb. 12&nbsp;&nbsp;Email: <a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&nbsp;&nbsp; |<br>&gt; &gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-13355 Berlin&nbsp;&nbsp;/ Germany&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; -------------------------------------------------------------------------<br>&gt; &gt; Using Tomcat but need to do more? Need to support web services, security?<br>&gt; &gt; Get stuff done quickly with pre-integrated technology to make your job
<br>&gt; &gt; easier<br>&gt; &gt; Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>&gt; &gt; <a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>&gt; &gt; _______________________________________________<br>&gt; &gt; Bluez-devel mailing list<br>&gt; &gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>&gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt; &gt;<br>&gt;<br>&gt;<br><br><br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Peter Wippich&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voice: +49 30 46776411&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G&amp;W Instruments GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fax:&nbsp;&nbsp; +49 30 46776419&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gustav-Meyer-Allee 25, Geb. 12&nbsp;&nbsp;Email: <a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&nbsp;&nbsp; |<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-13355 Berlin&nbsp;&nbsp;/ Germany&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br><br><br>-------------------------------------------------------------------------
<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________
<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_6204_16815414.1160575379795--


--===============0262700014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0262700014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0262700014==--
