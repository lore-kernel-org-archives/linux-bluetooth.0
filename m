Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061228064902.70882.qmail@web59104.mail.re1.yahoo.com>
Date: Wed, 27 Dec 2006 22:49:02 -0800 (PST)
From: jaeho lee <xefri@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] How to change defualt L2CAP mtu size?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1839643507=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1839643507==
Content-Type: multipart/alternative; boundary="0-407805476-1167288542=:69932"

--0-407805476-1167288542=:69932
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hi all.=0AI know that the default L2CAP mtu size is 672  and I heard it can=
 be changed up to 65535. =0ASo I changed it 65535 and had double check it. =
However, when I use "write function" in Network program, for example, "writ=
e (Socket_s, message, 2048)". It doesn't work at all. Even though I changed=
 default mtu size, I only can use "write function" with size 672 , for exam=
ple, "write (Socket_s, message, 672)". I don't know what's wrong. Is there =
any advise?=0A=0A__________________________________________________=0ADo Yo=
u Yahoo!?=0ATired of spam?  Yahoo! Mail has the best spam protection around=
 =0Ahttp://mail.yahoo.com 
--0-407805476-1167288542=:69932
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>Hi all.</DIV>=0A<DIV>I know that the default L2CAP mtu=
 size is 672&nbsp; and&nbsp;I heard it can be changed up to 65535. </DIV>=
=0A<DIV>So I changed it 65535 and had double check it. However, when I use =
"write function" in Network program, for example, "write (Socket_s, message=
, 2048)". It doesn't work at all. Even though I changed default mtu size, I=
 only can use "write function" with size 672 , for example, "write (Socket_=
s, message, 672)". I don't know what's wrong. Is there any advise?</DIV></d=
iv><br>__________________________________________________<br>Do You Yahoo!?=
<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>htt=
p://mail.yahoo.com </body></html>
--0-407805476-1167288542=:69932--


--===============1839643507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1839643507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1839643507==--
