Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603070704s65a86a46ued55b48074b80e87@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5934_26190036.1141743887185"
Subject: [Bluez-users] Re: Re: Re: Re: Help me! hciattach have no error msg, but hciconfig don't find the device.
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
Date: Tue, 7 Mar 2006 23:04:47 +0800

------=_Part_5934_26190036.1141743887185
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,Erwin
Follows your suggestion, I want to download bluez-utils-2.10 and
bluez-libs-2.10 package.I use your patch to bluez-utils-2.10.
Because of uclinux on my board, I copy my /bluez to my target root without
/bluez/include and /bluez/lib.

I use cmd "hciattach /dev/ttyS1 bcsp 115200 noflow" to attach my uart
bluetooth device,but have some hdr error. info as follows:
"bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
......"
And I use cmd "hcid".But I find the cmd run without stop.
hciattach is error so hcid is error?

In addition, the device is good used by my PC.

Thanks a lot.

Best regards
yong Zhu

------=_Part_5934_26190036.1141743887185
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,Erwin<br>Follows your suggestion, I want to download bluez-utils-2.10 an=
d<br>bluez-libs-2.10 package.I use your patch to bluez-utils-2.10.<br>Becau=
se of uclinux on my board, I copy my /bluez to my target root without<br>
/bluez/include and /bluez/lib.<br><br>I use cmd &quot;hciattach /dev/ttyS1 =
bcsp 115200 noflow&quot; to attach my uart<br>bluetooth device,but have som=
e hdr error. info as follows:<br>&quot;bcsp_recv: Error in BCSP hdr checksu=
m
<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCSP hdr c=
hecksum<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCS=
P hdr checksum<br>......&quot;<br>And I use cmd &quot;hcid&quot;.But I find=
 the cmd run without stop.
<br>hciattach is error so hcid is error?<br><br>In addition, the device is =
good used by my PC.<br><br>Thanks a lot.<br><br>Best regards<br>yong Zhu

------=_Part_5934_26190036.1141743887185--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
