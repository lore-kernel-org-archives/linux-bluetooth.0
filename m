Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AA81F0.8080005@bielefeld.ccc.de>
From: Nick <Nick@bielefeld.ccc.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] hello
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
Date: Mon, 29 Nov 2004 02:57:04 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I´m new to the list, my names nick and I´m from Bielefeld, Germany.

I´m still experimenting with my usb-dongle from acer

lsusb: Bus 003 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle

and try to get it work with my logitech bluetooth headset via btsco
and the snd-bt-sco module.

Versions:

kernel: 2.6.9-gentoo-r6
bluez-framework: gentoo-unstable
btsco: btsco-cvs 28.11

everything works fine, bluetooth started alsasound started /dev/dsp1
is there, i can connect to my headset via btsco and it gives me
something likes this:

Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=12
Sending up speaker change 12
recieved AT+VGS=13
Sending up speaker change 13

so, i can change the volume with the buttons on the headset, also i
hear some "noise" after connecting to the SCO channel with the
,multifunktional button on the headset.

my problem is:

i can´t get sound over the device. something dirty like:

cat foobar.file > /dev/dsp1

does nothing, until i cancel it with ctrl+c, also xmms (when
configured for hw:1 alsa with BT) just waits and does nothing.

my normal soundcard is a:

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97
Audio (rev 03) snd-i8x0

any suggestions?

~ ,nick

PS: obex file transfer and push to my t68i works, so the sdp-server is
running.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBqoEX40bmwXROfRURAuVXAJ0cZxrqMyfSSICtNrdHOtUfVM0PbQCeL3s5
WpaVoCy8SquEFdrzzJo15po=
=qxSd
-----END PGP SIGNATURE-----



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
