Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9f41439105072109526cb11e82@mail.gmail.com>
From: Julien BIBOLLET <julien.bibollet@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18752_23317346.1121964779692"
Subject: [Bluez-users] hcitool and rssi value=0
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
Date: Thu, 21 Jul 2005 18:52:59 +0200

------=_Part_18752_23317346.1121964779692
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
 I wan't to do something like
this<http://gentoo-wiki.com/TIP_Bluetooth_Proximity_Monitor>,
but I have a problem reading the rssi value:
 hcitool cc 00:04:3E:46:02:26 (adress of my bluetooth PDA)
hcitool rssi 00:04:3E:46:02:26
output is always RSSI return value: 0
 but if I launch KBluetoothd and establish an OBEX connection to download a=
=20
file, then the outpur of hcitool rssi ... is good
 What can I do to get ths correct rssi value only using hcitool, or shell=
=20
programs?
 Thanks.

------=_Part_18752_23317346.1121964779692
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I wan't to do something like <a href=3D"http://gentoo-wiki.com/TIP_Blu=
etooth_Proximity_Monitor">this</a>, but I have a problem reading the rssi v=
alue:</div>
<div>&nbsp;</div>
<div>hcitool cc 00:04:3E:46:02:26 (adress of my bluetooth PDA)</div>
<div>hcitool rssi 00:04:3E:46:02:26</div>
<div>output is always RSSI return value: 0</div>
<div>&nbsp;</div>
<div>but if I launch KBluetoothd and establish an OBEX connection to downlo=
ad a file, then the outpur of hcitool rssi ... is good</div>
<div>&nbsp;</div>
<div>What can I do to get ths correct rssi value only using hcitool, or she=
ll programs?</div>
<div>&nbsp;</div>
<div>Thanks.</div>

------=_Part_18752_23317346.1121964779692--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
