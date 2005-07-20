Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1ffb4b0705072008471f85c2df@mail.gmail.com>
From: Mike Lee <eemike@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth as ttyS0
In-Reply-To: <E1Dv9Kx-0007c4-NM@server.broadrick.moe.edu.sg>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2300_12630985.1121874453586"
References: <E1Dv9Kx-0007c4-NM@server.broadrick.moe.edu.sg>
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
Date: Wed, 20 Jul 2005 23:47:33 +0800

------=_Part_2300_12630985.1121874453586
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 7/20/05, fyp@dreamx.org <fyp@dreamx.org> wrote:=20
>=20
> Hi!
>=20
> I've having reading many sites and found that to bind a port for
> bluetooth i need rfcomm. I've also tried the steps in doing it but it
> doesn't seem like what I really wanted.
>=20
> My objective is to make a USB Bluetooth dongle work as a Serial port
> (i.e ttyS0). I've a USB Bluetooth dongle and a RS232 Bluetooth device.
> This is to emulate a serial cable replacement.
> A simple diagram of what I really want to achieve is osmething like
> this:
>=20
> |LinuxPC| USB<-->Bluetooth ~~~~~~ Bluetooth<-->RS232 |LinuxPC|

  I guess you are using rs232 bluetooth dongle in the right side. Then firs=
t=20
of all, you need to know how to get the dongle works. For the usb dongle ,=
=20
kernel should dynamic detect and what you need to do is to setup hcid. For=
=20
the RS232 dongle, you need additional command hciattach to setup the dongle=
=20
and run hcid.=20
 Up to now , you should get something by "hciconfig -a". Then you should us=
e=20
rfcomm command from bluez-util to setup the link between computer.
  Mike,Lee

------=_Part_2300_12630985.1121874453586
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br>
<div><span class=3D"gmail_quote">On 7/20/05, <b class=3D"gmail_sendername">=
<a href=3D"mailto:fyp@dreamx.org">fyp@dreamx.org</a></b> &lt;<a href=3D"mai=
lto:fyp@dreamx.org">fyp@dreamx.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi!<br><br>I've having reading m=
any sites and found that to bind a port for<br>bluetooth i need rfcomm. I'v=
e also tried the steps in doing it but it
<br>doesn't seem like what I really wanted.<br><br>My objective is to make =
a USB Bluetooth dongle work as a Serial port<br>(i.e ttyS0). I've a USB Blu=
etooth dongle and a RS232 Bluetooth device.<br>This is to emulate a serial =
cable replacement.
<br>A simple diagram of what I really want to achieve is osmething like<br>=
this:<br><br>|LinuxPC| USB&lt;--&gt;Bluetooth ~~~~~~ Bluetooth&lt;--&gt;RS2=
32 |LinuxPC|</blockquote>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; I guess you are using rs232 bluetooth dongle in the=
 right side.&nbsp; Then first of all, you need to know how to get the dongl=
e works. For the usb dongle , kernel should dynamic detect and what you nee=
d to do is to setup hcid. For the RS232 dongle, you need additional command=
 hciattach to setup the dongle and run hcid.=20
</div>
<div>&nbsp;&nbsp; Up to now , you should get something by &quot;hciconfig -=
a&quot;. Then you should use rfcomm command from bluez-util to setup the li=
nk between computer.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Mike,Lee</div><br>&nbsp;</div>

------=_Part_2300_12630985.1121874453586--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
