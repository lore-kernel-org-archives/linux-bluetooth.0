Return-Path: <cyrus@holtmann.org>
Subject: bluetooth on ubuntu without desktop environment
From: Michael Jarosch <mitsch@riotmusic.de>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Imd/glkZPM8JUH9QmLuZ"
Date: Fri, 03 Jun 2011 22:12:14 +0200
Message-ID: <1307131935.1862.189.camel@powermacG4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Imd/glkZPM8JUH9QmLuZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I'm using the latest Ubuntu (11.04) minimal installation with XBMC and I
try to make a Logitech Cordless MediaBoard Pro work with it. The
keyboard-/touchpad-combination designed for the PS3 worked just fine
with a "normal" install of Ubuntu 10.10 with the Gnome desktop
environment (and I guess it should work with 11.04/Unity, also). My
special problem now is, that I don't use any kind of desktop environment
any more, it's just X and the XBMC-GUI. I tried to use "blueman" to
configure the bluetooth connection, but it doesn't seem to start - just
getting some weird errors. So, I totally depend on the console-tools of
bluez and dbus - but, hey, this is linux and it shouldn't be a problem,
right?

Well, partly, it actually isn't. Pairing and connecting the keyboard
works right away. But if I reboot the computer or try to reconnect the
keyboard for other reasons, I'm forced to pair the devices again and
again, which isn't exactly the spirit of using bluetooth devices. :)

My goal is to make the keyboard connect to my PC whenever I need it. All
I achieved is that the connection only works if the PC initialises it.


I used an entry from the arch linux wiki for my configuration, which
only uses console-commands, mainly dbus-specific:
https://wiki.archlinux.org/index.php/Bluetooth_mouse_configuration


I tried this:

1) Pressing the reset button of the Logitech-device to make it
discoverable to the PC.

2) Scanning for the Logitech-device with "hcitool scan". I get this
answer from the kyeboard:
00:07:61:F6:97:F7   Logitech Cordless MediaBoard Pro(TM)

3) Getting the dbus adress of the BT-Dongle:
$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
"/" org.bluez.Manager.ListAdapters

method return sender=3D:1.23 -> dest=3D:1.26 reply_serial=3D2
   array [
      object path "/org/bluez/1926/hci0"
   ]

4) Create the bluez-device for the keyboard:
$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
"/org/bluez/1926/hci0" org.bluez.Adapter.CreateDevice
string:00:07:61:F6:97:F7

5) Give keyboard permission to connect the PC:
$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
"/org/bluez/1926/hci0/dev_00_07_61_F6_97_F7"
org.bluez.Device.SetProperty string:Trusted variant:boolean:true


I can connect the Logitech-device with hidd --connect 00:07:61:F6:97:F7,
now, but if the connection somehow breaks, it's not possible to
reconnect from the keyboard (by just pressing a button or turning the
device off and on, f.e.)

This is the state of dbus/bluez/the PC system, now:

$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
"/org/bluez/1926/hci0" org.bluez.Adapter.GetProperties

method return sender=3D:1.23 -> dest=3D:1.28 reply_serial=3D2
   array [
      dict entry(
         string "Address"
         variant             string "00:19:86:00:3C:65"
      )
      dict entry(
         string "Name"
         variant             string "dog-0"
      )
      dict entry(
         string "Class"
         variant             uint32 4849920
      )
      dict entry(
         string "Powered"
         variant             boolean true
      )
      dict entry(
         string "Discoverable"
         variant             boolean false
      )
      dict entry(
         string "Pairable"
         variant             boolean true
      )
      dict entry(
         string "DiscoverableTimeout"
         variant             uint32 0
      )
      dict entry(
         string "PairableTimeout"
         variant             uint32 0
      )
      dict entry(
         string "Discovering"
         variant             boolean false
      )
      dict entry(
         string "Devices"
         variant             array [
               object path "/org/bluez/1926/hci0/dev_00_07_61_F6_97_F7"
            ]
      )
      dict entry(
         string "UUIDs"
         variant             array [
               string "00001000-0000-1000-8000-00805f9b34fb"
               string "00001001-0000-1000-8000-00805f9b34fb"
               string "00001112-0000-1000-8000-00805f9b34fb"
               string "0000111f-0000-1000-8000-00805f9b34fb"
               string "0000110a-0000-1000-8000-00805f9b34fb"
               string "0000110c-0000-1000-8000-00805f9b34fb"
               string "0000110e-0000-1000-8000-00805f9b34fb"
               string "00001103-0000-1000-8000-00805f9b34fb"
            ]
      )
   ]


$ dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
"/org/bluez/1926/hci0/dev_00_07_61_F6_97_F7"
org.bluez.Device.GetProperties

method return sender=3D:1.23 -> dest=3D:1.31 reply_serial=3D2
   array [
      dict entry(
         string "Address"
         variant             string "00:07:61:F6:97:F7"
      )
      dict entry(
         string "Name"
         variant             string "Logitech Cordless MediaBoard
Pro(TM)"
      )
      dict entry(
         string "Alias"
         variant             string "Logitech Cordless MediaBoard
Pro(TM)"
      )
      dict entry(
         string "Class"
         variant             uint32 9536
      )
      dict entry(
         string "Icon"
         variant             string "input-keyboard"
      )
      dict entry(
         string "Paired"
         variant             boolean false
      )
      dict entry(
         string "Trusted"
         variant             boolean true
      )
      dict entry(
         string "Blocked"
         variant             boolean false
      )
      dict entry(
         string "Connected"
         variant             boolean true
      )
      dict entry(
         string "UUIDs"
         variant             array [
               string "00001124-0000-1000-8000-00805f9b34fb"
               string "00001200-0000-1000-8000-00805f9b34fb"
            ]
      )
      dict entry(
         string "Services"
         variant             array [
            ]
      )
      dict entry(
         string "Adapter"
         variant             object path "/org/bluez/1118/hci0"
      )
   ]



I've done everything like described in the wiki-entry except for one
thing: The author recommends using a non privileged user, I did
everything with root.

And just another deviation: In the article of the arch-wiki it is said,
that the dbus address reflects the pid of bluetoothd. Under Ubuntu this
is not true!

Now here is my question: What else can I do to reach my goal?
And then: What's your opinion: Is there a bug in the Ubuntu version of
bluez?


Thanks for any hints!
And greetings!

Mitsch

--=-Imd/glkZPM8JUH9QmLuZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk3pQBgACgkQNFzJVOwishmExgCgyo8yCxQgPFAPNRwnG4JZ4uuY
jRAAoKjm37pn0okAgvZrB10W5B07AfTy
=CtOd
-----END PGP SIGNATURE-----

--=-Imd/glkZPM8JUH9QmLuZ--

