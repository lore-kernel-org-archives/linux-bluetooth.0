Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603080742s393ad20k9939788957e013dc@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1792_33518717.1141832522113"
Subject: [Bluez-users] patch bluez for uclinux, but the cmd 'hcid' can not stop.
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
Date: Wed, 8 Mar 2006 23:42:02 +0800

------=_Part_1792_33518717.1141832522113
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,everyone
Follows Erwin suggestion, I download bluez-utils-2.10 and
bluez-libs-2.10 package.I use Erwin's patch to bluez-utils-2.10.
Because of uclinux on my board, I copy my compiled /bluez to my target root
without /bluez/include and /bluez/lib.

I use cmd "hciattach /dev/ttyS1 bcsp 115200 noflow" to attach my uart
bluetooth device,but have some hdr error. info as follows:
"bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
......"
And I use cmd "hcid".But I find the cmd run without stop.
Does anyone encounter the same problem? Maybe you can help me.

In addition, the device is good used by my PC.

thanks
yong Zhu

------=_Part_1792_33518717.1141832522113
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div style=3D"DIRECTION: ltr"><span class=3D"q">Hi,everyone<br>Follows <fon=
t color=3D"#550055">Erwin </font>suggestion, I download bluez-utils-2.10 an=
d<br></span></div><span></span>
<div style=3D"DIRECTION: ltr">bluez-libs-2.10 package.I use Erwin's patch t=
o bluez-utils-2.10.</div>
<div>Because of uclinux on my board, I copy my compiled /bluez to my target=
 root without /bluez/include and /bluez/lib.</div>
<div>&nbsp;</div>
<div>I use cmd &quot;hciattach /dev/ttyS1 bcsp 115200 noflow&quot; to attac=
h my uart bluetooth device,but have some hdr error. info as follows:</div>
<div>&quot;bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCS=
P hdr checksum<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error=
 in BCSP hdr checksum<br>bcsp_recv: Error in BCSP hdr checksum<br>......&qu=
ot;=20
</div>
<div>And I use cmd &quot;hcid&quot;.But I find the cmd run without stop.</d=
iv>
<div>Does anyone encounter the same problem? Maybe you can help me.<br>&nbs=
p;</div>
<div>In addition, the device is good used by my PC.</div>
<div>&nbsp;</div>
<div>thanks</div>
<div>yong Zhu</div>

------=_Part_1792_33518717.1141832522113--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
