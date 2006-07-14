Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 18:16:57 +0200
From: "Marcus C. Gottwald" <gottwald@inf.fu-berlin.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060714161657.GA25533@inf.fu-berlin.de>
Mime-Version: 1.0
Subject: [Bluez-users] SCO mapping, bccmd mapsco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello everyone!

I thought I'd give using my bluetooth headset as microphone and
speaker a try, using bluetooth-alsa. Everything is working
(pairing, connecting, getting key press info) apart from no
sound data being sent to or received from the headset, both with
a Nokia headset (HS-3W) and a Motorola one (H300).

One hint I found was to look at "hciconfig hci0 revision" to
check for the "SCO mapping". So I did:

  coach:~# hciconfig hci0 revision
  hci0:   Type: USB
          BD Address: 08:00:46:EB:0E:B6 ACL MTU: 192:8 SCO MTU: 64:8
          HCI 18.1
          Chip version: BlueCore02-External
          Max key size: 56 bit
          SCO mapping:  PCM

And supposedly the mapping to PCM is not what I want. Also, the
counters for "sco" in the hciconfig output never showed anything
but 0. So I got myself the bluez-utils sources, compiled them to
get "bccmd" and gave it a try:

  coach:~# bccmd psset mapsco 0
  coach:~# hciconfig hci0 revision
  hci0:   Type: USB
          BD Address: 08:00:46:EB:0E:B6 ACL MTU: 192:8 SCO MTU: 64:8
          HCI 18.1
          Chip version: BlueCore02-External
          Max key size: 56 bit
          SCO mapping:  HCI

Looking good, but nothing actually changed. Looking closer I
noticed:

  coach:~# bccmd psset mapsco 0
  coach:~# bccmd psget mapsco
  Map SCO over PCM: 0x0001 (1)
  coach:~# bccmd psset mapsco 1
  coach:~# bccmd psget mapsco
  Map SCO over PCM: 0x0001 (1)

However, the output of "hciconfig" changes from "PCM" to "HCI"
back and forth as expected. So question 1 would be: Is it normal
for the output of "hciconfig" to change although "psget" returns
an unchanged value?

Since the Bluetooth device is connected internally via USB, I
thought maybe I should try "bccmd" with "-t USB", but I only get
a "Device not available". Looking at "csr_open_usb()" I presume
the "device" argument isn't actually used. So I changed the code
to look for device 044e:3007 instead of 0a12:0001 since my
Bluetooth device identifies as such, but then only receive the
output of "Can't claim interface: Device or resource busy (16)"
even with all other Bluetooth stuff (rfcomm, sdpf, hcid) not
running.

So question 2 would be: What's the correct way to access the
device via USB (if trying to do so actually makes any sense at
all)?


Thanks in advance,

Marcus

-- =

   Marcus C. Gottwald  =B7  http://www.inf.fu-berlin.de/~gottwald/



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
