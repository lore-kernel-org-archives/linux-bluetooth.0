Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7100_1782598.1131442277863"
Subject: [Bluez-devel] C Program for Getting Link Quality
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
Date: Tue, 8 Nov 2005 17:31:17 +0800

------=_Part_7100_1782598.1131442277863
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

I've written a C program to help me get the link quality between two
bluetooth dongles. But, on compilation there are problems with the
definition:

cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(struct
hci_conn_info)); (Error: 'hci_conn_info_req' undeclared)

This the program I'm running:

//Program for finding LQ
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int main(int argc, char **argv)
{
int dev_id =3D -1;
uint16_t *handle;
struct hci_conn_info_req *cr;
struct hci_request rq;
read_link_quality_rp rp;
bdaddr_t bdaddr;
int dd;
char addr[18] =3D "00:10:60:B3:2C:F8";

//connecting
int ptype;
uint8_t role;

role =3D 0;
ptype =3D HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH3 | HCI_DH5;
str2ba(addr, &bdaddr);


if(dev_id < 0)
{
dev_id =3D hci_get_route(&bdaddr);
if(dev_id < 0)
{
printf("Cannot connect\n");
return 0;
}
}

if(hci_create_connection(dd, &bdaddr, htobs(ptype), 0, role, handle,4000) <
0)
{
//printf("Cannot create connection\n");
//return 0;
}


//get connection links
dd =3D hci_open_dev(dev_id);
if (dd < 0)
{
printf("HCI device open failed\n");
return 0;
}

cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(struct
hci_conn_info));
if (!cr)
return 0;

bacpy(&cr->bdaddr, &bdaddr);
cr->type =3D ACL_LINK;
if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0)
{
printf("Get connection info failed\n");
return 0;
}

memset(&rq, 0, sizeof(rq));
rq.ogf =3D OGF_STATUS_PARAM;
rq.ocf =3D OCF_READ_LINK_QUALITY;
rq.cparam =3D &cr->conn_info->handle;
rq.clen =3D 2;
rq.rparam =3D &rp;
rq.rlen =3D READ_LINK_QUALITY_RP_SIZE;

if (hci_send_req(dd, &rq, 100) < 0)
{
printf("HCI get_link_quality request failed\n");
return 0;
}

if (rp.status)
{
printf("HCI get_link_quality cmd failed\n", rp.status);
return 0;
}

int link_quality =3D rp.link_quality;
printf("Link quality for %s: %d", addr, link_quality);

close(dd);
free(cr);

//return link_quality;
}

On compilation, I get the following errors:

In file included from getlq.c:6:
/usr/include/bluetooth/hci.h:1113: error: syntax error before 'sa_family_t'
/usr/include/bluetooth/hci.h:1115: error: syntax error before '}' token
getlq.c: In function 'main':
getlq.c:53: error: 'hci_conn_info_req' undeclared (first use in this
function)
getlq.c:53: error: (Each undeclared identifier is reported only once
getlq.c:53: error: for each function it appears in.)
getlq.c:53: error: syntax error before ')' token
getlq.c:59: error: syntax error before 'int'
getlq.c: At top level:
getlq.c:65: error: syntax error before '&' token
getlq.c:85: error: 'rp' undeclared here (not in a function)
getlq.c:86: error: syntax error before string constant
getlq.c:86: error: conflicting types for 'printf'
getlq.c:86: note: a parameter list with an ellipsis can't match an empty
parameter name list declaration
getlq.c:86: warning: data definition has no type or storage class
getlq.c:88: warning: parameter names (without types) in function declaratio=
n
getlq.c:88: warning: data definition has no type or storage class
getlq.c:89: warning: parameter names (without types) in function declaratio=
n
getlq.c:89: error: conflicting types for 'free'
/usr/include/stdlib.h:601: error: previous declaration of 'free' was here
getlq.c:89: warning: data definition has no type or storage class
getlq.c:92: error: syntax error before '}' token

Any idea why I'm getting the compilation error?

Regards
Arpit

------=_Part_7100_1782598.1131442277863
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi<br>
<br>
I've written a C program to help me get the link quality between two
bluetooth dongles. But, on compilation there are problems with the
definition: <br>
<br>
cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(struct hci_conn_inf=
o)); <span style=3D"font-style: italic; font-weight: bold;">(Error: 'hci_co=
nn_info_req' undeclared)</span><br>
<br>
This the program I'm running:<br>
<br>
//Program for finding LQ<br>
#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
#include &lt;unistd.h&gt;<br>
#include &lt;bluetooth/bluetooth.h&gt;<br>
#include &lt;bluetooth/hci.h&gt;<br>
#include &lt;bluetooth/hci_lib.h&gt;<br>
<br>
int main(int argc, char **argv)<br>
{<br>
&nbsp;&nbsp;&nbsp; int dev_id =3D -1;<br>
&nbsp;&nbsp;&nbsp; uint16_t *handle;<br>
&nbsp;&nbsp;&nbsp; struct hci_conn_info_req *cr;<br>
&nbsp;&nbsp;&nbsp; struct hci_request rq;<br>
&nbsp;&nbsp;&nbsp; read_link_quality_rp rp;<br>
&nbsp;&nbsp;&nbsp; bdaddr_t bdaddr;<br>
&nbsp;&nbsp;&nbsp; int dd;<br>
&nbsp;&nbsp;&nbsp; char addr[18] =3D &quot;00:10:60:B3:2C:F8&quot;;<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; //connecting<br>
&nbsp;&nbsp;&nbsp; int ptype;<br>
&nbsp;&nbsp;&nbsp; uint8_t role;<br>
<br>
&nbsp;&nbsp;&nbsp; role =3D 0;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; ptype =3D HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH=
3 | HCI_DH5;<br>
&nbsp;&nbsp;&nbsp; str2ba(addr, &amp;bdaddr);<br>
<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; if(dev_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_id =3D hci_get_route(&amp;bdaddr)=
;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if(dev_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;Canno=
t connect\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &nbsp;}<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; if(hci_create_connection(dd, &amp;bdaddr, htobs(ptype), =
0, role, handle,4000) &lt; 0)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; //printf(&quot;Cannot create connection\n&q=
uot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; //get connection links<br>
&nbsp;&nbsp;&nbsp; dd =3D hci_open_dev(dev_id);<br>
&nbsp;&nbsp;&nbsp; if (dd &lt; 0) <br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;HCI device open failed\n=
&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(=
struct hci_conn_info));<br>
&nbsp;&nbsp;&nbsp; if (!cr)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
<br>
&nbsp;&nbsp;&nbsp; bacpy(&amp;cr-&gt;bdaddr, &amp;bdaddr);<br>
&nbsp;&nbsp;&nbsp; cr-&gt;type =3D ACL_LINK;<br>
&nbsp;&nbsp;&nbsp; if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) &lt; 0=
) <br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;Get connection info fail=
ed\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; memset(&amp;rq, 0, sizeof(rq));<br>
&nbsp;&nbsp;&nbsp; rq.ogf&nbsp;&nbsp;&nbsp; =3D OGF_STATUS_PARAM;<br>
&nbsp;&nbsp;&nbsp; rq.ocf&nbsp;&nbsp;&nbsp; =3D OCF_READ_LINK_QUALITY;<br>
&nbsp;&nbsp;&nbsp; rq.cparam =3D &amp;cr-&gt;conn_info-&gt;handle;<br>
&nbsp;&nbsp;&nbsp; rq.clen&nbsp;&nbsp; =3D 2;<br>
&nbsp;&nbsp;&nbsp; rq.rparam =3D &amp;rp;<br>
&nbsp;&nbsp;&nbsp; rq.rlen&nbsp;&nbsp; =3D READ_LINK_QUALITY_RP_SIZE;<br>
<br>
&nbsp;&nbsp;&nbsp; if (hci_send_req(dd, &amp;rq, 100) &lt; 0)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;HCI get_link_quality req=
uest failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; if (rp.status) <br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;HCI get_link_quality cmd=
 failed\n&quot;, rp.status);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; int link_quality =3D rp.link_quality;<br>
&nbsp;&nbsp;&nbsp; printf(&quot;Link quality for %s: %d&quot;, addr, link_q=
uality);<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; close(dd);<br>
&nbsp;&nbsp;&nbsp; free(cr);<br>
<br>
&nbsp;&nbsp;&nbsp; //return link_quality;<br>
}<br>
<br>
<span style=3D"font-weight: bold;">On compilation, I get the following erro=
rs:</span><br style=3D"font-weight: bold;">
<br style=3D"font-weight: bold;">
<span style=3D"font-style: italic;">In file included from getlq.c:6:</span>=
<br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">/usr/include/bluetooth/hci.h:1113: erro=
r: syntax error before 'sa_family_t'</span><br style=3D"font-style: italic;=
">
<span style=3D"font-style: italic;">/usr/include/bluetooth/hci.h:1115: erro=
r: syntax error before '}' token</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c: In function 'main':</span><br =
style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:53: error: 'hci_conn_info_req' =
undeclared (first use in this function)</span><br style=3D"font-style: ital=
ic;">
<span style=3D"font-style: italic;">getlq.c:53: error: (Each undeclared ide=
ntifier is reported only once</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:53: error: for each function it=
 appears in.)</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:53: error: syntax error before =
')' token</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:59: error: syntax error before =
'int'</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c: At top level:</span><br style=
=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:65: error: syntax error before =
'&amp;' token</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:85: error: 'rp' undeclared here=
 (not in a function)</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:86: error: syntax error before =
string constant</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:86: error: conflicting types fo=
r 'printf'</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:86: note: a parameter list with=
 an ellipsis can't match an empty parameter name list declaration</span><br=
 style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:86: warning: data definition ha=
s no type or storage class</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:88: warning: parameter names (w=
ithout types) in function declaration</span><br style=3D"font-style: italic=
;">
<span style=3D"font-style: italic;">getlq.c:88: warning: data definition ha=
s no type or storage class</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:89: warning: parameter names (w=
ithout types) in function declaration</span><br style=3D"font-style: italic=
;">
<span style=3D"font-style: italic;">getlq.c:89: error: conflicting types fo=
r 'free'</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">/usr/include/stdlib.h:601: error: previ=
ous declaration of 'free' was here</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:89: warning: data definition ha=
s no type or storage class</span><br style=3D"font-style: italic;">
<span style=3D"font-style: italic;">getlq.c:92: error: syntax error before =
'}' token</span><br style=3D"font-style: italic;">
<br>
Any idea why I'm getting the compilation error?<br>
<br>
Regards<br>
Arpit<br>


------=_Part_7100_1782598.1131442277863--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
