Return-Path: <cyrus@holtmann.org>
Message-ID: <49974F8C.2080603@pook.es>
Date: Sun, 15 Feb 2009 00:11:08 +0100
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: bluez-4.30: aplay: pcm_write:1269: write error: Input/output error
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hello

I have just installed bluez-4.30 on my machine running linux 2.6.28-rc6 and have found that aplay no longer works every time. As you can see it worked once in five attempts.

:; aplay -d 6 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
aplay: pcm_write:1269: write error: Input/output error
:; aplay -d 6 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
:; aplay -d 6 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
aplay: pcm_write:1269: write error: Input/output error
:; aplay -d 6 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
aplay: pcm_write:1269: write error: Input/output error
:; aplay -d 6 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
aplay: pcm_write:1269: write error: Input/output error

Once I got a bit of music then a different message

:; aplay -d 6 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:245:(playback_hw_thread) poll fd 0 revents 32

Sometimes it works until the end of the song.  I have a Jabra JX10 headset and a Belkin F8T017 Bluetooth adapter.

bluetoothd[6036]: Accepted new client connection on unix socket (fd=14)
bluetoothd[6036]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[6036]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[6036]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[6036]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[6036]: /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[6036]: State changed /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[6036]: /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[6036]: Received AT+BRSF=27
bluetoothd[6036]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[6036]: Received AT+CIND=?
bluetoothd[6036]: Received AT+CIND?
bluetoothd[6036]: Received AT+CMER=3, 0, 0, 1
bluetoothd[6036]: Event reporting (CMER): mode=3, ind=1
bluetoothd[6036]: HFP Service Level Connection established
bluetoothd[6036]: telephony-dummy: device 0xb99582f8 connected
bluetoothd[6036]: State changed /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[6036]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[6036]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[6036]: State changed /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[6036]: Received AT+VGS=15
bluetoothd[6036]: SCO socket opened for headset /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98
bluetoothd[6036]: SCO fd=20
bluetoothd[6036]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[6036]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[6036]: State changed /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[6036]: Unix client disconnected (fd=14)
bluetoothd[6036]: State changed /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[6036]: No matching connection found for handle 6
bluetoothd[6036]: telephony-dummy: device 0xb99582f8 disconnected
bluetoothd[6036]: State changed /org/bluez/6036/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED


This is all part of my attempts to get bluez (>4.19) and twinkle http://twinklephone.com/ to talk to each other!

Stuart
