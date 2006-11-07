Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: 7 Nov 2006 08:28:38 -0000
Message-ID: <20061107082838.28192.qmail@webmail70.rediffmail.com>
MIME-Version: 1.0
From: "Rupesh Gujare" <rupesh_gujare@rediffmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] How can i change MTU to max value?
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
Content-Type: multipart/mixed; boundary="===============1313747109=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 This is a multipart mime message


--===============1313747109==
Content-type: multipart/alternative;
	boundary="Next_1162888118---0-202.54.124.220-28184"

 This is a multipart mime message


--Next_1162888118---0-202.54.124.220-28184
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 =0A=0A Hello all,=0A  I am programming for transferring data between my Li=
nux box and mobile phone. But while transferring large files it takes quiet=
 a few time. =0A  I want to achieve maximum data transfer rates without aff=
ecting reliability of system. I am using "object push service" for this. An=
d tried changing default MTU size in /usr/include/openobex/obex_const.h=0A =
 But got same results.=0A  Can anyone tell me how can i increase MTU size? =
Or is there any limitation on it? (I think Max. MTU size can be 64k).=0A  A=
ny help or suggestions are appreciated.=0A(partial) hcidump looks something=
 like this:-=0A=0A     L2CAP(d): cid 0x0040 len 7 [psm 3]=0A      RFCOMM(d)=
: UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80=0A< ACL data: handle 1 flags 0x02 d=
len 678=0A< ACL data: handle 1 flags 0x01 dlen 338=0A    L2CAP(d): cid 0x00=
46 len 1012 [psm 3]=0A      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 1007 fcs =
0x5a=0A< ACL data: handle 1 flags 0x02 dlen 25=0A    L2CAP(d): cid 0x0046 l=
en 21 [psm 3]=0A      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 17 fcs 0x5a=0A>=
 HCI Event: Number of Completed Packets (0x13) plen 5=0A> HCI Event: Number=
 of Completed Packets (0x13) plen 5=0A> HCI Event: Number of Completed Pack=
ets (0x13) plen 5=0A> ACL data: handle 1 flags 0x02 dlen 11=0A    L2CAP(d):=
 cid 0x0040 len 7 [psm 3]=0A      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 f=
cs 0x80=0A< ACL data: handle 1 flags 0x02 dlen 678=0A< ACL data: handle 1 f=
lags 0x01 dlen 338=0A    L2CAP(d): cid 0x0046 len 1012 [psm 3]=0A      RFCO=
MM(d): UIH: cr 1 dlci 8 pf 0 ilen 1007 fcs 0x5a=0A< ACL data: handle 1 flag=
s 0x02 dlen 25=0A    L2CAP(d): cid 0x0046 len 21 [psm 3]=0A      RFCOMM(d):=
 UIH: cr 1 dlci 8 pf 0 ilen 17 fcs 0x5a=0A> HCI Event: Number of Completed =
Packets (0x13) plen 5=0A> HCI Event: Number of Completed Packets (0x13) ple=
n 5=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A> ACL data: =
handle 1 flags 0x02 dlen 11=0A    L2CAP(d): cid 0x0040 len 7 [psm 3]=0A    =
  RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80=0A< ACL data: handle 1 f=
lags 0x02 dlen 678=0A< ACL data: handle 1 flags 0x01 dlen 338=0A    L2CAP(d=
): cid 0x0046 len 1012 [psm 3]=0A      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ile=
n 1007 fcs 0x5a=0A< ACL data: handle 1 flags 0x02 dlen 25=0A    L2CAP(d): c=
id 0x0046 len 21 [psm 3]=0A      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 17 f=
cs 0x5a=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A> HCI Ev=
ent: Number of Completed Packets (0x13) plen 5=0A> HCI Event: Number of Com=
pleted Packets (0x13) plen 5=0A> ACL data: handle 1 flags 0x02 dlen 11=0A  =
  L2CAP(d): cid 0x0040 len 7 [psm 3]=0A      RFCOMM(d): UIH: cr 0 dlci 8 pf=
 0 ilen 3 fcs 0x80=0A< ACL data: handle 1 flags 0x02 dlen 678=0A< ACL data:=
 handle 1 flags 0x01 dlen 338=0A    L2CAP(d): cid 0x0046 len 1012 [psm 3]=
=0A      RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 1007 fcs 0x5a=0A< ACL data: =
handle 1 flags 0x02 dlen 25=0A    L2CAP(d): cid 0x0046 len 21 [psm 3]=0A   =
   RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 17 fcs 0x5a=0A> HCI Event: Number =
of Completed Packets (0x13) plen 5=0A> HCI Event: Number of Completed Packe=
ts (0x13) plen 5=0A> HCI Event: Number of Completed Packets (0x13) plen 5=
=0A> ACL data: handle 1 flags 0x02 dlen 11=0A    L2CAP(d): cid 0x0040 len 7=
 [psm 3]=0A      RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80=0A< ACL d=
ata: handle 1 flags 0x02 dlen 678=0A< ACL data: handle 1 flags 0x01 dlen 33=
8=0A    L2CAP(d): cid 0x0046 len 1012 [psm 3]=0A      RFCOMM(d): UIH: cr 1 =
dlci 8 pf 0 ilen 1007 fcs 0x5a=0A< ACL data: handle 1 flags 0x02 dlen 25=0A=
    L2CAP(d): cid 0x0046 len 21 [psm 3]=0A      RFCOMM(d): UIH: cr 1 dlci 8=
 pf 0 ilen 17 fcs 0x5a=0A> HCI Event: Number of Completed Packets (0x13) pl=
en 5=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A> HCI Event=
: Number of Completed Packets (0x13) plen 5=0A> ACL data: handle 1 flags 0x=
02 dlen 11=0A    L2CAP(d): cid 0x0040 len 7 [psm 3]=0A      RFCOMM(d): UIH:=
 cr 0 dlci 8 pf 0 ilen 3 fcs 0x80=0A< ACL data: handle 1 flags 0x02 dlen 67=
8=0A< ACL data: handle 1 flags 0x01 dlen 338=0A
--Next_1162888118---0-202.54.124.220-28184
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A <BR>=0A<BR>=0A Hello all,<BR>=0A&nbsp; I am programming for transfer=
ring data between my Linux box and mobile phone. But while transferring lar=
ge files it takes quiet a few time. <BR>=0A&nbsp; I want to achieve maximum=
 data transfer rates without affecting reliability of system. I am using &q=
uot;object push service&quot; for this. And tried changing default MTU size=
 in /usr/include/openobex/obex_const.h<BR>=0A&nbsp; But got same results.<B=
R>=0A&nbsp; Can anyone tell me how can i increase MTU size? Or is there any=
 limitation on it? (I think Max. MTU size can be 64k).<BR>=0A&nbsp; Any hel=
p or suggestions are appreciated.<BR>=0A(partial) hcidump looks something l=
ike this:-<BR>=0A<BR>=0A&nbsp; &nbsp;  L2CAP(d): cid 0x0040 len 7 [psm 3]<B=
R>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<=
BR>=0A&lt; ACL data: handle 1 flags 0x02 dlen 678<BR>=0A&lt; ACL data: hand=
le 1 flags 0x01 dlen 338<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0046 len 1012 =
[psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 10=
07 fcs 0x5a<BR>=0A&lt; ACL data: handle 1 flags 0x02 dlen 25<BR>=0A&nbsp; &=
nbsp; L2CAP(d): cid 0x0046 len 21 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM=
(d): UIH: cr 1 dlci 8 pf 0 ilen 17 fcs 0x5a<BR>=0A&gt; HCI Event: Number of=
 Completed Packets (0x13) plen 5<BR>=0A&gt; HCI Event: Number of Completed =
Packets (0x13) plen 5<BR>=0A&gt; HCI Event: Number of Completed Packets (0x=
13) plen 5<BR>=0A&gt; ACL data: handle 1 flags 0x02 dlen 11<BR>=0A&nbsp; &n=
bsp; L2CAP(d): cid 0x0040 len 7 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d=
): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<BR>=0A&lt; ACL data: handle 1 flag=
s 0x02 dlen 678<BR>=0A&lt; ACL data: handle 1 flags 0x01 dlen 338<BR>=0A&nb=
sp; &nbsp; L2CAP(d): cid 0x0046 len 1012 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp;=
 RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 1007 fcs 0x5a<BR>=0A&lt; ACL data: h=
andle 1 flags 0x02 dlen 25<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0046 len 21 =
[psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 17=
 fcs 0x5a<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<B=
R>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>=0A&gt; H=
CI Event: Number of Completed Packets (0x13) plen 5<BR>=0A&gt; ACL data: ha=
ndle 1 flags 0x02 dlen 11<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0040 len 7 [p=
sm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fc=
s 0x80<BR>=0A&lt; ACL data: handle 1 flags 0x02 dlen 678<BR>=0A&lt; ACL dat=
a: handle 1 flags 0x01 dlen 338<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0046 le=
n 1012 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 0 =
ilen 1007 fcs 0x5a<BR>=0A&lt; ACL data: handle 1 flags 0x02 dlen 25<BR>=0A&=
nbsp; &nbsp; L2CAP(d): cid 0x0046 len 21 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp;=
 RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 17 fcs 0x5a<BR>=0A&gt; HCI Event: Nu=
mber of Completed Packets (0x13) plen 5<BR>=0A&gt; HCI Event: Number of Com=
pleted Packets (0x13) plen 5<BR>=0A&gt; HCI Event: Number of Completed Pack=
ets (0x13) plen 5<BR>=0A&gt; ACL data: handle 1 flags 0x02 dlen 11<BR>=0A&n=
bsp; &nbsp; L2CAP(d): cid 0x0040 len 7 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; R=
FCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<BR>=0A&lt; ACL data: handle=
 1 flags 0x02 dlen 678<BR>=0A&lt; ACL data: handle 1 flags 0x01 dlen 338<BR=
>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0046 len 1012 [psm 3]<BR>=0A&nbsp; &nbsp;=
 &nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 1007 fcs 0x5a<BR>=0A&lt; ACL =
data: handle 1 flags 0x02 dlen 25<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0046 =
len 21 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 0 =
ilen 17 fcs 0x5a<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) p=
len 5<BR>=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>=
=0A&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>=0A&gt; ACL=
 data: handle 1 flags 0x02 dlen 11<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0040=
 len 7 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 =
ilen 3 fcs 0x80<BR>=0A&lt; ACL data: handle 1 flags 0x02 dlen 678<BR>=0A&lt=
; ACL data: handle 1 flags 0x01 dlen 338<BR>=0A&nbsp; &nbsp; L2CAP(d): cid =
0x0046 len 1012 [psm 3]<BR>=0A&nbsp; &nbsp; &nbsp; RFCOMM(d): UIH: cr 1 dlc=
i 8 pf 0 ilen 1007 fcs 0x5a<BR>=0A&lt; ACL data: handle 1 flags 0x02 dlen 2=
5<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0046 len 21 [psm 3]<BR>=0A&nbsp; &nbs=
p; &nbsp; RFCOMM(d): UIH: cr 1 dlci 8 pf 0 ilen 17 fcs 0x5a<BR>=0A&gt; HCI =
Event: Number of Completed Packets (0x13) plen 5<BR>=0A&gt; HCI Event: Numb=
er of Completed Packets (0x13) plen 5<BR>=0A&gt; HCI Event: Number of Compl=
eted Packets (0x13) plen 5<BR>=0A&gt; ACL data: handle 1 flags 0x02 dlen 11=
<BR>=0A&nbsp; &nbsp; L2CAP(d): cid 0x0040 len 7 [psm 3]<BR>=0A&nbsp; &nbsp;=
 &nbsp; RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80<BR>=0A&lt; ACL dat=
a: handle 1 flags 0x02 dlen 678<BR>=0A&lt; ACL data: handle 1 flags 0x01 dl=
en 338<BR>=0A=0A</P>=0A<br><br>=0A<a href=3D"http://adworks.rediff.com/cgi-=
bin/AdWorks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middl=
e5?PARTNER=3D3"><IMG SRC=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigim=
press.cgi/www.rediff.com/signature-home.htm/1963059423@Middle5?OAS_query=3D=
null&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1162888118---0-202.54.124.220-28184--



--===============1313747109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1313747109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1313747109==--
