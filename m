Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Nelson Murilo <nelson@pangeia.com.br>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050822133252.GG15729@pangeia.com.br>
References: <1124709049.23599.16.camel@pegasus> <Pine.LNX.4.33.0508221321180.6514-100000@redbean.intranet.gw-instruments.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.33.0508221321180.6514-100000@redbean.intranet.gw-instruments.de>
Subject: [Bluez-devel] investiganting why bt-alsa not working
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
Date: Mon, 22 Aug 2005 10:32:52 -0300


Hi,

Still I am investigating because homologated equipment pparently is not=20
works.=20
# hciconfig hci0 revison | HCI
	HCI 17.11
        SCO mapping:  HCI

HS is Plantronics M2500.=20

# modproble snd_bt_sco=20
Aug 22 10:21:00 localhost kernel: snd-bt-sco revision 1.6 $
Aug 22 10:21:00 localhost kernel: snd-bt-sco: snd-bt-scod thread starting

#  btsco -v 00:03:89:AA:AA:AA
btsco v0.4c
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected

# aplay -l=20
**** List of PLAYBACK Hardware Devices ****
card 0: I82801CAICH3 [Intel 82801CA-ICH3], device 0: Intel ICH [Intel 828=
01CA-ICH3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Modem [Intel 82801CA-ICH3 Modem], device 0: Intel ICH - Modem [In=
tel 82801CA-ICH3 Modem - Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: Headset [BT Headset], device 0: Bluetooth SCO PCM [BT SCO PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


If I try run aplay or xmms:
Aug 22 10:21:00 localhost kernel: snd-bt-sco: snd-bt-scod thread starting
Aug 22 10:24:47 localhost kernel: snd-bt-sco: playback_open
Aug 22 10:24:47 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size:=
 8000 count: 800
Aug 22 10:24:47 localhost kernel: snd-bt-sco: playback_trigger 1
Aug 22 10:24:47 localhost kernel: snd-bt-sco: setting playback to bspcm

A have sound for 2 sec and freeze or no sound.=20

I suspect this is ACPI issue (my nb is one sony vaio 2.6.12-mh1 with cvs=20
bluez and bt-alsa), but I don=B4t see how check it.=20

Thanks for ant hints,

./nelson -murilo




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
