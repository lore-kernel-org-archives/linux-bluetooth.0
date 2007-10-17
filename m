Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4716261D.40902@pagema.net>
Date: Wed, 17 Oct 2007 17:11:25 +0200
From: maho+bluez <maho+bluez@pagema.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] problem with alsa/bluetooth device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi, I need help with configuring my headset as alsa device.

Using hints at http://wiki.bluez.org/wiki/HOWTO/AudioDevices, I have
downloaded, compiled  and installed bluez-libs and bluez-utils
(I'm using Debian Sid if it's important):.

I have paired device properly (I think ;) ):
ran such python code:
#v+
import dbus
bus = dbus.SystemBus()
manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')
bus_id = manager.ActivateService('audio')
audio = dbus.Interface(bus.get_object(bus_id, '/org/bluez/audio'),
'org.bluez.audio.Manager')

path = audio.CreateHeadset('00:19:1F:1F:EB:BC')
#audio.ChangeDefaultHeadset(path) #change the device to be used by default
headset = dbus.Interface (bus.get_object(bus_id, path),
'org.bluez.audio.Headset')
#Connect and Play are not required in PCM mode
headset.Connect()
headset.Play()
#v-

Logs at the end of message.


Next, using audacity, I have convertdd /usr/share/sounds/KDE_Startup.wav
to 16 bit 8khz .wav file (/tmp/ee.wav).

Next, I have run:
#v+
maho@tereska:~/tmp$ aplay -v -Dbluetooth /tmp/ee.wav
Playing WAVE '/tmp/ee.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not
available (92)
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4008
  period_size  : 24
  period_time  : 3000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 24
  xfer_align   : 24
  start_threshold  : 4008
  stop_threshold   : 4008
  silence_threshold: 0
  silence_size : 0
  boundary     : 9025213653250473984
aplay: pcm_write:1265: write error: Invalid argument

Of course I have proper ~/.asoundrc:
#v+
maho@tereska:~/tmp$ cat ~/.asoundrc
pcm.bluetooth {
   type bluetooth
   device 00:19:1F:1F:EB:BC
}
#v-

Anyone has idea why I can't play through bluetooth alsa device? My
headset is Motorola H500. Kernel 2.6.22-1 amd64, from Debian Sid
repository.

regards

maHo




logs:

***after python h.py (that one with headset.Connect()/headset.Play())*****

Oct 17 17:01:20 tereska audio[5115]: Bluetooth Audio daemon
Oct 17 17:01:20 tereska audio[5115]: /etc/bluetooth/audio.conf:
/etc/bluetooth/audio.conf: No such file or directory
[^^ repeated 4 x ^^]
Oct 17 17:01:20 tereska audio[5115]: Config options: DisableHFP=true,
SCORouting=HCI, SourceCount=1
Oct 17 17:01:20 tereska audio[5115]: Unix socket created: 5
Oct 17 17:01:20 tereska audio[5115]: add_service_record: got record id
0x10000
Oct 17 17:01:20 tereska audio[5115]: add_service_record: got record id
0x10001
Oct 17 17:01:20 tereska audio[5115]: Registered manager
path:/org/bluez/audio
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.CreateDevice
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.RemoveDevice
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.ListDevices
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.DefaultDevice
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.ChangeDefaultDevice
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.CreateHeadset
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.RemoveHeadset
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.ListHeadsets
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.FindDeviceByAddress
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.DefaultHeadset
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding method
org.bluez.audio.Manager.ChangeDefaultHeadset
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding signal
org.bluez.audio.Manager.DeviceCreated
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding signal
org.bluez.audio.Manager.DeviceRemoved
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding signal
org.bluez.audio.Manager.HeadsetCreated
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding signal
org.bluez.audio.Manager.HeadsetRemoved
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding signal
org.bluez.audio.Manager.DefaultDeviceChanged
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio: adding signal
org.bluez.audio.Manager.DefaultHeadsetChanged
Oct 17 17:01:45 tereska audio[5115]: /org/bluez/audio:
org.bluez.audio.Manager.CreateHeadset()
Oct 17 17:01:45 tereska audio[5115]: Got path /org/bluez/hci0 for
adapter with address 00:1A:7D:00:C7:34
Oct 17 17:01:49 tereska audio[5115]: Audio service discovery completed
with success
Oct 17 17:01:49 tereska audio[5115]: Found Headset record
Oct 17 17:01:49 tereska audio[5115]: Discovered Headset service on
RFCOMM channel 2
Oct 17 17:01:49 tereska audio[5115]: Selecting default device
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Device.GetAddress
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Device.GetName
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Device.GetAdapter
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Device.GetConnectedInterfaces
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.Connect
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.Disconnect
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.IsConnected
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.IndicateCall
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.CancelCall
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.Play
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.Stop
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.IsPlaying
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.GetSpeakerGain
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.GetMicrophoneGain
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.SetSpeakerGain
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
method org.bluez.audio.Headset.SetMicrophoneGain
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.Connected
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.Disconnected
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.AnswerRequested
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.Stopped
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.Playing
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.SpeakerGainChanged
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0: adding
signal org.bluez.audio.Headset.MicrophoneGainChanged
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0:
org.bluez.audio.Headset.Connect()
Oct 17 17:01:49 tereska audio[5115]: State changed
/org/bluez/audio/device0: DISCONNECTED -> CONNECTING
Oct 17 17:01:49 tereska audio[5115]: /org/bluez/audio/device0:
Connecting to 00:19:1F:1F:EB:BC channel 2
Oct 17 17:01:49 tereska hcid[5110]: link_key_request
(sba=00:1A:7D:00:C7:34, dba=00:19:1F:1F:EB:BC)
Oct 17 17:01:49 tereska hcid[5110]: pin_code_request
(sba=00:1A:7D:00:C7:34, dba=00:19:1F:1F:EB:BC)
Oct 17 17:01:57 tereska hcid[5110]: link_key_notify
(sba=00:1A:7D:00:C7:34, dba=00:19:1F:1F:EB:BC)
Oct 17 17:02:01 tereska hcid[5110]: link_key_request
(sba=00:1A:7D:00:C7:34, dba=00:19:1F:1F:EB:BC)
Oct 17 17:02:01 tereska audio[5115]: State changed
/org/bluez/audio/device0: CONNECTING -> CONNECTED
Oct 17 17:02:01 tereska audio[5115]: /org/bluez/audio/device0: Connected
to 00:19:1F:1F:EB:BC
Oct 17 17:02:01 tereska audio[5115]: /org/bluez/audio/device0:
org.bluez.audio.Headset.Play()
Oct 17 17:02:01 tereska audio[5115]: State changed
/org/bluez/audio/device0: CONNECTED -> STREAM_STARTING
Oct 17 17:02:03 tereska audio[5115]: SCO socket opened for headset
/org/bluez/audio/device0
Oct 17 17:02:03 tereska audio[5115]: SCO fd=9
Oct 17 17:02:03 tereska audio[5115]: State changed
/org/bluez/audio/device0: STREAM_STARTING -> STREAMING

****AFTER aplay -v -Dbluetooth /tmp/ee.wav ************

Oct 17 17:04:35 tereska audio[5115]: Accepted new client connection on
unix socket (fd=10)
Oct 17 17:04:35 tereska audio[5115]: Package PKT_TYPE_CFG_REQ:0
Oct 17 17:04:35 tereska audio[5115]: fd=9, fd_opt=1, pkt_len=48,
sample_size=2, rate=8000
Oct 17 17:04:35 tereska audio[5115]: 30 bytes sent
Oct 17 17:04:35 tereska audio[5115]: 1 bytes sent
Oct 17 17:04:35 tereska audio[5115]: Unix client disconnected (fd=10)
Oct 17 17:04:35 tereska audio[5115]: State changed
/org/bluez/audio/device0: STREAMING -> DISCONNECTED



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
