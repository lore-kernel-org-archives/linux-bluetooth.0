Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43668e3005042810367c457ee4@mail.gmail.com>
From: Gabriel Marques <gabriel.agm@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2232_32891219.1114709802607"
Subject: [Bluez-users] device suggestion
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
Date: Thu, 28 Apr 2005 14:36:42 -0300

------=_Part_2232_32891219.1114709802607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm a total foreigner here, cause I'm using Window and J2SE, but I need to=
=20
solve a problem concerning bluetooth hardware and I believe you know better=
=20
than anyone what device can solve my problem.
 I need to make a bluetooth return channel for a set top box, and for that=
=20
all I can use is a RS232 port, and the bluetooth stack must be pure Java.
So I'm using JavaBluetooth (http://sourceforge.net/projects/javabluetooth),=
=20
that implements JSR82 trough a serial port or serial port abstraction. The=
=20
problem is that JavaBluetooth needs a device that offers a H4 (UART) HCI=20
Transport Specification access.=20
As far as I know there are some serial blutooth dongles that implements H4,=
=20
and some PCI cards that offer acess to the HCI layer trough an emulated=20
serial port (on Windows). Some USBdongles do it either, but with a 3rd=20
partie paid driver, and that won't help.
 So, basically, I want a lis of devices (brands, names) that can be acessed=
=20
trough an H4 HCI layer, specially serial dongles, since as soon as I get=20
things running on the PC I will port it to set-tops and cell phones.
 I've posted a similar message in the JavaBluetooth list of course, but the=
=20
developer is too busy with other things, and the most recent discutions on=
=20
the list are dating 2004.
 I think Brainbox BL-510 does the job, but I need more options, and the=20
manufacturers always want to push their own protocols and software.
 thanks for any help

------=_Part_2232_32891219.1114709802607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I'm a total foreigner here, cause I'm using Window and J2SE, but I nee=
d to solve a problem&nbsp; concerning bluetooth hardware and I believe you =
know better than anyone what device can solve my problem.</div>
<div>&nbsp;</div>
<div>I need to make a bluetooth return channel for a set top box, and for t=
hat all I can use is a RS232 port, and the bluetooth stack must be pure Jav=
a.</div>
<div>So I'm using JavaBluetooth (<a href=3D"http://sourceforge.net/projects=
/javabluetooth">http://sourceforge.net/projects/javabluetooth</a>), that im=
plements JSR82 trough a serial port or serial port abstraction. The problem=
 is that JavaBluetooth needs a device that offers a H4 (UART) HCI Transport=
 Specification access.=20
</div>
<div>As far as I know there are some serial blutooth dongles that implement=
s H4, and some PCI cards that offer acess to the HCI layer trough an emulat=
ed serial port (on Windows). Some USBdongles do it either, but with a 3rd p=
artie paid driver, and that won't help.
</div>
<div>&nbsp;</div>
<div>So, basically, I want a lis of devices (brands, names) that can be ace=
ssed trough an H4 HCI layer, specially serial dongles, since as soon as I g=
et things running on the PC I will port it to set-tops and cell phones.
</div>
<div>&nbsp;</div>
<div>I've posted a similar message in the JavaBluetooth list of course, but=
 the developer is too busy with other things, and the most recent discution=
s on the list are dating 2004.</div>
<div>&nbsp;</div>
<div>I think Brainbox BL-510 does the job, but I need more options, and the=
 manufacturers always want to push their own protocols and software.</div>
<div>&nbsp;</div>
<div>thanks for any help</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
------=_Part_2232_32891219.1114709802607--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
