Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 May 2008 16:24:05 +0800 (CST)
From: attaboyu@163.com
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Message-ID: <28757280.111411211531045216.JavaMail.coremail@bj163app12.163.com>
In-Reply-To: <20844183.487421211530034467.JavaMail.coremail@bj163app76.163.com>
References: <20844183.487421211530034467.JavaMail.coremail@bj163app76.163.com>
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
Content-Type: multipart/mixed; boundary="===============0043058749=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0043058749==
Content-Type: multipart/alternative;
	boundary="----=_Part_29663_190559.1211531045214"

------=_Part_29663_190559.1211531045214
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable

=20
 and what's the difference between H4 and bcsp, while both of them use uart=
 interface?

=20
=20

--


=20
hi all
I got a problem while init the csr bluecore4 chip, my toolchain: bluez-3.12=
, dbus-1.0.2,kernel-2.6.10
#dbus-daemon --system
#hciattach ttyS0 bcsp
#hcid -f /opt/bluez/etc/bluetooth/hcidconf
#hciconfig=20
hci0:   Type: UART
        BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN=20
        RX bytes:1128 acl:0 sco:0 events:23 errors:0
        TX bytes:706 acl:0 sco:0 commands:26 errors:0
above is always ok.
but csr chip need to set pskeys and warmreset,so I run bccmd
#bccmd warmreset
#hcitool scan
Scanning
Timeout...

This problem around me for a few days, I cant figure out why the csr chip d=
oesnt work after warmreset.UART0 connect to csr chip, so I choose bcsp conf=
ig in kernel and choose hci interface(here i am not sure about choosing hci=
 or bcsp while run bccmd?), am i right?

=20
=20

--

 Best Regards
 ------------
 Tony




=C8=F0=D1=A9=B4=BA=CC=C3 =BC=B4=BD=AB=BF=AA=C6=F4
------=_Part_29663_190559.1211531045214
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;</div><div>&nbsp;and what's the difference between H4 and bcsp, =
while both of them use uart interface?<br></div><div>&nbsp;</div><div>&nbsp=
;</div><div><br>--<br>
<br>
</div><blockquote id=3D"isReplyContent" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;"><div>&nbsp;=
</div>hi all<br>I got a problem while init the csr bluecore4 chip, my toolc=
hain: bluez-3.12, dbus-1.0.2,kernel-2.6.10<br>#dbus-daemon --system<br>#hci=
attach ttyS0 bcsp<br>#hcid -f /opt/bluez/etc/bluetooth/hcid<wbr>conf<br>#hc=
iconfig <br>
hci0:&nbsp;&nbsp; Type: UART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
BD Address: 00:02:5B:00:A5:A5 ACL MTU: 310:10 SCO MTU: 64:8<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN <br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1128 acl:0 sco:0 events:23 errors:0<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:706 acl:0 sco:0 commands=
:26 errors:0<br>
above is always ok.<br>but csr chip need to set pskeys and warmreset,so I r=
un bccmd<br>#bccmd warmreset<br>#hcitool scan<br>Scanning<br>Timeout...<br>=
<br>This problem around me for a few days, I cant figure out why the csr ch=
ip doesnt work after warmreset.UART0 connect to csr chip, so I choose bcsp =
config in kernel and choose hci interface(here i am not sure about choosing=
 hci or bcsp while run bccmd?), am i right?<br><div>&nbsp;</div><div>&nbsp;=
</div><div><br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size: 12px; line-height: 15px;"></font><a style=3D"font=
-size: 12px; line-height: 15px; color: blue; text-decoration: underline;" h=
ref=3D"http://popme.163.com/link/003982_0523_567.html">=C8=F0=D1=A9=B4=BA=
=CC=C3 =BC=B4=BD=AB=BF=AA=C6=F4</a></wbr></blockquote><br><!-- footer --><b=
r>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;"></font><a style=3D"font-si=
ze:12px;line-height:15px; color:blue; text-decoration:underline;" href=3D"h=
ttp://popme.163.com/link/003982_0523_567.html">=C8=F0=D1=A9=B4=BA=CC=C3 =BC=
=B4=BD=AB=BF=AA=C6=F4</a>
------=_Part_29663_190559.1211531045214--



--===============0043058749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0043058749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0043058749==--
