Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30803272254l768ba62bjdc4318b3c0c0ea1@mail.gmail.com>
Date: Fri, 28 Mar 2008 13:54:36 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] How to test sco over pcm in bluez?
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

Hi All:
      I have bluez3.28 and kernel2.6.18 with eSCO patch and bluez
2.6.18mh8 patch in hand.I'm using ST's STLC2500 in the bluetooth
module.Since stlc2500c support only sco over pcm , i have its pcm
interface connected to cpu.Right now i've established an eSCO
connection, the problem is i can't find proper means to test audio
data transmit/receive based on sco over pcm.
     I used "aplay -D plug:bluetooth *.wav" and something wrong
happened,please refer to the log.
1.This is how my audio.conf is set:
[General]
Enable=Control
# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=Headset
Disable=
Master=

# SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
# Defaults to HCI
SCORouting=PCM

# Headset interface specific options (i.e. options which affect how the audio
# service interacts with remote headset devices)
[Headset]
HFP=true

# Set to true to only support HSP
# Defaults to false
DisableHFP=false

# HFP Gateway features
# Defaults to false
3WayCalling=true
EchoCancelNoiseCancel=true
VoiceRecognition=true
InBandRingtone=true
VoiceTags=true
RejectingCalls=true
EnhancedCallStatus=true
EnhancedCallControl=true
ExtendedErrorResultCodes=true

# Just an example of potential config options for the other interfaces
[A2DP]
SourceCount=2
SBCSources=1
MPEG12Sources=0
SBCSinks=
MPEG12Sinks=

2.Settings in asound.conf:
 pcm.headset {
type bluetooth
}
ctl.headset {
type bluetooth
}
pcm.bluetooth {
type bluetooth
device 00:18:13:E7:B8:D6
profile voice
}

3.The log when tried to play music in bluetooth headset:
$ /aplay -D plug:bluetooth 1.wav
audio[192]: Found Headset record
audio[192]: Discovered Headset service on RFCOMM channel 1
audio[192]: Found Hansfree record
audio[192]: Discovered Handsfree service on RFCOMM channel 2
audio[192]: Found Audio Sink
audio[192]: Found AV Remote
audio[192]: Found AV Target
audio[192]: Selecting default device
audio[192]: Audio API: sending BT_GETCAPABILITIES_RSP
Playing WAVE '/tmp1/1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
audio[192]: Audio API: received BT_SETCONFIGURATION_REQ
audio[192]: config sco - device = 00:18:13:E7:B8:D6 access_mode = 2
audio[192]: /org/bluez/audio/device0: Connecting to 00:18:13:E7:B8:D6
channel 2
audio[192]: State changed /org/bluez/audio/device0:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:18:13:E7:B8:D6)
hcid[173]: pin_code_request (sba=00:80:E1:00:AB:BA, dba=00:18:13:E7:B8:D6)
hcid[173]: Calling PasskeyAgent.Request: name=:1.1,
path=/org/bluez/passkey_agent_179
Passkey request for device 00:18:13:E7:B8:D6
hcid[173]: link_key_notify (sba=00:80:E1:00:AB:BA, dba=00:18:13:E7:B8:D6)
audio[192]: /org/bluez/audio/device0: Connected to 00:18:13:E7:B8:D6
audio[192]: Received AT+BRSF=127
audio[192]: Received AT+CIND=?
audio[192]: Received AT+CIND?
audio[192]: Received AT+CMER=3,0,0,1
audio[192]: Received AT+CHLD=?
audio[192]: HFP Service Level Connection established
audio[192]: State changed  KERNEL:sco_connect(): type=2
/org/bluez/audio/device0:
HEADSET_STATE_CONNECT_IN_PROGRESh4_check_data_len: Data length is too large
S -> HEADSET_STATE_CONNECTED
audio[192]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECTED
-> HEADSET_STATE_PLAY_IN_PROGRESS
h4_recv: Unknown HCI packet type 00
audio[192]: connect(): Connection timed out (110)
audio[192]: config failed
audio[192]: Audio API: sending BT_SETCONFIGURATION_RSP
audio[192]: State changed /org/bluez/audio/device0:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
ALSA lib pcm_bluetooth.c:460:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION
failed : Input/output error(5)
aplay: set_params:979: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 125000
PERIOD_SIZE: (5512 5513)
PERIOD_BYTES: (22048 22052)
PERIODS: (3 5)
BUFFER_TIME: 500000
BUFFER_SIZE: 22050
BUFFER_BYTES: 88200
TICK_TIME: 0
audio[192]: Unix client disconnected (fd=9)
l2cap_recv_acldata: Unexpected continuation frame (len 258)
/ $ audio[192]: Received AT+CLAN?
audio[192]: Badly formated or unrecognized command: AT+CLAN?
audio[192]: Received AT*EIPS=2,1
audio[192]: Badly formated or unrecognized command: AT*EIPS=2,1
audio[192]: Received AT+COLP=1
audio[192]: Badly formated or unrecognized command: AT+COLP=1



Can anybody tell me what's wrong with my log?
Or how to test audio transfer when using the sco over pcm route in hsp/hfp?

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
