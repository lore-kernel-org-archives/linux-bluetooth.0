Return-Path: <cyrus@holtmann.org>
Message-ID: <49ECB4BB.8050204@pook.es>
Date: Mon, 20 Apr 2009 19:45:31 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez git + Linksys USBBT100 + 2.6.30-rc2 -> Segmentation fault
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es> <20090405172212.GB6612@jh-x301> <49EB7950.4000802@pook.es> <20090419200528.GA18068@jh-x301> <49EB93C2.3090702@pook.es> <20090419213837.GA6514@jh-x301>
In-Reply-To: <20090419213837.GA6514@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

On 19/04/09 23:38, Johan Hedberg wrote:
> Could you please run bluetoothd through valgrind to get a proper 
> backtrace.

I tested the bluetoothd from git and aplay with the alsa libs from bluez 4.36. I ran play 1451 times. It worked once. valgrind didn't say anything. I guess the errors below are more or less normal because my headset's battery went flat. I don't think that the "Too short" message from aplay is normal (even if the headset is off).

Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
aplay: set_params:1022: Unable to install hw params:
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

bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Unable to get a SCO fd
bluetoothd[1851]: headset_resume_complete: resume failed
bluetoothd[1851]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Unix client disconnected (fd=13)
bluetoothd[1851]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[1851]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Unable to get a SCO fd
bluetoothd[1851]: headset_resume_complete: resume failed
bluetoothd[1851]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Unix client disconnected (fd=13)
bluetoothd[1851]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[1851]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Unable to get a SCO fd
bluetoothd[1851]: headset_resume_complete: resume failed
bluetoothd[1851]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Unix client disconnected (fd=13)
bluetoothd[1851]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[1851]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Unable to get a SCO fd
bluetoothd[1851]: headset_resume_complete: resume failed
bluetoothd[1851]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Unix client disconnected (fd=13)
bluetoothd[1851]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[1851]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Unable to get a SCO fd
bluetoothd[1851]: headset_resume_complete: resume failed
bluetoothd[1851]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Unix client disconnected (fd=13)
bluetoothd[1851]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[1851]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[1851]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[1851]: Unable to get service record: Host is down (112)
bluetoothd[1851]: Unable to get a SCO fd
bluetoothd[1851]: headset_resume_complete: resume failed
bluetoothd[1851]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[1851]: telephony-dummy: device 0x4b90d40 disconnected
bluetoothd[1851]: State changed /org/bluez/1851/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[1851]: Unix client disconnected (fd=13)



-- 
If the From address bounces, please see http://www.pook.it/.
