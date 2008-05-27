Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 May 2008 10:36:01 +0800 (CST)
From: attaboyu <attaboyu@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Message-ID: <11216581.210541211855761644.JavaMail.coremail@bj163app120.163.com>
MIME-Version: 1.0
Subject: [Bluez-users] hcid problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2086025683=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2086025683==
Content-Type: multipart/alternative;
	boundary="----=_Part_56438_31613661.1211855761643"

------=_Part_56438_31613661.1211855761643
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 Hi all
 I have got a hcid problem below:
 $hcid -f /etc/bluetooth/hcid.conf
 BUG: scheduling while atomic: hcid/0x00000101/51
 caller is schedule+0xec/0x12c
 
 There is no hcid process running from ps view. if run hcid again, something will be issued:

BUG: scheduling while atomic: swapper/0x00000103/0
caller is schedule+0xec/0x12c
BUG: scheduling from the idle thread!
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = c0004000
[00000004] *pgd= 

 as kernel version is 2.6.10, so I use a old bluez version 3.12 

 
 
 

--

 Best Regards
 ------------
 Tony

------=_Part_56438_31613661.1211855761643
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;Hi all<br>&nbsp;I have got a hcid problem below:<br>&nbsp;<i>$hc=
id -f /etc/bluetooth/hcid.conf<br>&nbsp;BUG: scheduling while atomic: hcid/=
0x00000101/51<br>&nbsp;caller is schedule+0xec/0x12c</i><br>&nbsp;<br>&nbsp=
;There is no hcid process running from ps view. if run hcid again, somethin=
g will be issued:<br><br><i>BUG: scheduling while atomic: swapper/0x0000010=
3/0<br>caller is schedule+0xec/0x12c<br>BUG: scheduling from the idle threa=
d!<br>Unable to handle kernel NULL pointer dereference at virtual address 0=
0000004<br>pgd =3D c0004000<br>[00000004] *pgd=3D <br><br>&nbsp;</i>as kern=
el version is 2.6.10, so I use a old bluez version 3.12 <br></div><div>&nbs=
p;</div><div>&nbsp;</div><div>&nbsp;</div><div><br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;">=BE=A1=CF=ED=BD=AD=B1=B1=
=B3=C7=CA=D0=C8=D9=B9=E2=A3=AC=BF=AA=C6=F4=B1=F5=BD=AD=CA=C0=BD=E7=B0=B6=C7=
=F8=A3=AC</font><a style=3D"font-size:12px;line-height:15px; color:blue; te=
xt-decoration:underline;" href=3D"http://popme.163.com/link/003982_0526_790=
9.html">=B6=AB=BA=A3=B0=B6=D4=F9=BF=D5=BC=E4=BD=FC50%</a>
------=_Part_56438_31613661.1211855761643--



--===============2086025683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2086025683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2086025683==--
