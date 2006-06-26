Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606260453ud6da167ic88d8ddee45ca072@mail.gmail.com>
Date: Mon, 26 Jun 2006 17:23:37 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <449FC543.2090507@andric.com>
MIME-Version: 1.0
References: <6297d67c0606260404kc22d718u4561df45147624e@mail.gmail.com>
	<449FC543.2090507@andric.com>
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
Content-Type: multipart/mixed; boundary="===============0197495143=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0197495143==
Content-Type: multipart/alternative;
	boundary="----=_Part_45445_23922498.1151322817934"

------=_Part_45445_23922498.1151322817934
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Dimitry,


On 6/26/06, Dimitry Andric <dimitry@andric.com> wrote:
>
> Mayank Batra wrote:
> > But when I cross compile bluez-utils, I get the following error while
> ...
> > configure: error: Bluetooth library not found
>
> Read ./configure --help, and use the --with-bluez option correctly.


It works after I give the options --with-bluez=PATH
But now when I say make, I get the following error:

arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common
-I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2 -c `test -f 'hciattach.c'
|| echo './'`hciattach.c
hciattach.c: In function `main':
hciattach.c:1006: `PATH_MAX' undeclared (first use in this function)
hciattach.c:1006: (Each undeclared identifier is reported only once
hciattach.c:1006: for each function it appears in.)
hciattach.c:1006: warning: unused variable `dev'
make[2]: *** [hciattach.o] Error 1


Please help me out.
Thanks

Regards,
Mayank

------=_Part_45445_23922498.1151322817934
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Dimitry,</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 6/26/06, <b class="gmail_sendername">Dimitry Andric</b> &lt;<a href="mailto:dimitry@andric.com">dimitry@andric.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Mayank Batra wrote:<br>&gt; But when I cross compile bluez-utils, I get the following error while<br>...<br>
&gt; configure: error: Bluetooth library not found<br><br>Read ./configure --help, and use the --with-bluez option correctly.</blockquote>
<div>&nbsp;</div>
<div>It works after I give the options --with-bluez=PATH</div>
<div>But now when I say make, I get the following error:</div>
<div>&nbsp;</div>
<div>arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2 -c `test -f 'hciattach.c' || echo './'`hciattach.c<br>hciattach.c: In function `main':<br>hciattach.c:1006: `PATH_MAX' undeclared (first use in this function)
<br>hciattach.c:1006: (Each undeclared identifier is reported only once<br>hciattach.c:1006: for each function it appears in.)<br>hciattach.c:1006: warning: unused variable `dev'<br>make[2]: *** [hciattach.o] Error 1<br>&nbsp;
</div><br>Please help me out.</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div>

------=_Part_45445_23922498.1151322817934--


--===============0197495143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0197495143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0197495143==--
