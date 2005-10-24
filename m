Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10264_8829478.1130164475777"
Subject: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
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
Date: Mon, 24 Oct 2005 22:34:35 +0800

------=_Part_10264_8829478.1130164475777
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!
 I'm doing a project on indoor positioning using bluetooth.

I've installed Linux(Fedore Core 4) on my comp and the Bluez Protocol Stack
to get the value of the signal strength between two Bluetooth USB dongles.
I've connected two Bluetooth USB dongles to one computer(have the USB
extension cables to increase the distance between the two dongles).When I
run the command 'hcitool lq <bdaddr>' to get the value of the link quality
between the two dongles,it is always 255.Even if I increase or decrease the
distance between the two dongles,the LQ remains constant at 255.The RSSI
value changes but this change is abrupt and does not seem like a good
measure of the signal strength. Any idea as to what could be the possible
problem with the LQ and any solutions?
 The adaptors I'm using are: Billionton Version 1.2 Bluetooth USB Adaptors
(P/N: USBBT02 (UBTBR2-B)).
 Thanks
 Arpit

------=_Part_10264_8829478.1130164475777
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi!</div>
<div>&nbsp;</div>
<div>I'm doing a project on indoor positioning using bluetooth.</div>
<div><br><span>I've installed Linux(Fedore Core 4) on my&nbsp;comp and the =
Bluez Protocol Stack to get the value of the signal strength between two Bl=
uetooth USB dongles. I've connected two Bluetooth USB dongles to one comput=
er(have the USB extension cables to increase the distance between the two d=
ongles).When I run the command 'hcitool lq &lt;bdaddr&gt;' to get the value=
 of the link quality between the two dongles,it is always=20
255.Even if I increase or decrease the distance between the two dongles,the=
 LQ remains constant at 255.The RSSI value changes but this change is abrup=
t and does not seem like a good measure of the signal strength. Any idea as=
 to what could be the possible problem with the LQ and any solutions?
</span></div>
<div><span></span>&nbsp;</div>
<div><span>The&nbsp;adaptors I'm using are: Billionton Version 1.2 Bluetoot=
h USB Adaptors (P/N: USBBT02 (UBTBR2-B)).</span></div>
<div><span></span>&nbsp;</div>
<div><span>Thanks</span></div>
<div><span></span>&nbsp;</div>
<div><span>Arpit</span></div>

------=_Part_10264_8829478.1130164475777--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
