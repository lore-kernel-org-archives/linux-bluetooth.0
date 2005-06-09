Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ddc9dd7e050609154524bf83ac@mail.gmail.com>
From: Christopher Peterson <webappz@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1240_2019350.1118357120796"
Subject: [Bluez-devel] Bluetooth 1.2 Java-based USB Dongle Interface - 6 simultaneous scanners
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 9 Jun 2005 15:45:20 -0700

------=_Part_1240_2019350.1118357120796
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Description: Bluetooth 1.2 Java-based USB Dongle Interface - with support=
=20
for 6 Parallel serial port sessions

Hello everyone, I'm looking for a quick fix here. I am in the middle of=20
completing a project for a Java based POS system. We had decided to use BT=
=20
usb dongle and BT 1.1 flicscanner(microvision), but when we asked if we=20
could add any additional scanners for inventory we discovered that it wasn'=
t=20
a viable option without a BT hub. One of our main focuses for the POS over=
=20
the last few years is to minimize the footprint, in retail - space matters!=
=20

To sync multiple units via BT 1.1 I would have to tell the unit to "power=
=20
off" and then wait for the next device to sync. I would considered this a=
=20
"confusing batch mode" method.
The concept is to build a Java server that will connect to 6 scanners=20
simultaneously, we will parse the data and stream it directly into our MySQ=
L=20
database.

I want to avoid installing yet another hardware device(BT Hub) to support,=
=20
so I'm asking the Bluetooth Pro's two questions:

   1. Am I possibly misunderstanding the scatternet concept in BT 1.2? Is=
=20
   simultaneous scanning possible via a USB Dongle?=20
   2. Would any of you be interested in a 20-40 hour project to build=20
   this for us, so I can focus on POS development?=20
      - We need source code so we can continue development.
       - You can choose to do the entire project, or just the part=20
      that you're good at. e.g. we could handle the Java/MySQL=20
      connectivity as long as you can develop the file transfer
communication with
      the BlueZ protocol API.
      =20

Chris Peterson
MIS Manager
Sterling Shoes Inc.
604-270-6114 x125
webappz@gmail.com

------=_Part_1240_2019350.1118357120796
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Description: Bluetooth 1.2 Java-based USB Dongle Interface - with support f=
or 6 Parallel serial port sessions<br>
<br>
Hello everyone, I'm looking for a quick fix here.&nbsp; I am in the
middle of completing a project for a Java based POS system.&nbsp; We
had decided to use BT usb dongle and BT 1.1 flicscanner(microvision),
but when we asked if we could add any additional scanners for inventory
we discovered that it wasn't a viable option without a BT hub.&nbsp;
One of our main focuses for the POS over the last few years is to
minimize the footprint, in retail - space matters! <br>
<br>
To sync multiple units via BT 1.1 I would have to tell the unit to
&quot;power off&quot; and then wait for the next device to sync.&nbsp; I wo=
uld
considered this a &quot;confusing batch mode&quot; method.<br>
<span style=3D"font-weight: bold;">The concept is to build a Java server
that will connect to 6 scanners simultaneously, we will parse the data
and stream it directly into our MySQL database.</span><br>
<br>
I want to avoid installing yet another hardware device(BT Hub) to support, =
so I'm asking the Bluetooth Pro's two questions:<br>
<ol>
  <li>Am I possibly misunderstanding the scatternet concept in BT 1.2?&nbsp=
; Is simultaneous scanning possible via a USB Dongle?</li>
  <li>Would any of you be interested in a 20-40 hour project to build this =
for us, so I can focus on POS development?</li>
  <ul>
    <li>We need source code so we can continue development.<br>
    </li>
    <li>You can choose to do the entire project, or just the part that
you're good at. e.g. we could handle the Java/MySQL connectivity as
long as you can develop the file transfer communication with the BlueZ
protocol API.<br>
    </li>
  </ul>
</ol>
<br>
Chris Peterson<br>
MIS Manager<br>
Sterling Shoes Inc.<br>
604-270-6114 x125<br>
<a href=3D"mailto:webappz@gmail.com">webappz@gmail.com</a><br>
<br>

------=_Part_1240_2019350.1118357120796--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
