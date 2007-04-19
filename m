Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0704182253v272e2a06u36790429af9d4c0@mail.gmail.com>
Date: Thu, 19 Apr 2007 11:23:11 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "Choi Sonim" <choisonim@gmail.com>
In-Reply-To: <f21e7dc80704182248q2d6ab7xcfc724e6c6360d64@mail.gmail.com>
MIME-Version: 1.0
References: <f21e7dc80704181305j58c6d188i4d2eccb7d1d54981@mail.gmail.com>
	<57c68ddc0704182242y4fb58518pcc2550b4ae8a3533@mail.gmail.com>
	<f21e7dc80704182248q2d6ab7xcfc724e6c6360d64@mail.gmail.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-util: dbus for embedded
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0799196766=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0799196766==
Content-Type: multipart/alternative;
	boundary="----=_Part_112019_17193499.1176961991167"

------=_Part_112019_17193499.1176961991167
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
i exactly dont remember the steps ... what i would suggest is u proceed
normally and whenever u get stuck , i will try my best to resolve the
issues.

Few points which are good if u follow :-

a) Install everything need for th arm platform in a separate directory e.g.
/usr/arm/
b) set PKG_CONFIG_PATH to director /usr/arm/lib/pkg-config ( or a similar
directory ) so that write path are given by pkg-config.

regards
siddhant

On 4/19/07, Choi Sonim <choisonim@gmail.com> wrote:
>
> Hello
>
> On 4/19/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
> > On 4/19/07, Choi Sonim <choisonim@gmail.com> wrote:
> > > Has anyone had any success with compiling dbus (and thus bluez-util)
> to an
> > > embedded system (ARM in particular) ?
>
> >    What are the problems that u r facing. May be the method i followed
> is not a
> > text book one but the binaries i got finally run successfully on the arm
> board.
>
> really ???
>
> can you please tell me the methods you followed ? (i don't care about
> text books,
> all i want is bluez-utils-3.9 working in embedded)
>
> did you manage to cross compile dbus and its dependencies ?
>
> please tell all your steps...
>
> Thank YOU !!
> choi
>
> >
> > regards
> > siddhant
> >
> >
> >
>
> > >
> > > thanks alot
> > > choi
>

------=_Part_112019_17193499.1176961991167
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi, <br>i exactly dont remember the steps ... what i would suggest is u proceed normally and whenever u get stuck , i will try my best to resolve the issues.<br><br>Few points which are good if u follow :-<br><br>a) Install everything need for th arm platform in a separate directory 
e.g. /usr/arm/<br>b) set PKG_CONFIG_PATH to director /usr/arm/lib/pkg-config ( or a similar directory ) so that write path are given by pkg-config.<br><br>regards<br>siddhant<br><br><div><span class="gmail_quote">On 4/19/07, 
<b class="gmail_sendername">Choi Sonim</b> &lt;<a href="mailto:choisonim@gmail.com">choisonim@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello<br><br>On 4/19/07, siddhant tewari &lt;<a href="mailto:siddhant.tewari@gmail.com">siddhant.tewari@gmail.com</a>&gt; wrote:<br>&gt; On 4/19/07, Choi Sonim &lt;<a href="mailto:choisonim@gmail.com">choisonim@gmail.com</a>
&gt; wrote:<br>&gt; &gt; Has anyone had any success with compiling dbus (and thus bluez-util) to an<br>&gt; &gt; embedded system (ARM in particular) ?<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;What are the problems that u r facing. May be the method i followed is not a
<br>&gt; text book one but the binaries i got finally run successfully on the arm board.<br><br>really ???<br><br>can you please tell me the methods you followed ? (i don&#39;t care about<br>text books,<br>all i want is bluez-utils-3.9
 working in embedded)<br><br>did you manage to cross compile dbus and its dependencies ?<br><br>please tell all your steps...<br><br>Thank YOU !!<br>choi<br><br>&gt;<br>&gt; regards<br>&gt; siddhant<br>&gt;<br>&gt;<br>&gt;
<br><br>&gt; &gt;<br>&gt; &gt; thanks alot<br>&gt; &gt; choi<br></blockquote></div><br>

------=_Part_112019_17193499.1176961991167--


--===============0799196766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0799196766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0799196766==--
