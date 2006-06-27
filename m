Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606262140ie16e662w155c5d014caacfec@mail.gmail.com>
Date: Tue, 27 Jun 2006 10:10:19 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151323323.7694.7.camel@localhost>
MIME-Version: 1.0
References: <6297d67c0606260404kc22d718u4561df45147624e@mail.gmail.com>
	<449FC543.2090507@andric.com>
	<6297d67c0606260453ud6da167ic88d8ddee45ca072@mail.gmail.com>
	<1151323323.7694.7.camel@localhost>
Subject: Re: [Bluez-devel] bluez-utils do not cross compile
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1270061408=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1270061408==
Content-Type: multipart/alternative;
	boundary="----=_Part_19078_26183933.1151383219510"

------=_Part_19078_26183933.1151383219510
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On 6/26/06, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Mayank,
>
> > It works after I give the options --with-bluez=PATH
> > But now when I say make, I get the following error:
> >
> > arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common
> > -I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2 -c `test -f
> > 'hciattach.c' || echo './'`hciattach.c
> > hciattach.c: In function `main':
> > hciattach.c:1006: `PATH_MAX' undeclared (first use in this function)
> > hciattach.c:1006: (Each undeclared identifier is reported only once
> > hciattach.c:1006: for each function it appears in.)
> > hciattach.c:1006: warning: unused variable `dev'
> > make[2]: *** [hciattach.o] Error 1
>
> check if the attached patch helps.


It works!!
But one question: why don't I get this error when I am not cross compiling?
Is it specific to arm-linux-gcc?

Also, the same error was coming in tools/hciconfig.c and hidd/sdp.c as well.


Thanks a lot for your help.

Regards,
Mayank

------=_Part_19078_26183933.1151383219510
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div><br><span class="gmail_quote">On 6/26/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span></div>
<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Mayank,<br><br>&gt; It works after I give the options --with-bluez=PATH<br>&gt; But now when I say make, I get the following error:
<br>&gt;<br>&gt; arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common<br>&gt; -I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2 -c `test -f<br>&gt; 'hciattach.c' || echo './'`hciattach.c<br>&gt; hciattach.c: In function `main':
<br>&gt; hciattach.c:1006: `PATH_MAX' undeclared (first use in this function)<br>&gt; hciattach.c:1006: (Each undeclared identifier is reported only once<br>&gt; hciattach.c:1006: for each function it appears in.)<br>&gt; 
hciattach.c:1006: warning: unused variable `dev'<br>&gt; make[2]: *** [hciattach.o] Error 1<br><br>check if the attached patch helps.</blockquote>
<div>&nbsp;</div>
<div>It works!!</div>
<div>But one question: why don't I get this error when I am not cross compiling? </div>
<div>Is it specific to arm-linux-gcc?</div>
<div>&nbsp;</div>
<div>Also, the same error was coming in tools/hciconfig.c and hidd/sdp.c as well.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks a lot for your help.</div><br>Regards,</div>
<div>Mayank</div>

------=_Part_19078_26183933.1151383219510--


--===============1270061408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1270061408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1270061408==--
