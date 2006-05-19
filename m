Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0605191439m1330205ckf3e85213195c9a4a@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] cannot " hci_create_connection "
In-Reply-To: <BAY111-F1767DE6A7429B539F50C6C98A70@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_45383_2168228.1148074768426"
References: <BAY111-F1767DE6A7429B539F50C6C98A70@phx.gbl>
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
Date: Fri, 19 May 2006 17:39:28 -0400

------=_Part_45383_2168228.1148074768426
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

use hcidump -X -V and pay attention to the output to see what happens.

-albert

On 5/19/06, ozkan gumus <ozkan_gumus@hotmail.com> wrote:
>
> hi mr holtmann,
>
> i have problem with hci_create_connection function at line 120.
> here's the code ,  when program comes to the line  of
> hci_create_connection function
> it always says :
>
>  #./simplescan
> scanning ...
> 00:0E:6D:3F:E0:73  ozkan
> Cannot create connection
>
>
> simplescan.c
>
> #include <stdio.h>
> #include <errno.h>
> #include <ctype.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> #include <getopt.h>
> #include <sys/param.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <signal.h>
> #include <termios.h>
> #include <fcntl.h>
> #include <getopt.h>
> #include <asm/types.h>
> #include <netinet/in.h>
>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
>
> int main(int argc, char **argv)
> {
>     inquiry_info *ii =3D NULL;
>     int max_rsp, num_rsp;
>     int dev_id, sock, len, flags;
>     int i;
>     char addr[19] =3D { 0 };
>     char name[248] =3D { 0 };
>  int measure ;
>
>     dev_id =3D hci_get_route(NULL);
>     sock =3D hci_open_dev( dev_id );
>     if (dev_id < 0 || sock < 0) {
>         perror("opening socket");
>         exit(1);
>     }
>
>     len  =3D 8;
>     max_rsp =3D 255;
>     flags =3D IREQ_CACHE_FLUSH;
>     ii =3D (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));
>     printf("scanning ...\n");
>     num_rsp =3D hci_inquiry(dev_id, len, max_rsp, NULL, &ii, flags);
>     if( num_rsp < 0 ) perror("hci_inquiry");
>
>     for (i =3D 0; i < num_rsp; i++) {
>         ba2str(&(ii+i)->bdaddr, addr);
>         memset(name, 0, sizeof(name));
>         if (hci_read_remote_name(sock, &(ii+i)->bdaddr, sizeof(name),
>             name, 0) < 0)
>         strcpy(name, "[unknown]");
>         printf("%s  %s\n", addr, name);
>   measure =3D read_rssi(&(ii+i)->bdaddr);
>   printf("the RSSI measure for %s is %d",name,measure);
>     }
>
>     free( ii );
>     close( sock );
>     return 0;
> }
>
>
> static int find_conn(int s, int dev_id, long arg)
> {
>  struct hci_conn_list_req *cl;
>  struct hci_conn_info *ci;
>  int i;
>
>  if (!(cl =3D malloc(10 * sizeof(*ci) + sizeof(*cl)))) {
>   perror("Can't allocate memory");
>   exit(1);
>  }
>  cl->dev_id =3D dev_id;
>  cl->conn_num =3D 10;
>  ci =3D cl->conn_info;
>
>  if (ioctl(s, HCIGETCONNLIST, (void*)cl)) {
>   perror("Can't get connection list");
>   exit(1);
>  }
>
>  for (i=3D0; i < cl->conn_num; i++, ci++)
>   if (!bacmp((bdaddr_t *)arg, &ci->bdaddr))
>    return 1;
>  return 0;
> }
>
>
> int read_rssi(char* address) {
>   int cc =3D 0;
>   int dd;
>   int dev_id;
>   uint16_t handle;
>   struct hci_conn_info_req *cr;
>   struct hci_request rq;
>   read_rssi_rp rp;
>   bdaddr_t bdaddr;
>
>   str2ba(address, &bdaddr);
>
>   dev_id =3D hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
>   if (dev_id < 0) {
>     dev_id =3D hci_get_route(&bdaddr);
>     cc =3D 1;
>   }
>   if (dev_id < 0) {
>     printf("Device not available\n");
>     exit(1);
>   }
>
>   dd =3D hci_open_dev(dev_id);
>   if (dd < 0) {
>     printf("Cannot open device\n");
>     exit(1);
>   }
> // ***************************   PROBLEM HERE *************************
>   if (cc) {
>     if (hci_create_connection(dd, &bdaddr, 0x0008 | 0x0010, 0, 0, &handle=
,
> 25000) < 0) {
>       printf("Cannot create connection\n");
>       close(dd);
>       exit(1);
>     }
>   }
>  // *****************************
> *****************************************
>   cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
>   if (!cr) {
>     printf("Could not allocate memory\n");
>     exit(1);
>   }
>
>   bacpy(&cr->bdaddr, &bdaddr);
>   cr->type =3D ACL_LINK;
>   if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
>     printf("Get connection info failed\n");
>     exit(1);
>   }
>
>   memset(&rq, 0, sizeof(rq));
>   rq.ogf    =3D OGF_STATUS_PARAM;
>   rq.ocf    =3D OCF_READ_RSSI;
>   rq.cparam =3D &cr->conn_info->handle;
>   rq.clen   =3D 2;
>   rq.rparam =3D &rp;
>   rq.rlen   =3D READ_RSSI_RP_SIZE;
>
>   if (hci_send_req(dd, &rq, 100) < 0) {
>     printf("Read RSSI failed\n");
>     exit(1);
>   }
>
>   if (rp.status) {
>     printf("Read RSSI returned (error) status 0x%2.2X\n", rp.status);
>     exit(1);
>   }
>
>   if (cc) {
>     hci_disconnect(dd, handle, 0x13, 10000);
>   }
>
>   close(dd);
>   free(cr);
>   printf("My RSSI is  : %d",rp.rssi);
>   return rp.rssi ;
> }
>
> can you give me some advise to resolve this problem, ? do you think my
> ptype or clkoffset are false ?
>
> i will be very grateful for a little help..
>
> thanks,
>
>
>
>
>
> ------------------------------
> Find just what you're after with the new, more precise MSN Search - try i=
t
> now! <http://g.msn.com/8HMAENUS/2731??PS=3D47575>------------------------=
------------------------------- Using Tomcat but
> need to do more? Need to support web services, security? Get stuff done
> quickly with pre-integrated technology to make your job easier Download I=
BM
> WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642_______________________________________________ Bluez-devel mailin=
g list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_45383_2168228.1148074768426
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

use hcidump -X -V and pay attention to the output to see what happens.<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 5/19/06, <b class=3D"gma=
il_sendername">ozkan gumus</b> &lt;<a href=3D"mailto:ozkan_gumus@hotmail.co=
m">ozkan_gumus@hotmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
<div><div style=3D""><p>hi mr holtmann, </p>
<p>i have problem with hci_create_connection function at line 120. <br>here=
's the code ,&nbsp; when program comes to the line&nbsp; of hci_create_conn=
ection function <br>it always says :</p>
<p>&nbsp;#./simplescan<br>scanning ...<br>00:0E:6D:3F:E0:73&nbsp; ozkan<br>=
Cannot create connection</p>
<p><br>simplescan.c</p>
<p>#include &lt;stdio.h&gt;<br>#include &lt;errno.h&gt;<br>#include &lt;cty=
pe.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;unistd.h&gt;<br>#inclu=
de &lt;stdlib.h&gt;<br>#include &lt;string.h&gt;<br>#include &lt;getopt.h
&gt;<br>#include &lt;sys/param.h&gt;<br>#include &lt;sys/ioctl.h&gt;<br>#in=
clude &lt;sys/socket.h&gt;<br>#include &lt;signal.h&gt;<br>#include &lt;ter=
mios.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;getopt.h&gt;<br>
#include &lt;asm/types.h&gt;<br>#include &lt;netinet/in.h&gt;</p>
<p>#include &lt;bluetooth/bluetooth.h&gt;<br>#include &lt;bluetooth/hci.h&g=
t;<br>#include &lt;bluetooth/hci_lib.h&gt;</p>
<p>int main(int argc, char **argv)<br>{<br>&nbsp;&nbsp;&nbsp; inquiry_info =
*ii =3D NULL;<br>&nbsp;&nbsp;&nbsp; int max_rsp, num_rsp;<br>&nbsp;&nbsp;&n=
bsp; int dev_id, sock, len, flags;<br>&nbsp;&nbsp;&nbsp; int i;<br>&nbsp;&n=
bsp;&nbsp; char addr[19] =3D { 0 };<br>&nbsp;&nbsp;&nbsp; char name[248] =
=3D { 0 };<br>&nbsp;int measure ;
</p>
<p>&nbsp;&nbsp;&nbsp; dev_id =3D hci_get_route(NULL);<br>&nbsp;&nbsp;&nbsp;=
 sock =3D hci_open_dev( dev_id );<br>&nbsp;&nbsp;&nbsp; if (dev_id &lt; 0 |=
| sock &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror(&quot=
;opening socket&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(=
1);<br>&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; len&nbsp; =3D 8;<br>&nbsp;&nbsp;&nbsp; max_rsp =3D 25=
5;<br>&nbsp;&nbsp;&nbsp; flags =3D IREQ_CACHE_FLUSH;<br>&nbsp;&nbsp;&nbsp; =
ii =3D (inquiry_info*)malloc(max_rsp * sizeof(inquiry_info));<br>&nbsp;&nbs=
p;&nbsp; printf(&quot;scanning ...\n&quot;);<br>&nbsp;&nbsp;&nbsp; num_rsp =
=3D hci_inquiry(dev_id, len, max_rsp, NULL, &amp;ii, flags);
<br>&nbsp;&nbsp;&nbsp; if( num_rsp &lt; 0 ) perror(&quot;hci_inquiry&quot;)=
;</p>
<p>&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_rsp; i++) {<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ba2str(&amp;(ii+i)-&gt;bdaddr, addr);<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(name, 0, sizeof(name));<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hci_read_remote_name(sock, &am=
p;(ii+i)-&gt;bdaddr, sizeof(name), <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name, 0) &lt; 0)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(name, &quot;[unknown]=
&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s&nbsp=
; %s\n&quot;, addr, name);<br>&nbsp;&nbsp;measure =3D read_rssi(&amp;(ii+i)=
-&gt;bdaddr);<br>&nbsp;&nbsp;printf(&quot;the RSSI measure for %s is %d&quo=
t;,name,measure);<br>
&nbsp;&nbsp;&nbsp; }</p>
<p>&nbsp;&nbsp;&nbsp; free( ii );<br>&nbsp;&nbsp;&nbsp; close( sock );<br>&=
nbsp;&nbsp;&nbsp; return 0;<br>}</p>
<p><br>static int find_conn(int s, int dev_id, long arg)<br>{<br>&nbsp;stru=
ct hci_conn_list_req *cl;<br>&nbsp;struct hci_conn_info *ci;<br>&nbsp;int i=
;</p>
<p>&nbsp;if (!(cl =3D malloc(10 * sizeof(*ci) + sizeof(*cl)))) {<br>&nbsp;&=
nbsp;perror(&quot;Can't allocate memory&quot;);<br>&nbsp;&nbsp;exit(1);<br>=
&nbsp;}<br>&nbsp;cl-&gt;dev_id =3D dev_id;<br>&nbsp;cl-&gt;conn_num =3D 10;=
<br>&nbsp;ci =3D cl-&gt;conn_info;</p>
<p>&nbsp;if (ioctl(s, HCIGETCONNLIST, (void*)cl)) {<br>&nbsp;&nbsp;perror(&=
quot;Can't get connection list&quot;);<br>&nbsp;&nbsp;exit(1);<br>&nbsp;}</=
p>
<p>&nbsp;for (i=3D0; i &lt; cl-&gt;conn_num; i++, ci++)<br>&nbsp;&nbsp;if (=
!bacmp((bdaddr_t *)arg, &amp;ci-&gt;bdaddr))<br>&nbsp;&nbsp;&nbsp;return 1;=
<br>&nbsp;return 0;<br>}</p>
<p><br>int read_rssi(char* address) {<br>&nbsp; int cc =3D 0;<br>&nbsp; int=
 dd;<br>&nbsp; int dev_id;<br>&nbsp; uint16_t handle;<br>&nbsp; struct hci_=
conn_info_req *cr;<br>&nbsp; struct hci_request rq;<br>&nbsp; read_rssi_rp =
rp;<br>&nbsp; bdaddr_t bdaddr;<br>&nbsp; <br>
&nbsp; str2ba(address, &amp;bdaddr);<br>&nbsp; <br>&nbsp; dev_id =3D hci_fo=
r_each_dev(HCI_UP, find_conn, (long) &amp;bdaddr);<br>&nbsp; if (dev_id &lt=
; 0) {<br>&nbsp;&nbsp;&nbsp; dev_id =3D hci_get_route(&amp;bdaddr);<br>&nbs=
p;&nbsp;&nbsp; cc =3D 1;<br>&nbsp; }<br>&nbsp; if (dev_id &lt; 0) {
<br>&nbsp;&nbsp;&nbsp; printf(&quot;Device not available\n&quot;);<br>&nbsp=
;&nbsp;&nbsp; exit(1);<br>&nbsp; }<br>&nbsp; <br>&nbsp; dd =3D hci_open_dev=
(dev_id);<br>&nbsp; if (dd &lt; 0) {<br>&nbsp;&nbsp;&nbsp; printf(&quot;Can=
not open device\n&quot;);<br>&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp; }<br>// =
***************************&nbsp;&nbsp; PROBLEM HERE=20
************************* <br>&nbsp; if (cc) {<br>&nbsp;&nbsp;&nbsp; if (hc=
i_create_connection(dd, &amp;bdaddr, 0x0008 | 0x0010, 0, 0, &amp;handle, 25=
000) &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Cannot create=
 connection\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(dd);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp;&nbsp;&nbsp; }<br>&nbs=
p; }<br>&nbsp;// ***************************** ****************************=
*************<br>&nbsp; cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_=
info));<br>&nbsp; if (!cr) {<br>&nbsp;&nbsp;&nbsp; printf(&quot;Could not a=
llocate memory\n&quot;);
<br>&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp=
; bacpy(&amp;cr-&gt;bdaddr, &amp;bdaddr);<br>&nbsp; cr-&gt;type =3D ACL_LIN=
K;<br>&nbsp; if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) &lt; 0) {<br=
>&nbsp;&nbsp;&nbsp; printf(&quot;Get connection info failed\n&quot;);
<br>&nbsp;&nbsp;&nbsp;=20
exit(1);<br>&nbsp; }<br>&nbsp; <br>&nbsp; memset(&amp;rq, 0, sizeof(rq));<b=
r>&nbsp; rq.ogf&nbsp;&nbsp;&nbsp; =3D OGF_STATUS_PARAM;<br>&nbsp; rq.ocf&nb=
sp;&nbsp;&nbsp; =3D OCF_READ_RSSI;<br>&nbsp; rq.cparam =3D &amp;cr-&gt;conn=
_info-&gt;handle;<br>&nbsp; rq.clen&nbsp;&nbsp; =3D 2;<br>&nbsp; rq.rparam =
=3D &amp;rp;
<br>&nbsp; rq.rlen&nbsp;&nbsp; =3D READ_RSSI_RP_SIZE;<br>&nbsp; <br>&nbsp; =
if (hci_send_req(dd, &amp;rq, 100) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; printf(&=
quot;Read RSSI failed\n&quot;);<br>&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp; }<=
br>&nbsp; <br>&nbsp; if (rp.status) {<br>&nbsp;&nbsp;&nbsp; printf(&quot;Re=
ad RSSI returned (error) status 0x%2.2X\n&quot;,=20
rp.status);<br>&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp; }<br>&nbsp; <br>&nbsp;=
 if (cc) {<br>&nbsp;&nbsp;&nbsp; hci_disconnect(dd, handle, 0x13, 10000);<b=
r>&nbsp; }<br>&nbsp; <br>&nbsp; close(dd);<br>&nbsp; free(cr);<br>&nbsp; pr=
intf(&quot;My RSSI is&nbsp; : %d&quot;,rp.rssi);<br>&nbsp; return rp.rssi ;=
<br>
} </p>
<p>can you give me some advise to resolve this problem, ? do you think my p=
type or clkoffset are false ? </p>
<p>i will be very grateful for a little help..</p>
<p>thanks,</p></div><div><span class=3D"ad">
<p>&nbsp;</p>
<p>&nbsp;</p></span></div><div></div></div><div><span class=3D"ad"><br clea=
r=3D"all"><hr> <a href=3D"http://g.msn.com/8HMAENUS/2731??PS=3D47575" targe=
t=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Find =
just what you're after with the new, more precise MSN Search - try it now!
</a>=20



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;b=
id=3D263057&amp;dat=3D121642" target=3D"_blank" onclick=3D"return top.js.Op=
enExtLink(window,event,this)">http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp=
;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642
</a>
_______________________________________________
Bluez-devel mailing list
<a href=3D"mailto:Bluez-devel@lists.sourceforge.net" target=3D"_blank" oncl=
ick=3D"return top.js.OpenExtLink(window,event,this)">Bluez-devel@lists.sour=
ceforge.net</a>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a>
</span></div></blockquote></div><br>

------=_Part_45383_2168228.1148074768426--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
