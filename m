Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603090902t7c2ab03m61383b87d7a868e6@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Re: [Bluez-users] Can't open PIN file /home/chenjiajing/bluez//etc/bluetooth/pin!
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8072_25298026.1141923722075"
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
Date: Fri, 10 Mar 2006 01:02:02 +0800

------=_Part_8072_25298026.1141923722075
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Erwin

>you need to specify --prefix=3D\"\" for "configure" in bluez-utils and
>bluez-libs for cross compiling.

>-Erwin
I follow your suggest that set --prefix=3D/.
but the cmd 'hcid -n' still can not stop. And the cmd 'hciattach /dev/ttyS1
bcsp 115200' have the error 'bcsp_recv: Error in BCSP hdr checksum'.
I read some old mail in this maillist, said the error can ignore.
How can i do to use my device.
Info as follows:

# ./hcid -n -f /bluez/etc/bluetooth/hcid.conf
hcid[31]: Bluetooth HCI daemon

hcid[31]: Exit.
# ./hciattach /dev/ttyS1 bcsp 115200
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
bcsp_recv: Error in BCSP hdr checksum
#


Thanks
yong Zhu


> I use the cmd 'hcid', but find that hcid find the pin file from error
> directory.
> the /home/chenjiajing/bluez/ is my compile directory.
> How can I change to the correct directory of '/etc/bluetooth/pin'?
> info as follows:
> # ./hcid -n -f /etc/bluetooth/hcid.conf
> hcid[32]: Bluetooth HCI daemon
> hcid[32]: Can't open PIN
> file /home/chenjiajing/bluez//etc/bluetooth/pin. No suc
> h file or directory(2)
> hcid[33]: Can't init device hci0. Connection timed out(110)
>

------=_Part_8072_25298026.1141923722075
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Erwin</div>
<div>&nbsp;</div>
<div>&gt;you need to specify --prefix=3D\&quot;\&quot; for &quot;configure&=
quot; in bluez-utils and<br>&gt;bluez-libs for cross compiling.<br><br>&gt;=
-Erwin</div>
<div>I follow your suggest that set --prefix=3D/.</div>
<div>but the cmd 'hcid -n' still can not stop. And the cmd 'hciattach /dev/=
ttyS1 bcsp 115200' have the error 'bcsp_recv: Error in BCSP hdr checksum'.<=
/div>
<div>I read some old mail in this maillist, said the error can ignore. </di=
v>
<div>How can i do to use my device.</div>
<div>Info as follows:</div>
<div>
<p># ./hcid -n -f /bluez/etc/bluetooth/hcid.conf<br>hcid[31]: Bluetooth HCI=
 daemon&nbsp;</p>
<p>hcid[31]: Exit.<br># ./hciattach /dev/ttyS1 bcsp 115200<br>bcsp_recv: Er=
ror in BCSP hdr checksum<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_r=
ecv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCSP hdr checksum
<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCSP hdr c=
hecksum<br>bcsp_recv: Error in BCSP hdr checksum<br>bcsp_recv: Error in BCS=
P hdr checksum<br>#</p></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>yong Zhu</div>
<div>&nbsp;</div>
<div><br>&gt; I use the cmd 'hcid', but find that hcid find the pin file fr=
om error<br>&gt; directory.<br>&gt; the /home/chenjiajing/bluez/ is my comp=
ile directory.<br>&gt; How can I change to the correct directory of '/etc/b=
luetooth/pin'?
<br>&gt; info as follows:<br>&gt; # ./hcid -n -f /etc/bluetooth/hcid.conf<b=
r>&gt; hcid[32]: Bluetooth HCI daemon<br>&gt; hcid[32]: Can't open PIN<br>&=
gt; file /home/chenjiajing/bluez//etc/bluetooth/pin. No suc<br>&gt; h file =
or directory(2)
<br>&gt; hcid[33]: Can't init device hci0. Connection timed out(110)<br>&gt=
;<br>&nbsp;</div>

------=_Part_8072_25298026.1141923722075--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
