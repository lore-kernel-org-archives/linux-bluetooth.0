Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603080810v740f51fejeab23a6b86751b0@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2220_30325168.1141834230253"
Subject: [Bluez-users] Can't open PIN file /home/chenjiajing/bluez//etc/bluetooth/pin!
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
Date: Thu, 9 Mar 2006 00:10:30 +0800

------=_Part_2220_30325168.1141834230253
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I use the cmd 'hcid', but find that hcid find the pin file from error
directory.
the /home/chenjiajing/bluez/ is my compile directory.
How can I change to the correct directory of '/etc/bluetooth/pin'?
info as follows:
# ./hcid -n -f /etc/bluetooth/hcid.conf
hcid[32]: Bluetooth HCI daemon
hcid[32]: Can't open PIN file /home/chenjiajing/bluez//etc/bluetooth/pin. N=
o
suc
h file or directory(2)
hcid[33]: Can't init device hci0. Connection timed out(110)

thanks
yong Zhu

------=_Part_2220_30325168.1141834230253
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I use the cmd 'hcid', but find that hcid find the pin file from error =
directory.</div>
<div>the /home/chenjiajing/bluez/ is my compile directory. </div>
<div>How can I change to the correct directory of '/etc/bluetooth/pin'?</di=
v>
<div>info as follows:</div>
<div># ./hcid -n -f /etc/bluetooth/hcid.conf<br>hcid[32]: Bluetooth HCI dae=
mon<br>hcid[32]: Can't open PIN file /home/chenjiajing/bluez//etc/bluetooth=
/pin. No suc<br>h file or directory(2)<br>hcid[33]: Can't init device hci0.=
 Connection timed out(110)
</div>
<div>&nbsp;</div>
<div>thanks </div>
<div>yong Zhu </div>

------=_Part_2220_30325168.1141834230253--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
