Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <94e407f00511080958j74841800k45532fdbd149e9cd@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] C Program for Getting Link Quality
In-Reply-To: <1131454195.5824.161.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12203_6344898.1131472690679"
References: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
	 <1131454195.5824.161.camel@blade>
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
Date: Wed, 9 Nov 2005 01:58:10 +0800

------=_Part_12203_6344898.1131472690679
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel

I did a yum update bluez*.

The verion I'm using is:

[root@174-15 bluetooth]# ls -l
total 116
-rw-r--r-- 1 root root 3607 Mar 2 2005 bluetooth.h

On including sys/socket.h..the error is the same:

[root@174-15 cprog]# gcc -o getlq getlq.c -lbluetooth
getlq.c: In function 'main':
getlq.c:54: error: 'hci_conn_info_req' undeclared (first use in this
function)
getlq.c:54: error: (Each undeclared identifier is reported only once
getlq.c:54: error: for each function it appears in.)
getlq.c:54: error: syntax error before ')' token
getlq.c:60: error: syntax error before 'int'
getlq.c: At top level:
getlq.c:66: error: syntax error before '&' token
getlq.c:86: error: 'rp' undeclared here (not in a function)
getlq.c:87: error: syntax error before string constant
getlq.c:87: error: conflicting types for 'printf'
getlq.c:87: note: a parameter list with an ellipsis can't match an empty
parameter name list declaration
getlq.c:87: warning: data definition has no type or storage class
getlq.c:89: warning: parameter names (without types) in function declaratio=
n
getlq.c:89: warning: data definition has no type or storage class
getlq.c:90: warning: parameter names (without types) in function declaratio=
n
getlq.c:90: error: conflicting types for 'free'
/usr/include/stdlib.h:601: error: previous declaration of 'free' was here
getlq.c:90: warning: data definition has no type or storage class
getlq.c:93: error: syntax error before '}' token

Any idea why its saying hci_conn_info_req undeclared?

Regards
Arpit

On 11/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > I've written a C program to help me get the link quality between two
> > bluetooth dongles. But, on compilation there are problems with the
> > definition:
> >
> > cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(struct
> > hci_conn_info)); (Error: 'hci_conn_info_req' undeclared)
> >
> > This the program I'm running:
> >
> > //Program for finding LQ
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <bluetooth/bluetooth.h>
> > #include <bluetooth/hci.h>
> > #include <bluetooth/hci_lib.h>
>
> don't forget to include <sys/socket.h> before <bluetooth/bluetooth.h> or
> use a newer version of the Bluetooth library.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_12203_6344898.1131472690679
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel<br>
<br>
I did a yum update bluez*.<br>
<br>
The verion I'm using is:<br>
<br>
<span style=3D"color: rgb(255, 0, 0);">[root@174-15 bluetooth]# ls -l</span=
><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">total 116</span><br style=3D"color: =
rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">-rw-r--r--&nbsp; 1 root root&nbsp; 3=
607 Mar&nbsp; 2&nbsp; 2005 bluetooth.h</span><br>
<br>
On including sys/socket.h..the error is the same:<br>
<br>
<span style=3D"color: rgb(255, 0, 0);">[root@174-15 cprog]# gcc -o getlq ge=
tlq.c -lbluetooth</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c: In function 'main':</span><=
br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:54: error: 'hci_conn_info_re=
q' undeclared (first use in this function)</span><br style=3D"color: rgb(25=
5, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:54: error: (Each undeclared =
identifier is reported only once</span><br style=3D"color: rgb(255, 0, 0);"=
>
<span style=3D"color: rgb(255, 0, 0);">getlq.c:54: error: for each function=
 it appears in.)</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:54: error: syntax error befo=
re ')' token</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:60: error: syntax error befo=
re 'int'</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c: At top level:</span><br sty=
le=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:66: error: syntax error befo=
re '&amp;' token</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:86: error: 'rp' undeclared h=
ere (not in a function)</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:87: error: syntax error befo=
re string constant</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:87: error: conflicting types=
 for 'printf'</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:87: note: a parameter list w=
ith an ellipsis can't match an empty parameter name list declaration</span>=
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:87: warning: data definition=
 has no type or storage class</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:89: warning: parameter names=
 (without types) in function declaration</span><br style=3D"color: rgb(255,=
 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:89: warning: data definition=
 has no type or storage class</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:90: warning: parameter names=
 (without types) in function declaration</span><br style=3D"color: rgb(255,=
 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:90: error: conflicting types=
 for 'free'</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">/usr/include/stdlib.h:601: error: pr=
evious declaration of 'free' was here</span><br style=3D"color: rgb(255, 0,=
 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:90: warning: data definition=
 has no type or storage class</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">getlq.c:93: error: syntax error befo=
re '}' token</span><br>
<br>
Any idea why its saying hci_conn_info_req undeclared?<br>
<br>
Regards<br>
Arpit<br><br><div><span class=3D"gmail_quote">On 11/8/05, <b class=3D"gmail=
_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org"=
>marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
Hi Arpit,<br><br>&gt; I've written a C program to help me get the link qual=
ity between two<br>&gt; bluetooth dongles. But, on compilation there are pr=
oblems with the<br>&gt; definition:<br>&gt;<br>&gt; cr =3D (hci_conn_info_r=
eq *)malloc(sizeof(*cr) + sizeof(struct
<br>&gt; hci_conn_info)); (Error: 'hci_conn_info_req' undeclared)<br>&gt;<b=
r>&gt; This the program I'm running:<br>&gt;<br>&gt; //Program for finding =
LQ<br>&gt; #include &lt;stdio.h&gt;<br>&gt; #include &lt;stdlib.h&gt;<br>
&gt; #include &lt;unistd.h&gt;<br>&gt; #include &lt;bluetooth/bluetooth.h&g=
t;<br>&gt; #include &lt;bluetooth/hci.h&gt;<br>&gt; #include &lt;bluetooth/=
hci_lib.h&gt;<br><br>don't forget to include &lt;sys/socket.h&gt; before &l=
t;bluetooth/bluetooth.h&gt; or
<br>use a newer version of the Bluetooth library.<br><br>Regards<br><br>Mar=
cel<br><br><br><br><br>----------------------------------------------------=
---<br>SF.Net email is sponsored by:<br>Tame your development challenges wi=
th Apache's Geronimo App Server. Download
<br>it for free - -and be entered to win a 42&quot; plasma tv or your very =
own<br>Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http://source=
forge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br>________=
_______________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_12203_6344898.1131472690679--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
