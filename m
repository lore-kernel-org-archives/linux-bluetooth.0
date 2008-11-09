Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Nov 2008 23:19:36 -0800 (PST)
From: Damon Hastings <damonhastings@yahoo.com>
Subject: Possible to send audio to multiple bluetooth headsets at once?
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <393285.15460.qm@web81808.mail.mud.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

Is it possible to stream audio to multiple bluetooth headsets on the same dongle, simultaneously?  Details of my setup and failed attempts are below if anyone wishes to help -- but honestly, even a one-line response "yes it's possible" would at least tell me I'm not wasting my time!  What I've read elsewhere suggests that what I'm trying to do may not even be possible in Linux.  (In case you're curious, I'll have too many headsets to have a separate dongle for each -- probably dozens of headsets, assuming the Bluetooth band can handle that many, which I'm also unsure about and pretty nervous about too.  Each stream will be 90% silent, with only occasional bursts of speech, but, still.  Oh well, I guess I'll find whether it works *after* I invest tons of coding time into this.)  I don't need to receive any audio from the headsets.

About my setup and my failed attempts:

I'm running Fedora 9 and have tried its built-in bluez (version 3.35) as well as bluez-4.17, and I'm using alsa.  I'm using the Motorola H680 and Jabra BT2040 headsets with an Aluratek ABD2020 dongle.  I can pair both headsets at once, and I can stream audio to one of them at a time just fine.  But if I try streaming to both at once, I get this error from aplay on the second one:

  damon@localhost [/home/damon]> aplay -D bluetooth_mot_h680 bmtl.wav  
  Playing WAVE '/home/damon/bmtl.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
  ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)
  aplay: set_params:1015: Unable to install hw params:
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
  TICK_TIME: [0 0]

I also get this in /var/log/messages (with bluez 3.35):

  Nov  7 21:08:14 scanners hcid[4512]: Audio API: received BT_GETCAPABILITIES_REQ
  Nov  7 21:08:14 scanners hcid[4512]: Audio API: sending BT_GETCAPABILITIES_RSP
  Nov  7 21:08:14 scanners hcid[4512]: Audio API: received BT_SETCONFIGURATION_REQ
  Nov  7 21:08:14 scanners hcid[4512]: config sco - device = 00:1A:0E:82:35:D5 access_mode = 2
  Nov  7 21:08:14 scanners hcid[4512]: connect: Operation not permitted (1)
  Nov  7 21:08:14 scanners kernel: hcid[4512]: segfault at 10 ip 003e818f sp bfcb08d0 error 6 in audio.so[3de000+21000]

And for bluez-4.17 I got all fancy and ran bluetoothd (which I take it replaces hcid) manually as root in debug mode.  I got the same error from aplay, and bluetoothd gave me this (note it doesn't segault like hcid did):

  bluetoothd[2925]: Accepted new client connection on unix socket (fd=27)
  bluetoothd[2925]: Audio API: received BT_GETCAPABILITIES_REQ
  bluetoothd[2925]: Audio API: sending BT_GETCAPABILITIES_RSP
  bluetoothd[2925]: Audio API: received BT_SETCONFIGURATION_REQ
  bluetoothd[2925]: config sco - device = 00:1A:0E:B8:B3:7F access_mode = 2
  bluetoothd[2925]: connect: Operation not permitted (1)
  bluetoothd[2925]: config failed
  bluetoothd[2925]: Audio API: sending BT_SETCONFIGURATION_RSP
  bluetoothd[2925]: Unix client disconnected (fd=27)

Same result if I don't run as root.  The original headset kept playing just fine, but the second headset remained quiet.  Reversing order of playing makes no difference.  Pairing second while first is already playing makes no difference.

And here's a bunch of info that may or may not be relevant:

My .asoundrc:

  pcm.bluetooth_jab_bt2040 {
      type bluetooth
      device 00:1A:45:31:47:69
      profile "auto"
  }
  pcm.bluetooth_mot_h680 {
      type bluetooth
      device 00:1A:0E:B8:B3:7F
      profile "auto"
  }

My /etc/bluetooth/main.conf (unchanged from defaults):

  [General]
  Name = %h-%d
  Class = 0x000100
  DiscoverableTimeout = 0
  PageTimeout = 8192
  OffMode = NoScan
  DiscoverSchedulerInterval = 0

Hardware info:

  root@localhost [/root]> hciconfig hci0 features
  hci0:	Type: USB
  	BD Address: 00:15:83:02:4F:E7 ACL MTU: 310:10 SCO MTU: 64:8
  	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
  		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
  		<timing accuracy> <role switch> <hold mode> <sniff mode> 
  		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
  		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
  		<power control> <transparent SCO> <broadcast encrypt> 
  		<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
  		<interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
  		<extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
  		<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
  		<AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
  		<EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features> 

  root@localhost [/root]> hcitool info 00:1A:45:31:47:69 
  Requesting information ...
  	BD Address:  00:1A:45:31:47:69
  	OUI Company: GN Netcom as (00-1A-45)
  	Device Name: Jabra BT2040
  	LMP Version: 2.0 (0x3) LMP Subversion: 0xbf9
  	Manufacturer: Cambridge Silicon Radio (10)
  	Features: 0xbc 0xfe 0x0f 0x86 0x8b 0xe9 0x00 0x00
  		<encryption> <slot offset> <timing accuracy> <role switch> 
  		<sniff mode> <RSSI> <channel quality> <SCO link> <HV2 packets> 
  		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
  		<power control> <transparent SCO> <EDR ACL 2 Mbps> 
  		<EDR ACL 3 Mbps> <extended SCO> <EV4 packets> <EV5 packets> 
  		<AFH cap. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
  		<AFH cap. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps> 
  		<3-slot EDR eSCO> 

  root@localhost [/root]> hcitool info 00:1A:0E:B8:B3:7F 
  Requesting information ...
  	BD Address:  00:1A:0E:B8:B3:7F
  	OUI Company: Cheng Uei Precision Industry Co.,Ltd (00-1A-0E)
  	Device Name: Motorola H680
  	LMP Version: 2.0 (0x3) LMP Subversion: 0x109d
  	Manufacturer: Cambridge Silicon Radio (10)
  	Features: 0xfc 0xfc 0x0b 0x80 0x0b 0x88 0x00 0x00
  		<encryption> <slot offset> <timing accuracy> <role switch> 
  		<hold mode> <sniff mode> <channel quality> <SCO link> 
  		<HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD> 
  		<paging scheme> <transparent SCO> <extended SCO> <EV4 packets> 
  		<EV5 packets> <AFH cap. slave> <AFH cap. master> 
  		<3-slot EDR eSCO> 

Thanks for any help -- I'm at wits' end!  :-P

Damon Hastings


      
