Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: Headset doesn't work at all (ALSA)
From: Michal Sojka <sojkam1@fel.cvut.cz>
Date: Fri, 26 Jun 2009 11:22:39 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906261122.39383.sojkam1@fel.cvut.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I cannot make my BT headset (Motorola HS820) work. I use Debian 
with 2.6.30 kernel and the following versions of packages:

ii  bluez                                  4.42-1                                 Bluetooth tools and daemons
ii  bluez-alsa                             4.42-1                                 Bluetooth ALSA support

I've followed http://wiki.bluez.org/wiki/HOWTO/AudioDevices without success.
I have the following in .asoundrc:

>$ cat .asoundrc
>pcm.bluetoothraw {
>   type bluetooth
>   device 00:07:A4:87:E2:EE
>}
>pcm.bluetooth {
>    type plug
>    slave {
>        pcm bluetoothraw
>    }
>}

Then I tried:

>$ aplay -D bluetooth  'rec.wav'
>Playing WAVE 'rec.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
>aplay: pcm_write:1528: write error: Connection timed out

And after some time I got the error without any sound from the headset.
I attach the output of bluetoothd -d:

Jun 25 11:42:34 resox bluetoothd[10186]: Accepted new client connection on unix socket (fd=22)
Jun 25 11:42:34 resox bluetoothd[10186]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
Jun 25 11:42:34 resox bluetoothd[10186]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
Jun 25 11:42:34 resox bluetoothd[10186]: Audio API: BT_REQUEST <- BT_OPEN
Jun 25 11:42:34 resox bluetoothd[10186]: open sco - object=ANY source=ANY destination=00:07:A4:87:E2:EE lock=write
Jun 25 11:42:34 resox bluetoothd[10186]: Audio API: BT_RESPONSE -> BT_OPEN
Jun 25 11:42:34 resox bluetoothd[10186]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
Jun 25 11:42:34 resox bluetoothd[10186]: State changed /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Jun 25 11:42:46 resox bluetoothd[10186]: Discovered Handsfree service on channel 2
Jun 25 11:42:46 resox bluetoothd[10186]: /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: Connecting to 00:07:A4:87:E2:EE channel 2
Jun 25 11:42:58 resox bluetoothd[10186]: /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: Connected to 00:07:A4:87:E2:EE
Jun 25 11:43:01 resox bluetoothd[10186]: Received AT+BRSF=26
Jun 25 11:43:01 resox bluetoothd[10186]: HFP HF features: "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
Jun 25 11:43:04 resox bluetoothd[10186]: Received AT+CIND=?
Jun 25 11:43:06 resox bluetoothd[10186]: Received AT+CIND?
Jun 25 11:43:09 resox bluetoothd[10186]: Received AT+CMER=3,0,0,1
Jun 25 11:43:09 resox bluetoothd[10186]: Event reporting (CMER): mode=3, ind=1
Jun 25 11:43:09 resox bluetoothd[10186]: HFP Service Level Connection established
Jun 25 11:43:09 resox bluetoothd[10186]: telephony-dummy: device 0xb9f0fcc0 connected
Jun 25 11:43:09 resox bluetoothd[10186]: State changed /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Jun 25 11:43:09 resox bluetoothd[10186]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
Jun 25 11:43:09 resox bluetoothd[10186]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 11:43:09 resox bluetoothd[10186]: State changed /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Jun 25 11:43:09 resox bluetoothd[10186]: Received AT+VGS=13
Jun 25 11:43:49 resox bluetoothd[10186]: HUP or ERR on socket
Jun 25 11:43:49 resox bluetoothd[10186]: Audio API: BT_RESPONSE -> BT_START_STREAM
Jun 25 11:43:49 resox bluetoothd[10186]: Audio API: BT_INDICATION -> BT_NEW_STREAM
Jun 25 11:43:49 resox bluetoothd[10186]: State changed /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Jun 25 11:43:49 resox bluetoothd[10186]: Unix client disconnected (fd=22)
Jun 25 11:43:49 resox bluetoothd[10186]: client_free(0xb9f0ead8)
Jun 25 11:43:52 resox bluetoothd[10186]: telephony-dummy: device 0xb9f0fcc0 disconnected
Jun 25 11:43:52 resox bluetoothd[10186]: State changed /org/bluez/10186/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

When I tried mplayer, the result were even worse. The error at the end 
repeated undefinitely and no sound was heard.

> $ mplayer -ao alsa:device=bluetooth xxx.mp3
> ...
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
> [AO_ALSA] pcm prepare error: Invalid argument                                                              
> [AO_ALSA] Write error: Transport endpoint is not connected
> [AO_ALSA] Trying to reset soundcard.                      
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
> [AO_ALSA] pcm prepare error: Invalid argument                                                              
> [AO_ALSA] Write error: Transport endpoint is not connected
> [AO_ALSA] Trying to reset soundcard.                      
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
> [AO_ALSA] pcm prepare error: Invalid argument                                                              
> [AO_ALSA] Write error: Transport endpoint is not connected

Jun 25 13:24:30 resox bluetoothd[14098]: Accepted new client connection on unix socket (fd=22)
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_OPEN
Jun 25 13:24:30 resox bluetoothd[14098]: open sco - object=ANY source=ANY destination=00:07:A4:87:E2:EE lock=write
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_OPEN
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
Jun 25 13:24:30 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 13:24:30 resox bluetoothd[14098]: State changed /org/bluez/14098/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Jun 25 13:25:10 resox bluetoothd[14098]: HUP or ERR on socket
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_RESPONSE -> BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_INDICATION -> BT_NEW_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: State changed /org/bluez/14098/hci0/dev_00_07_A4_87_E2_EE: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: sco_bind: Address already in use (98)
Jun 25 13:25:10 resox bluetoothd[14098]: start_resume: resume failed
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_ERROR -> BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: sco_bind: Address already in use (98)
Jun 25 13:25:10 resox bluetoothd[14098]: start_resume: resume failed
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_ERROR -> BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: sco_bind: Address already in use (98)
Jun 25 13:25:10 resox bluetoothd[14098]: start_resume: resume failed
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_ERROR -> BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: sco_bind: Address already in use (98)
Jun 25 13:25:10 resox bluetoothd[14098]: start_resume: resume failed
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_ERROR -> BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: Audio API: BT_REQUEST <- BT_START_STREAM
Jun 25 13:25:10 resox bluetoothd[14098]: sco_bind: Address already in use (98)
Jun 25 13:25:10 resox bluetoothd[14098]: start_resume: resume failed

Has anybody some clue what can be wrong?

Thanks
Michal Sojka

