Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <94e407f00511090452m7f86753bq6f1ba05a8653379f@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] C Program for Getting Link Quality
In-Reply-To: <1131473837.5544.4.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_23466_26367994.1131540770623"
References: <94e407f00511080131u11f01d79x65d05cfe47ccbb7@mail.gmail.com>
	 <1131454195.5824.161.camel@blade>
	 <94e407f00511080958j74841800k45532fdbd149e9cd@mail.gmail.com>
	 <1131473837.5544.4.camel@blade>
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
Date: Wed, 9 Nov 2005 20:52:50 +0800

------=_Part_23466_26367994.1131540770623
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel

Yes, I forgot to include the icotl.h as well.Anyway, for I changed the
definition of: cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(stru=
ct
hci_conn_info)); to this: cr =3D (struct hci_conn_info_req*)
malloc(sizeof(struct hci_conn_info_req) + sizeof(struct hci_conn_info)); .
This doesn't give me the error any more.

However, running the compiled program results in: Get connection info faile=
d

//Program for finding LQ
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/l2cap.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

int main(int argc, char **argv)
{
 int dev_id;
 uint16_t *handle;
 struct hci_conn_info_req *cr=3D0;
 struct hci_request rq;
 read_link_quality_rp rp;
 bdaddr_t bdaddr;
 int dd;
 int err=3D0;
 char addr[18] =3D "00:10:60:B3:2C:F3";


 printf("Link quality for %s: ", addr);

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

 if(hci_create_connection(dd, &bdaddr, htobs(ptype), 0, role, handle,4000) =
<
0)
 {
 //printf("Cannot create connection\n");
 //return 0;
 }


 //get connection links
 dd =3D hci_open_dev(dev_id);
 if (dd < 0) {
 printf("HCI device open failed\n");
 return 0;
 }

 //cr =3D (hci_conn_info_req *)malloc(sizeof(*cr) + sizeof(struct
hci_conn_info));
 cr =3D (struct hci_conn_info_req*) malloc(sizeof(struct hci_conn_info_req)=
 +
sizeof(struct hci_conn_info));
 if (!cr)
 {
 return 0;
 }

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

Any idea what might be wrong?

Regards
Arpit


On 11/9/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > I did a yum update bluez*.
> >
> > The verion I'm using is:
> >
> > [root@174-15 bluetooth]# ls -l
> > total 116
> > -rw-r--r-- 1 root root 3607 Mar 2 2005 bluetooth.h
> >
> > On including sys/socket.h..the error is the same:
>
> maybe <sys/ioctl.h> is also missing.
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

------=_Part_23466_26367994.1131540770623
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel<br>
<br>
Yes, I forgot to include the icotl.h as well.Anyway, for I changed the defi=
nition of: <span style=3D"font-style: italic;">cr =3D (hci_conn_info_req *)=
malloc(sizeof(*cr) + sizeof(struct hci_conn_info));</span> to this: <span s=
tyle=3D"font-weight: bold;">
cr =3D (struct hci_conn_info_req*) malloc(sizeof(struct hci_conn_info_req) =
+ sizeof(struct hci_conn_info));</span> . This doesn't give me the error an=
y more.<br>
<br>
However, running the compiled program results in:&nbsp; Get connection info=
 failed<br>
<br>
<span style=3D"color: rgb(255, 0, 0);">//Program for finding LQ</span><br s=
tyle=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;stdio.h&gt;</span><br s=
tyle=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;stdlib.h&gt;</span><br =
style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;unistd.h&gt;</span><br =
style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;errno.h&gt;</span><br s=
tyle=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;sys/ioctl.h&gt;</span><=
br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;sys/socket.h&gt;</span>=
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;sys/poll.h&gt;</span><b=
r style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/bluetooth.h&g=
t;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/hci.h&gt;</sp=
an><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/l2cap.h&gt;</=
span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/hci_lib.h&gt;=
</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/rfcomm.h&gt;<=
/span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/sdp.h&gt;</sp=
an><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">#include &lt;bluetooth/sdp_lib.h&gt;=
</span><br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">int main(int argc, char **argv)</spa=
n><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">{</span><br style=3D"color: rgb(255,=
 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; int dev_id;</span=
><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; uint16_t *handle;=
</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; struct hci_conn_i=
nfo_req *cr=3D0;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; struct hci_reques=
t rq;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; read_link_quality=
_rp rp;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; bdaddr_t bdaddr;<=
/span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; int dd;</span><br=
 style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; int err=3D0;</spa=
n><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; char addr[18] =3D=
 &quot;00:10:60:B3:2C:F3&quot;;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; printf(&quot;Link=
 quality for %s: &quot;, addr);</span><br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; //connecting</spa=
n><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; int ptype;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; uint8_t role;</span><br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; role =3D 0;&nbsp;&nbsp;&nbsp; </span><br style=3D"color: rgb(255, 0,=
 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ptype =3D HCI_DM1 | HCI_DM3 | HCI_DM5 | HCI_DH1 | HCI_DH3 | HCI_DH5;=
</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; str2ba(addr, &amp=
;bdaddr);</span><br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if(dev_id &lt; 0)</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; {</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; dev_id =3D hci_get_route(&amp;bdaddr);</span><br style=3D"color: rgb(255,=
 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; if(dev_id &lt; 0)</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; {</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; printf(&quot;Cannot connect\n&quot;);</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; return 0;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; }</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;}</span><br=
 style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; </span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if(hci_create_connection(dd, &amp;bdaddr, htobs(ptype), 0, role, han=
dle,4000) &lt; 0)</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; {</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; //printf(&quot;Cannot create connection\n&quot;);</span><br style=3D=
"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; //return 0;</span=
><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; }</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; //get connection =
links</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; dd =3D hci_open_d=
ev(dev_id);</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; if (dd &lt; 0) {<=
/span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; printf(&quot;HCI device open failed\n&quot;);</span><br style=3D"color: r=
gb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; return 0;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; }</span><br style=
=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; //cr =3D (hci_con=
n_info_req *)malloc(sizeof(*cr) + sizeof(struct hci_conn_info));</span><br =
style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; cr =3D (struct hci_conn_info_req*)
malloc(sizeof(struct hci_conn_info_req) + sizeof(struct hci_conn_info));</s=
pan><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; if (!cr)</span><b=
r style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; {</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; return 0;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; }</span><br style=
=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; bacpy(&amp;cr-&gt=
;bdaddr, &amp;bdaddr);</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; cr-&gt;type =3D A=
CL_LINK;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0); font-weight: bold;">&nbsp;&nbsp;&nbsp=
; if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) &lt; 0) </span><br styl=
e=3D"color: rgb(255, 0, 0); font-weight: bold;">
<span style=3D"color: rgb(255, 0, 0); font-weight: bold;">&nbsp;&nbsp;&nbsp=
; {</span><br style=3D"color: rgb(255, 0, 0); font-weight: bold;">
<span style=3D"color: rgb(255, 0, 0); font-weight: bold;">&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; printf(&quot;Get connection info failed\n&quot;);</spa=
n><br style=3D"color: rgb(255, 0, 0); font-weight: bold;">
<span style=3D"color: rgb(255, 0, 0); font-weight: bold;">&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; return 0;</span><br style=3D"color: rgb(255, 0, 0); fo=
nt-weight: bold;">
<span style=3D"color: rgb(255, 0, 0); font-weight: bold;">&nbsp;&nbsp;&nbsp=
; }</span><br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; memset(&amp;rq, 0=
, sizeof(rq));</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; rq.ogf&nbsp;&nbsp=
;&nbsp; =3D OGF_STATUS_PARAM;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; rq.ocf&nbsp;&nbsp=
;&nbsp; =3D OCF_READ_LINK_QUALITY;</span><br style=3D"color: rgb(255, 0, 0)=
;">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; rq.cparam =3D &am=
p;cr-&gt;conn_info-&gt;handle;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; rq.clen&nbsp;&nbs=
p; =3D 2;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; rq.rparam =3D &am=
p;rp;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; rq.rlen&nbsp;&nbs=
p; =3D READ_LINK_QUALITY_RP_SIZE;</span><br style=3D"color: rgb(255, 0, 0);=
">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; if (hci_send_req(=
dd, &amp;rq, 100) &lt; 0)</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; {</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; printf(&quot;HCI get_link_quality request failed\n&quot;);</span><br styl=
e=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; return 0;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; }</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; if (rp.status) </=
span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; {</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; printf(&quot;HCI get_link_quality cmd failed\n&quot;, rp.status);</span><=
br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; return 0;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; }</span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; int link_quality =
=3D rp.link_quality;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; printf(&quot;Link=
 quality for %s: %d&quot;, addr, link_quality);</span><br style=3D"color: r=
gb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; </span><br style=
=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; close(dd);</span>=
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; free(cr);</span><=
br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">&nbsp;&nbsp;&nbsp; //return link_qua=
lity;</span><br style=3D"color: rgb(255, 0, 0);">
<span style=3D"color: rgb(255, 0, 0);">}</span><br>
<br>
Any idea what might be wrong?<br>

<br>

Regards<br>

Arpit<br>
<br>
<br><div><span class=3D"gmail_quote">On 11/9/05, <b class=3D"gmail_senderna=
me">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">marcel=
@holtmann.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
Hi Arpit,<br><br>&gt; I did a yum update bluez*.<br>&gt;<br>&gt; The verion=
 I'm using is:<br>&gt;<br>&gt; [root@174-15 bluetooth]# ls -l<br>&gt; total=
 116<br>&gt; -rw-r--r--&nbsp;&nbsp;1 root root&nbsp;&nbsp;3607 Mar&nbsp;&nb=
sp;2&nbsp;&nbsp;2005 bluetooth.h<br>

&gt;<br>&gt; On including sys/socket.h..the error is the same:<br><br>maybe=
 &lt;sys/ioctl.h&gt; is also missing.<br><br>Regards<br><br>Marcel<br><br><=
br><br><br>-------------------------------------------------------<br>
SF.Net
 email is sponsored by:<br>Tame your development challenges with Apache's G=
eronimo App Server. Download<br>it for free - -and be entered to win a 42&q=
uot; plasma tv or your very own<br>Sony(tm)PSP.&nbsp;&nbsp;Click here to pl=
ay: <a href=3D"http://sourceforge.net/geronimo.php" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">

http://sourceforge.net/geronimo.php</a><br>________________________________=
_______________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-deve=
l@lists.sourceforge.net" target=3D"_blank" onclick=3D"return top.js.OpenExt=
Link(window,event,this)">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel" target=3D"_blank" onclick=3D"return top.=
js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>


------=_Part_23466_26367994.1131540770623--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
