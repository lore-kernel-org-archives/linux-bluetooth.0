Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPcThSGtpatfJmrW7Gw-Wm+=LG83th7wOJwCDxP5vxqqk=tK5Q@mail.gmail.com>
References: <CAPcThSGtpatfJmrW7Gw-Wm+=LG83th7wOJwCDxP5vxqqk=tK5Q@mail.gmail.com>
Date: Fri, 18 Mar 2016 15:57:03 +1000
Message-ID: <CAPcThSEoaNF8POqEBF_x9p=Op8u8A_6eV+ZowfXfThA_HyWtMA@mail.gmail.com>
Subject: Re: aplay failed on bluetooth audio with bluez 4.101
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Community,

I kept debugging this issue today and found out that aplay failed to
send out the .wav file content to bluetooth headset.

>From the "strace aplay -D btheadset .wav" I can see that the wav file
is read in 12000B chunk, but sent to bluetooth socket in 48B chunk of
data. Compared with the strace result for aplay through speaker, the
wav file can be read correctly, however, when using bluetooth headset
aplay always seems to send 48B zero again and again.

This explains why there is no sound output at all.

fd 6 is the opened wav file.
fd 7 is the connection with /org/bluez/audio.

...
read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
12000) = 12000
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
read(6, "w\37\210 \21!\6!\320 q
\244\37u\36b\35\222\34a\33\314\31\267\30C\30\265\27\234\26"..., 12000)
= 12000
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
read(6, "\t\23\205\23\27\24\206\24\330\24G\25\301\25!\26x\26\335\26B\27\211\27\301\27\24\30`\30\211\30"...,
12000) = 12000
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
read(6, "\334\377\343\377\347\377\337\377\332\377\340\377\344\377\342\377\337\377\327\377\324\377\345\377\350\377\331\377\343\377\362\377"...,
12000) = 12000
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
clock_gettime(CLOCK_REALTIME, {1457576840, 978074823}) = 0
read(6, "\374\377\361\377\345\377\363\377\366\377\361\377\364\377\364\377\367\377\370\377\352\377\352\377\371\377\362\377\360\377\4\0"...,
12000) = 12000
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
send(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
48, 0) = 48
... (endless sending 48b of zeros) ...

Any comments?

Thanks,
Harry

On Thu, Mar 17, 2016 at 2:47 PM, Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
> Hi Community,
>
> I run into a bluetooth headset issue with bluez 4.101. After a
> successful pairing and connection, I failed to play a .wav file
> through the bluetooth headset by aplay. I have been searching around
> for a couple days and looked at bluez 4.101 source code to ensure the
> audio.conf settings make sense but still clueless.
>
> My laptop is Ubuntu 15.04 with bluez 4.101-ubuntu25 (kernel:
> 3.19.0-25-generic), the target embedded uses yocto "dizzy" release
> with bluez 4.101 as well (kernel: 3.4). On both laptop and target
> machine the libasound-module-bluez has been installed properly.
>
> My settings are:
>
> 1. /etc/bluetooth/main.conf
> The default one, in particular, Class=0x00100
>
> 2. /etc/bluetooth/audio.conf
>
>     [General]
>     Enable=Socket
>
>     [Headset]
>     HFP=true
>     MaxConnected=1
>     FastConnectable=false
>
>     [A2DP]
>     SBCSources=1
>     SBCSinks=1
>     MPEG12Sources=1
>     MPEG12Sinks=1
>
> 3. ~/.asoundrc
>     pcm.btheadset {
>         type plug
>         slave {
>             pcm {
>                 type bluetooth
>                 device "1C:48:F9:AD:19:EE"
>                 profile "auto"
>             }
>         }
>
>         hint {
>             show on
>             description "BT Headset"
>         }
>     }
>
>     ctl.btheadset {
>         type bluetooth
>     }
>
> where I have hardcoded the bdaddr of my bluetooth headset.
>
> 4. My bluetooth headset has been paired and connected successfully:
>
> $ hcitool con
> Connections:
>     < eSCO 1C:48:F9:AD:19:EE handle 70 state 1 lm MASTER
>     < ACL 1C:48:F9:AD:19:EE handle 69 state 1 lm MASTER AUTH ENCRYPT
>
>
> 5. On my laptop, I can play through bluetooth headset with mplayer successfully:
>
>     $ mplayer -ao alsa:device=btheadset /usr/share/sounds/alsa/Front_Center.wav
>
>     MPlayer2 2.0-728-g2c378c7-4 (C) 2000-2012 MPlayer Team
>     Cannot open file '/home/harry/.mplayer/input.conf': No such file
> or directory
>     Failed to open /home/harry/.mplayer/input.conf.
>     Cannot open file '/etc/mplayer/input.conf': No such file or directory
>     Failed to open /etc/mplayer/input.conf.
>
>     Playing /usr/share/sounds/alsa/Front_Center.wav.
>     Detected file format: WAV / WAVE (Waveform Audio) (libavformat)
>     [lavf] stream 0: audio (pcm_s16le), -aid 0
>     Load subtitles in /usr/share/sounds/alsa/
>     Selected audio codec: Uncompressed PCM [pcm]
>     AUDIO: 48000 Hz, 1 ch, s16le, 768.0 kbit/100.00% (ratio: 96000->96000)
>     AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
>     Video: no video
>     Starting playback...
>     A:   1.4 (01.4) of 1.4 (01.4)  0.1%
>
>     Exiting... (End of file)
>
>
> 6. However, on my laptop, play with aplay failed:
>
>     $ aplay -D btheadset /usr/share/sounds/alsa/Front_Center.wav
>
>     Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16
> bit Little Endian, Rate 48000 Hz,         Mono
>     ^CAborted by signal Interrupt...
>
> All I got is constant beeeeep noises and I have to press Ctrl^C to terminate it.
>
> 7. On my target machine, the rootfs is provided by "dizzy" yocto
> release also with bluez 4.101. I have modified main.conf to define
> "Class=0x5A020C" (or simply 0x000200) and audio.conf to enable
> "SCORouting=PCM".
>
> 8. On my target machine, the same aplay command failed as well. But it
> doesn't output any sound, no constant beep noise. Only when I
> terminated it could I hear a short beep sound.
>
>
> Given that mplayer works on bluetooth headset, I thought the bridging
> from alsa to bluez works. However, why aplay failed? On my target
> there is only aplay now and it's difficult to add mplay, so I would
> have to make aplay work with bluetooth audio.
>
> Any comments are much appreciated!
>
> Cheers,
> Harry
>
>
> P.S.
>
> The following is the "bluetoothd -d -n" result during "aplay -D btheadset ...":
>
> bluetoothd[9490]: audio/unix.c:server_cb() Accepted new client
> connection on unix socket (fd=33)
> bluetoothd[9490]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
> BT_GET_CAPABILITIES
> bluetoothd[9490]: audio/unix.c:unix_ipc_sendmsg() Audio API:
> BT_RESPONSE -> BT_GET_CAPABILITIES
> bluetoothd[9490]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_OPEN
> bluetoothd[9490]: audio/unix.c:handle_sco_open() open sco - object=ANY
> source=ANY destination=1C:48:F9:AD:19:EE lock=write
> bluetoothd[9490]: audio/unix.c:unix_ipc_sendmsg() Audio API:
> BT_RESPONSE -> BT_OPEN
> bluetoothd[9490]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
> BT_SET_CONFIGURATION
> bluetoothd[9490]: audio/unix.c:unix_ipc_sendmsg() Audio API:
> BT_RESPONSE -> BT_SET_CONFIGURATION
> bluetoothd[9490]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
> BT_START_STREAM
> bluetoothd[9490]: audio/headset.c:headset_set_state() State changed
> /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE: HEADSET_STATE_CONNECTED ->
> HEADSET_STATE_PLAY_IN_PROGRESS
> bluetoothd[9490]: audio/media.c:headset_state_changed()
> bluetoothd[9490]: audio/media.c:headset_state_changed()
> bluetoothd[9490]: audio/headset.c:sco_connect_cb() SCO socket opened
> for headset /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE
> bluetoothd[9490]: audio/headset.c:sco_connect_cb() SCO fd=35
> bluetoothd[9490]: audio/unix.c:unix_ipc_sendmsg() Audio API:
> BT_RESPONSE -> BT_START_STREAM
> bluetoothd[9490]: audio/unix.c:unix_ipc_sendmsg() Audio API:
> BT_INDICATION -> BT_NEW_STREAM
> bluetoothd[9490]: audio/headset.c:headset_set_state() State changed
> /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE:
> HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
> bluetoothd[9490]: audio/media.c:headset_state_changed()
> bluetoothd[9490]: audio/media.c:headset_state_changed()
> bluetoothd[9490]: audio/transport.c:media_transport_acquire()
> Transport /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE/fd0: read lock
> acquired
> bluetoothd[9490]: audio/transport.c:media_transport_acquire()
> Transport /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE/fd0: write lock
> acquired
> bluetoothd[9490]: audio/transport.c:media_owner_create() Owner
> created: sender=:1.309 accesstype=rw
> bluetoothd[9490]: audio/transport.c:media_transport_release()
> Transport /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE/fd0: read lock
> released
> bluetoothd[9490]: audio/transport.c:media_transport_release()
> Transport /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE/fd0: write lock
> released
> bluetoothd[9490]: audio/transport.c:media_owner_free() Owner :1.309
> bluetoothd[9490]: audio/unix.c:client_cb() Unix client disconnected (fd=33)
> bluetoothd[9490]: audio/headset.c:headset_set_state() State changed
> /org/bluez/9490/hci1/dev_1C_48_F9_AD_19_EE: HEADSET_STATE_PLAYING ->
> HEADSET_STATE_CONNECTED
> bluetoothd[9490]: audio/media.c:headset_state_changed()
> bluetoothd[9490]: audio/media.c:headset_state_changed()
> bluetoothd[9490]: audio/unix.c:client_free() client_free(0x7f59b52e54b0)
