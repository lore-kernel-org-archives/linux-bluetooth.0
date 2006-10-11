Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <becc9d2c0610110515l94f0c2bq25fdab08cdba9674@mail.gmail.com>
Date: Wed, 11 Oct 2006 14:15:54 +0200
From: "Andrea Carlevato" <andrea.carlevatoml@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <becc9d2c0610110401l2bb3c868o11be616b795031c7@mail.gmail.com>
	<Pine.LNX.4.63.0610111308030.644@redbean.intranet.gw-instruments.de>
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
Content-Type: multipart/mixed; boundary="===============0322344338=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0322344338==
Content-Type: multipart/alternative;
	boundary="----=_Part_3626_20787963.1160568954561"

------=_Part_3626_20787963.1160568954561
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry Peter but using openobex libs i ve no socket there, only an
handle...How can i use getpeername()  if i ve no socket to pass it ???


andrea


On 10/11/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
>
> Hi Andrea,
>
> usualy you use  getpeername() to her the remote address of a socket.
>
> Ciao,
>
> Peter
>
> On Wed, 11 Oct 2006, Andrea Carlevato wrote:
>
> > Hello,
> > i ve a very simple question. I got a simple obex server code that runs
> > fine.I ve taken the obexserver sample souce code as a tamplate. Question
> is:
> > how/where can i get, on my server, the bt address of the client ??
> >
> > thanks a lot
> >
> > Andrea
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

------=_Part_3626_20787963.1160568954561
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry Peter but using openobex libs i ve no socket there, only an handle...How can i use getpeername()&nbsp; if i ve no socket to pass it ???<br><br><br>andrea<br><br><br><div><span class="gmail_quote">On 10/11/06, <b class="gmail_sendername">
Peter Wippich</b> &lt;<a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Hi Andrea,<br><br>usualy you use&nbsp;&nbsp;getpeername() to her the remote address of a socket.<br><br>Ciao,<br><br>Peter<br><br>On Wed, 11 Oct 2006, Andrea Carlevato wrote:<br><br>&gt; Hello,<br>&gt; i ve a very simple question. I got a simple obex server code that runs
<br>&gt; fine.I ve taken the obexserver sample souce code as a tamplate. Question is:<br>&gt; how/where can i get, on my server, the bt address of the client ??<br>&gt;<br>&gt; thanks a lot<br>&gt;<br>&gt; Andrea<br>&gt;<br>
&gt;<br><br><br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Peter Wippich&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voice: +49 30 46776411&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G&amp;W Instruments GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fax:&nbsp;&nbsp; +49 30 46776419&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gustav-Meyer-Allee 25, Geb. 12&nbsp;&nbsp;Email: 
<a href="mailto:pewi@gw-instruments.de">pewi@gw-instruments.de</a>&nbsp;&nbsp; |<br>|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-13355 Berlin&nbsp;&nbsp;/ Germany&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br><br><br>-------------------------------------------------------------------------
<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>_______________________________________________
<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_3626_20787963.1160568954561--


--===============0322344338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0322344338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0322344338==--
