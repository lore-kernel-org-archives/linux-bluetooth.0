Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <becc9d2c0610110535j3eaed755s6a06a6f2e089b474@mail.gmail.com>
Date: Wed, 11 Oct 2006 14:35:02 +0200
From: "Andrea Carlevato" <andrea.carlevatoml@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610111422500.644@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
	<Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
	<becc9d2c0610110515l94f0c2bq25fdab08cdba9674@mail.gmail.com>
	<Pine.LNX.4.63.0610111422500.644@redbean.intranet.gw-instruments.de>
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
Content-Type: multipart/mixed; boundary="===============1024116982=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1024116982==
Content-Type: multipart/alternative;
	boundary="----=_Part_3930_4546933.1160570102448"

------=_Part_3930_4546933.1160570102448
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

what do you mean with "obex structure" ? which structure are you referring ?

andrea



On 10/11/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
>
> Hello Andrea,
>
> On Wed, 11 Oct 2006, Andrea Carlevato wrote:
>
> > Sorry Peter but using openobex libs i ve no socket there, only an
> > handle...How can i use getpeername()  if i ve no socket to pass it ???
> >
> >
> > andrea
> >
> I've not used Oben Obex so far. But when I look at the source code of
> btobex_listen / btobex_accept / btobex_connect_request use sockets for
> bluetooth communication. And the file descriptor inside the obex structure
> is a socket file descriptor. Also you have an obex_transport structure
> which should already contain the source / destination addresses (not sure
> if this is realy the bluetooth address for BT transport, just had a short
> look).
>
> Ciao,
>
> Peter
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

------=_Part_3930_4546933.1160570102448
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

what do you mean with &quot;obex structure&quot; ? which structure are you referring ?<br><br>andrea<br><br><br><br><div><span class="gmail_quote">On 10/11/06, <b class="gmail_sendername">Peter Wippich</b> &lt;<a href="mailto:pewi@gw-instruments.de">
pewi@gw-instruments.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Hello Andrea,<br><br>On Wed, 11 Oct 2006, Andrea Carlevato wrote:
<br><br>&gt; Sorry Peter but using openobex libs i ve no socket there, only an<br>&gt; handle...How can i use getpeername()&nbsp;&nbsp;if i ve no socket to pass it ???<br>&gt;<br>&gt;<br>&gt; andrea<br>&gt;<br>I've not used Oben Obex so far. But when I look at the source code of
<br>btobex_listen / btobex_accept / btobex_connect_request use sockets for<br>bluetooth communication. And the file descriptor inside the obex structure<br>is a socket file descriptor. Also you have an obex_transport structure
<br>which should already contain the source / destination addresses (not sure<br>if this is realy the bluetooth address for BT transport, just had a short<br>look).<br><br>Ciao,<br><br>Peter<br><br><br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Peter Wippich&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voice: +49 30 46776411&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|
<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G&amp;W Instruments GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fax:&nbsp;&nbsp; +49 30 46776419&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gustav-Meyer-Allee 25, Geb. 12&nbsp;&nbsp;Email: <a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&nbsp;&nbsp; |<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-13355 Berlin&nbsp;&nbsp;/ Germany&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
<br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_3930_4546933.1160570102448--


--===============1024116982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1024116982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1024116982==--
