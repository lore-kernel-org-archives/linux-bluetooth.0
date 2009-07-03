Return-Path: <cyrus@holtmann.org>
Subject: aplay: set_params:966: Channels count non available
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ixJ8bA3LOM/pXQpulXy4"
Date: Fri, 03 Jul 2009 08:29:57 -0400
Message-Id: <1246624197.3410.415.camel@pc.interlinx.bc.ca>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ixJ8bA3LOM/pXQpulXy4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am ultimately, trying to get my Jabra BT 125 headset to work with
pulseaudio, but given that I am having problems with that, I thought I
would take a step back and see if I could just get basic BT headset
functionality working first.

I am using linux 2.6.30, and bluez 0.41 and this BT dongle:

Bus 002 Device 008: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth

I have the headset paired with my workstation but when I try to play a
file with it I get an error:

$ aplay -D bluetoothraw /mnt/mp3/bad_mouth.wav=20
Playing WAVE '/mnt/mp3/bad_mouth.wav' : Signed 16 bit Little Endian, Rate 4=
4100 Hz, Stereo
aplay: set_params:966: Channels count non available

When I try this, bluetoothd -d reports:

bluetoothd[21210]: Accepted new client connection on unix socket (fd=3D24)
bluetoothd[21210]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[21210]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[21210]: Unix client disconnected (fd=3D24)
bluetoothd[21210]: client_free(0x130f7d0)

In my ~/.asoundrc I have:

pcm.bluetoothraw {
   type bluetooth
   device 00:1A:45:1B:19:89
   #profile "auto" #optional, supported profiles are: auto, hifi and voice
}

Uncommenting that profile doesn't seem to help.

Additionally, when I try to record from the headset:

$ arecord -D bluetooth -f S16_LE | paplay
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_OPEN failed : Invali=
d argument(22)
arecord: set_params:1022: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: 0

and bluetoothd -d says:

bluetoothd[21210]: Accepted new client connection on unix socket (fd=3D24)
bluetoothd[21210]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[21210]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[21210]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[21210]: open sco - object=3DANY source=3DANY destination=3DANY l=
ock=3Dread
bluetoothd[21210]: Unable to open seid 64
bluetoothd[21210]: Audio API: BT_ERROR -> BT_OPEN
bluetoothd[21210]: Unix client disconnected (fd=3D24)
bluetoothd[21210]: client_free(0x130f7d0)

Something is definitely awry, but I'm not really sure where to go from
here in debugging.

Any help would be appreciated.

Thanx,
b.

--=-ixJ8bA3LOM/pXQpulXy4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpN+cMACgkQl3EQlGLyuXDPMgCg/FYF9//VKzmldyF71Xd5QZTG
+LcAn31ML7D0x9+Kst+7eJQK63Qd35S7
=S/UW
-----END PGP SIGNATURE-----

--=-ixJ8bA3LOM/pXQpulXy4--

