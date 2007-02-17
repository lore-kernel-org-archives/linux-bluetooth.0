Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45D7173C.6090108@yahoo.com.au>
Date: Sat, 17 Feb 2007 15:54:52 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] bluetooth-alsa: ALSA doesn't recognise a2dpd?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I'm trying to connect a Plantronics 590A headset to my Debian machine
with a D-Link DBT-120 (B2) USB dongle.  But bluetooth-alsa isn't working
for me.  I followed the instructions here:

http://bluetooth-alsa.sourceforge.net/build.html

I can get as far as pairing the headset with the computer and running
a2dpd.  But in XMMS I don't get an "a2dpd" option for ALSA output.  Can
anyone tell me what I'm doing wrong, or what I should do next to debug it?

I have set up my ~/.asoundrc as instructed:

pcm.a2dpd {
      type a2dpd
}

But no ALSA device seems to be available.  aplay only sees my M-Audio
Delta 44:

mexon@aeon:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: M44 [M Audio Delta 44], device 0: ICE1712 multi [ICE1712 multi]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

Here's the output of a2dpd.  There's an error in the second line, but I
ran an strace and it looks like the file not found is "/tmp/a2dp.pid",
so that should be OK:

A2DPD[748.729]: make_daemon_process: a2dpd [Feb 16 2007 19:10:35]
starting ...
A2DPD[748.730]: main: (errno=2:No such file or directory)a2dpd
addr=XX:XX:XX:XX:XX:XX timer=4000 us [Feb 16 2007 19:10:49]
A2DPD[748.731]: a2dpd_signal_init: Getting on DBUS
A2DPD[748.734]: a2dpd_signal_init: Installing watch
A2DPD[748.734]: add_dbus_watch: Added watch 0 0x809a570 disabled
A2DPD[748.734]: add_dbus_watch: Added watch 1 0x809a598 enabled
A2DPD[748.734]: a2dpd_signal_init: Registering object path:
/com/access/a2dpd
A2DPD[748.734]: a2dpd_signal_init: Acquiring service: com.access.a2dpd
A2DPD[748.736]: a2dpd_signal_init: OK
A2DPD[748.736]: a2dpd_signal_init: OK
A2DPD[748.736]: add_avrtg:
A2DPD[748.737]: add_a2source:
A2DPD[748.737]: main_loop:
A2DPD[748.737]: make_server_socket:
A2DPD[748.737]: bta2dpdevicenew:
A2DPD[748.738]: a2dpd_signal_set_socket: Signal socket set to 8
A2DPD[748.739]: a2dpd_signal_state: Disconnected
A2DPD[748.739]: a2dp_alloc:
A2DPD[748.740]: a2dp_alloc: (a2dp = 0x809f858)
A2DPD[748.759]: a2dp_new: XX:XX:XX:XX:XX:XX, 44100
A2DPD[748.759]: a2dp_new: State AVDTP_STATE_DISCONNECTED
A2DPD[748.759]: alsa_new:
A2DPD[748.759]: alsa_new: Frame rate is 44100
A2DPD[748.763]: alsa_new: snd_pcm_open()==1
A2DPD[748.763]: alsa_new: snd_pcm_hw_params_malloc()==1
A2DPD[748.763]: alsa_new: snd_pcm_hw_params_any()==1
A2DPD[748.764]: alsa_new: snd_pcm_hw_params_set_access()==1
A2DPD[748.812]: alsa_new: snd_pcm_hw_params_set_format()==1
A2DPD[748.812]: alsa_new: snd_pcm_hw_params_set_rate()==1
A2DPD[748.812]: alsa_new: snd_pcm_hw_params_set_channels()==1
A2DPD[748.813]: alsa_new: snd_pcm_hw_params()==1
A2DPD[748.813]: alsa_new: snd_pcm_prepare()==1
A2DPD[748.813]: alsa_new: params freed
A2DPD[748.813]: alsa_new: returning 0x809a6f8
A2DPD[748.813]: sco_new:
A2DPD[748.813]: sco_new: State SCO_STATE_DISCONNECTED
A2DPD[748.813]: sco_state_disconnect: Filtering state : already disconnected
A2DPD[748.814]: main_loop: Bluetooth Device Settings [44100 hz, 2
channels, 16 bits]
A2DPD[748.816]: avrcp_new: Listening for AVRCP on socket 12
A2DPD[748.817]: avrcp_new: 0x80a99f0

Here are my answers to the questions on the contact page.  The only
thing I haven't done is try SCO, because I don't want to patch my
kernel.  If there's no other way to debug this, I'll probably just give up.

http://bluetooth-alsa.sourceforge.net/contact.html

* I'm already using plugz
* I'm not trying to use SCO. So this doesn't apply to me. Right?
* I do have bluez-passkey-gnome installed (version 0.5-2, Debian Etch).
* I don't think I'm using an old bluez version (libbluetooth2 is version
3.7-1, so is bluez-utils).
* I did pair it with another device, then I tried the re-pairing
procedure.  I can only make it pair if I run hcitool info, which is
interesting.  I also have to delete the headset from my linkkeys file
for this to work.  But now that I've figured out this procedure, I have
no problem pairing.
* Eliminating the hub made no difference.
* Headset is Plantronics 590A:
http://plantronics.com/north_america/en_US/products/cat1150057/cat1150057/prod29780013
* Here's the output:
      aeon:~# hciconfig -a
      hci0:   Type: USB
              BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
              UP RUNNING PSCAN
              RX bytes:395 acl:0 sco:0 events:17 errors:0
              TX bytes:313 acl:0 sco:0 commands:16 errors:0
              Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
              Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
              Link policy: RSWITCH HOLD SNIFF PARK
              Link mode: SLAVE ACCEPT
              Name: 'Aeon'
              Class: 0x3e0100
              Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
              Device Class: Computer, Uncategorized
              HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP
Subver: 0x1bb
              Manufacturer: Cambridge Silicon Radio (10)
* Here's the output:
      aeon:~# hciconfig hci0 revision
      hci0:   Type: USB
              BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 192:8 SCO MTU: 64:8
              HCI 15.3
              Chip version: BlueCore02-External
              Max key size: 56 bit
              SCO mapping:  HCI
* This information only turns up once I've successfully paired the
device, and that only happens if I start hcitool scan before doing the
pairing:
      aeon:~# hcitool info XX:XX:XX:XX:XX:XX
      Requesting information ...
              BD Address:  XX:XX:XX:XX:XX:XX
              Device Name: 590Plantronics
              LMP Version: 2.0 (0x3) LMP Subversion: 0x9a2
              Manufacturer: Cambridge Silicon Radio (10)
              Features: 0xbf 0xec 0x01 0x00 0x18 0x18 0x00 0x00
                      <3-slot packets> <5-slot packets>
* I'm not running btsco or a2play, so I guess this isn't appropriate
* Debian Etch, bluez 3.7.
      aeon:~# uname -a
      Linux aeon 2.6.18-3-k7 #1 SMP Mon Dec 4 17:23:11 UTC 2006 i686
GNU/Linux
* I don't want to try SCO, because I don't want to patch my kernel
* I don't have any other adapter or headset.
* I don't have "choppiness", I don't have anything at all. So this isn't
relevant, right?
* I don't get this error.






-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
