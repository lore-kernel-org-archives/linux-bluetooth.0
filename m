Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jun 2008 13:04:01 +0530 (IST)
From: ashok pundit <ashokgautam15@yahoo.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <716558.46862.qm@web94708.mail.in2.yahoo.com>
Subject: [Bluez-devel] Regarding calculation of hash value for mobile phones
	using Bluetooth services.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1498396529=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1498396529==
Content-Type: multipart/alternative; boundary="0-1257024511-1214811241=:46862"

--0-1257024511-1214811241=:46862
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear All=0A=0AWe are working on a application that calculates an integer va=
lue=0A(called hash value of mobile) for mobile device based on Bluetooth=0A=
services available on mobile phone. I am using following algorithm=0AStep 1=
: Search all services available on mobile phone.=0AStep 2: Calculate hash v=
alue by using formula =E2=88=91(chi*reci)=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Where chi is channel number and reci is record handler=0A=
ith service.=0A=0AHere we have bit confusion in Step 1 of algorithm. We are=
 not sure=0Aabout using the service group to search services. We have to ch=
oice=0Ahere either RFCOMM(ox 0003) or PublicBrowseGroup(ox1002). It will be=
=0Agreat help to us, if you tell the which option is better and why.=0A=0AT=
hanks and Regards=0AAshok Pundit=0A=0A=0A=0A      Bollywood, fun, friendshi=
p, sports and more. You name it, we have it on http://in.promos.yahoo.com/g=
roups/bestofyahoo/
--0-1257024511-1214811241=:46862
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV></DIV>=0A<DIV>Dear All<BR><BR>We are working on a appl=
ication that calculates an integer value<BR>(called hash value of mobile) f=
or mobile device based on Bluetooth<BR>services available on mobile phone. =
I am using following algorithm<BR>Step 1: Search all services available on =
mobile phone.<BR>Step 2: Calculate hash value by using formula =E2=88=91(ch=
i*reci)<BR>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Where chi is ch=
annel number and reci is record handler<BR>ith service.<BR><BR>Here we have=
 bit confusion in Step 1 of algorithm. We are not sure<BR>about using the s=
ervice group to search services. We have to choice<BR>here either RFCOMM(ox=
 0003) or PublicBrowseGroup(ox1002). It will be<BR>great help to us, if you=
 tell the which option is better and why.<BR></DIV>=0A<DIV>Thanks and Regar=
ds<BR>Ashok Pundit<BR></DIV></div><br>=0A=0A=0A      <!--6--><hr size=3D1><=
/hr> Explore your hobbies and interests. <a href=3D"http://in.rd.yahoo.com/=
tagline_groups_6/*http://in.promos.yahoo.com/groups/">Click here to begin.<=
/a></body></html>
--0-1257024511-1214811241=:46862--



--===============1498396529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1498396529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1498396529==--
