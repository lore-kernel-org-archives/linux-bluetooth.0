Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: 2 Nov 2006 12:28:56 -0000
Message-ID: <20061102122856.28888.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
From: "Rupesh Gujare" <rupesh_gujare@rediffmail.com>
To: bluez-devel@lists.sourceforge.net
Cc: pewi@gw-instruments.de
Subject: Re: [Bluez-devel] Need Help In SDP Programming......
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
Content-Type: multipart/mixed; boundary="===============0740641809=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

 This is a multipart mime message


--===============0740641809==
Content-type: multipart/alternative;
	boundary="Next_1162470536---0-202.54.124.178-28885"

 This is a multipart mime message


--Next_1162470536---0-202.54.124.178-28885
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  =0AThanks Peter and Mingfan for your suggestions and code review. I will =
definately try to improve on it. =0A  I am currently working on 2.6.15 kern=
el. and had not applied any patch.=0A I will like to ask peter that which k=
ernel you are using? Are you facing same problem after patching to latest k=
ernel?=0A  Do let me know.=0A  Thanks and regards.=0A Rupesh=0A=0A>=0A>I th=
ink the sleep(..) call causes a reschedule and allows the sdpd to=0A>finish=
 some internal cleanup or so after a close. I got some similar=0A>behaviour=
 even when connecting to the local sdp data base.=0A>=0A>To get your code a=
 little bit faster you should not use the hci_inquiry()=0A>call. This does =
not only do the inquiry but also does a name request which=0A>requires a ba=
seband connection to the remote device. It is much more=0A>efficient to do =
the name request as a part of the sdp request if you make=0A>the sdp reques=
t anyway (only one baseband connection for each device).=0A>=0A>Further, be=
cause most BT chips today allow for inquirie to run in the=0A>background, y=
ou can try to start SDP requests once you receive the BT=0A>address for a d=
evice and not when the inquiry is finished. However, this=0A>would require =
some much more complicated code and direct HCI socket=0A>programming. You m=
ay have a look at hcid to get an idea.=0A>=0A>Ciao,=0A>=0A>Peter=0A
--Next_1162470536---0-202.54.124.178-28885
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0AThanks Peter and Mingfan for your suggestions and code =
review. I will definately try to improve on it. <BR>=0A&nbsp; I am currentl=
y working on 2.6.15 kernel. and had not applied any patch.<BR>=0A I will li=
ke to ask peter that which kernel you are using? Are you facing same proble=
m after patching to latest kernel?<BR>=0A&nbsp; Do let me know.<BR>=0A&nbsp=
; Thanks and regards.<BR>=0A Rupesh<BR>=0A<BR>=0A&gt;<BR>=0A&gt;I think the=
 sleep(..) call causes a reschedule and allows the sdpd to<BR>=0A&gt;finish=
 some internal cleanup or so after a close. I got some similar<BR>=0A&gt;be=
haviour even when connecting to the local sdp data base.<BR>=0A&gt;<BR>=0A&=
gt;To get your code a little bit faster you should not use the hci_inquiry(=
)<BR>=0A&gt;call. This does not only do the inquiry but also does a name re=
quest which<BR>=0A&gt;requires a baseband connection to the remote device. =
It is much more<BR>=0A&gt;efficient to do the name request as a part of the=
 sdp request if you make<BR>=0A&gt;the sdp request anyway (only one baseban=
d connection for each device).<BR>=0A&gt;<BR>=0A&gt;Further, because most B=
T chips today allow for inquirie to run in the<BR>=0A&gt;background, you ca=
n try to start SDP requests once you receive the BT<BR>=0A&gt;address for a=
 device and not when the inquiry is finished. However, this<BR>=0A&gt;would=
 require some much more complicated code and direct HCI socket<BR>=0A&gt;pr=
ogramming. You may have a look at hcid to get an idea.<BR>=0A&gt;<BR>=0A&gt=
;Ciao,<BR>=0A&gt;<BR>=0A&gt;Peter<BR>=0A=0A</P>=0A<br><br>=0A<a href=3D"htt=
p://adworks.rediff.com/cgi-bin/AdWorks/sigclick.cgi/www.rediff.com/signatur=
e-home.htm/1507191490@Middle5?PARTNER=3D3"><IMG SRC=3D"http://adworks.redif=
f.com/cgi-bin/AdWorks/sigimpress.cgi/www.rediff.com/signature-home.htm/1963=
059423@Middle5?OAS_query=3Dnull&PARTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=
=3D0></a>=0A
--Next_1162470536---0-202.54.124.178-28885--



--===============0740641809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0740641809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0740641809==--
