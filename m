Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thilo Riessner <thilo@riessner.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 22 Oct 2007 13:59:45 +0200
References: <200710170839.22891.thilo@riessner.de>
	<1192640778.6184.37.camel@violet>
	<200710181205.24046.thilo@riessner.de>
In-Reply-To: <200710181205.24046.thilo@riessner.de>
MIME-Version: 1.0
Message-Id: <200710221359.45610.thilo@riessner.de>
Subject: Re: [Bluez-users]
	=?iso-8859-1?q?HP_Bluetooth_PC_Card_Mouse_doesn=27t?=
	=?iso-8859-1?q?_work=09after=09upgrade_to_openSuSE_10=2E3?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I got the solution at last. It is in the file "/etc/bluetooth/hcid.conf". T=
he =

parameter "lm" (link mode) has to be set to "master". After that the =

reconnection of the mouse worked again. If for some reasons the link mode =

should not be set to "master", you can use the following script after =

switching the mouse (or any other hid device?) on:

################## direct executable python script ########################
#!/usr/bin/python
import dbus

bus =3D dbus.SystemBus()

# service activation
bmgr =3D =

dbus.Interface(bus.get_object('org.bluez', '/org/bluez'), 'org.bluez.Manage=
r')
bus_id =3D bmgr.ActivateService('input')
imgr =3D =

dbus.Interface(bus.get_object(bus_id, '/org/bluez/input'), 'org.bluez.input=
.Manager')
devlist =3D imgr.ListDevices()

for dev in devlist:
  idev =3D dbus.Interface (bus.get_object(bus_id,dev), 'org.bluez.input.Dev=
ice')
  print(dev)
  idev.Disconnect()
  idev.Connect()
###########################################################################=
################

Am Donnerstag, 18. Oktober 2007 schrieb Thilo Riessner:
> Am Mittwoch, 17. Oktober 2007 schrieb Marcel Holtmann:
> > Hi Thilo,
> >
> > > > > my HP Bluetooth PC Card Moue, worked fine under openSuSE 10.2 aft=
er
> > > > > I added --connect 00:02:76:00:D0:3E to the hidd option (in the fi=
le
> > > > > /etc/sysconfig/bluetooth). But after upgrade to 10.3 this trick
> > > > > doesn't work any more. I tryed to to remove the pionting device a=
nd
> > > > > create it new. But than I have to switch the mouse in discorvery
> > > > > more. Is there any hint how to solve the problem?
> > > >
> > > > the openSuSE 10.3 should use the input service. Check the
> > > > wiki.bluez.org for details on how to configure devices. You only ne=
ed
> > > > to do that once btw. and then the mouse will re-connect.
> > >
> > > I tried that already, but it doesn't work for me, at least not
> > > satisfying. The reconnect does not work. Should the hidd still run, a=
nd
> > > if yes, which options should it be given? I guess "--connect
> > > 00:02:76:00:D0:3E" is not needed any more? But maybe --master and/or
> > > --server?
> >
> > no, go with the input service. It should work.
> >
> > Regards
> >
> > Marcel
>
> Thanks for your information so far. But still the mouse doesn't work. The=
re
> seems to be a kind of connection between the mouse and the notebook (the
> kbluetooth icon in the system tray gets blue and lists the hp-mouse as
> connected), but the LED of the mouse remains dark, and it simply does not
> work. As I said, it used to work with openSuSE 10.2 and hidd.
>
> Thilo
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-- =

Mit freundlichen Gr=FC=DFen

Thilo Rie=DFner

--
----------------------------------------------------
|Rie=DFner Gase GmbH & Co. KG                        |
|Rudolf-Diesel-Stra=DFe 5                            |
|96215 Lichtenfels                                 |
|Telefon: 0049 (0) 9571 / 765 - 0                  |
|Telefax: 0049 (0) 9571 / 765 - 67                 |
|Komplement=E4rin: Rie=DFner-Gase Beteiligungs-GmbH    |
|Sitz: Lichtenfels                                 |
|Registergericht Coburg HRB 2616                   |
|Registergericht Coburg HRA 3533                   |
|Gesch=E4ftsf=FChrer: Dipl.-Ing. Dr. Rolf Rie=DFner,     |
|                 Dr. Thilo Rie=DFner                |
|Umsatzsteuernummer: 173/06405                     |
|Umsatz-IdNr.: DE 812 175 462                      |
----------------------------------------------------

-----------------------------------------------------------------------
|Diese E-Mail (ggf. nebst Anhang) enth=E4lt vertrauliche und/oder       |
|rechtlich gesch=FCtzte Informationen. Wenn Sie nicht der richtige      |
|Adressat sind, oder diese E-Mail irrt=FCmlich erhalten haben,          |
|informieren |Sie bitte sofort den Absender und vernichten Sie        |
|diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe   |
|dieser Mail ist nicht gestattet.                                     |
|---------------------------------------------------------------------|
|This e-mail (and any attachment/s) contains confidential and/or      |
|privileged information. If you are not the intended recipient        |
|(or have received this e-mail in error) please notify the sender     |
|immediately and destroy this e-mail. Any unauthorised copying,       |
|disclosure or distribution of the material in this e-mail is         |
|strictly forbidden.                                                  |
-----------------------------------------------------------------------


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
