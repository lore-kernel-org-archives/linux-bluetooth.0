Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jul 2008 09:39:58 +0530 (IST)
From: ashok pundit <ashokgautam15@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <69313.93350.qm@web94708.mail.in2.yahoo.com>
Subject: [Bluez-users] Fw: calculation of hash value for mobile phones using
	Bluetooth services.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1291696876=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1291696876==
Content-Type: multipart/alternative; boundary="0-452783473-1215058198=:93350"

--0-452783473-1215058198=:93350
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0ADear All=0A=0AWe are working on a application that calculates an inte=
ger value=0A(called hash value of mobile) for mobile device based on Blueto=
oth=0Aservices available on mobile phone. I am using following algorithm=0A=
Step 1: Search all services available on mobile phone.=0AStep 2: Calculate =
hash value by using formula =E2=88=91(chi*reci)=0A              Where chi i=
s channel number and reci is record handler=0Aith service.=0A=0AHere we hav=
e bit confusion in Step 1 of algorithm. We are not sure=0Aabout using the s=
ervice group to search services. We have to choice=0Ahere either RFCOMM(ox =
0003) or PublicBrowseGroup(ox1002). It will be=0Agreat help to us, if you t=
ell the which option is better and why.=0A=0AThanks and Regards=0AAshok Pun=
dit=0A=0A=0A      From Chandigarh to Chennai - find friends all over India.=
 Go to http://in.promos.yahoo.com/groups/citygroups/
--0-452783473-1215058198=:93350
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;"><div style=3D"font-family: times new roman,new york=
,times,serif; font-size: 12pt;"><div style=3D"font-family: times new roman,=
new york,times,serif; font-size: 12pt;"><br><div style=3D"font-family: time=
s new roman,new york,times,serif; font-size: 12pt;"><div style=3D"font-fami=
ly: times new roman,new york,times,serif; font-size: 12pt;"><div style=3D"f=
ont-family: times new roman,new york,times,serif; font-size: 12pt;"><div></=
div>=0A<div>Dear All<br><br>We are working on a application that calculates=
 an integer value<br>(called hash value of mobile) for mobile device based =
on Bluetooth<br>services available on mobile phone. I am using following al=
gorithm<br>Step 1: Search all services available on mobile phone.<br>Step 2=
: Calculate hash value by using formula =E2=88=91(chi*reci)<br>&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Where chi is channel number and reci i=
s record handler<br>ith service.<br><br>Here we have bit confusion in Step =
1 of algorithm. We are not sure<br>about using the service group to search =
services. We have to choice<br>here either RFCOMM(ox 0003) or PublicBrowseG=
roup(ox1002). It will be<br>great help to us, if you tell the which option =
is better and why.<br></div>=0A<div>Thanks and Regards<br>Ashok Pundit<br><=
/div></div></div></div></div><a rel=3D"nofollow" target=3D"_blank" href=3D"=
http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yahoo/mai=
l/yahoomail/tools/tools-08.html/"><br></a></div></div></div><br>=0A=0A=0A  =
    <!--2--><hr size=3D1></hr> Unlimited freedom, unlimited storage. <a hre=
f=3D"http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yaho=
o/mail/yahoomail/tools/tools-08.html/">Get it now</a></body></html>
--0-452783473-1215058198=:93350--



--===============1291696876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1291696876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1291696876==--
