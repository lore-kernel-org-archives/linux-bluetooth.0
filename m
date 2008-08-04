Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Aug 2008 17:30:48 +0800 (CST)
From: attaboyu <attaboyu@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Message-ID: <29417318.619571217842248039.JavaMail.coremail@bj163app19.163.com>
In-Reply-To: <33494690.546031217836504913.JavaMail.coremail@bj163app19.163.com>
References: <33494690.546031217836504913.JavaMail.coremail@bj163app19.163.com>
	<16515303.641251217832066401.JavaMail.coremail@bj163app113.163.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth Headset (hstest,
 rfcomm and sco connected but no sound)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1723690765=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1723690765==
Content-Type: multipart/alternative;
	boundary="----=_Part_164125_30985588.1217842248038"

------=_Part_164125_30985588.1217842248038
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable

 hi all

 at first I am thinking about the SCO routing problem, so run

[root@root sbin]$bccmd psset -s default 0x1ab 0
[root@root sbin]$hciconfig hci0 revision
hci0:   Type: UART
        BD Address: 00:06:6E:05:05:05 ACL MTU: 310:10 SCO MTU: 64:8
        Unified 21e
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI

=20
here we can see the SCO is mapping to HCI, after this, i try hstest

[root@root bin]$hstest play 1.wav 00:0D:3C:E8:1A:AC 2 &
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 45, mtu 64)
AT+VGS=3D11

there is still no sound output from headset, that's why?
who can help out , thanks in advance!

Tony

=20

--

 Best Regards
 ------------
 Tony


=D4=DA2008-08-04=A3=ACattaboyu <attaboyu@163.com> =D0=B4=B5=C0=A3=BA
and SCO route below:

[root@root bin]$../sbin/hciconfig hci0 revision
go...
hci0:   Type: UART
        BD Address: 00:06:6E:05:05:05 ACL MTU: 310:10 SCO MTU: 64:8
        Unified 21e
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  PCM
=20
=20
=20

--

 Best Regards
 ------------
 Tony


=D4=DA2008-08-04=A3=ACattaboyu <attaboyu@163.com> =D0=B4=B5=C0=A3=BA

 hi everyone

 I'm experimenting with the i-tech BlueBAND headset with bluez, this headse=
t support HS,HF,A2DP and AVRCP profile, But for me, I only want to test the=
 MONO for telephoning. it doesnt work well now.

toolchain: kernel 2.6.10, bluez-libs/utils-3.12, CSR BC4 UART interface
(the version of the toolchain is old, but I must work on that)

I will definitely test HeadSet profile, so btsco/snd-bt-sco are not include=
d. and I use the hstest in bluez-utils. hcid,hciattach,sdpd are always work=
 well.

when send audio to headset:

[root@root bin]$hstest play 1.wav 00:0D:3C:E8:1A:AC 2 &
Voice setting: 0x0060
RFCOMM channel connected
SCO audio channel connected (handle 45, mtu 64)
AT+VGS=3D11=20
AT+CKPD=3D200
AT+CKPD=3D200
AT+CKPD=3D200
AT+VGS=3D12
AT+VGS=3D11
AT+VGS=3D10
AT+VGS=3D11
AT+VGS=3D12
AT+CKPD=3D200

Here the headset beeps (it does that everytime a connection is initiated) a=
nd I can hear only some noise through it. By pressing one of the buttons on=
 the headset I even see the AT-comands which are submitteted via the rfcomm=
 channel. But no audio. A hcidump during the connection procedure shows jus=
t a normal looking bunch of hci and acl commands and events, but no sco pac=
kets whatsoever.

here the SCO is connected
[root@root bin]$hcitool con
Connections:
        < SCO 00:0D:3C:E8:1A:AC handle 45 state 1 lm SLAVE=20
        < ACL 00:0D:3C:E8:1A:AC handle 43 state 1 lm MASTER ENCRYPT=20


Am I doing something wrong or missing a step?=20



Thanks for your help and best regards

Tony

------=_Part_164125_30985588.1217842248038
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;hi all<br><br>&nbsp;at first I am thinking about the SCO routing=
 problem, so run<br><br>[root@root sbin]$bccmd psset -s default 0x1ab 0<br>=
[root@root sbin]$hciconfig hci0 revision<br>hci0:&nbsp;&nbsp; Type: UART<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:06:6E:05:05:05 A=
CL MTU: 310:10 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Unified 21e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: Blu=
eCore4-ROM<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 128 =
bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br=
></div><div>&nbsp;<br>here we can see the SCO is mapping to HCI, after this=
, i try hstest<br><br>[root@root bin]$hstest play 1.wav 00:0D:3C:E8:1A:AC 2=
 &amp;<br>Voice setting: 0x0060<br>RFCOMM channel connected<br>SCO audio ch=
annel connected (handle 45, mtu 64)<br>AT+VGS=3D11<br><br>there is still no=
 sound output from headset, that's why?<br>who can help out , thanks in adv=
ance!<br><br>Tony<br></div><div>&nbsp;</div><div><br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div><br>=D4=DA2008-08-04=A3=ACattaboyu &lt;attaboyu@163.com&gt; =D0=B4=B5=
=C0=A3=BA<br> <blockquote id=3D"isReplyContent" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;">and=
 SCO route below:<br><br>[root@root bin]$../sbin/hciconfig hci0 revision<br=
>go...<br>hci0:&nbsp;&nbsp; Type: UART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; BD Address: 00:06:6E:05:05:05 ACL MTU: 310:10 SCO MTU: 64:8<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unified 21e<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore4-ROM<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Max key size: 128 bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SCO mapping:&nbsp; PCM<div>&nbsp;</div><div>&nbsp;</div><di=
v>&nbsp;</div><div><br>--<br>
<div>&nbsp;Best Regards<br>&nbsp;------------<br>&nbsp;Tony<br></div>
</div><br>=D4=DA2008-08-04=A3=ACattaboyu &lt;<a href=3D"mailto:attaboyu@163=
.com">attaboyu@163.com</a>&gt; =D0=B4=B5=C0=A3=BA<br> <blockquote id=3D"isR=
eplyContent" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
x 0px 0px 0.8ex; padding-left: 1ex;"><div>&nbsp;hi everyone<br><br>&nbsp;I'=
m experimenting with the i-tech BlueBAND headset with bluez, this headset s=
upport HS,HF,A2DP and AVRCP profile, But for me, I only want to test the MO=
NO for telephoning. it doesnt work well now.<br><br>toolchain: kernel 2.6.1=
0, bluez-libs/utils-3.12, CSR BC4 UART interface<br>(the version of the too=
lchain is old, but I must work on that)<br><br>I will definitely test HeadS=
et profile, so btsco/snd-bt-sco are not included. and I use the hstest in b=
luez-utils. hcid,hciattach,sdpd are always work well.<br><br>when send audi=
o to headset:<br><br>[root@root bin]$hstest play 1.wav 00:0D:3C:E8:1A:AC 2 =
&amp;<br>Voice setting: 0x0060<br>RFCOMM channel connected<br>SCO audio cha=
nnel connected (handle 45, mtu 64)<br>AT+VGS=3D11 <br>AT+CKPD=3D200<br>AT+C=
KPD=3D200<br>AT+CKPD=3D200<br>AT+VGS=3D12<br>AT+VGS=3D11<br>AT+VGS=3D10<br>=
AT+VGS=3D11<br>AT+VGS=3D12<br>AT+CKPD=3D200<br><br><tt>Here the headset bee=
ps (it does that everytime a connection is initiated) =20
</tt><tt>and I</tt> can hear only some noise through it. By pressing one of=
 the buttons on the<tt> headset I even see the AT-comands which are submitt=
eted via the rfcomm =20
</tt><tt>channel.
</tt><tt>But no audio. </tt><tt>A hcidump during the connection procedure s=
hows just a normal looking =20
</tt><tt>bunch of</tt> hci and acl commands and events, but no sco packets =
whatsoever.<br><br>here the SCO is connected<br>[root@root bin]$hcitool con=
<br>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; SCO 00:=
0D:3C:E8:1A:AC handle 45 state 1 lm SLAVE <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &lt; ACL 00:0D:3C:E8:1A:AC handle 43 state 1 lm MASTER ENCRYP=
T <br><br><pre style=3D"margin: 0em;">Am I doing something wrong or missing=
 a step? </pre><br><br><pre style=3D"margin: 0em;">Thanks for your help and=
 best regards<br></pre></div><div><div>Tony<br></div>
</div></blockquote></blockquote>
------=_Part_164125_30985588.1217842248038--



--===============1723690765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1723690765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1723690765==--
