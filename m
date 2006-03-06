Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603060718n657e8de2y224925836fede98c@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7969_28802094.1141658322024"
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
Date: Mon, 6 Mar 2006 23:18:42 +0800

------=_Part_7969_28802094.1141658322024
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

Am Donnerstag, den 02.03.2006, 23:08 +0800 schrieb zhu yong:
> Hi,Erwin
> my board use Samsung 44B0x chip of ATM7TDMI. I use bluez-utils-2.24
> and bluez-libs-2.24.
> Do I need patchs for non-mmu systems?
> Is 'startup script'  /etc/hcid.conf?
> I have no ides how to change the file, I use default config.

>The default config should be ok. Some patches are necessary because of
>the fork() restrictions on nommu (they may be different for 2.24!):
>http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez-utils-2.10/

>My startup script works as follows:

>/sbin/hcid -n &
>/sbin/hciattach ttyS0 csr &

>-Erwin

------=_Part_7969_28802094.1141658322024
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,Erwin<br>Follows your suggestion, I want to download bluez-utils-2.=
10 and<br>bluez-libs-2.10 package.I use your patch to bluez-utils-2.10.</di=
v>
<div>Because of uclinux on my board, I copy my /bluez to my target root wit=
hout /bluez/include and /bluez/lib.</div>
<div>&nbsp;</div>
<div>I use cmd &quot;hciattach /dev/ttyS1 bcsp 115200 noflow&quot; to attac=
h my uart bluetooth device,but have some hdr error. info as follows:</div>
<div>&quot;bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCS=
P hdr checksum<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error=
 in BCSP hdr checksum<br>bcsp_recv: Error in BCSP hdr checksum<br>......&qu=
ot;
</div>
<div>And I use cmd &quot;hcid&quot;.But I find the cmd run without stop.</d=
iv>
<div>hciattach is error so hcid is error?<br>&nbsp;</div>
<div>In addition, the device is good used by my PC.</div>
<div><br>Thanks a lot.<br><br>Best regards<br>yong Zhu<br><br>Am Donnerstag=
, den 02.03.2006, 23:08 +0800 schrieb zhu yong:<br>&gt; Hi,Erwin<br>&gt; my=
 board use Samsung 44B0x chip of ATM7TDMI. I use bluez-utils-2.24<br>&gt; a=
nd=20
bluez-libs-2.24.<br>&gt; Do I need patchs for non-mmu systems?<br>&gt; Is '=
startup script' &nbsp;/etc/hcid.conf?<br>&gt; I have no ides how to change =
the file, I use default config.<br><br>&gt;The default config should be ok.=
 Some patches are necessary because of
<br>&gt;the fork() restrictions on nommu (they may be different for 2.24!):=
<br>&gt;<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D=
"http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez-utils-2.10/" targe=
t=3D"_blank">
http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez-utils-2.10/</a><br>=
<br>&gt;My startup script works as follows:<br><br>&gt;/sbin/hcid -n &amp;<=
br>&gt;/sbin/hciattach ttyS0 csr &amp;<br><br>&gt;-Erwin<br>&nbsp;</div>

------=_Part_7969_28802094.1141658322024--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
