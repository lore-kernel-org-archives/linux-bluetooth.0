Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <28c817710606291744l354a24d0h4113ec90e176c24a@mail.gmail.com>
Date: Fri, 30 Jun 2006 08:44:38 +0800
From: ifq <ifqqfi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151596973.14964.30.camel@localhost>
MIME-Version: 1.0
References: <28c817710606290332o2e84020dl91d4a0bff11db73f@mail.gmail.com>
	<6297d67c0606290445h455ea56bjfdf3bc2b44f26ad1@mail.gmail.com>
	<1151582944.14964.17.camel@localhost>
	<28c817710606290543i3f331478ta461242dcc94d612@mail.gmail.com>
	<1151596973.14964.30.camel@localhost>
Subject: Re: [Bluez-devel] how to create a ACL connection with an
	authentication?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0886486664=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0886486664==
Content-Type: multipart/alternative;
	boundary="----=_Part_481_10238848.1151628278932"

------=_Part_481_10238848.1151628278932
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/6/30, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> > if I need to build the authentication connection in my own
> > program,what should I do?
> > what I know is use the socket API to create a connection.but how to
> > set this connection to have an authentication?
>
> for L2CAP/RFCOMM you can use socket options to request authentication
> and encryption on incoming connections. Take a look at the source of
> rctest.c and l2test.c.


I have seen file l2test.c,and I found how to let a socket to request
authentication,but another question is I did'n found the source about set
link key in server or client. is there something I missed?

Regards
>
> Marcel
>
>
>
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

------=_Part_481_10238848.1151628278932
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2006/6/30, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>&gt; if I need to build the authentication connection in my own<br>&gt; program,what should I do?<br>&gt; what I know is use the socket API to create a connection.but how to<br>&gt; set this connection to have an authentication?
<br><br>for L2CAP/RFCOMM you can use socket options to request authentication<br>and encryption on incoming connections. Take a look at the source of<br>rctest.c and l2test.c.</blockquote><div><br>I have seen file l2test.c
,and I found how to let a socket to request authentication,but another question is I did'n found the source about set link key in server or client. is there something I missed?<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Regards<br><br>Marcel<br><br><br><br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server 
v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a><br>
_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_481_10238848.1151628278932--


--===============0886486664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0886486664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0886486664==--
