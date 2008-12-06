Return-Path: <cyrus@holtmann.org>
Message-ID: <493A6CC6.7000205@pook.es>
Date: Sat, 06 Dec 2008 13:15:02 +0100
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: bluez-4.22 + twinkle -> Unable to lock headset
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>	 <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com> <48EA6D84.7020101@pook.es>	 <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com> <48EA7B66.1050208@pook.es>	 <1223326990.11272.229.camel@violet.holtmann.net> <48EA7ED9.9080801@pook.es> <1223328106.11272.232.camel@violet.holtmann.net> <48EA93F7.4060000@pook.es> <14CF8002-9C68-48AF-AAB7-783C16CAC8CA@gmail.com>
In-Reply-To: <14CF8002-9C68-48AF-AAB7-783C16CAC8CA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all

I have been getting the dreaded "Unable to lock headset" message with bluez-4.18 so I decided to upgrade to bluez-4.22. Now I get the message even more often, in fact I can no longer telephone at all using twinkle (1.3.2).

I use bluetooth to make VoIP calls with my Jabra JX10 headset and to connect to my Nokia E65 mobile phone to backup it up. The connection to my phone still works. I can play music using "aplay -D JX10" and do echo tests using "arecord -D JX10 -f S16_LE|aplay -D JX10 -f S16_LE". However using twinkle always fails with the messages "Cannot access the speaker (ALSA: JX10)" and "Cannot access the microphone (ALSA: JX10)". The log window contains "Critical: Opening ALSA driver failed: snd_pcm_prepare failed: Input/output error".

What does "Unable to lock headset" mean?

I have just downgraded to bluez-4.18 and can now make a few calls before I get "Unable to lock headset" & "config failed". When I do get this message I have to restart bluetoothd.

I have a Belkin F8T017 USB adapter and am running linux 2.6.28-rc6.

My /etc/bluetooth/main.conf contains

[General]
DisablePlugins = network,input,serial
Name = %h-%d
Class = 0x000100
DiscoverableTimeout = 0
PageTimeout = 8192
OffMode = NoScan
DiscoverSchedulerInterval = 0

Should I remove anything or add something (to prohibit incoming connections for example)?

thanks!
Stuart

: root@kooka; /usr/local/stow/bluez-4.22/sbin/bluetoothd -dn
bluetoothd[13986]: Bluetooth daemon
bluetoothd[13986]: Enabling debug information
bluetoothd[13986]: parsing main.conf
bluetoothd[13986]: discovto=0
bluetoothd[13986]: Key file does not have key 'PairableTimeout'
bluetoothd[13986]: pageto=8192
bluetoothd[13986]: name=%h-%d
bluetoothd[13986]: class=0x000100
bluetoothd[13986]: inqmode=0
bluetoothd[13986]: Starting SDP server
bluetoothd[13986]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[13986]: register_interface: path /org/bluez/13986/any
bluetoothd[13986]: Registered interface org.bluez.Service on path /org/bluez/13986/any
bluetoothd[13986]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[13986]: Unix socket created: 11
bluetoothd[13986]: Telephony plugin initialized
bluetoothd[13986]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[13986]: HCI dev 0 registered
bluetoothd[13986]: child 13987 forked
bluetoothd[13986]: HCI dev 0 already up
bluetoothd[13986]: Starting security manager 0
bluetoothd[13986]: register_interface: path /org/bluez/13986/hci0
bluetoothd[13986]: Registered interface org.bluez.Service on path /org/bluez/13986/hci0
bluetoothd[13986]: headset_server_probe: path /org/bluez/13986/hci0
bluetoothd[13986]: Adding record with handle 0x10000
bluetoothd[13986]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[13986]: Adding record with handle 0x10001
bluetoothd[13986]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[13986]: a2dp_server_probe: path /org/bluez/13986/hci0
bluetoothd[13986]: SEP 0xb9e0fb08 registered: type:0 codec:0 seid:1
bluetoothd[13986]: Adding record with handle 0x10002
bluetoothd[13986]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[13986]: avrcp_server_probe: path /org/bluez/13986/hci0
bluetoothd[13986]: Adding record with handle 0x10003
bluetoothd[13986]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[13986]: Adding record with handle 0x10004
bluetoothd[13986]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13986]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[13986]: Creating device /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98
bluetoothd[13986]: Probe drivers for /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98
bluetoothd[13986]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[13986]: Found Headset record
bluetoothd[13986]: Discovered Headset service on RFCOMM channel 2
bluetoothd[13986]: Registered interface org.bluez.Headset on path /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98
bluetoothd[13986]: Found Handsfree record
bluetoothd[13986]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[13986]: Creating device /org/bluez/13986/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[13986]: Probe drivers for /org/bluez/13986/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[13986]: adapter_get_device(00:17:E5:0C:EA:70)
bluetoothd[13986]: audio handle_uuid: server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[13986]: audio handle_uuid: server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[13986]: Found AV Target
bluetoothd[13986]: Registered interface org.bluez.Control on path /org/bluez/13986/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[13986]: Found AV Target
bluetoothd[13986]: Adapter /org/bluez/13986/hci0 has been enabled
bluetoothd[13986]: child 13987 exited
bluetoothd[13986]: Computer is classified as desktop
bluetoothd[13986]: Current device class is 0x480104
bluetoothd[13986]: Setting 0x000104 for major/minor device class
bluetoothd[13986]: Agent registered for hci0 at :1.232:/org/bluez/agent/hci0

# here I try to telephone using twinkle

bluetoothd[13986]: Accepted new client connection on unix socket (fd=14)
bluetoothd[13986]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[13986]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[13986]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[13986]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[13986]: /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[13986]: /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[13986]: Received AT+BRSF=27
bluetoothd[13986]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[13986]: Received AT+CIND=?
bluetoothd[13986]: Received AT+CIND?
bluetoothd[13986]: Received AT+CMER=3, 0, 0, 1
bluetoothd[13986]: Event reporting (CMER): mode=3, ind=1
bluetoothd[13986]: HFP Service Level Connection established
bluetoothd[13986]: telephony-dummy: device 0xb9e11300 connected
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[13986]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[13986]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[13986]: SCO socket opened for headset /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98
bluetoothd[13986]: SCO fd=20
bluetoothd[13986]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[13986]: Audio API: sending BT_STREAMFD_IND
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[13986]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[13986]: Unable to lock headset
bluetoothd[13986]: headset_resume_complete: resume failed
bluetoothd[13986]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[13986]: Unix client disconnected (fd=14)
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[13986]: Accepted new client connection on unix socket (fd=14)
bluetoothd[13986]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[13986]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[13986]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[13986]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[13986]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[13986]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[13986]: SCO socket opened for headset /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98
bluetoothd[13986]: SCO fd=20
bluetoothd[13986]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[13986]: Audio API: sending BT_STREAMFD_IND
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[13986]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[13986]: Unable to lock headset
bluetoothd[13986]: headset_resume_complete: resume failed
bluetoothd[13986]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[13986]: Unix client disconnected (fd=14)
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[13986]: No matching connection for handle 6
bluetoothd[13986]: Received AT+VGS=06
bluetoothd[13986]: telephony-dummy: device 0xb9e11300 disconnected
bluetoothd[13986]: State changed /org/bluez/13986/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

