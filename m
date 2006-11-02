Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: 2 Nov 2006 04:39:06 -0000
Message-ID: <20061102043906.3875.qmail@webmail31.rediffmail.com>
MIME-Version: 1.0
From: "Rupesh Gujare" <rupesh_gujare@rediffmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Need Help In SDP Programming......
Reply-To: Rupesh Gujare <rupesh_gujare@rediffmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1933597351=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 This is a multipart mime message


--===============1933597351==
Content-type: multipart/alternative;
	boundary="Next_1162442346---0-202.54.124.130-3863"

 This is a multipart mime message


--Next_1162442346---0-202.54.124.130-3863
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,=0A    I am a newbie to bluez programming. and i am currently wri=
ting a code that will discover all nearby bluetooth devices and make a SDP =
enquiry to know on which channel "OBEX Object Push" service is running.=0A =
  For this purpose i have gone through a quiet a few documentation and samp=
le code. And i am ready with some code.=0A    =0A   Now my question is why =
it is required to give a "sleep(1)" call before sdp_connect() call? If i do=
nt give it, sdp connection simply fails. And how should i reduce over all t=
ime of making discovery of devices and connecting to their respective SDP s=
ervers.=0A  I am using USB dongle as a local bluetooth device.=0A=0A  Can s=
omeone help me on this issues? And how can i write better and efficient cod=
e?=0AAny reviews and suggestions for improvement r welcomed.=0A Any help wi=
ll be greatly appreciated.=0AThanks in advance =0ARupesh..=0A=0AMy code :--=
--=0A=0A#include <stdio.h>=0A#include <stdlib.h>=0A#include <unistd.h>=0A#i=
nclude <sys/socket.h>=0A#include <bluetooth/bluetooth.h>=0A#include <blueto=
oth/hci.h>=0A#include <bluetooth/hci_lib.h>=0A#include <bluetooth/sdp.h>=0A=
#include <bluetooth/sdp_lib.h>=0A=0Aint port_search(bdaddr_t *target);=0A=
=0Aint main(int argc, char **argv)=0A{=0A    inquiry_info *ii =3D NULL;=0A =
   int max_rsp, num_rsp;=0A    int dev_id, sock, len, flags;=0A    int i;=
=0A    char addr[19] =3D { 0 };=0A    char name[248] =3D { 0 };=0A    dev_i=
d =3D hci_get_route(NULL);=0A    sock =3D hci_open_dev( dev_id );=0A       =
                            =0A  if (dev_id < 0 || sock < 0) {=0A      perr=
or("opening socket");=0A      exit(1);=0A  }=0A  len =3D 8;=0A  max_rsp =3D=
 255;=0A  flags =3D IREQ_CACHE_FLUSH;=0A  ii =3D (inquiry_info*)malloc(max_=
rsp * sizeof(inquiry_info));=0A  num_rsp =3D hci_inquiry(dev_id, len, max_r=
sp, NULL, &ii, flags);=0A  printf("%d Blue devices found\n",num_rsp);=0A  i=
f( num_rsp < 0 ) perror("hci_inquiry");=0A  for (i =3D 0; i < num_rsp; i++)=
 {=0A      ba2str(&(ii+i)->bdaddr, addr);=0A      memset(name, 0, sizeof(na=
me));=0A      if (hci_read_remote_name(sock, &(ii+i)->bdaddr, sizeof(name),=
=0A          name, 0) < 0)=0A      strcpy(name, "[unknown]");=0A      print=
f("%s %s\n", addr, name);=0A	  port_search(&(ii+i)->bdaddr);=0A  }=0A  free=
( ii );=0A  close( sock );=0A  return 0;=0A}=0A=0A=0A=0A=0Aint port_search(=
bdaddr_t *target)=0A{=0A    uint16_t svc_uuid_int =3D 0x1105;=0A    int sta=
tus;=0A    char addr[18];=0A    bdaddr_t local_addr;=0A    uuid_t svc_uuid;=
=0A    sdp_list_t *response_list, *search_list, *attrid_list;=0A    sdp_ses=
sion_t *session =3D 0;=0A    uint32_t range =3D 0x0000ffff;=0A    uint8_t p=
ort =3D 0;=0A=0A    ba2str(target,addr);=0A	printf("Target blue addr is %s\=
n",addr);=0A	//str2ba( addr, &target );=0A    // connect to the SDP server =
running on the remote machine=0A      =0A      ba2str(&local_addr, addr);=
=0A      printf("Local address is %s\n",addr);  =0A	  sleep(1);=0A      ses=
sion =3D sdp_connect( BDADDR_ANY, target,SDP_RETRY_IF_BUSY);=0A	if (session=
=3D=3DNULL)=0A	{=0A		printf("Can not connect to SDP server\n");=0A		return =
-1;=0A	}=0A    sdp_uuid16_create( &svc_uuid, svc_uuid_int );=0A    search_l=
ist =3D sdp_list_append( 0, &svc_uuid );=0A    attrid_list =3D sdp_list_app=
end( 0, &range );=0A    // get a list of service records that have UUID 0xa=
bcd=0A    response_list =3D NULL;=0A=0A  status =3D sdp_service_search_attr=
_req( session, search_list, SDP_ATTR_REQ_RANGE, attrid_list, &response_list=
);=0A  if( status =3D=3D 0 ) {=0A		  if(response_list=3D=3DNULL)=0A		  {	  =
    =0A		  	printf("Object Push Service not found\n");=0A		  	return -1;=0A=
		  }=0A	  sdp_list_t *proto_list;=0A      sdp_list_t *r =3D response_list;=
=0A      // go through each of the service records=0A      for (; r; r =3D =
r->next ) {=0A          sdp_record_t *rec =3D (sdp_record_t*) r->data;=0A  =
        // get a list of the protocol sequences=0A          if( sdp_get_acc=
ess_protos( rec, &proto_list ) =3D=3D 0 ) =0A		 //    if(sdp_get_profile_de=
scs(rec,&proto_list)=3D=3D0)=0A		  {=0A		 =0A              // get the RFCOM=
M port number=0A              port =3D sdp_get_proto_port( proto_list, RFCO=
MM_UUID );=0A              sdp_list_free( proto_list, 0 );=0A          }=0A=
          sdp_record_free( rec );=0A      }=0A  }=0A  sdp_list_free( respon=
se_list, 0 );=0A  sdp_list_free( search_list, 0 );=0A  sdp_list_free( attri=
d_list, 0 );=0A  sdp_close( session );=0A  if( port !=3D 0 ) {=0A      prin=
tf("found service running on RFCOMM port %d\n", port);=0A  }=0A  return 0;=
=0A}=0A
--Next_1162442346---0-202.54.124.130-3863
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHello all,<BR>=0A&nbsp; &nbsp; I am a newbie to bluez programming. an=
d i am currently writing a code that will discover all nearby bluetooth dev=
ices and make a SDP enquiry to know on which channel &quot;OBEX Object Push=
&quot; service is running.<BR>=0A&nbsp;  For this purpose i have gone throu=
gh a quiet a few documentation and sample code. And i am ready with some co=
de.<BR>=0A&nbsp; &nbsp; <BR>=0A&nbsp;  Now my question is why it is require=
d to give a &quot;sleep(1)&quot; call before sdp_connect() call? If i dont =
give it, sdp connection simply fails. And how should i reduce over all time=
 of making discovery of devices and connecting to their respective SDP serv=
ers.<BR>=0A&nbsp; I am using USB dongle as a local bluetooth device.<BR>=0A=
<BR>=0A&nbsp; Can someone help me on this issues? And how can i write bette=
r and efficient code?<BR>=0AAny reviews and suggestions for improvement r w=
elcomed.<BR>=0A Any help will be greatly appreciated.<BR>=0AThanks in advan=
ce <BR>=0ARupesh..<BR>=0A<BR>=0AMy code :----<BR>=0A<BR>=0A#include &lt;std=
io.h&gt;<BR>=0A#include &lt;stdlib.h&gt;<BR>=0A#include &lt;unistd.h&gt;<BR=
>=0A#include &lt;sys/socket.h&gt;<BR>=0A#include &lt;bluetooth/bluetooth.h&=
gt;<BR>=0A#include &lt;bluetooth/hci.h&gt;<BR>=0A#include &lt;bluetooth/hci=
_lib.h&gt;<BR>=0A#include &lt;bluetooth/sdp.h&gt;<BR>=0A#include &lt;blueto=
oth/sdp_lib.h&gt;<BR>=0A<BR>=0Aint port_search(bdaddr_t *target);<BR>=0A<BR=
>=0Aint main(int argc, char **argv)<BR>=0A{<BR>=0A&nbsp; &nbsp; inquiry_inf=
o *ii =3D NULL;<BR>=0A&nbsp; &nbsp; int max_rsp, num_rsp;<BR>=0A&nbsp; &nbs=
p; int dev_id, sock, len, flags;<BR>=0A&nbsp; &nbsp; int i;<BR>=0A&nbsp; &n=
bsp; char addr[19] =3D { 0 };<BR>=0A&nbsp; &nbsp; char name[248] =3D { 0 };=
<BR>=0A&nbsp; &nbsp; dev_id =3D hci_get_route(NULL);<BR>=0A&nbsp; &nbsp; so=
ck =3D hci_open_dev( dev_id );<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;  <BR>=0A&nbsp; if (dev_id &lt; 0 || sock &lt; 0) {<BR>=0A&nbsp; &nbsp=
; &nbsp; perror(&quot;opening socket&quot;);<BR>=0A&nbsp; &nbsp; &nbsp; exi=
t(1);<BR>=0A&nbsp; }<BR>=0A&nbsp; len =3D 8;<BR>=0A&nbsp; max_rsp =3D 255;<=
BR>=0A&nbsp; flags =3D IREQ_CACHE_FLUSH;<BR>=0A&nbsp; ii =3D (inquiry_info*=
)malloc(max_rsp * sizeof(inquiry_info));<BR>=0A&nbsp; num_rsp =3D hci_inqui=
ry(dev_id, len, max_rsp, NULL, &amp;ii, flags);<BR>=0A&nbsp; printf(&quot;%=
d Blue devices found\n&quot;,num_rsp);<BR>=0A&nbsp; if( num_rsp &lt; 0 ) pe=
rror(&quot;hci_inquiry&quot;);<BR>=0A&nbsp; for (i =3D 0; i &lt; num_rsp; i=
++) {<BR>=0A&nbsp; &nbsp; &nbsp; ba2str(&amp;(ii+i)-&gt;bdaddr, addr);<BR>=
=0A&nbsp; &nbsp; &nbsp; memset(name, 0, sizeof(name));<BR>=0A&nbsp; &nbsp; =
&nbsp; if (hci_read_remote_name(sock, &amp;(ii+i)-&gt;bdaddr, sizeof(name),=
<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; name, 0) &lt; 0)<BR>=0A&nbsp; &nb=
sp; &nbsp; strcpy(name, &quot;[unknown]&quot;);<BR>=0A&nbsp; &nbsp; &nbsp; =
printf(&quot;%s %s\n&quot;, addr, name);<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; p=
ort_search(&amp;(ii+i)-&gt;bdaddr);<BR>=0A&nbsp; }<BR>=0A&nbsp; free( ii );=
<BR>=0A&nbsp; close( sock );<BR>=0A&nbsp; return 0;<BR>=0A}<BR>=0A<BR>=0A<B=
R>=0A<BR>=0A<BR>=0Aint port_search(bdaddr_t *target)<BR>=0A{<BR>=0A&nbsp; &=
nbsp; uint16_t svc_uuid_int =3D 0x1105;<BR>=0A&nbsp; &nbsp; int status;<BR>=
=0A&nbsp; &nbsp; char addr[18];<BR>=0A&nbsp; &nbsp; bdaddr_t local_addr;<BR=
>=0A&nbsp; &nbsp; uuid_t svc_uuid;<BR>=0A&nbsp; &nbsp; sdp_list_t *response=
_list, *search_list, *attrid_list;<BR>=0A&nbsp; &nbsp; sdp_session_t *sessi=
on =3D 0;<BR>=0A&nbsp; &nbsp; uint32_t range =3D 0x0000ffff;<BR>=0A&nbsp; &=
nbsp; uint8_t port =3D 0;<BR>=0A<BR>=0A&nbsp; &nbsp; ba2str(target,addr);<B=
R>=0A&nbsp; &nbsp; &nbsp;printf(&quot;Target blue addr is %s\n&quot;,addr);=
<BR>=0A&nbsp; &nbsp; &nbsp;//str2ba( addr, &amp;target );<BR>=0A&nbsp; &nbs=
p; // connect to the SDP server running on the remote machine<BR>=0A&nbsp; =
&nbsp; &nbsp; <BR>=0A&nbsp; &nbsp; &nbsp; ba2str(&amp;local_addr, addr);<BR=
>=0A&nbsp; &nbsp; &nbsp; printf(&quot;Local address is %s\n&quot;,addr);&nb=
sp; <BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; sleep(1);<BR>=0A&nbsp; &nbsp; &nbsp; =
session =3D sdp_connect( BDADDR_ANY, target,SDP_RETRY_IF_BUSY);<BR>=0A&nbsp=
; &nbsp; &nbsp;if (session=3D=3DNULL)<BR>=0A&nbsp; &nbsp; &nbsp;{<BR>=0A&nb=
sp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;printf(&quot;Can not connect to SDP se=
rver\n&quot;);<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;return -1;<BR>=
=0A&nbsp; &nbsp; &nbsp;}<BR>=0A&nbsp; &nbsp; sdp_uuid16_create( &amp;svc_uu=
id, svc_uuid_int );<BR>=0A&nbsp; &nbsp; search_list =3D sdp_list_append( 0,=
 &amp;svc_uuid );<BR>=0A&nbsp; &nbsp; attrid_list =3D sdp_list_append( 0, &=
amp;range );<BR>=0A&nbsp; &nbsp; // get a list of service records that have=
 UUID 0xabcd<BR>=0A&nbsp; &nbsp; response_list =3D NULL;<BR>=0A<BR>=0A&nbsp=
; status =3D sdp_service_search_attr_req( session, search_list, SDP_ATTR_RE=
Q_RANGE, attrid_list, &amp;response_list);<BR>=0A&nbsp; if( status =3D=3D 0=
 ) {<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; if(response_list=
=3D=3DNULL)<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; {&nbsp; &n=
bsp; &nbsp;&nbsp; &nbsp; &nbsp; <BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &n=
bsp;&nbsp; &nbsp; &nbsp; &nbsp;printf(&quot;Object Push Service not found\n=
&quot;);<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;=
 &nbsp;return -1;<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; }<BR=
>=0A&nbsp; &nbsp; &nbsp;&nbsp; sdp_list_t *proto_list;<BR>=0A&nbsp; &nbsp; =
&nbsp; sdp_list_t *r =3D response_list;<BR>=0A&nbsp; &nbsp; &nbsp; // go th=
rough each of the service records<BR>=0A&nbsp; &nbsp; &nbsp; for (; r; r =
=3D r-&gt;next ) {<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sdp_record_t *r=
ec =3D (sdp_record_t*) r-&gt;data;<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 // get a list of the protocol sequences<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; if( sdp_get_access_protos( rec, &amp;proto_list ) =3D=3D 0 ) <BR>=0A=
&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; //&nbsp; &nbsp; if(sdp_get_profile=
_descs(rec,&amp;proto_list)=3D=3D0)<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;=
 &nbsp;&nbsp; {<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; <BR>=0A&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // get the RFCOMM port number<B=
R>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; port =3D sdp_get_prot=
o_port( proto_list, RFCOMM_UUID );<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; sdp_list_free( proto_list, 0 );<BR>=0A&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; }<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sdp_record_free( re=
c );<BR>=0A&nbsp; &nbsp; &nbsp; }<BR>=0A&nbsp; }<BR>=0A&nbsp; sdp_list_free=
( response_list, 0 );<BR>=0A&nbsp; sdp_list_free( search_list, 0 );<BR>=0A&=
nbsp; sdp_list_free( attrid_list, 0 );<BR>=0A&nbsp; sdp_close( session );<B=
R>=0A&nbsp; if( port !=3D 0 ) {<BR>=0A&nbsp; &nbsp; &nbsp; printf(&quot;fou=
nd service running on RFCOMM port %d\n&quot;, port);<BR>=0A&nbsp; }<BR>=0A&=
nbsp; return 0;<BR>=0A}<BR>=0A=0A</P>=0A<br><br>=0A<a href=3D"http://adwork=
s.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm=
/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D"http://adworks.rediff.com/cgi-=
bin/AdWorks/sigimpress.cgi/www.rediff.com/signature-home.htm/1963059423@Mid=
dle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1162442346---0-202.54.124.130-3863--



--===============1933597351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1933597351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1933597351==--
