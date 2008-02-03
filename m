Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 Feb 2008 22:45:29 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1201948807.11895.10.camel@littletux>
Message-ID: <alpine.LNX.1.00.0802022032290.23675@nge2.ngu.pk>
References: <47A274DB.9020808@gmx.de> <47A438C6.90700@gmx.de>
	<1201948807.11895.10.camel@littletux>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1287635953-1120767825-1202010331=:23675"
Subject: Re: [Bluez-users] BT Headset connected but no sound
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1287635953-1120767825-1202010331=:23675
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 8BIT


On Sat, 2 Feb 2008, Guillaume Bedot wrote:

-> > > can connect to my BT Headset but if I try to play a sound, it does only
-> > > beep at the start and at the end of the connection but there is no sound.

Same here.

-> > > mplayer -ao alsa:device=bluetooth test.wav
-> > > - beep -
-> > > (pressing 'q')
-> > > - beep -
-> > > 
-> > > I am running Gentoo with linux 2.6.23 (x86)
-> > > bluez-libs-3.24
-> > > blues-utils-3.24
-> > > 
-> There is a bug in bluez-utils 3.24 that prevents headset/SCO connections
-> to work.
-> Try with current bluez cvs or with the attached patch.
-> 
-> > But the errors don't change...
-> > What do I have to do to get my key-agent working?
-> > 
-> You can check your configuration in /etc/bluetooth/hcid.conf too.

Patch applied, but it doesn't seem to be making a difference. As several 
people have suggested, the passkey-agent does not appear to work correctly.

Started as: passkey-agent --default 0000 00:1A:45:01:F9:42 &


Ex:

Feb  2 20:09:20 vdrl kernel: usb 3-2: new full speed USB device using uhci_hcd and address 2
Feb  2 20:09:21 vdrl kernel: usb 3-2: Product: BELKIN BLUETOOTH USB ADAPTER CL. 1
Feb  2 20:09:21 vdrl kernel: usb 3-2: Manufacturer: Broadcom Corp
Feb  2 20:09:21 vdrl kernel: usb 3-2: configuration #1 chosen from 1 choice
Feb  2 20:09:21 vdrl kernel: Bluetooth: Core ver 2.11
Feb  2 20:09:21 vdrl kernel: NET: Registered protocol family 31
Feb  2 20:09:21 vdrl kernel: Bluetooth: HCI device and connection manager initialized
Feb  2 20:09:21 vdrl kernel: Bluetooth: HCI socket layer initialized
Feb  2 20:09:21 vdrl kernel: Bluetooth: HCI USB driver ver 2.9
Feb  2 20:09:21 vdrl kernel: usbcore: registered new interface driver hci_usb
Feb  2 20:09:22 vdrl sdpd[31664]: Bluetooth SDP daemon
Feb  2 20:09:22 vdrl sdpd[31664]: Starting SDP server
Feb  2 20:09:22 vdrl kernel: Bluetooth: L2CAP ver 2.8
Feb  2 20:09:22 vdrl kernel: Bluetooth: L2CAP socket layer initialized
Feb  2 20:09:23 vdrl hcid[31671]: Bluetooth HCI daemon
Feb  2 20:09:23 vdrl hcid[31671]: HCI dev 0 registered
Feb  2 20:09:23 vdrl hcid[31671]: Created local server at unix:abstract=/var/run/dbus-A2kUxUntXr,guid=1e5c5a75a89eef29f9a7210047a51443
Feb  2 20:09:23 vdrl echo[31673]: Bluetooth echo service ver 3.24
Feb  2 20:09:23 vdrl network[31674]: Bluetooth Network daemon
Feb  2 20:09:23 vdrl serial[31677]: Bluetooth Serial Port daemon
Feb  2 20:09:23 vdrl input[31680]: Bluetooth Input daemon
Feb  2 20:09:23 vdrl input[31680]: Registered input manager path:/org/bluez/input
Feb  2 20:09:23 vdrl audio[31681]: Bluetooth Audio daemon
Feb  2 20:09:23 vdrl audio[31681]: Unix socket created: 5
Feb  2 20:09:23 vdrl hcid[31671]: HCI dev 0 up
Feb  2 20:09:23 vdrl hcid[31671]: Device hci0 has been added
Feb  2 20:09:23 vdrl hcid[31671]: Starting security manager 0
Feb  2 20:09:23 vdrl kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Feb  2 20:09:23 vdrl kernel: Bluetooth: BNEP filters: protocol multicast
Feb  2 20:09:24 vdrl hcid[31671]: Device hci0 has been activated
Feb  2 20:09:24 vdrl transfer[31686]: Bluetooth transfer service ver 3.24
Feb  2 20:09:24 vdrl kernel: Bluetooth: RFCOMM socket layer initialized
Feb  2 20:09:24 vdrl kernel: Bluetooth: RFCOMM TTY layer initialized
Feb  2 20:09:24 vdrl kernel: Bluetooth: RFCOMM ver 1.8
Feb  2 20:09:24 vdrl serial[31677]: Registered manager path:/org/bluez/serial
Feb  2 20:09:24 vdrl audio[31681]: Registered manager path:/org/bluez/audio
Feb  2 20:09:24 vdrl kernel: Bridge firewalling registered
Feb  2 20:09:24 vdrl kernel: pan0: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
Feb  2 20:09:24 vdrl network[31674]: Registered manager path:/org/bluez/network
Feb  2 20:09:24 vdrl network[31674]: Registered server path:/org/bluez/network/panu
Feb  2 20:09:24 vdrl network[31674]: Registered server path:/org/bluez/network/gn
Feb  2 20:09:24 vdrl network[31674]: Registered server path:/org/bluez/network/nap

Notice here it claims that a passkey-agent is registered. The pin is simply 
'0000', I know this from pairing phone <-> headset. It even logs "Default 
passkey agent (:1.7, /org/bluez/passkey_agent_31704) registered".


Feb  2 20:10:29 vdrl hcid[31671]: Default passkey agent (:1.7, /org/bluez/passkey_agent_31704) registered
Feb  2 20:10:48 vdrl hcid[31671]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)

OK, here we go, connect...pin please...

Feb  2 20:10:48 vdrl hcid[31671]: pin_code_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:10:48 vdrl hcid[31671]: link_key_notify (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:10:50 vdrl hcid[31671]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:10:51 vdrl audio[31681]: Access denied: Authorization agent does not exist

Huh? "agent does not exist". That seems exact opposite of what is claimed 
above.

Feb  2 20:10:51 vdrl hcid[31671]: link_key_notify (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:11:05 vdrl kernel: Bluetooth: SCO (Voice Link) ver 0.5
Feb  2 20:11:05 vdrl kernel: Bluetooth: SCO socket layer initialized
Feb  2 20:11:45 vdrl smartd[1340]: Device: /dev/hda, SMART Usage Attribute: 194 Temperature_Celsius changed from 119 to 120 
Feb  2 20:12:26 vdrl audio[31681]: Audio API: received BT_GETCAPABILITIES_REQ
Feb  2 20:12:26 vdrl audio[31681]: Audio API: sending BT_GETCAPABILITIES_RSP
Feb  2 20:12:26 vdrl audio[31681]: Audio API: received BT_SETCONFIGURATION_REQ

After this the results are the same: connect...


Feb  2 20:12:28 vdrl hcid[31671]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:12:29 vdrl audio[31681]: connect(): Connection refused (111)
Feb  2 20:12:29 vdrl audio[31681]: config failed

Denied.

Feb  2 20:12:29 vdrl audio[31681]: Audio API: sending BT_SETCONFIGURATION_RSP
Feb  2 20:12:32 vdrl audio[31681]: Error handling command AT+BTRH?: Invalid argument (22)
Feb  2 20:12:32 vdrl audio[31681]: Audio API: received BT_GETCAPABILITIES_REQ
Feb  2 20:12:32 vdrl audio[31681]: Audio API: sending BT_GETCAPABILITIES_RSP
Feb  2 20:12:32 vdrl audio[31681]: Audio API: received BT_SETCONFIGURATION_REQ
Feb  2 20:12:33 vdrl audio[31681]: SCO fd=12
Feb  2 20:12:33 vdrl audio[31681]: Audio API: sending BT_SETCONFIGURATION_RSP
Feb  2 20:12:33 vdrl audio[31681]: Audio API: received BT_STREAMSTART_REQ
Feb  2 20:12:33 vdrl audio[31681]: Audio API: sending BT_STREAMSTART_RSP
Feb  2 20:12:33 vdrl audio[31681]: Audio API: sending BT_STREAMFD_IND
Feb  2 20:13:19 vdrl audio[31681]: Audio API: received BT_GETCAPABILITIES_REQ
Feb  2 20:13:19 vdrl audio[31681]: Audio API: sending BT_GETCAPABILITIES_RSP
Feb  2 20:13:19 vdrl audio[31681]: Audio API: received BT_SETCONFIGURATION_REQ
Feb  2 20:13:19 vdrl hcid[31671]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:13:21 vdrl audio[31681]: connect(): Connection refused (111)
Feb  2 20:13:21 vdrl audio[31681]: config failed

Again.

Feb  2 20:13:21 vdrl audio[31681]: Audio API: sending BT_SETCONFIGURATION_RSP
Feb  2 20:13:24 vdrl audio[31681]: Error handling command AT+BTRH?: Invalid argument (22)
Feb  2 20:13:25 vdrl audio[31681]: Audio API: received BT_GETCAPABILITIES_REQ
Feb  2 20:13:25 vdrl audio[31681]: Audio API: sending BT_GETCAPABILITIES_RSP
Feb  2 20:13:25 vdrl audio[31681]: Audio API: received BT_SETCONFIGURATION_REQ
Feb  2 20:13:25 vdrl audio[31681]: SCO fd=12
Feb  2 20:13:25 vdrl audio[31681]: Audio API: sending BT_SETCONFIGURATION_RSP
Feb  2 20:13:25 vdrl audio[31681]: Audio API: received BT_STREAMSTART_REQ
Feb  2 20:13:25 vdrl audio[31681]: Audio API: sending BT_STREAMSTART_RSP
Feb  2 20:13:25 vdrl audio[31681]: Audio API: sending BT_STREAMFD_IND
Feb  2 20:13:58 vdrl audio[31681]: Audio API: received BT_GETCAPABILITIES_REQ
Feb  2 20:13:58 vdrl audio[31681]: Audio API: sending BT_GETCAPABILITIES_RSP
Feb  2 20:13:58 vdrl audio[31681]: Audio API: received BT_SETCONFIGURATION_REQ
Feb  2 20:14:00 vdrl audio[31681]: connect(): Connection refused (111)
Feb  2 20:14:00 vdrl audio[31681]: config failed

And again...

Feb  2 20:14:51 vdrl hcid[31671]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
Feb  2 20:14:53 vdrl audio[31681]: connect(): Connection refused (111)
Feb  2 20:14:53 vdrl audio[31681]: config failed

>>From the command line it looks like the below. I'm guessing this the reason 
for the failure. It alternates between what is below, making a tiny channel 
clearing noise in headset, and hanging aplay to which Ctrl-C needs to be hit.


aplay  -Dbluetooth alert.wav

Playing WAVE 'alert.wav' : Signed 16 bit Little
Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:458:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION
failed : Input/output error(5)
aplay: set_params:962: Unable to install hw params:
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

(aplay alert.wav does play using normal speakers)

hcitool con
Connections:
 	< ACL 00:1A:45:01:F9:42 handle 12 state 1 lm MASTER

If press the headset button, it then reads:

hcitool con
Connections:
 	> ACL 00:1A:45:01:F9:42 handle 11 state 1 lm MASTER AUTH ENCRYPT SECURE



Connecting from the computer to the headset doesn't work as the headset 
immediately disconnects the connection before I can type hcitool cc <addr>; 
hcitool auth <addr> etc. Prehaps this is standard headset behavior, because on 
power-up the headset automatically attempts to pair with the computer, then 
meets passkey-agent. The devices are a Belkin (Broadcom) USB adapter and a 
Jabra BT135; configs are similar to everyone else's that's posted on this 
issue. Has anyone got a Jabra BT135 actually playing sound? Is this doable?
I think passkey-agent is alot of the issue, but possibly my hardware is junk
  ;)





---1287635953-1120767825-1202010331=:23675
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---1287635953-1120767825-1202010331=:23675
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

---1287635953-1120767825-1202010331=:23675--
