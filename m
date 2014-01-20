Return-Path: <cyrus@holtmann.org>
Message-ID: <649bfd2b8da26f5cf4b19f59d40d26fc.squirrel@mungewell.org>
In-Reply-To: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
References: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
Date: Mon, 20 Jan 2014 12:31:14 -0500
Subject: Re: [PATCH 1/5] lib: Add flag to double L2CAP IMTU size used for SDP
 connection
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Szymon Janc" <szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140120123114_93055"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_20140120123114_93055
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> This will allow to workaround Dualshock4 not respecting L2CAP MTU
> size while sending SDP response.

Maybe a little late (I see that there's a V2 of this patch series), but I
can confirm that I was able to get my 'crappy' laptop to connect to the
DS4 and stream the basic joystick data.

The connection was sensitive to technique, ie. it wouldn't 'pair then
connect' or allow pairing initiated by DS4.
--
[liveuser@localhost ~]$ bluetoothctl
[NEW] Controller 00:0F:B3:99:6B:CC localhost [default]
[bluetooth]# power on
[CHG] Controller 00:0F:B3:99:6B:CC Class: 0x00010c
Changing power on succeeded
[CHG] Controller 00:0F:B3:99:6B:CC Powered: yes
[bluetooth]# agent on
Agent registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# scan on
Discovery started
[CHG] Controller 00:0F:B3:99:6B:CC Discovering: yes
[NEW] Device 1C:66:6D:07:C3:E0 1C-66-6D-07-C3-E0
[CHG] Device 1C:66:6D:07:C3:E0 LegacyPairing: no
[CHG] Device 1C:66:6D:07:C3:E0 Name: Wireless Controller
[CHG] Device 1C:66:6D:07:C3:E0 Alias: Wireless Controller
[CHG] Device 1C:66:6D:07:C3:E0 LegacyPairing: yes <--------- wait for this!!
[bluetooth]# connect 1C:66:6D:07:C3:E0
Attempting to connect to 1C:66:6D:07:C3:E0
[CHG] Device 1C:66:6D:07:C3:E0 Connected: yes
[CHG] Device 1C:66:6D:07:C3:E0 Modalias: usb:v054Cp05C4d0100
[CHG] Device 1C:66:6D:07:C3:E0 Modalias: usb:v054Cp05C4d0100
[CHG] Device 1C:66:6D:07:C3:E0 UUIDs has unsupported type
Request PIN code
[agent] Enter PIN code: 0000
[CHG] Device 1C:66:6D:07:C3:E0 Paired: yes
Connection successful
[bluetooth]#
--

I also noticed a weird log at one point, although only saw this once and
don't know what triggered it.
--
[bluetooth]#
[CHG] Device 1C:66:6D:07:C3:E0 Class: 0x200404
[CHG] Device 1C:66:6D:07:C3:E0 Icon: audio-card <--------!!
[CHG] Device 1C:66:6D:07:C3:E0 Class: 0x002508
[CHG] Device 1C:66:6D:07:C3:E0 Icon: input-gaming
--

I will try with the V2 patch series.
Simon

------=_20140120123114_93055
Content-Type: text/plain; name="crappy_hciconfig.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="crappy_hciconfig.txt"

root@atom:/home/simon# hciconfig -a
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:0F:B3:99:6B:CC  ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN 
	RX bytes:672 acl:0 sco:0 events:22 errors:0
	TX bytes:337 acl:0 sco:0 commands:21 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: 
	Link mode: SLAVE ACCEPT 
	Name: 'atom-0'
	Class: 0x520100
	Service Classes: Networking, Object Transfer, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 1.1 (0x1)  Revision: 0x222
	LMP Version: 1.1 (0x1)  Subversion: 0x222
	Manufacturer: Cambridge Silicon Radio (10)

------=_20140120123114_93055--


