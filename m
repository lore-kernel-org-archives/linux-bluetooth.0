Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603280754m41f03b06o631d9ea15d06832e@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19927_32473125.1143561252845"
Subject: [Bluez-users] problem: application bug: pand(4239) has SIGCHLD set to SIG_IGN but calls wait().
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 28 Mar 2006 23:54:12 +0800

------=_Part_19927_32473125.1143561252845
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, everyone
I want to use two bluetooth dongle to connect my notebook and pc so I
can use same connection to internet. Both of them use Redhat9.0 and the
lastest bluez-utils-2.25 and bluez-libs-2.25.
*In pc, I input  these comands*
"hciconfig hci0 up
 hcid
 sdpd
 pand --listen --role NAP --master"
*In notebook, I input these comands*
"hciconfig hci0 up
 pand --role PANU --search --service NAP
 pand --connect <the bt address of pc dongle> --service NAP"
but not bnep0 device create.
*I cat /var/log/messages, have some error info of "kernel: application bug:
pand(4239) has SIGCHLD set to SIG_IGN but calls wait()." Is this bug known,
or I use error command?*
*Maybe you can help me, any advice is appreciate.*
**
*thanks*
*yong Zhu*
**
*info as follows:*
"Mar 28 23:24:13 localhost kernel: BlueZ Core ver 2.2 Copyright (C)
2000,2001 Qualcomm Inc
Mar 28 23:24:13 localhost kernel: Written 2000,2001 by Maxim Krasnyansky <
maxk@qualcomm.com>
Mar 28 23:24:13 localhost kernel: BlueZ HCI UART driver ver 2.1 Copyright
(C) 2000,2001 Qualcomm Inc
Mar 28 23:24:13 localhost kernel: Written 2000,2001 by Maxim Krasnyansky <
maxk@qualcomm.com>
Mar 28 23:24:13 localhost /sbin/hotplug: no runnable
/etc/hotplug/bluetooth.agent is installed
Mar 28 23:24:38 localhost kernel: BlueZ BNEP ver 1.1
Mar 28 23:24:38 localhost kernel: Copyright (C) 2001,2002 Inventel Systemes
Mar 28 23:24:38 localhost kernel: Written 2001,2002 by Clement Moreau <
clement.moreau@inventel.fr>
Mar 28 23:24:38 localhost kernel: Written 2001,2002 by David Libault <
david.libault@inventel.fr>
Mar 28 23:24:38 localhost kernel: Copyright (C) 2002 Maxim Krasnyanskiy <
maxk@qualcomm.com>
Mar 28 23:25:17 localhost pand[4237]: Bluetooth PAN daemon version 2.25
Mar 28 23:25:17 localhost pand[4237]: Inquiring
Mar 28 23:25:45 localhost pand[4239]: Bluetooth PAN daemon version 2.25
Mar 28 23:25:45 localhost pand[4239]: Connecting to 00:11:67:20:7e:33
Mar 28 23:25:45 localhost kernel: application bug: pand(4239) has SIGCHLD
set to SIG_IGN but calls wait().
Mar 28 23:25:45 localhost kernel: (see the NOTES section of 'man 2 wait').
Workaround activated.
Mar 28 23:25:45 localhost kernel: BlueZ L2CAP ver 2.1 Copyright (C)
2000,2001 Qualcomm Inc
Mar 28 23:25:45 localhost kernel: Written 2000,2001 by Maxim Krasnyansky <
maxk@qualcomm.com>"

------=_Part_19927_32473125.1143561252845
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>hi, everyone </div>
<div>I want to use two bluetooth dongle to connect my notebook and pc so I =
can&nbsp;use same connection to internet. Both of them use Redhat9.0 and th=
e lastest bluez-utils-2.25 and bluez-libs-2.25.</div>
<div><strong>In&nbsp;pc, I&nbsp;input &nbsp;these comands</strong></div>
<div>&quot;hciconfig hci0 up</div>
<div>&nbsp;hcid</div>
<div>&nbsp;sdpd</div>
<div>&nbsp;pand --listen --role NAP --master&quot;</div>
<div><strong>In notebook, I input these comands</strong></div>
<div>&quot;hciconfig hci0 up</div>
<div>&nbsp;pand --role PANU --search --service NAP</div>
<div>&nbsp;pand --connect &lt;the bt address of pc dongle&gt; --service NAP=
&quot;</div>
<div>but not bnep0 device create.</div>
<div><strong>I cat /var/log/messages, have some error info of &quot;kernel:=
 application bug: pand(4239) has SIGCHLD set to SIG_IGN but calls wait().&q=
uot;&nbsp;Is this bug known, or I use error command?</strong></div>
<div><strong>Maybe you can help me, any advice is appreciate.</strong></div=
>
<div><strong></strong>&nbsp;</div>
<div><strong>thanks</strong></div>
<div><strong>yong Zhu</strong></div>
<div><strong></strong>&nbsp;</div>
<div><strong>info as follows:</strong></div>
<div>&quot;Mar 28 23:24:13 localhost kernel: BlueZ Core ver 2.2 Copyright (=
C) 2000,2001 Qualcomm Inc<br>Mar 28 23:24:13 localhost kernel: Written 2000=
,2001 by Maxim Krasnyansky &lt;<a href=3D"mailto:maxk@qualcomm.com">maxk@qu=
alcomm.com
</a>&gt;<br>Mar 28 23:24:13 localhost kernel: BlueZ HCI UART driver ver 2.1=
 Copyright (C) 2000,2001 Qualcomm Inc<br>Mar 28 23:24:13 localhost kernel: =
Written 2000,2001 by Maxim Krasnyansky &lt;<a href=3D"mailto:maxk@qualcomm.=
com">
maxk@qualcomm.com</a>&gt;<br>Mar 28 23:24:13 localhost /sbin/hotplug: no ru=
nnable /etc/hotplug/bluetooth.agent is installed<br>Mar 28 23:24:38 localho=
st kernel: BlueZ BNEP ver 1.1<br>Mar 28 23:24:38 localhost kernel: Copyrigh=
t (C) 2001,2002 Inventel Systemes
<br>Mar 28 23:24:38 localhost kernel: Written 2001,2002 by Clement Moreau &=
lt;<a href=3D"mailto:clement.moreau@inventel.fr">clement.moreau@inventel.fr=
</a>&gt;<br>Mar 28 23:24:38 localhost kernel: Written 2001,2002 by David Li=
bault &lt;
<a href=3D"mailto:david.libault@inventel.fr">david.libault@inventel.fr</a>&=
gt;<br>Mar 28 23:24:38 localhost kernel: Copyright (C) 2002 Maxim Krasnyans=
kiy &lt;<a href=3D"mailto:maxk@qualcomm.com">maxk@qualcomm.com</a>&gt;<br>M=
ar 28 23:25:17 localhost pand[4237]: Bluetooth PAN daemon version=20
2.25<br>Mar 28 23:25:17 localhost pand[4237]: Inquiring<br>Mar 28 23:25:45 =
localhost pand[4239]: Bluetooth PAN daemon version 2.25<br>Mar 28 23:25:45 =
localhost pand[4239]: Connecting to 00:11:67:20:7e:33<br>Mar 28 23:25:45 lo=
calhost kernel: application bug: pand(4239) has SIGCHLD set to SIG_IGN but =
calls wait().
<br>Mar 28 23:25:45 localhost kernel: (see the NOTES section of 'man 2 wait=
'). Workaround activated.<br>Mar 28 23:25:45 localhost kernel: BlueZ L2CAP =
ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc<br>Mar 28 23:25:45 localhost k=
ernel: Written 2000,2001 by Maxim Krasnyansky &lt;
<a href=3D"mailto:maxk@qualcomm.com">maxk@qualcomm.com</a>&gt;&quot;</div>

------=_Part_19927_32473125.1143561252845--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
