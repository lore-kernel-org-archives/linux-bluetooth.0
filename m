Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tobias Lang <tobias-lang@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-Id: <20050515145042.70745815.tobias-lang@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__15_May_2005_14_50_42_+0200_/ppkpYR1g6UBO4H/"
Subject: [Bluez-users] Hama BT1000 Headset Problems
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
Date: Sun, 15 May 2005 14:50:42 +0200

--Signature=_Sun__15_May_2005_14_50_42_+0200_/ppkpYR1g6UBO4H/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a problem using Bluetooth with a Hama BT1000 Headset.
I installed th elatest Bluez Version (2.17) and the snd-bt-sco driver
via cvs. I followed the instructions on how to install the bt-sco module
and userland program and everything worked fine.
I already searched the archives, but found nothing helpful.

The first problem I encountered was, that I am not able to pair the HS
with my computer. I put the HS in pairing mode and run the command:

	btsco <headset> -v

Then I get the following:

	btsco v0.4b
	Device is 1:0
	Error: Failed to connect to SDP server: Invalid exchange
	Assuming channel 2

	Voice setting: 0x0060
	Can't connect RFCOMM channel: Invalid exchange

However, when I ignore the fact, that I haven't paired yet I can still conn=
ect the HS
just as I would have done and I am able to start xmms playback. However, I =
don't
hear a sound on the HS and xmms freezes after the 1 second of playback. Alt=
hough
the Status LED on the HS indicates data transfer and I can change the volum=
e. This
is what the userland program says:

	:~$ btsco 00:0B:2E:06:15:74 -v
	btsco v0.4b
	Device is 1:0
	Voice setting: 0x0060
	RFCOMM channel 6 connected
	speaker volume: 15 mic volume: 15
	i/o needed: connecting sco...
	connected SCO channel
	Done setting sco fd
	recieved AT+VGS=3D15
	Sending up speaker change 15
	recieved AT+VGS=3D14
	Sending up speaker change 14
	recieved AT+VGS=3D14
	speaker volume: 15 mic volume: 15
	driver is not in use
	disconnected SCO channel
	speaker volume: 15 mic volume: 15
	i/o needed: connecting sco...
	Can't connect SCO audio channel
	: Connection timed out
	speaker volume: 15 mic volume: 15
	RFCOMM channel lost

Don't really now, what is happening. But it somehow seems, that the audio-d=
ata never reaches the headset
(but that is simply a guess from someone not knowing whats going on).A yes,=
 I get the same, when I am
doing an 'aplay' like mentioned in the README.

Here are some additional infos:

/var/log/messages:
	May 15 14:19:07 localhost kernel: snd-bt-sco: playback_open
	May 15 14:19:07 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size: =
8000 count: 800
	May 15 14:19:07 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size: =
8000 count: 800
	May 15 14:19:07 localhost kernel: snd-bt-sco: playback_trigger 1
	May 15 14:19:07 localhost kernel: snd-bt-sco: setting playback to bspcm
	May 15 14:19:44 localhost kernel: snd-bt-sco: playback_trigger 0
	May 15 14:19:44 localhost kernel: snd-bt-sco: setting playback to NULL
	May 15 14:19:44 localhost kernel: snd-bt-sco: Disposing of previous socket=
 count 2
	May 15 14:19:44 localhost kernel: snd-bt-sco: playback_open
	May 15 14:19:44 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size: =
8000 count: 800
	May 15 14:19:44 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size: =
8000 count: 800
	May 15 14:19:44 localhost kernel: snd-bt-sco: playback_trigger 1
	May 15 14:19:44 localhost kernel: snd-bt-sco: setting playback to bspcm
	May 15 14:19:51 localhost kernel: snd-bt-sco: playback_trigger 0
	May 15 14:19:51 localhost kernel: snd-bt-sco: setting playback to NULL

>: hciconfig -a
	hci0:   Type: USB
	        BD Address: 00:0B:0D:04:BB:98 ACL MTU: 120:20 SCO MTU: 64:0
	        UP RUNNING PSCAN ISCAN
	        RX bytes:187 acl:0 sco:0 events:22 errors:0
	        TX bytes:353 acl:0 sco:0 commands:18 errors:0
	        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
	        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	        Link policy: RSWITCH HOLD SNIFF PARK
 	       Link mode: SLAVE ACCEPT
 	       Name: 'melchior-0'
 	       Class: 0x000100
 	       Service Classes: Unspecified
	       Device Class: Computer, Uncategorized
  	       HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x=
757
   	       Manufacturer: Silicon Wave (11)

>: hciconfig hci0 revision
	hci0:   Type: USB
 	       BD Address: 00:0B:0D:04:BB:98 ACL MTU: 120:20 SCO MTU: 64:0
  	      Unsupported manufacturer

>: hcitool info 00:0B:2E:06:15:74
	Requesting information ...
	Can't create connection: Input/output error

One last thing. The USB Bluetooth Dongle(Class II) is working. I can share =
data with my
mobile phone just fine.

Thanks for your help, Tobias Lang

--Signature=_Sun__15_May_2005_14_50_42_+0200_/ppkpYR1g6UBO4H/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCh0WnjxmcDuHlx5oRAtwDAKDQhBUv6+AdyD9WYiJZvFtV/8R23QCfVTB0
8tPeQmrzyg3SNYbk3QECoH4=
=esrZ
-----END PGP SIGNATURE-----

--Signature=_Sun__15_May_2005_14_50_42_+0200_/ppkpYR1g6UBO4H/--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
