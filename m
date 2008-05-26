Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 May 2008 15:34:18 +0800 (CST)
From: attaboyu@163.com
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Message-ID: <25980571.990131211787258597.JavaMail.coremail@bj163app120.163.com>
In-Reply-To: <4837F637.9060904@wurmsdobler.org>
References: <4837F637.9060904@wurmsdobler.org>
	<20844183.487421211530034467.JavaMail.coremail@bj163app76.163.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] CSR bluecore initial problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1562246621=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1562246621==
Content-Type: multipart/alternative;
	boundary="----=_Part_260736_14561697.1211787258596"

------=_Part_260736_14561697.1211787258596
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks indeed, it works!

=E5=9C=A82008-05-24=EF=BC=8C"Peter Wurmsdobler" <peter@wurmsdobler.org> =E5=
=86=99=E9=81=93=EF=BC=9A
>
>
>Hello,
>
>a few months back I encountered a similar problem. hciattach did not=20
>(and still does not) always succeed, and bccmd seems to have a problem=20
>using the BlueCore serial protocol (bcsp), possibly a race condition.=20
>That's why I have to use:
>
>      /usr/sbin/hciattach /dev/ttymxc2 bcsp 57600 flow
>      /usr/sbin/hciconfig hci0 up
>      /usr/sbin/bccmd -t hci psload -r /usr/etc/bluetooth/apm6628BT-UART.p=
sr
>      killall hciattach
>      /usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow
>      /usr/sbin/hciconfig hci0 up
>
>Notice the bccmd -t hci, so you have to attach first using bcsp, then=20
>use bccmd with this hci in order to download the psr file (which will=20
>reset the BlueCore), then kill the hci and re-attach.
>
>Hope this helps,
>peter
>
>
>=20
>
>');
>=09}
>//-->
>
>
------=_Part_260736_14561697.1211787258596
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks indeed, it works!<br><br>=E5=9C=A82008-05-24=EF=BC=8C"Peter Wurmsdob=
ler" &lt;peter@wurmsdobler.org&gt; =E5=86=99=E9=81=93=EF=BC=9A<br>&gt;<br>&=
gt;<br>&gt;Hello,<br>&gt;<br>&gt;a few months back I encountered a similar =
problem. hciattach did not <br>&gt;(and still does not) always succeed, and=
 bccmd seems to have a problem <br>&gt;using the BlueCore serial protocol (=
bcsp), possibly a race condition. <br>&gt;That's why I have to use:<br>&gt;=
<br>&gt;      /usr/sbin/hciattach /dev/ttymxc2 bcsp 57600 flow<br>&gt;     =
 /usr/sbin/hciconfig hci0 up<br>&gt;      /usr/sbin/bccmd -t hci psload -r =
/usr/etc/bluetooth/apm6628BT-UART.psr<br>&gt;      killall hciattach<br>&gt=
;      /usr/sbin/hciattach /dev/ttymxc2 bcsp 115200 flow<br>&gt;      /usr/=
sbin/hciconfig hci0 up<br>&gt;<br>&gt;Notice the bccmd -t hci, so you have =
to attach first using bcsp, then <br>&gt;use bccmd with this hci in order t=
o download the psr file (which will <br>&gt;reset the BlueCore), then kill =
the hci and re-attach.<br>&gt;<br>&gt;Hope this helps,<br>&gt;peter<br>&gt;=
<br>&gt;<br>&gt; <br>&gt;<br>&gt;');<br>&gt;=09}<br>&gt;//--&gt;<br>&gt;<br=
>&gt;<br><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;">=E5=B0=BD=E4=BA=AB=E6=B1=
=9F=E5=8C=97=E5=9F=8E=E5=B8=82=E8=8D=A3=E5=85=89=EF=BC=8C=E5=BC=80=E5=90=AF=
=E6=BB=A8=E6=B1=9F=E4=B8=96=E7=95=8C=E5=B2=B8=E5=8C=BA=EF=BC=8C</font><a st=
yle=3D"font-size:12px;line-height:15px; color:blue; text-decoration:underli=
ne;" href=3D"http://popme.163.com/link/003982_0526_7909.html">=E4=B8=9C=E6=
=B5=B7=E5=B2=B8=E8=B5=A0=E7=A9=BA=E9=97=B4=E8=BF=9150%</a>
------=_Part_260736_14561697.1211787258596--



--===============1562246621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1562246621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1562246621==--
