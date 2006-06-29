Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <28c817710606290543i3f331478ta461242dcc94d612@mail.gmail.com>
Date: Thu, 29 Jun 2006 20:43:41 +0800
From: ifq <ifqqfi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151582944.14964.17.camel@localhost>
MIME-Version: 1.0
References: <28c817710606290332o2e84020dl91d4a0bff11db73f@mail.gmail.com>
	<6297d67c0606290445h455ea56bjfdf3bc2b44f26ad1@mail.gmail.com>
	<1151582944.14964.17.camel@localhost>
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
Content-Type: multipart/mixed; boundary="===============1815428624=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1815428624==
Content-Type: multipart/alternative;
	boundary="----=_Part_93884_8161195.1151585021330"

------=_Part_93884_8161195.1151585021330
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

if I need to build the authentication connection in my own program,what
should I do?
what I know is use the socket API to create a connection.but how to set this
connection to have an authentication?
thanks.

Regards

Jingtian Wang

2006/6/29, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Mayank,
>
> > On 6/29/06, ifq <ifqqfi@gmail.com> wrote:
> >         I want to create a ACL connection with an authentication and
> >         encryption use BlueZ. I searched the BlueZ lib and found
> >         nothing.is there anyone could give me some advice?thank you
> >         very much!
> >
> > In /etc/bluetooth/hcid.conf file make sure that the following lines
> > are there (i.e. they should not be commented!)
> > auth enable
> > encrypt enable
>
> don't advise people to enter security mode 3 unless you are going to
> handle all their troubles with different devices. These two option are
> removed in the 3.x releases anyway.
>
> Regards
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

------=_Part_93884_8161195.1151585021330
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

if I need to build the authentication connection in my own program,what should I do?<br>what I know is use the socket API to create a connection.but how to set this connection to have an authentication?<br>thanks.<br><br>Regards
<br><br>Jingtian Wang<br><br><div><span class="gmail_quote">2006/6/29, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Mayank,<br><br>&gt; On 6/29/06, ifq &lt;<a href="mailto:ifqqfi@gmail.com">ifqqfi@gmail.com</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I want to create a ACL connection with an authentication and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encryption use BlueZ. I searched the BlueZ lib and found
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://nothing.is">nothing.is</a> there anyone could give me some advice?thank you<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; very much!<br>&gt;<br>&gt; In /etc/bluetooth/hcid.conf file make sure that the following lines<br>
&gt; are there (i.e. they should not be commented!)<br>&gt; auth enable<br>&gt; encrypt enable<br><br>don't advise people to enter security mode 3 unless you are going to<br>handle all their troubles with different devices. These two option are
<br>removed in the 3.x releases anyway.<br><br>Regards<br><br>Marcel<br><br><br><br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_93884_8161195.1151585021330--


--===============1815428624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1815428624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1815428624==--
