Return-Path: <cyrus@holtmann.org>
Message-ID: <4A2A6FFE.4080906@wowway.com>
Date: Sat, 06 Jun 2009 08:32:46 -0500
From: "John R." <johnr@wowway.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Additional info: aplay: pcm_write:1269: write error: Input/output
 error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Debug info below...

bluez: 4.39
kernel: 2.6.29.2

When attempting to play a wav file I get a short blip of sound but it
errors out and stops every time:

aplay -D bluetooth ross.wav
Playing WAVE 'ross.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
aplay: pcm_write:1269: write error: Input/output error

If I try and play a stereo 44100 Hz file there is no blip of sound just
the same error.

Any suggestions on where to look?   I have used AudioDevices Wiki page
for configuration.

asoundrc:

pcm.bluetoothraw {
   type bluetooth
   device XX:XX:XX:XX:XX:XX
   profile auto
}

pcm.bluetooth {
   type plug
   slave {
        pcm bluetoothraw
   }
}


First time playing (Bringing up connection):

Jun  6 08:26:01 aqui bluetoothd[32589]: Accepted new client connection 
on unix socket (fd=13)
Jun  6 08:26:01 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- 
BT_GET_CAPABILITIES
Jun  6 08:26:01 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=2
Jun  6 08:26:04 aqui bluetoothd[32589]: 
adapter_get_device(XX:XX:XX:XX:XX:XX)
Jun  6 08:26:04 aqui bluetoothd[32589]: link_key_request 
(sba=00:1B:DC:0F:E6:38, dba=XX:XX:XX:XX:XX:XX)
Jun  6 08:26:04 aqui bluetoothd[32589]: kernel auth requirements = 0x04
Jun  6 08:26:04 aqui bluetoothd[32589]: stored link key type = 0x00
Jun  6 08:26:05 aqui bluetoothd[32589]: AVDTP: connected signaling 
channel to XX:XX:XX:XX:XX:XX
Jun  6 08:26:05 aqui bluetoothd[32589]: AVDTP imtu=672, omtu=895
Jun  6 08:26:05 aqui bluetoothd[32589]: session_cb
Jun  6 08:26:05 aqui bluetoothd[32589]: DISCOVER request succeeded
Jun  6 08:26:05 aqui bluetoothd[32589]: seid 1 type 1 media 0 in use 0
Jun  6 08:26:05 aqui bluetoothd[32589]: session_cb
Jun  6 08:26:05 aqui bluetoothd[32589]: GET_CAPABILITIES request succeeded
Jun  6 08:26:05 aqui bluetoothd[32589]: seid 1 type 1 media 0
Jun  6 08:26:05 aqui bluetoothd[32589]: Media Codec: SBC Channel Modes: 
Mono DualChannel Stereo JointStereo Frequencies: 16Khz 32Khz 44.1Khz 
48Khz  Subbands: 4 8  Blocks: 4 8 12 16  Bitpool: 2-32
Jun  6 08:26:05 aqui bluetoothd[32589]: Append  seid 1 - length 13 - 
total 181
Jun  6 08:26:05 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_GET_CAPABILITIES
Jun  6 08:26:05 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- BT_OPEN
Jun  6 08:26:05 aqui bluetoothd[32589]: open a2dp - object=ANY 
source=ANY destination=XX:XX:XX:XX:XX:XX lock=write
Jun  6 08:26:05 aqui bluetoothd[32589]: SEP 0xb7f0fd48 locked
Jun  6 08:26:05 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> BT_OPEN
Jun  6 08:26:05 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- 
BT_SET_CONFIGURATION
Jun  6 08:26:05 aqui bluetoothd[32589]: Media Codec: SBC Channel Modes: 
Mono  Frequencies: 44.1Khz  Subbands: 8  Blocks: 16  Bitpool: 2-31
Jun  6 08:26:05 aqui bluetoothd[32589]: a2dp_source_config: selected SEP 
0xb7f0fd48
Jun  6 08:26:05 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=3
Jun  6 08:26:05 aqui bluetoothd[32589]: setup_ref(0xb7f083b8): ref=1
Jun  6 08:26:05 aqui bluetoothd[32589]: 
avdtp_set_configuration(0xb7f120f8): int_seid=1, acp_seid=1
Jun  6 08:26:06 aqui bluetoothd[32589]: session_cb
Jun  6 08:26:06 aqui bluetoothd[32589]: SET_CONFIGURATION request succeeded
Jun  6 08:26:06 aqui bluetoothd[32589]: Source 0xb7f0fd48: 
Set_Configuration_Cfm
Jun  6 08:26:06 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=4
Jun  6 08:26:06 aqui bluetoothd[32589]: stream state changed: IDLE -> 
CONFIGURED
Jun  6 08:26:06 aqui bluetoothd[32589]: session_cb
Jun  6 08:26:06 aqui bluetoothd[32589]: OPEN request succeeded
Jun  6 08:26:07 aqui input: XX:XX:XX:XX:XX:XX as /class/input/input22
Jun  6 08:26:07 aqui bluetoothd[32589]: AVCTP: connected to 
XX:XX:XX:XX:XX:XX
Jun  6 08:26:07 aqui bluetoothd[32589]: AVRCP: uinput initialized for 
XX:XX:XX:XX:XX:XX
Jun  6 08:26:08 aqui bluetoothd[32589]: AVDTP: connected transport 
channel to XX:XX:XX:XX:XX:XX
Jun  6 08:26:08 aqui bluetoothd[32589]: Source 0xb7f0fd48: Open_Cfm
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_ref(0xb7f083b8): ref=2
Jun  6 08:26:08 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_SET_CONFIGURATION
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_unref(0xb7f083b8): ref=1
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_unref(0xb7f083b8): ref=0
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_free(0xb7f083b8)
Jun  6 08:26:08 aqui bluetoothd[32589]: avdtp_unref(0xb7f120f8): ref=3
Jun  6 08:26:08 aqui bluetoothd[32589]: stream state changed: CONFIGURED 
-> OPEN
Jun  6 08:26:08 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- 
BT_START_STREAM
Jun  6 08:26:08 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=4
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_ref(0xb7f11598): ref=1
Jun  6 08:26:08 aqui bluetoothd[32589]: session_cb
Jun  6 08:26:08 aqui bluetoothd[32589]: START request succeeded
Jun  6 08:26:08 aqui bluetoothd[32589]: Source 0xb7f0fd48: Start_Cfm
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_ref(0xb7f11598): ref=2
Jun  6 08:26:08 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_START_STREAM
Jun  6 08:26:08 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_NEW_STREAM
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_unref(0xb7f11598): ref=1
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_unref(0xb7f11598): ref=0
Jun  6 08:26:08 aqui bluetoothd[32589]: setup_free(0xb7f11598)
Jun  6 08:26:08 aqui bluetoothd[32589]: avdtp_unref(0xb7f120f8): ref=3
Jun  6 08:26:08 aqui bluetoothd[32589]: stream state changed: OPEN -> 
STREAMING
Jun  6 08:26:08 aqui bluetoothd[32589]: Unix client disconnected (fd=13)
Jun  6 08:26:08 aqui bluetoothd[32589]: SEP 0xb7f0fd48 unlocked
Jun  6 08:26:08 aqui bluetoothd[32589]: avdtp_unref(0xb7f120f8): ref=2
Jun  6 08:26:08 aqui bluetoothd[32589]: client_free(0xb7f0f348)
Jun  6 08:26:08 aqui bluetoothd[32589]: a2dp_source_cancel()
Jun  6 08:26:09 aqui bluetoothd[32589]: session_cb
Jun  6 08:26:09 aqui bluetoothd[32589]: SUSPEND request succeeded
Jun  6 08:26:09 aqui bluetoothd[32589]: stream state changed: STREAMING 
-> OPEN
Jun  6 08:26:09 aqui bluetoothd[32589]: Source 0xb7f0fd48: Suspend_Cfm

Subsequent attempts:

Jun  6 08:29:32 aqui bluetoothd[32589]: Accepted new client connection 
on unix socket (fd=13)
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- 
BT_GET_CAPABILITIES
Jun  6 08:29:32 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=3
Jun  6 08:29:32 aqui bluetoothd[32589]: Media Codec: SBC Channel Modes: 
Mono DualChannel Stereo JointStereo Frequencies: 16Khz 32Khz 44.1Khz 
48Khz  Subbands: 4 8  Blocks: 4 8 12 16  Bitpool: 2-32
Jun  6 08:29:32 aqui bluetoothd[32589]: Append configured seid 1 - 
length 13 - total 181
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_GET_CAPABILITIES
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- BT_OPEN
Jun  6 08:29:32 aqui bluetoothd[32589]: open a2dp - object=ANY 
source=ANY destination=XX:XX:XX:XX:XX:XX lock=write
Jun  6 08:29:32 aqui bluetoothd[32589]: SEP 0xb7f0fd48 locked
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> BT_OPEN
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- 
BT_SET_CONFIGURATION
Jun  6 08:29:32 aqui bluetoothd[32589]: Media Codec: SBC Channel Modes: 
Mono  Frequencies: 44.1Khz  Subbands: 8  Blocks: 16  Bitpool: 2-31
Jun  6 08:29:32 aqui bluetoothd[32589]: a2dp_source_config: selected SEP 
0xb7f0fd48
Jun  6 08:29:32 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=4
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_ref(0xb7f13200): ref=1
Jun  6 08:29:32 aqui bluetoothd[32589]: Configuration match: resuming
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_ref(0xb7f13200): ref=2
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_SET_CONFIGURATION
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_unref(0xb7f13200): ref=1
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_unref(0xb7f13200): ref=0
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_free(0xb7f13200)
Jun  6 08:29:32 aqui bluetoothd[32589]: avdtp_unref(0xb7f120f8): ref=3
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_REQUEST <- 
BT_START_STREAM
Jun  6 08:29:32 aqui bluetoothd[32589]: avdtp_ref(0xb7f120f8): ref=4
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_ref(0xb7f13200): ref=1
Jun  6 08:29:32 aqui bluetoothd[32589]: session_cb
Jun  6 08:29:32 aqui bluetoothd[32589]: START request succeeded
Jun  6 08:29:32 aqui bluetoothd[32589]: Source 0xb7f0fd48: Start_Cfm
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_ref(0xb7f13200): ref=2
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_START_STREAM
Jun  6 08:29:32 aqui bluetoothd[32589]: Audio API: BT_RESPONSE -> 
BT_NEW_STREAM
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_unref(0xb7f13200): ref=1
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_unref(0xb7f13200): ref=0
Jun  6 08:29:32 aqui bluetoothd[32589]: setup_free(0xb7f13200)
Jun  6 08:29:32 aqui bluetoothd[32589]: avdtp_unref(0xb7f120f8): ref=3
Jun  6 08:29:32 aqui bluetoothd[32589]: stream state changed: OPEN -> 
STREAMING
Jun  6 08:29:32 aqui bluetoothd[32589]: Unix client disconnected (fd=13)
Jun  6 08:29:32 aqui bluetoothd[32589]: SEP 0xb7f0fd48 unlocked
Jun  6 08:29:32 aqui bluetoothd[32589]: avdtp_unref(0xb7f120f8): ref=2
Jun  6 08:29:32 aqui bluetoothd[32589]: client_free(0xb7f0f348)
Jun  6 08:29:32 aqui bluetoothd[32589]: a2dp_source_cancel()
Jun  6 08:29:33 aqui bluetoothd[32589]: session_cb
Jun  6 08:29:33 aqui bluetoothd[32589]: SUSPEND request succeeded
Jun  6 08:29:33 aqui bluetoothd[32589]: stream state changed: STREAMING 
-> OPEN
Jun  6 08:29:33 aqui bluetoothd[32589]: Source 0xb7f0fd48: Suspend_Cfm

